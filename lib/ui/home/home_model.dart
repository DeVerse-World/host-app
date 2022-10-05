import 'package:deverse_host_app/repositories/user_repository.dart';
import 'package:deverse_host_app/ui/base_change_notifier.dart';

import '../../data/models/sub_world_template.dart';
import '../../repositories/world_template_repository.dart';
import '../../utils/injection_container.dart';

class HomeModel extends BaseModel {
  List<SubWorldTemplate> templates = [];
  final WorldTemplateRepository _worldTemplateRepository = container<WorldTemplateRepository>();
  final UserRepository _userRepository = container<UserRepository>();
  bool isAuthenticated = false;

  void initData() {
    authenticate(false);
    _worldTemplateRepository.getRootTemplates().then((value) {
      templates = value;
      notifyListeners();
    });
  }

  void authenticate(bool forceClearCache) {
    _userRepository.authenticateSession(forceClearCache).then((value) {
      if (value.data != null) {
        logsContainer.addLog("Authorized...");
        isAuthenticated = _userRepository.isAuthenticated;
        notifyListeners();
      }
    });
  }

  void logout() {
    _userRepository.logout();
    isAuthenticated = _userRepository.isAuthenticated;
    notifyListeners();
  }
}
