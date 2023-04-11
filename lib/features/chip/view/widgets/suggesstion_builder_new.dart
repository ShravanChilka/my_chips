import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';
import 'package:provider/provider.dart';

import 'custom_stack.dart';

class SuggesstionBuilderNew<T extends ChipViewModel> extends StatefulWidget {
  const SuggesstionBuilderNew({
    Key? key,
  }) : super(key: key);

  @override
  State<SuggesstionBuilderNew<T>> createState() =>
      _SuggesstionBuilderNewState<T>();
}

class _SuggesstionBuilderNewState<T extends ChipViewModel>
    extends State<SuggesstionBuilderNew<T>> {
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _focusNode.addListener(() => context.read<T>().focusEvents(_focusNode));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStack(
      clipBehavior: Clip.none,
      alignment: Alignment.topLeft,
      fit: StackFit.loose,
      children: [
        SizedBox(
          height: 40,
          width: double.maxFinite,
          child: TextField(
            focusNode: _focusNode,
          ),
        ),
        Positioned(
          top: 50,
          height: 90,
          width: 390,
          child: Consumer<T>(
            builder: (context, value, child) {
              if (!value.isFocused) {
                return const SizedBox.shrink();
              }
              return Material(
                elevation: 5.0,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    interactive: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: value.nonSelected
                            .map((e) => InkWell(
                                  onTap: () {
                                    log(e.toString());
                                  },
                                  child: Chip(
                                    label: Text(e.value),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
