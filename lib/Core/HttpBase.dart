import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BaseModel {
  void fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    return {};
  }
}

class HttpBase {
  static HttpBase? _instance;

  HttpBase._();

  static HttpBase get instance {
    _instance ??= HttpBase._();
    // var client=HttpClient();
    // client.badCertificateCallback=(X509Certificate cert, String host, int port) => true;
    return _instance!;
  }

  final String BASE_URL = 'http://192.168.1.16:5005';

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  addHeader(Map<String, String> param) {
    headers.addAll(param);
  }

  setAuthToken(String token) {
    headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }

  Future<int> post(String url,
      {dynamic bodyData, void Function(http.Response response)? callBack}) async {
    var uri = Uri.parse(BASE_URL + url);
    try {
      var resp =
          await http.post(uri, headers: headers, body: jsonEncode(bodyData));

      if (callBack != null) callBack(resp);
      return resp.statusCode;
    } catch (e) {
      // print(e);
      if (callBack != null) callBack(http.Response(e.toString(), 500));
      return 500;
    }
  }

  Future<int> put(String url,
      {dynamic bodyData, void Function(http.Response response)? callBack}) async {
    var uri = Uri.parse(BASE_URL + url);
    try {
      var resp =
      await http.put(uri, headers: headers, body: jsonEncode(bodyData));

      if (callBack != null) callBack(resp);
      return resp.statusCode;
    } catch (e) {
      // print(e);
      if (callBack != null) callBack(http.Response(e.toString(), 500));
      return 500;
    }
  }

  Future<int> delete(String url,
      {dynamic bodyData, void Function(http.Response response)? callBack}) async {
    var uri = Uri.parse(BASE_URL + url);
    try {
      var resp =
      await http.delete(uri, headers: headers, body: jsonEncode(bodyData));

      if (callBack != null) callBack(resp);
      return resp.statusCode;
    } catch (e) {
      // print(e);
      if (callBack != null) callBack(http.Response(e.toString(), 500));
      return 500;
    }
  }

  Future<http.Response> get(String url) async {
    try {
      final result = await http.get(
        Uri.parse(BASE_URL + url),
        headers: headers,
      );
      return result;
    } catch (e) {
      // print(e);
      return http.Response(e.toString(), 500);
    }
  }


}
