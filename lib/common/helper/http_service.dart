import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

class HttpService {
  static const Duration _timeOutDuration = Duration(hours: 1);
  static const String errorMessageString = "message";
  static Future<dynamic> get(String url, {Map<String, String>? headers, bool isContentTypeJson = true}) async {
    log("------------GET--------------");
    log(url, name: "Url");
    if (isContentTypeJson) {
      headers?.addAll(
        {"Content-Type": "application/json"},
      );
    }
    final response = await http
        .get(
          Uri.parse(url),
          headers: headers,
        )
        .timeout(_timeOutDuration);
    return _returnResponse(response);
  }

  static Future<dynamic> post(String url,
      {Map<String, String>? headers, dynamic body, bool isContentTypeJson = true}) async {
    log("------------POST--------------");
    log(url, name: "Url");
    log(body.toString(), name: "Body");

    if (isContentTypeJson) {
      headers?.addAll(
        {"Content-Type": "application/json"},
      );
    }
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return _returnResponse(response);
  }

  static Future<dynamic> put(String url,
      {Map<String, String>? headers, dynamic body, bool isContentTypeJson = true}) async {
    log("------------PUT--------------");
    log(url, name: "Url");
    log(body.toString(), name: "Body");
    if (isContentTypeJson) {
      headers?.addAll(
        {"Content-Type": "application/json"},
      );
    }
    final response = await http
        .put(
          Uri.parse(url),
          headers: headers,
          body: body,
        )
        .timeout(_timeOutDuration);
    return _returnResponse(response);
  }

  static Future<dynamic> delete(String url,
      {Map<String, String>? headers, dynamic body, bool isContentTypeJson = true}) async {
    log("------------DELETE--------------");
    log(url, name: "Url");
    log(body.toString());
    if (isContentTypeJson) {
      headers?.addAll(
        {"Content-Type": "application/json"},
      );
    }
    final response = await http
        .delete(
          Uri.parse(url),
          headers: headers,
          body: body,
        )
        .timeout(_timeOutDuration);
    return _returnResponse(response);
  }

  static dynamic _returnResponse(http.Response response) {
    log(response.statusCode.toString(), name: "Response Status Code");
    log(response.body.toString(), name: "Response Body");
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        final responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        // final error = jsonDecode(response.body)["error"];
        throw BadRequestException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      case 401:
        throw UnauthorisedException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      case 403:
        throw UnauthorisedException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      case 404:
        throw UnauthorisedException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      case 408:
        throw TimeoutException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      case 409:
        throw BadRequestException(
          jsonDecode(response.body)[errorMessageString] == null
              ? response.body.toString()
              : jsonDecode(response.body)[errorMessageString].toString(),
        );
      // case 500:
      default:
        throw FetchDataException('Error occured while communication with server'
            ' with status code : ${response.statusCode}');
    }
  }
}
