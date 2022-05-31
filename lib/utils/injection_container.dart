import 'package:deverse_host_app/services/app_service.dart';
import 'package:get_it/get_it.dart';

final container = GetIt.instance;

Future<void> initDIContainer() async {
  // container.registerSingleton(UserChannel());
  container.registerSingleton(AppService());
  // container.registerSingleton(LocationService());
  // container.registerSingleton(UserService());
  // container.registerSingleton(AddressService());
}