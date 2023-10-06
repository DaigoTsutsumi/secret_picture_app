// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FolderViewState {
  List<Folder>? get folders => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<String>? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FolderViewStateCopyWith<FolderViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderViewStateCopyWith<$Res> {
  factory $FolderViewStateCopyWith(
          FolderViewState value, $Res Function(FolderViewState) then) =
      _$FolderViewStateCopyWithImpl<$Res, FolderViewState>;
  @useResult
  $Res call({List<Folder>? folders, List<String>? images, List<String>? name});
}

/// @nodoc
class _$FolderViewStateCopyWithImpl<$Res, $Val extends FolderViewState>
    implements $FolderViewStateCopyWith<$Res> {
  _$FolderViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folders = freezed,
    Object? images = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      folders: freezed == folders
          ? _value.folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<Folder>?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FolderViewStateCopyWith<$Res>
    implements $FolderViewStateCopyWith<$Res> {
  factory _$$_FolderViewStateCopyWith(
          _$_FolderViewState value, $Res Function(_$_FolderViewState) then) =
      __$$_FolderViewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Folder>? folders, List<String>? images, List<String>? name});
}

/// @nodoc
class __$$_FolderViewStateCopyWithImpl<$Res>
    extends _$FolderViewStateCopyWithImpl<$Res, _$_FolderViewState>
    implements _$$_FolderViewStateCopyWith<$Res> {
  __$$_FolderViewStateCopyWithImpl(
      _$_FolderViewState _value, $Res Function(_$_FolderViewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folders = freezed,
    Object? images = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_FolderViewState(
      folders: freezed == folders
          ? _value._folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<Folder>?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      name: freezed == name
          ? _value._name
          : name // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$_FolderViewState implements _FolderViewState {
  const _$_FolderViewState(
      {final List<Folder>? folders,
      final List<String>? images,
      final List<String>? name})
      : _folders = folders,
        _images = images,
        _name = name;

  final List<Folder>? _folders;
  @override
  List<Folder>? get folders {
    final value = _folders;
    if (value == null) return null;
    if (_folders is EqualUnmodifiableListView) return _folders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _name;
  @override
  List<String>? get name {
    final value = _name;
    if (value == null) return null;
    if (_name is EqualUnmodifiableListView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FolderViewState(folders: $folders, images: $images, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FolderViewState &&
            const DeepCollectionEquality().equals(other._folders, _folders) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._name, _name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_folders),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_name));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FolderViewStateCopyWith<_$_FolderViewState> get copyWith =>
      __$$_FolderViewStateCopyWithImpl<_$_FolderViewState>(this, _$identity);
}

abstract class _FolderViewState implements FolderViewState {
  const factory _FolderViewState(
      {final List<Folder>? folders,
      final List<String>? images,
      final List<String>? name}) = _$_FolderViewState;

  @override
  List<Folder>? get folders;
  @override
  List<String>? get images;
  @override
  List<String>? get name;
  @override
  @JsonKey(ignore: true)
  _$$_FolderViewStateCopyWith<_$_FolderViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
