// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChipModel _$ChipModelFromJson(Map<String, dynamic> json) {
  return _ChipModel.fromJson(json);
}

/// @nodoc
mixin _$ChipModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  String get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'difficulty')
  Difficulty get difficulty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChipModelCopyWith<ChipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChipModelCopyWith<$Res> {
  factory $ChipModelCopyWith(ChipModel value, $Res Function(ChipModel) then) =
      _$ChipModelCopyWithImpl<$Res, ChipModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'value') String value,
      @JsonKey(name: 'difficulty') Difficulty difficulty});
}

/// @nodoc
class _$ChipModelCopyWithImpl<$Res, $Val extends ChipModel>
    implements $ChipModelCopyWith<$Res> {
  _$ChipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? difficulty = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChipModelCopyWith<$Res> implements $ChipModelCopyWith<$Res> {
  factory _$$_ChipModelCopyWith(
          _$_ChipModel value, $Res Function(_$_ChipModel) then) =
      __$$_ChipModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'value') String value,
      @JsonKey(name: 'difficulty') Difficulty difficulty});
}

/// @nodoc
class __$$_ChipModelCopyWithImpl<$Res>
    extends _$ChipModelCopyWithImpl<$Res, _$_ChipModel>
    implements _$$_ChipModelCopyWith<$Res> {
  __$$_ChipModelCopyWithImpl(
      _$_ChipModel _value, $Res Function(_$_ChipModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? difficulty = null,
  }) {
    return _then(_$_ChipModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChipModel implements _ChipModel {
  const _$_ChipModel(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'value') required this.value,
      @JsonKey(name: 'difficulty') required this.difficulty});

  factory _$_ChipModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChipModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'value')
  final String value;
  @override
  @JsonKey(name: 'difficulty')
  final Difficulty difficulty;

  @override
  String toString() {
    return 'ChipModel(id: $id, value: $value, difficulty: $difficulty)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChipModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, value, difficulty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChipModelCopyWith<_$_ChipModel> get copyWith =>
      __$$_ChipModelCopyWithImpl<_$_ChipModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChipModelToJson(
      this,
    );
  }
}

abstract class _ChipModel implements ChipModel {
  const factory _ChipModel(
          {@JsonKey(name: '_id') required final String id,
          @JsonKey(name: 'value') required final String value,
          @JsonKey(name: 'difficulty') required final Difficulty difficulty}) =
      _$_ChipModel;

  factory _ChipModel.fromJson(Map<String, dynamic> json) =
      _$_ChipModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'value')
  String get value;
  @override
  @JsonKey(name: 'difficulty')
  Difficulty get difficulty;
  @override
  @JsonKey(ignore: true)
  _$$_ChipModelCopyWith<_$_ChipModel> get copyWith =>
      throw _privateConstructorUsedError;
}
