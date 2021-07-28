import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_failure.freezed.dart';

@freezed
class FetchFailure with _$FetchFailure {
  const factory FetchFailure.serverError() = _ServerError;
  const factory FetchFailure.networkError() = _NetworkError;
  const factory FetchFailure.unknownError() = _EnknownError;
}