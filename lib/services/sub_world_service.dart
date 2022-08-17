import 'dart:convert';

import 'package:deverse_host_app/data/api/result.dart';
import 'package:deverse_host_app/data/db/app_storage.dart';
import 'package:deverse_host_app/data/models/world_instance_config.dart';
import 'package:deverse_host_app/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../data/api/request_body.dart';
import 'base_service.dart';

class SubWorldService extends BaseService {
  final _baseUrl = "https://api.staging.deverse.world/api/subworld";

  final AppCache _appStorage;
  SubWorldService(this._appStorage);
  Future<Result<SubWorldTemplateData, Exception>> getRootSubWorlds(int? userId) async {
    var uri = "$_baseUrl/root_template";
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

  Future<Result<SubWorldTemplateData, Exception>> getSubSubWorlds(int? userId, int rootId) async {
    var uri = "$_baseUrl/root_template/$rootId/deriv";
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

  Future<Result<SubWorldInstancesData, Exception>> fetchInstances(int? userId) async {
    var uri = "$_baseUrl/instance";
    if (userId != null) {
      uri = "$uri?userId=$userId";
    }
    return getResult(() async {
      var res = await http.get(Uri.parse(uri));
      final response = parse(res);
      var data = SubWorldInstancesData.fromJson(response.data);
      return data;
    });
  }

  Future<Result<SubWorldInstanceData, Exception>> createInstance(WorldInstanceConfig config) async {
    var uri = "$_baseUrl/instance";
    var requestBody = SubWorldRequest(config);
    var cookie = await _appStorage.get<String>(Constants.COOKIE);
    return getResult(() async {
      var res = await http.post(Uri.parse(uri), headers: generateHeader(cookie ?? ""), body: json.encode(requestBody.toJson()));
      final response = parse(res);
      var data = SubWorldInstanceData.fromJson(response.data);
      return data;
    });
  }

  Future<String> removeInstance(int subworldId) async {
    var uri = "$_baseUrl/instance/$subworldId";
    var cookie = await _appStorage.get<String>(Constants.COOKIE);
    var res = await http.delete(Uri.parse(uri), headers: generateHeader(cookie ?? ""));
    final response = parse(res);
    return response.message;
  }
}
