import 'package:deverse_host_app/data/db/app_storage.dart';
import 'package:deverse_host_app/repositories/user_repository.dart';
import 'package:deverse_host_app/repositories/world_instance_repository.dart';
import 'package:deverse_host_app/services/app_service.dart';
import 'package:deverse_host_app/services/auth_service.dart';
import 'package:deverse_host_app/services/user_service.dart';
import 'package:get_it/get_it.dart';

import '../repositories/world_template_repository.dart';
import '../services/sub_world_service.dart';

final container = GetIt.instance;

Future<void> initDIContainer() async {
  container.registerSingleton(AppStorage());
  // container.registerSingleton(UserChannel());
  container.registerSingleton(AppService());
  container.registerSingleton(AuthService());
  container.registerSingleton(SubWorldService(container()));
  container.registerSingleton(UserService(container()));

  container.registerSingleton(WorldTemplateRepository(container()));
  container.registerSingleton(WorldInstanceRepository(container()));
  container.registerSingleton(UserRepository(container(), container()));
}