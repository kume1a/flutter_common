import 'dart:developer';

import 'package:meta/meta.dart';

import '../core/empty_result.dart';
import '../core/result.dart';

mixin ResultWrap {
  @protected
  Future<Result<T>> wrapWithResult<T>(Future<T> Function() call) async {
    try {
      final T result = await call();
      return Result.success(result);
    } catch (e) {
      log('', error: e);
      return Result.err();
    }
  }

  @protected
  Future<EmptyResult> wrapWithEmptyResult<T>(Future<T> Function() call) async {
    try {
      await call();
      return EmptyResult.success();
    } catch (e) {
      log('', error: e);
      return EmptyResult.err();
    }
  }
}
