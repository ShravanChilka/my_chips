import 'dart:developer';
import 'package:flutter/material.dart';

class CustomAutoComplete extends StatefulWidget {
  final void Function(FocusNode focusNode, OverlayEntry entry)? onFocusChanged;
  final bool Function() showOverlay;
  final Widget Function(
    BuildContext context,
    OverlayEntry entry,
    void Function(OverlayEntry entry) onSelected,
    FocusNode focusNode,
  ) overlayBuilder;
  final double overlayHeight;
  final void Function(OverlayEntry entry) onSelected;

  final Widget Function(
    BuildContext context,
    FocusNode focusNode,
    TextEditingController controller,
  ) fieldBuilder;

  const CustomAutoComplete({
    Key? key,
    this.onFocusChanged,
    required this.showOverlay,
    required this.overlayBuilder,
    this.overlayHeight = 200,
    required this.fieldBuilder,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CustomAutoComplete> createState() => _CustomAutoCompleteState();
}

class _CustomAutoCompleteState extends State<CustomAutoComplete> {
  late final OverlayEntry entry;
  late final LayerLink _link;
  late final FocusNode _focusNode;
  late final GlobalKey _key;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _key = GlobalKey();
    _link = LayerLink();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showOverlay(),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Overlay.of(context).insert(entry);
      } else {
        entry.remove();
      }
    });
  }

  void showOverlay() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    log('size : $size\noffset : $offset');
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          height: widget.overlayHeight,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            offset: Offset(0, size.height),
            link: _link,
            child: widget.overlayBuilder(
                context, entry, widget.onSelected, _focusNode),
          ),
        );
      },
    );
  }

  void hideOverlay() {
    entry.remove();
  }

  @override
  void dispose() {
    _link.leader?.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      key: _key,
      child: widget.fieldBuilder(context, _focusNode, _controller),
    );
  }
}
