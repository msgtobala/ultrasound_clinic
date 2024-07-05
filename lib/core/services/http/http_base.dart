import 'dart:async' show Future;

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import 'package:ultrasound_clinic/core/interceptors/http/http_interceptor.dart';

class HttpBase {
  String? _baseUrl;
  late InterceptedHttp client;

  // Private constructor
  HttpBase._privateConstructor() {
    client = InterceptedHttp.build(interceptors: [HttpBaseInterceptor()]);
  }

  // The single instance of HttpBase, initialized lazily
  static final HttpBase _instance = HttpBase._privateConstructor();

  // Factory constructor to return the _instance
  factory HttpBase() {
    return _instance;
  }

  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  // Asynchronous GET method
  Future<http.Response> get(String endpoint) async {
    final url = _baseUrl != null
        ? Uri.parse('$_baseUrl$endpoint')
        : Uri.parse(endpoint);
    return await client.get(url);
  }
}
