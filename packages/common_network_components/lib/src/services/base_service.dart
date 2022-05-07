import 'dart:developer';
import 'dart:io';

import 'package:common_models/common_models.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract class BaseService {
  @protected
  Future<Either<F, T>> safeCall<F, T>({
    required Future<T> Function() call,
    required F Function() onNetworkError,
    required F Function(Object? e) onUnknownError,
    F Function(Response<dynamic>? response)? onResponseError,
  }) async {
    try {
      final T result = await call();
      return right(result);
    } on DioError catch (e) {
      log('BaseService.safeCall: ', error: e);
      try {
        switch (e.type) {
          case DioErrorType.connectTimeout:
            return left(onNetworkError());
          case DioErrorType.sendTimeout:
            return left(onNetworkError());
          case DioErrorType.receiveTimeout:
            return left(onNetworkError());
          case DioErrorType.response:
            return left(onResponseError != null ? onResponseError(e.response) : onUnknownError(e));
          case DioErrorType.cancel:
            return left(onNetworkError());
          case DioErrorType.other:
            if (e.error is SocketException) {
              return left(onNetworkError());
            }
            return left(onUnknownError(e));
        }
      } catch (err) {
        log('BaseService.safeCall: ', error: e);
        return left(onUnknownError(e));
      }
    } catch (e) {
      log('BaseService.safeCall: ', error: e);
      return left(onUnknownError(e));
    }
  }

  @protected
  Future<Either<FetchFailure, T>> safeFetch<T>(
    Future<T> Function() call,
  ) async {
    return safeCall(
      call: call,
      onNetworkError: () => FetchFailure.network(),
      onResponseError: (Response<dynamic>? response) {
        if (response != null && response.statusCode != null) {
          final int statusCode = response.statusCode!;
          if (statusCode >= 500 && statusCode < 600) {
            return FetchFailure.server();
          }
        }
        return FetchFailure.unknown();
      },
      onUnknownError: (Object? e) => FetchFailure.unknown(),
    );
  }

  @protected
  Future<Either<SimpleActionFailure, T>> safeSimpleCall<T>(Future<T> Function() call) async {
    return safeCall(
      call: call,
      onNetworkError: () => SimpleActionFailure.network(),
      onUnknownError: (_) => SimpleActionFailure.unknown(),
    );
  }
}
