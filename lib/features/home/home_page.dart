import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/chip_view.dart';
import 'package:my_chips/features/chip/view/widgets/auto_suggession_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: const [
              SizedBox(height: 100),
              AutoSuggessionBuilder<ChipViewModelFrameworks>(),
              SizedBox(height: 100),
              AutoSuggessionBuilder<ChipViewModelLanguages>(),
            ],
          ),
        ),
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late final TextEditingController _controller;
  late final OverlayEntry entry;
  late final LayerLink _link;
  late final FocusNode _focusNode;
  late final GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _key = GlobalKey();
    _link = LayerLink();
    _controller = TextEditingController();
    _focusNode.addListener(onfocusEvent);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showOverlay(),
    );
  }

  @override
  void dispose() {
    _link.leader?.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.globalToLocal(Offset.zero);

    entry = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Positioned(
          width: size.width,
          height: 200,
          child: CompositedTransformFollower(
            offset: Offset(0, size.height),
            link: _link,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    onTap: () {
                      _controller.text = 'Person $index';
                      log('Person $index');
                      hideOverlay();
                    },
                    title: Text('Person $index'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void hideOverlay() {
    entry.remove();
  }

  void onfocusEvent() {
    if (_focusNode.hasFocus) {
      Overlay.of(context).insert(entry);
    } else {
      // entry.remove();
    }
    log('focusEvent : ${_focusNode.hasFocus}');
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: TextField(
        focusNode: _focusNode,
        key: _key,
        controller: _controller,
      ),
    );
  }
}
