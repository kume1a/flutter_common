import 'dart:async';

import 'package:dio/dio.dart';

abstract class AbstractTokenHeaderInterceptorFlow {
  FutureOr<Map<String, dynamic>?> provideExtraHeaders();
  Future<String?> refreshToken(Dio dio, String refreshToken, String? oldAccessToken);
  void onTokenExpired();
}