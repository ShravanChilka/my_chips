import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:my_chips/core/errors/errors.dart';
import 'package:my_chips/features/chip/models/chip_model.dart';
import 'package:my_chips/features/chip/web_services/chip_web_service.dart';

abstract class ChipViewModel extends ChangeNotifier {
  final List<ChipModel> _selected = [];
  final List<ChipModel> _nonSelected = [];
  final List<ChipModel> _all = [];

  final ChipWebService _service;
  ChipViewModel({
    required ChipWebService service,
  }) : _service = service;

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
      log(e.toString());
    }
  }

  List<ChipModel> get selected => _selected;
  List<ChipModel> get nonSelected => _nonSelected;
  List<ChipModel> get all => _all;

  void selectedEvent(ChipModel value) {
    _nonSelected.remove(value);
    _selected.add(value);
    notifyListeners();
  }

  void removeEvent(ChipModel value) {
    _selected.remove(value);
    _nonSelected.add(value);
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
