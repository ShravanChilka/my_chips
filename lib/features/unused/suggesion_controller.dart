import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/custom_overlay.dart';

@immutable
class SuggestionController {
  final CustomOverlayEntry overlayEntry;
  final OverlayState overlayState;
  final FocusNode focusNode;

  const SuggestionController({
    required this.overlayEntry,
    required this.overlayState,
    required this.focusNode,
  });

  void hide() {
    overlayEntry.remove();
  }

  void show() {
    if (overlayEntry.mounted) {
      overlayState.insert(overlayEntry);
    } else {
      log(overlayEntry.toString());
    }
  }

  void dispose() {
    focusNode.dispose();
    overlayState.dispose();
    overlayEntry.dispose();
  }
}
