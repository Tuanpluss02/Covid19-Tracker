import 'package:covid19_tracker/model/covid.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final String _url = "https://api.covid19api.com/summary";
  final Dio _dio = Dio();
  Future<CovidModel> getCovid() async {
    try {
      final Response response = await _dio.get(_url);
      return CovidModel.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return CovidModel.withError("$error");
    }
  }
}
