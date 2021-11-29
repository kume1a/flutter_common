import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_page.freezed.dart';

@freezed
class DataPage<T> with _$DataPage<T> {
  const factory DataPage({
    required List<T> items,
    required int count,
  }) = _DataPage<T>;

  factory DataPage.empty() => DataPage<T>(items: List<T>.empty(growable: true), count: 0);
}
