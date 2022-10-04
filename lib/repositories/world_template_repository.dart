import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/repositories/base_repository.dart';

import '../services/sub_world_service.dart';

class WorldTemplateRepository extends BaseRepository {
  final SubWorldService _subWorldService;
  WorldTemplateRepository(this._subWorldService);

  Future<List<SubWorldTemplate>> getRootTemplates() async {
    var res = await _subWorldService.getRootSubWorlds(null);
    if (res.isFailure) {
      logsContainer.addLog(res.error.toString());
    }
    return res.data?.subworld_templates ?? [];
  }

  Future<List<SubWorldTemplate>> getSubTemplates(SubWorldTemplate rootTemplate) async {
    var res = await _subWorldService.getSubSubWorlds(null, rootTemplate.id);
    if (res.isFailure) {
      logsContainer.addLog(res.error.toString());
    }
    return res.data?.subworld_templates ?? [];
  }
}