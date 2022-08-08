import 'package:deverse_host_app/data/models/sub_world_template.dart';

import '../services/sub_world_service.dart';

class WorldInstanceRepository {
  final SubWorldService _subWorldService;
  WorldInstanceRepository(this._subWorldService);

  Future<void> createInstance() async {
    var res = await _subWorldService.getRootSubWorlds(null);
    return;
  }
}