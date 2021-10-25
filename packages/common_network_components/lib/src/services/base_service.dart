// ignore_for_file: always_specify_types

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
    F Function(Response? response)? onResponseError,
  }) async {
    try {
      final T result = await call();
      return right(result);
    } on DioError catch (e) {
      log('BaseService.safeCall: ', error: e);
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
      onNetworkError: () => const FetchFailure.networkError(),
      onResponseError: (Response? response) {
        if (response != null && response.statusCode != null) {
          final int statusCode = response.statusCode!;
          if (statusCode >= 500 && statusCode < 600) {
            return const FetchFailure.serverError();
          }
        }
        return const FetchFailure.unknownError();
      },
      onUnknownError: (Object? e) => const FetchFailure.unknownError(),
    );
  }

  @protected
  Future<Either<SimpleActionFailure, T>> safeSimpleCall<T>(Future<T> Function() call) async {
    return safeCall(
      call: call,
      onNetworkError: () => const SimpleActionFailure.network(),
      onUnknownError: (_) => const SimpleActionFailure.unknown(),
    );
  }
}
