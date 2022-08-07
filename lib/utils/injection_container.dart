import 'package:deverse_host_app/services/app_service.dart';
import 'package:get_it/get_it.dart';

import '../repositories/world_template_repository.dart';
import '../services/sub_world_service.dart';

final container = GetIt.instance;

Future<void> initDIContainer() async {
  // container.registerSingleton(UserChannel());
  container.registerSingleton(AppService());
  container.registerSingleton(SubWorldService());
  // container.registerSingleton(UserService());

  container.registerSingleton(WorldTemplateRepository(container()));
}