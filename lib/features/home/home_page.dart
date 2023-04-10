import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/chip_view.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            const Text('Select Frameworks'),
            ChipView<ChipViewModelFrameworks>(
              viewModel: ChipViewModelFrameworks(),
            ),
            const SizedBox(height: defaultPadding),
            const Text('Select Languages'),
            ChipView<ChipViewModelLanguages>(
              viewModel: ChipViewModelLanguages(),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
