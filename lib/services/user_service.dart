import 'dart:convert';

import 'package:deverse_host_app/data/api/response_body.dart';
import 'package:deverse_host_app/data/db/app_storage.dart';
import 'package:deverse_host_app/services/base_service.dart';
import 'package:http/http.dart' as http;

import '../data/api/request_body.dart';

class UserService extends BaseService {
  final _baseUrl = "https://api.staging.deverse.world/api/user";
  final AppCache _appStorage;

  UserService(this._appStorage);

  Future<String> createLoginLink() async {
    var uri = "$_baseUrl/createLoginLink";
    var response = await http.post(Uri.parse(uri));
    var data = LoginResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return data.login_url;
  }

  Future<User> pollLoginLink(String key) async {
    var uri = "$_baseUrl/pollLoginLink/$key";
    var response = await http.get(Uri.parse(uri));
    if (response.headers['set-cookie'] != null) {
      var cookieString = response.headers['set-cookie']!.replaceAll(";", "").split(" ");
      saveCookie(cookieString.elementAt(0));
    }
    var data = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return data;
  }

  void saveLoginKey(String key) {
    _appStorage.save("loginKey", key);
  }

  void saveCookie(String cookie) {
    _appStorage.save("cookie", cookie);
  }

  Future<String?> getLoginKey() async {
    return await _appStorage.get<String>("loginKey");
  }
}
