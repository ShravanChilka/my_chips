import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chips/core/errors/errors.dart';
import 'package:my_chips/features/chip/models/chip_model.dart';
import 'package:my_chips/features/chip/web_services/chip_web_service.dart';

abstract class ChipViewModel extends ChangeNotifier {
  final List<ChipModel> _selected = [];
  final List<ChipModel> _nonSelected = [];
  final List<ChipModel> _all = [];
  ScrollController? _scrollController;
  TextEditingController? _textEditingController;

  final ChipWebService _service;
  ChipViewModel({
    required ChipWebService service,
  }) : _service = service;

  set scrollController(ScrollController value) {
    _scrollController = value;
  }

  set textEditingController(TextEditingController value) {
    _textEditingController = value;
  }

  Future<void> init({
    required String url,
  }) async {
    try {
      final data = await _service.getData(url: url);
      _selected.clear();
      _nonSelected.addAll(data);
      _all.addAll(data);
      notifyListeners();
    } on RemoteException catch (e) {
      log(e.error.toString());
    }
  }

  List<ChipModel> get selected => _selected;
  List<ChipModel> get nonSelected => _nonSelected;
  List<ChipModel> get all => _all;

  void selectedEvent(ChipModel value) {
    _nonSelected.remove(value);
    _selected.add(value);
    animateScroll(200);
    _textEditingController?.text = '';
    onTextChangeEvent('');
    notifyListeners();
  }

  void animateScroll(int value) {
    _scrollController?.animateTo(
      _scrollController!.position.maxScrollExtent - value,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
    );
  }

  void removeEvent(ChipModel value) {
    _selected.remove(value);
    _nonSelected.add(value);
    notifyListeners();
    animateScroll(400);
  }

  void onRawKeyEvent(
    RawKeyEvent keyEvent,
    TextEditingController controller,
  ) {
    if (keyEvent.isKeyPressed(
      LogicalKeyboardKey.backspace,
    )) {
      if (controller.text.isEmpty && selected.isNotEmpty) {
        removeEvent(selected.last);
      }
    }
  }

  void onTextChangeEvent(
    String value,
  ) {
    if (value.isEmpty && _nonSelected.isNotEmpty) {
      _nonSelected.clear();
      _nonSelected.addAll(_all);
    } else {
      _nonSelected.clear();
      _nonSelected.addAll(
        _all
            .where(
              (element) =>
                  element.value.toLowerCase().contains(value.toLowerCase()),
            )
            .toList()
          ..sort(
            (a, b) => a.value.toLowerCase().indexOf(value).compareTo(
                  b.value.toLowerCase().indexOf(value),
                ),
          ),
      );
    }
    for (ChipModel chip in _selected) {
      _nonSelected.removeWhere((element) => element == chip);
    }

    notifyListeners();
  }
}

class ChipViewModelFrameworks extends ChipViewModel {
  ChipViewModelFrameworks()
      : super(
          service: ChipWebServiceFramework(),
        );
}

class ChipViewModelLanguages extends ChipViewModel {
  ChipViewModelLanguages()
      : super(
          service: ChipWebServiceLanguage(),
        );
}
