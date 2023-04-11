import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.blue,
            ),
            TestWidget(),
            Container(
              height: 1000,
              color: Colors.blue,
            ),
          ],
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
    super.dispose();
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.globalToLocal(Offset.zero);
    entry = OverlayEntry(
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
                    onTap: () {},
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

  void onfocusEvent() {
    if (_focusNode.hasFocus) {
      Overlay.of(context).insert(entry);
    } else {
      entry.remove();
    }
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
