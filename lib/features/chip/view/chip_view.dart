import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
import 'package:my_chips/features/chip/view/widgets/suggestion_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class ChipView<T extends ChipViewModel> extends StatelessWidget {
  final T viewModel;
  const ChipView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuggestionBuilder<T>(viewModel: viewModel),
        SelectedBuilder<T>(viewModel: viewModel),
      ],
    );
  }
}
