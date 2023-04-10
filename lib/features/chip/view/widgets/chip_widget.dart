import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String value;
  final void Function()? onDeleted;
  const ChipWidget({
    Key? key,
    required this.value,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      label: Text(value),
      onDeleted: onDeleted,
    );
  }
}
