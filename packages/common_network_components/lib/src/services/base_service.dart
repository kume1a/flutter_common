import 'dart:developer';
import 'dart:io';

import 'package:common_models/common_models.dart';
import 'package:dio/dio.dart';


abstract class BaseService {

  Future<Either<F, T>> safeCall<F, T>({
    required Future<T> Function() call,
    required F Function() onNetworkError,
    required F Function(Response? response) onResponseError, // ignore: always_specify_types
    required F Function(Exception e) onUnknownError,
  }) async {
    try {
      final T result = await call();
      return right(result);
    } on DioError catch (e) {
      log('UserService.safeCall: ', error: e);
      switch (e.type) {
        case DioErrorType.connectTimeout:
          return left(onNetworkError());
        case DioErrorType.sendTimeout:
          return left(onNetworkError());
        case DioErrorType.receiveTimeout:
          return left(onNetworkError());
        case DioErrorType.response:
          return left(onResponseError(e.response));
        case DioErrorType.cancel:
          return left(onNetworkError());
        case DioErrorType.other:
          if (e.error is SocketException) {
            return left(onNetworkError());
          }
          return left(onUnknownError(e));
      }
    }
  }

  Future<Either<FetchFailure, T>> safeFetch<T>(Future<T> Function() call) async {
    return safeCall(
      call: call,
      onNetworkError: () => const FetchFailure.networkError(),
      // ignore: always_specify_types
      onResponseError: (Response? response) {
        if (response != null && response.statusCode != null) {
          final int statusCode = response.statusCode!;
          if (statusCode >= 500 && statusCode < 600) {
            return const FetchFailure.serverError();
          }
        }
        return const FetchFailure.unknownError();
      },
      onUnknownError: (Exception e) => const FetchFailure.unknownError(),
    );
  }
}