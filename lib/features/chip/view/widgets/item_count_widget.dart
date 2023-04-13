import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class ItemCountWidget<T extends ChipViewModel> extends StatelessWidget {
  const ItemCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${value.selected.length} Selected',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
