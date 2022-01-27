// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DataPageTearOff {
  const _$DataPageTearOff();

  _DataPage<T> call<T>({required List<T> data, required int count}) {
    return _DataPage<T>(
      data: data,
      count: count,
    );
  }
}

/// @nodoc
const $DataPage = _$DataPageTearOff();

/// @nodoc
mixin _$DataPage<T> {
  List<T> get data => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataPageCopyWith<T, DataPage<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataPageCopyWith<T, $Res> {
  factory $DataPageCopyWith(
          DataPage<T> value, $Res Function(DataPage<T>) then) =
      _$DataPageCopyWithImpl<T, $Res>;
  $Res call({List<T> data, int count});
}

/// @nodoc
class _$DataPageCopyWithImpl<T, $Res> implements $DataPageCopyWith<T, $Res> {
  _$DataPageCopyWithImpl(this._value, this._then);

  final DataPage<T> _value;
  // ignore: unused_field
  final $Res Function(DataPage<T>) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$DataPageCopyWith<T, $Res>
    implements $DataPageCopyWith<T, $Res> {
  factory _$DataPageCopyWith(
          _DataPage<T> value, $Res Function(_DataPage<T>) then) =
      __$DataPageCopyWithImpl<T, $Res>;
  @override
  $Res call({List<T> data, int count});
}

/// @nodoc
class __$DataPageCopyWithImpl<T, $Res> extends _$DataPageCopyWithImpl<T, $Res>
    implements _$DataPageCopyWith<T, $Res> {
  __$DataPageCopyWithImpl(
      _DataPage<T> _value, $Res Function(_DataPage<T>) _then)
      : super(_value, (v) => _then(v as _DataPage<T>));

  @override
  _DataPage<T> get _value => super._value as _DataPage<T>;

  @override
  $Res call({
    Object? data = freezed,
    Object? count = freezed,
  }) {
    return _then(_DataPage<T>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_DataPage<T> implements _DataPage<T> {
  const _$_DataPage({required this.data, required this.count});

  @override
  final List<T> data;
  @override
  final int count;

  @override
  String toString() {
    return 'DataPage<$T>(data: $data, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataPage<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), count);

  @JsonKey(ignore: true)
  @override
  _$DataPageCopyWith<T, _DataPage<T>> get copyWith =>
      __$DataPageCopyWithImpl<T, _DataPage<T>>(this, _$identity);
}

abstract class _DataPage<T> implements DataPage<T> {
  const factory _DataPage({required List<T> data, required int count}) =
      _$_DataPage<T>;

  @override
  List<T> get data;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$DataPageCopyWith<T, _DataPage<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
