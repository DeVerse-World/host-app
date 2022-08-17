import 'dart:async';

import 'package:deverse_host_app/data/api/response_body.dart';
import 'package:deverse_host_app/data/api/result.dart';
import 'package:deverse_host_app/repositories/base_repository.dart';
import 'package:deverse_host_app/services/auth_service.dart';
import 'package:deverse_host_app/services/user_service.dart';

class UserRepository extends BaseRepository {
  final UserService _userService;
  final AuthService _authService;
  //https://staging.deverse.world/login?key=OwGpDJHRbb
  UserRepository(this._userService, this._authService);

  Future<Result<PollLoginResponse?, Exception>> authenticateSession(bool forceReload) {
    return getResult(() async {
      var loginKey = await _userService.getLoginKey();
      if (loginKey == null || forceReload) {
        logsContainer.addLog("No login key cached, creating link...");
        var loginUrl = await _userService.createLoginLink();
        var loginUri = Uri.parse(loginUrl);
        loginKey = loginUri.queryParameters['key'];
        _userService.saveLoginKey(loginKey!);
      }

      try {
        const delayTime = Duration(seconds: 15);
        logsContainer.addLog("Using login key : $loginKey");
        PollLoginResponse? res;
        var loginOnce = false;
        var tryCount = 15;
        while (tryCount > 0) {
          var data = await _userService.pollLoginLink(loginKey);
          if (data.error != null) {
            logsContainer.addLog(data.error);
            if (!loginOnce) {
              _authService.authenticateUser(loginKey);
              loginOnce = true;
            }
            await Future.delayed(delayTime);
          } else {
            res = data;
            break;
          }
          tryCount--;
        }
        return res;
      } catch (e) {
        logsContainer.addLog("Error : $e");
      }
      return null;
    });
  }
}