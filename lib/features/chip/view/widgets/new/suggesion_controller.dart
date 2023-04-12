import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view/widgets/new/custom_overlay.dart';

@immutable
class SuggestionController {
  final CustomOverlayEntry overlayEntry;
  final OverlayState overlayState;

  const SuggestionController({
    required this.overlayEntry,
    required this.overlayState,
  });

  void hide() {
    overlayEntry.remove();
  }

  void show() {
    if (!overlayEntry.mounted) {
      overlayState.insert(overlayEntry);
    }
  }

  void dispose() {
    overlayState.dispose();
    overlayEntry.dispose();
  }
}
