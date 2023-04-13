import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/custom_overlay.dart';
import 'package:my_chips/features/chip/view/widgets/custom_search_field.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class AutoSuggessionBuilder<T extends ChipViewModel> extends StatefulWidget {
  final double overlayHeight;
  const AutoSuggessionBuilder({
    super.key,
    this.overlayHeight = 120,
  });

  @override
  State<AutoSuggessionBuilder<T>> createState() =>
      _AutoSuggessionBuilderState<T>();
}

class _AutoSuggessionBuilderState<T extends ChipViewModel>
    extends State<AutoSuggessionBuilder<T>> {
  late final OverlayEntry overlayEntry;
  late final LayerLink _layerLink;
  late final FocusNode _focusNode;
  late final GlobalKey _widgetKey;
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _widgetKey = GlobalKey();
    _layerLink = LayerLink();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    context.read<T>().scrollController = _scrollController;
    context.read<T>().textEditingController = _controller;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => buildOverlay(),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
  }

  void buildOverlay() {
    overlayEntry = CustomOverlayEntry<T>(
      widgetKey: _widgetKey,
      overlayHeight: widget.overlayHeight,
      layerLink: _layerLink,
    );
  }

  void showOverlay() {
    if (!overlayEntry.mounted) {
      Overlay.of(context).insert(overlayEntry);
    }
  }

  void hideOverlay() {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField<T>(
      layerLink: _layerLink,
      widgetKey: _widgetKey,
      scrollController: _scrollController,
      controller: _controller,
      focusNode: _focusNode,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _layerLink.leader?.dispose();
    super.dispose();
  }
}
