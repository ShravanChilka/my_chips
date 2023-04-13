import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/auto_suggession_builder.dart';
import 'package:my_chips/features/chip/view/widgets/item_count_widget.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class ChipView extends StatelessWidget {
  const ChipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chips'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Frameworks',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                const AutoSuggessionBuilder<ChipViewModelFrameworks>(),
                const SizedBox(height: defaultPadding * 0.5),
                const ItemCountWidget<ChipViewModelFrameworks>(),
                const SizedBox(height: 100),
                Text(
                  'Languages',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                const AutoSuggessionBuilder<ChipViewModelLanguages>(),
                const SizedBox(height: defaultPadding * 0.5),
                const ItemCountWidget<ChipViewModelLanguages>(),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
