import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AbstractService {
  static const backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://localhost:8080/',
  );

  final _client = http.Client();

  Uri _getUri(String path) {
    String uriString = backendUrl + path;

    return Uri.parse(uriString);
  }

  Future<http.Response> get(path, [menuDay]) {
    if (menuDay != null)
    {
      var pathnew = Uri.parse(backendUrl + path).replace(queryParameters: {
        'menuDay': menuDay,
        });
      return _client.get(pathnew, headers: getHeaders());
    }
    else
    {
      return _client.get(_getUri(path), headers: getHeaders());
    }

  }

  Future<http.Response> post(path, String body) {
    return _client.post(_getUri(path), body: body, headers: getHeaders());
  }

  Future<http.Response> put(path, String body) {
    return _client.put(_getUri(path), body: body, headers: getHeaders(), encoding: Encoding.getByName("utf-8"));
  }

  Future<http.Response> delete(path, String body) {
    return _client.delete(_getUri(path), body: body, headers: getHeaders());
  }
  /// Set X-XSRF-TOKEN header if cookie is set
  Map<String, String> getHeaders() {
    var headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };
    return headers;
  }
}
