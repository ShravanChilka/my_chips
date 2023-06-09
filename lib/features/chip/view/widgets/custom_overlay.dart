import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/utils/utils.dart';
import 'package:my_chips/features/chip/view/widgets/chip_widget.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class CustomOverlayEntry<T extends ChipViewModel> extends OverlayEntry {
  final GlobalKey widgetKey;
  final double overlayHeight;
  final LayerLink layerLink;
  final ScrollController scrollController;

  CustomOverlayEntry({
    required this.widgetKey,
    required this.overlayHeight,
    required this.layerLink,
    required this.scrollController,
  }) : super(builder: (context) {
          final renderBox =
              widgetKey.currentContext?.findRenderObject() as RenderBox;
          final size = renderBox.size;
          return Positioned(
            width: size.width,
            height: overlayHeight,
            child: CompositedTransformFollower(
              showWhenUnlinked: false,
              offset: Offset(0, size.height),
              link: layerLink,
              child: Consumer<T>(
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: kOverlayBorder,
                    child: Material(
                      color: Colors.white,
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: value.nonSelected.isNotEmpty
                              ? Wrap(
                                  clipBehavior: Clip.hardEdge,
                                  children: value.nonSelected
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                          ),
                                          child: GestureDetector(
                                            onTap: () => value.selectedEvent(e),
                                            child: ChipWidget(chipModel: e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Column(
                                  children: [
                                    const SizedBox(height: defaultPadding),
                                    Center(
                                      child: value.all.length ==
                                              value.selected.length
                                          ? const Text('All elements added!')
                                          : const Text('No results found!'),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
}
