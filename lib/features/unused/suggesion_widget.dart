import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/custom_overlay.dart';
import 'package:my_chips/features/chip/view/widgets/custom_search_field.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:my_chips/features/unused/suggesion_controller.dart';

class SuggesionWidget<T extends ChipViewModel> extends StatefulWidget {
  const SuggesionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SuggesionWidget<T>> createState() => _SuggesionWidgetState<T>();
}

class _SuggesionWidgetState<T extends ChipViewModel>
    extends State<SuggesionWidget<T>> {
  late final ScrollController _scrollController;
  late final TextEditingController _controller;
  late final LayerLink _layerLink;
  late final GlobalKey _widgetKey;
  late final SuggestionController _suggestionController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = TextEditingController();
    _layerLink = LayerLink();
    _widgetKey = GlobalKey();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField(
      layerLink: _layerLink,
      widgetKey: _widgetKey,
      scrollController: _scrollController,
      controller: _controller,
      focusNode: _suggestionController.focusNode,
    );
  }
}
