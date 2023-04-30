import 'dart:isolate';

import 'package:covid19_tracker/model/covid.dart';
import 'package:covid19_tracker/resources/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  void isolateEntry(SendPort sendPort) async {
    final result = await _apiProvider.getCovid();
    sendPort.send(result);
  }

  Future<CovidModel> getCovidWithIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(isolateEntry, receivePort.sendPort);
    final result = await receivePort.first as CovidModel;
    return result;
  }
}

class NetworkError extends Error {}
