import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:ui_practice/models/response_model.dart';

class HttpService {
  Dio? _dio;

  HttpService() {
    BaseOptions options = new BaseOptions(
      baseUrl:
          'https://epistolary-example.000webhostapp.com/', // 'https://simplyclear.myrwds.com/api/', //
      connectTimeout: 100000,
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, PUT, POST, DELETE, OPTIONS",
        "Access-Control-Allow-Headers":
            "Origin, Content-Type, X-Auth-Token , Authorization"
      },
      contentType: "application/json",

      receiveTimeout: 30000,
    );
    _dio = Dio(options);
  }

  Future<ResponseModel?> get({String? path}) async {
    try {
      final tmp = await _dio?.get(path!);
      print("Response :$tmp");
      return ResponseModel.fromJson(json.decode(tmp.toString()));
    } on Exception catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future<ResponseModel?> post(
      {String? path, Map<String, dynamic>? body}) async {
    try {
      print("Requested URL : $path");
      final tmp = await _dio!.post(
        path!,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: body,
      );
      print("Response Data: $tmp");
      return ResponseModel.fromJson(json.decode(tmp.toString()));
    } on Exception catch (e) {
      print(" Exceptions $e");
      return null;
    }
  }
}
