import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:my_chips/core/errors/errors.dart';
import 'package:my_chips/features/chip/models/chip_model.dart';

//! RUN THE LIVE Extension in VSCODE : ritwickdey.LiveServer

@immutable
abstract class ChipWebService {
  final Dio client;

  ChipWebService() : client = Dio();

  Future<List<ChipModel>> getData({
    required String url,
  }) async {
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((e) => ChipModel.fromJson(e))
            .toList();
      } else {
        throw RemoteException(
          error: 'invalid status code : ${response.statusCode}',
        );
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
