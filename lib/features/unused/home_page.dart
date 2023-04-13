import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chips/config/styles.dart';
import 'package:my_chips/features/chip/view/widgets/auto_suggession_builder.dart';
import 'package:my_chips/features/chip/view_model/chip_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Select Frameworks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const AutoSuggessionBuilder<ChipViewModelFrameworks>(),
                const SizedBox(height: 200),
                Text(
                  'Select Languages',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const AutoSuggessionBuilder<ChipViewModelLanguages>(),
                const SizedBox(height: 500),
                // SuggesionWidget<ChipViewModelLanguages>()
                // TestWidget(),
              ],
            ),
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
        return CompositedTransformFollower(
          targetAnchor: Alignment.bottomLeft,
          // followerAnchor: Alignment.bottomLeft,
          // offset: Offset(0, size.height),
          link: _link,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Material(
                    child: ListTile(
                      onTap: () {
                        _controller.text = 'Person $index';
                        log('Person $index');
                        // hideOverlay();
                      },
                      title: Text('Person $index'),
                    ),
                  );
                },
              ),
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
      entry.remove();
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
