import 'package:deverse_host_app/data/models/sub_world_template.dart';

import '../services/sub_world_service.dart';

class WorldTemplateRepository {
  final SubWorldService _subWorldService;
  WorldTemplateRepository(this._subWorldService);

  Future<List<SubWorldTemplate>> getRootTemplates() async {
    var res = await _subWorldService.getRootSubWorlds(null);
    return res.data?.subworld_templates ?? [];
  }

  Future<List<SubWorldTemplate>> getSubTemplates(SubWorldTemplate rootTemplate) async {
    var res = await _subWorldService.getSubSubWorlds(null, rootTemplate.id);
    return res.data?.subworld_templates ?? [];
  }
}