import 'dart:convert';

import 'package:http/http.dart';

import '../data/api/request_body.dart';

class BaseService {

  var cachedCookie = "";

  Map<String, String> get header => {
    'Cookie' : "deverse-jwt=$cachedCookie"
  };

  void setCookie(String cookie) {
    cachedCookie = cookie;
  }

  DResponse parse(Response response) {
    var data = DResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    if (data.error != null) {
      print(data.error);
      throw Exception(data.error);
    }
    return data;
  }
}