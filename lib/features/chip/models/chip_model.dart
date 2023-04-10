import 'package:freezed_annotation/freezed_annotation.dart';

part 'chip_model.freezed.dart';
part 'chip_model.g.dart';

@freezed
class ChipModel with _$ChipModel {
  const factory ChipModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'value') required String value,
  }) = _ChipModel;

  factory ChipModel.fromJson(Map<String, Object?> json) =>
      _$ChipModelFromJson(json);
}
