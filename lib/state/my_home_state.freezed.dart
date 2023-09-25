// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyHomePageState {
  int get counter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyHomePageStateCopyWith<MyHomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyHomePageStateCopyWith<$Res> {
  factory $MyHomePageStateCopyWith(
          MyHomePageState value, $Res Function(MyHomePageState) then) =
      _$MyHomePageStateCopyWithImpl<$Res, MyHomePageState>;
  @useResult
  $Res call({int counter});
}

/// @nodoc
class _$MyHomePageStateCopyWithImpl<$Res, $Val extends MyHomePageState>
    implements $MyHomePageStateCopyWith<$Res> {
  _$MyHomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_value.copyWith(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyHomePageStateCopyWith<$Res>
    implements $MyHomePageStateCopyWith<$Res> {
  factory _$$_MyHomePageStateCopyWith(
          _$_MyHomePageState value, $Res Function(_$_MyHomePageState) then) =
      __$$_MyHomePageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int counter});
}

/// @nodoc
class __$$_MyHomePageStateCopyWithImpl<$Res>
    extends _$MyHomePageStateCopyWithImpl<$Res, _$_MyHomePageState>
    implements _$$_MyHomePageStateCopyWith<$Res> {
  __$$_MyHomePageStateCopyWithImpl(
      _$_MyHomePageState _value, $Res Function(_$_MyHomePageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
  }) {
    return _then(_$_MyHomePageState(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MyHomePageState implements _MyHomePageState {
  const _$_MyHomePageState({required this.counter});

  @override
  final int counter;

  @override
  String toString() {
    return 'MyHomePageState(counter: $counter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyHomePageState &&
            (identical(other.counter, counter) || other.counter == counter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, counter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyHomePageStateCopyWith<_$_MyHomePageState> get copyWith =>
      __$$_MyHomePageStateCopyWithImpl<_$_MyHomePageState>(this, _$identity);
}

abstract class _MyHomePageState implements MyHomePageState {
  const factory _MyHomePageState({required final int counter}) =
      _$_MyHomePageState;

  @override
  int get counter;
  @override
  @JsonKey(ignore: true)
  _$$_MyHomePageStateCopyWith<_$_MyHomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
