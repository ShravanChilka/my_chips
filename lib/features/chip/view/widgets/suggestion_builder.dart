import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class SuggestionBuilder<T extends ChipViewModel> extends StatefulWidget {
  const SuggestionBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<SuggestionBuilder<T>> createState() => _SuggestionBuilderState<T>();
}

class _SuggestionBuilderState<T extends ChipViewModel>
    extends State<SuggestionBuilder<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) {
        return Autocomplete(
          optionsMaxHeight: 200,
          onSelected: (selectedChip) {
            value.selectedEvent(selectedChip);
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent * 0.6,
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
            );
          },
          displayStringForOption: (option) => '',
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.2,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: [
                    SelectedBuilder<T>(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RawKeyboardListener(
                        onKey: (keyEvent) {
                          if (keyEvent.isKeyPressed(
                            LogicalKeyboardKey.backspace,
                          )) {
                            if (textEditingController.text.isEmpty &&
                                value.selected.isNotEmpty) {
                              value.removeEvent(value.selected.last);
                            }
                          }
                        },
                        focusNode: focusNode,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          controller: textEditingController,
                          onFieldSubmitted: (value) {
                            onFieldSubmitted();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    onTap: () => onSelected(
                      options.elementAt(index),
                    ),
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
