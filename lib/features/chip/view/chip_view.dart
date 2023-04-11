import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/suggestion_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class ChipView<T extends ChipViewModel> extends StatelessWidget {
  const ChipView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SelectedBuilder<T>(viewModel: viewModel),
        SuggestionBuilder<T>(),
      ],
    );
  }
}
