import 'package:flutter/material.dart';

class CustomAutoComplete extends StatefulWidget {
  final void Function(FocusNode focusNode)? onFocusChanged;
  final bool Function()? showOverlay;
  final Widget overlayBuilder;
  final double overlayHeight;

  final Widget Function() fieldBuilder;

  const CustomAutoComplete({
    Key? key,
    this.onFocusChanged,
    this.showOverlay,
    required this.overlayBuilder,
    this.overlayHeight = 200,
    required this.fieldBuilder,
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
    _focusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showOverlay(),
    );
  }

  void showOverlay() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          height: widget.overlayHeight,
          child: CompositedTransformFollower(
            offset: Offset(0, size.height),
            link: _link,
            child: widget.overlayBuilder,
          ),
        );
      },
    );
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
    return widget.fieldBuilder();
  }
}
