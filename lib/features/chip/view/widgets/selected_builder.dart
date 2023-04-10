import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_chips/features/chip/view/widgets/chip_widget.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class SelectedBuilder<T extends ChipViewModel> extends StatelessWidget {
  final T viewModel;
  const SelectedBuilder({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) {
        return Wrap(
          children: value.selected
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ChipWidget(
                    value: e.value,
                    onDeleted: () {
                      value.removeEvent(e);
                    },
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}