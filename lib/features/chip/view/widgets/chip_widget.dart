import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/models/chip_model.dart';

class ChipWidget extends StatelessWidget {
  final ChipModel chipModel;
  final void Function()? onDeleted;
  const ChipWidget({
    Key? key,
    required this.chipModel,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: const StadiumBorder(),
      backgroundColor: chipModel.difficulty.color,
      side: BorderSide.none,
      label: Text(chipModel.value),
      onDeleted: onDeleted,
    );
  }
}
