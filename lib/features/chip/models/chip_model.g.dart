// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChipModel _$$_ChipModelFromJson(Map<String, dynamic> json) => _$_ChipModel(
      id: json['_id'] as String,
      value: json['value'] as String,
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
    );

Map<String, dynamic> _$$_ChipModelToJson(_$_ChipModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'value': instance.value,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
    };

const _$DifficultyEnumMap = {
  Difficulty.low: 'low',
  Difficulty.medium: 'medium',
  Difficulty.high: 'high',
};
