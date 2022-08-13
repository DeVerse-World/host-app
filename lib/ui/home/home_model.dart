import 'package:deverse_host_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../../data/models/sub_world_template.dart';
import '../../repositories/world_template_repository.dart';
import '../../utils/injection_container.dart';

class HomeModel extends ChangeNotifier {
  List<SubWorldTemplate> templates = [];
  bool isAuthenticated = false;
  final WorldTemplateRepository _worldTemplateRepository = container<WorldTemplateRepository>();
  final UserRepository _userRepository = container<UserRepository>();
  void initData() {
    _userRepository.authenticateSession(false).then((value) {
      print(value.data?.wallet_address);
      if (value.data != null) {
        isAuthenticated = true;
        notifyListeners();
      }
    });
    _worldTemplateRepository.getRootTemplates().then((value) {
      templates = value;
      notifyListeners();
    });
  }

  void reAuthenticate() {
    isAuthenticated = false;
    notifyListeners();
    _userRepository.authenticateSession(true).then((value) {
      if (value.data != null) {
        isAuthenticated = true;
        notifyListeners();
      }
      print(value.data?.wallet_address);
    });
  }
}
