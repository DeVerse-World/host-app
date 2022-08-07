import 'dart:convert';

import 'package:http/http.dart';

import '../data/models/d_response.dart';

class BaseService {
  DResponse parse(Response response) {
    return DResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}