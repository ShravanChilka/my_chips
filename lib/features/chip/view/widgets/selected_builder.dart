import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_chips/features/chip/view/widgets/chip_widget.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class SelectedBuilder<T extends ChipViewModel> extends StatelessWidget {
  const SelectedBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) {
        return Wrap(
          clipBehavior: Clip.hardEdge,
          children: value.selected
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ChipWidget(
                    chipModel: e,
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
