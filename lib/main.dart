import 'dart:io';

import 'package:deverse_host_app/ui/home/home_model.dart';
import 'package:deverse_host_app/ui/home/home_screen.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_model.dart';
import 'package:deverse_host_app/ui/session_manager/session_manager_screen.dart';
import 'package:deverse_host_app/ui/settings/settings_model.dart';
import 'package:deverse_host_app/ui/settings/settings_screen.dart';
import 'package:deverse_host_app/ui/widgets/console_view.dart';
import 'package:deverse_host_app/utils/app_theme.dart';
import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1200, 700));
    // setWindowMaxSize(const Size(800, 800));
    // await flutter_acrylic.Window.initialize();
    // await WindowManager.instance.ensureInitialized();
  }
  await initDIContainer();
  // await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeModel()),
          ChangeNotifierProvider(create: (context) => SessionManagerModel()),
          ChangeNotifierProvider(create: (context) => SettingsModel()),
        ],
        child: FluentApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(),
          routes: {
            SessionManagerScreen.route: (context) => const SessionManagerScreen(rootTemplate: null),
            SettingsScreen.route: (context) => const SettingsScreen()},
          home: const HomeScreen(),
        ));
  }
}
