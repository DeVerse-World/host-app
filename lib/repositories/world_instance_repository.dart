import 'package:deverse_host_app/data/api/result.dart';
import 'package:deverse_host_app/data/models/sub_world_instance.dart';
import 'package:deverse_host_app/data/models/sub_world_template.dart';
import 'package:deverse_host_app/data/models/world_instance_config.dart';
import 'package:deverse_host_app/repositories/base_repository.dart';

import '../services/sub_world_service.dart';

class WorldInstanceRepository extends BaseRepository {
  final SubWorldService _subWorldService;

  WorldInstanceRepository(this._subWorldService);

  Future<List<SubWorldInstance>> fetchInstances() async {
    var res = await _subWorldService.fetchInstances(null);
    return res.data?.subworld_instances ?? [];
  }

  Future<Result<SubWorldInstance?, Exception>> createInstance(SubWorldTemplate template, String hostName, String region, String maxPlayer, String port, String beaconPort) async {
    var instanceConfig = WorldInstanceConfig(hostName, region, int.parse(maxPlayer), port, beaconPort, template.id);
    return getResult(() async {
      var response = await _subWorldService.createInstance(instanceConfig);
      if (response.isSuccess) {
        logsContainer.addLog("Created instance ${response.data?.subworld_instance?.host_name} successfully...");
      }
      return response.get()?.subworld_instance;
    });
  }

  Future<Result<String?, Exception>> deleteInstance(SubWorldInstance subWorldInstance) async {
    return getResult(() async {
      var res = await _subWorldService.removeInstance(subWorldInstance.id);
      logsContainer.addLog(res);
      return res;
    });
  }
}