import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_chips/config/styles.dart';

part 'chip_model.freezed.dart';
part 'chip_model.g.dart';

@freezed
class ChipModel with _$ChipModel {
  const factory ChipModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'value') required String value,
    @JsonKey(name: 'difficulty') required Difficulty difficulty,
  }) = _ChipModel;

  factory ChipModel.fromJson(Map<String, Object?> json) =>
      _$ChipModelFromJson(json);
}

enum Difficulty {
  low,
  medium,
  high,
}

extension GetColor on Difficulty {
  Color get color {
    switch (this) {
      case Difficulty.low:
        return Palette.orange;
      case Difficulty.medium:
        return Palette.green;
      case Difficulty.high:
        return Palette.purple;
    }
  }
}
