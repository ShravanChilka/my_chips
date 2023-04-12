import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/new/custom_overlay.dart';
import 'package:my_chips/features/chip/view/widgets/new/suggesion_controller.dart';
import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class SuggesionWidget<T extends ChipViewModel> extends StatefulWidget {
  const SuggesionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SuggesionWidget<T>> createState() => _SuggesionWidgetState<T>();
}

class _SuggesionWidgetState<T extends ChipViewModel>
    extends State<SuggesionWidget<T>> {
  late final SuggestionController _suggestionController;
  late final ScrollController _scrollController;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _controller = TextEditingController();
    _suggestionController = SuggestionController(
      overlayEntry: CustomOverlayEntry(
        layerLink: LayerLink(),
        overlayHeight: 100,
        widgetKey: GlobalKey(),
      ),
      overlayState: OverlayState(),
    );
  }

  @override
  void dispose() {
    _suggestionController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _suggestionController.overlayEntry.layerLink,
      key: _suggestionController.overlayEntry.widgetKey,
      child: Container(
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
                child: Consumer<T>(
                  builder: (context, value, child) {
                    return RawKeyboardListener(
                      onKey: (keyEvent) =>
                          value.onRawKeyEvent(keyEvent, _controller),
                      focusNode: _focusNode,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        controller: _controller,
                        onChanged: (query) => value.onTextChangeEvent(query),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
