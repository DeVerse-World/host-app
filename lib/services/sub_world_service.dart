import 'dart:convert';

import 'package:deverse_host_app/data/models/result.dart';
import 'package:http/http.dart' as http;

import '../data/models/sub_world_template.dart';
import 'base_service.dart';

class SubWorldService extends BaseService {
  final baseUrl = "https://api.staging.deverse.world/api";

  Future<Result<SubWorldTemplateData, Exception>> getRootSubWorlds(int? userId) async {
    var uri = "$baseUrl/subworld/root_template";
    if (userId != null) {
      uri = "$uri?userId=$userId";
    }
    return getResult(() async {
      var res = await http.get(Uri.parse(uri));
      final response = parse(res);
      var data = SubWorldTemplateData.fromJson(response.data);
      return data;
    });
  }
}