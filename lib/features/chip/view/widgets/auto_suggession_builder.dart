import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/chip_widget.dart';
import 'package:my_chips/features/chip/view/widgets/selected_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

class AutoSuggessionBuilder<T extends ChipViewModel> extends StatefulWidget {
  final double overlayHeight;
  const AutoSuggessionBuilder({
    super.key,
    this.overlayHeight = 100,
  });

  @override
  State<AutoSuggessionBuilder<T>> createState() =>
      _AutoSuggessionBuilderState<T>();
}

class _AutoSuggessionBuilderState<T extends ChipViewModel>
    extends State<AutoSuggessionBuilder<T>> {
  late final OverlayEntry entry;
  late final LayerLink _link;
  late final FocusNode _focusNode;
  late final GlobalKey _key;
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _key = GlobalKey();
    _link = LayerLink();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => buildOverlay(),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Overlay.of(context).insert(entry);
      } else {
        entry.remove();
      }
    });
  }

  void buildOverlay() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          height: widget.overlayHeight,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            offset: Offset(0, size.height),
            link: _link,
            child: Consumer<T>(
              builder: (context, value, child) {
                return Material(
                  child: Wrap(
                    children: value.nonSelected
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              value.selectedEvent(e);
                              _focusNode.requestFocus();
                            },
                            child: ChipWidget(value: e.value),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showOverlay() {
    if (!entry.mounted) {
      Overlay.of(context).insert(entry);
    }
  }

  void hideOverlay() {
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      key: _key,
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
                      onKey: (keyEvent) {
                        if (keyEvent.isKeyPressed(
                          LogicalKeyboardKey.backspace,
                        )) {
                          if (_controller.text.isEmpty &&
                              value.selected.isNotEmpty) {
                            value.removeEvent(value.selected.last);
                          }
                        }
                      },
                      focusNode: _focusNode,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        controller: _controller,
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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _link.leader?.dispose();
    super.dispose();
  }
}
