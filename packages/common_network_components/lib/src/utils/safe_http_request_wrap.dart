import 'dart:developer';
import 'dart:io';

import 'package:common_models/common_models.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

mixin SafeHttpRequestWrap {
  @protected
  Future<Either<F, T>> callCatch<F, T>(
    Future<T> Function() call, {
    required F networkError,
    required F unknownError,
    F Function(Response<dynamic>? response)? onResponseError,
  }) async {
    try {
      final T result = await call();
      return right(result);
    } on DioException catch (e) {
      try {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.connectionError:
          case DioExceptionType.cancel:
            return left(networkError);
          case DioExceptionType.badResponse:
            return left(onResponseError != null ? onResponseError(e.response) : unknownError);
          default:
            if (e.error is SocketException) {
              return left(networkError);
            }
            return left(unknownError);
        }
      } catch (err) {
        log('', error: e);
        return left(unknownError);
      }
    } catch (e) {
      log('', error: e);
      return left(unknownError);
    }
  }

  @protected
  Future<Either<NetworkCallError, T>> callCatchHandleNetworkCallError<T>(
    Future<T> Function() call,
  ) async {
    return callCatch(
      call,
      networkError: NetworkCallError.network,
      unknownError: NetworkCallError.unknown,
      onResponseError: (response) {
        if (response?.statusCode == null) {
          return NetworkCallError.unknown;
        }

        if (response!.statusCode! >= 500) {
          return NetworkCallError.internalServer;
        }

        return NetworkCallError.unknown;
      },
    );
  }
}
