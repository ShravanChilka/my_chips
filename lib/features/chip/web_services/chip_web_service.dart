import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:my_chips/core/errors/errors.dart';
import 'package:my_chips/features/chip/models/chip_model.dart';
import 'package:my_chips/features/chip/view/utils/mock_api.dart';

//! RUN THE LIVE Extension in VSCODE : ritwickdey.LiveServer

@immutable
abstract class ChipWebService {
  final Dio client;

  ChipWebService() : client = Dio();

  Future<List<ChipModel>> getData({
    required String url,
  }) async {
    try {
      if (url.contains('frameworks')) {
        return frameworks.map((e) => ChipModel.fromJson(e)).toList();
      } else {
        return languages.map((e) => ChipModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}

@immutable
class ChipWebServiceFramework extends ChipWebService {}

@immutable
class ChipWebServiceLanguage extends ChipWebService {}
