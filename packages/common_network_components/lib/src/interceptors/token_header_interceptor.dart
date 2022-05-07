import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../local/auth_key_store.dart';
import '../utils/jwt_decoder.dart';
import 'abstract_token_header_interceptor_flow.dart';

const int kNetworkTimeout = 20000;

class TokenHeaderInterceptor extends Interceptor {
  TokenHeaderInterceptor({
    required this.authKeyStore,
    required this.tokenHeaderInterceptorFlow,
    Dio? dio,
  }) {
    _dio = dio ??
        Dio(
          BaseOptions(
            connectTimeout: kNetworkTimeout,
            receiveTimeout: kNetworkTimeout,
            sendTimeout: kNetworkTimeout,
          ),
        );
  }

  final AuthKeyStore authKeyStore;
  final AbstractTokenHeaderInterceptorFlow tokenHeaderInterceptorFlow;

  late final Dio _dio;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await authKeyStore.readAccessToken();

    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        await _tryRefreshAccessToken();
        accessToken = await authKeyStore.readAccessToken();
      }
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
      final Map<String, dynamic>? extraHeaders =
          await tokenHeaderInterceptorFlow.provideExtraHeaders();
      if (extraHeaders != null) {
        options.headers.addAll(extraHeaders);
      }
    }

    super.onRequest(options, handler);
  }

  Future<void> _tryRefreshAccessToken() async {
    final String? refreshToken = await authKeyStore.readRefreshToken();
    if (refreshToken != null) {
      if (JwtDecoder.isExpired(refreshToken)) {
        await _clearExit();
      } else {
        await _refreshAccessToken(refreshToken);
      }
    }
  }

  Future<void> _refreshAccessToken(String refreshToken) async {
    try {
      final String? oldAccessToken = await authKeyStore.readAccessToken();
      final String? newAccessToken =
          await tokenHeaderInterceptorFlow.refreshToken(_dio, refreshToken, oldAccessToken);
      if (newAccessToken != null) {
        authKeyStore.writeAccessToken(newAccessToken);
      } else {
        await _clearExit();
      }
    } on DioError catch (e) {
      log('TokenHeaderInterceptor._refreshAccessToken: ', error: e);
    }
  }

  Future<void> _clearExit() async {
    await authKeyStore.clear();
    tokenHeaderInterceptorFlow.onTokenExpired();
  }
}
