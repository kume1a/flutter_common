import 'dart:async';

import 'package:dio/dio.dart';

abstract class AbstractTokenHeaderInterceptorFlow {
  FutureOr<Map<String, dynamic>?> provideExtraHeaders() => null;

  Future<String?> refreshToken(Dio dio, String refreshToken, String? oldAccessToken);

  void onTokenExpired();
}
