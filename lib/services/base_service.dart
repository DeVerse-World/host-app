import 'dart:convert';

import 'package:http/http.dart';

import '../data/api/request_body.dart';

class BaseService {

  Map<String, String> generateHeader(String cachedCookie) => {
    'Cookie' : cachedCookie,
    'Content-type': "application/json",
  };

  DResponse parse(Response response) {
    var data = DResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    if (data.error != null) {
      print(data.error);
      throw Exception(data.error);
    }
    return data;
  }
}