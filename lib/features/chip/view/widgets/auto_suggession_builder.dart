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
  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();
  final GlobalKey widgetKey = GlobalKey();
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ScrollController suggestionScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<T>().scrollController = scrollController;
    context.read<T>().textEditingController = controller;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => buildOverlay(),
    );
    focusNode.addListener(onFocusNodeEvent);
  }

  void onFocusNodeEvent() {
    focusNode.hasFocus ? showOverlay() : hideOverlay();
  }

  void buildOverlay() {
    overlayEntry = CustomOverlayEntry<T>(
      widgetKey: widgetKey,
      overlayHeight: widget.overlayHeight,
      layerLink: layerLink,
      scrollController: suggestionScrollController,
    );
  }

  void showOverlay() {
    if (!overlayEntry.mounted) {
      Overlay.of(context).insert(overlayEntry);
    }
  }

  void hideOverlay() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField<T>(
      layerLink: layerLink,
      widgetKey: widgetKey,
      scrollController: scrollController,
      controller: controller,
      focusNode: focusNode,
    );
  }

  @override
  void dispose() {
    overlayEntry.dispose();
    controller.dispose();
    scrollController.dispose();
    suggestionScrollController.dispose();
    focusNode.dispose();
    layerLink.leader?.dispose();
    super.dispose();
  }
}
