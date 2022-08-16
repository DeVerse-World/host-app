import 'dart:convert';

import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:http/http.dart';

import '../data/api/request_body.dart';

class BaseService {
  final LogsContainer logsContainer = container<LogsContainer>();

  Map<String, String> generateHeader(String cachedCookie) => {
    'Cookie' : cachedCookie,
    'Content-type': "application/json",
  };

  DResponse parse(Response response) {
    var data = DResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    if (data.error != null) {
      // print(data.error);
      logsContainer.addLog(data.error);
      throw Exception(data.error);
    }
    return data;
  }
}