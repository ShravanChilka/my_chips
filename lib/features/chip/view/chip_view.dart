import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/suggesstion_builder_new.dart';
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
        // SuggestionBuilder<T>(viewModel: viewModel),
        // SelectedBuilder<T>(viewModel: viewModel),
        SuggesstionBuilderNew<T>(),
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
