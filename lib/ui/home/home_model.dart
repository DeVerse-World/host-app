import 'package:flutter/material.dart';

import '../../data/models/sub_world_template.dart';
import '../../repositories/world_template_repository.dart';
import '../../utils/injection_container.dart';

class HomeModel extends ChangeNotifier {
  List<SubWorldTemplate> templates = [];
  final WorldTemplateRepository _worldTemplateRepository = container<WorldTemplateRepository>();

  void initData() {
    _worldTemplateRepository.getRootTemplates().then((value) {
      templates = value;
      notifyListeners();
    });
  }
}
