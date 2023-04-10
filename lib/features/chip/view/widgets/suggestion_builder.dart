import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class SuggestionBuilder<T extends ChipViewModel> extends StatelessWidget {
  final T viewModel;
  const SuggestionBuilder({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) {
        return Autocomplete(
          onSelected: (selectedChip) {
            value.selectedEvent(selectedChip);
          },
          displayStringForOption: (option) {
            return '';
          },
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return TextFormField(
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
              controller: textEditingController,
              focusNode: focusNode,
              onFieldSubmitted: (value) {
                onFieldSubmitted();
              },
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    onTap: () => onSelected(options.elementAt(index)),
                    title: Text(options.elementAt(index).value),
                  ),
                );
              },
            );
          },
          optionsBuilder: (textEditingValue) {
            return value.nonSelected.where(
              (element) => element.value.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
            );
          },
        );
      },
    );
  }
}
