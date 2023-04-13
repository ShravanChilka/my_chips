import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class CustomSearchField<T extends ChipViewModel> extends StatelessWidget {
  final LayerLink layerLink;
  final GlobalKey widgetKey;
  final ScrollController scrollController;
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomSearchField({
    Key? key,
    required this.layerLink,
    required this.widgetKey,
    required this.scrollController,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      key: widgetKey,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * 0.2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: Row(
            children: [
              SelectedBuilder<T>(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RawKeyboardListener(
                  onKey: (keyEvent) =>
                      context.read<T>().onRawKeyEvent(keyEvent, controller),
                  focusNode: focusNode,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    controller: controller,
                    onChanged: (query) =>
                        context.read<T>().onTextChangeEvent(query),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
