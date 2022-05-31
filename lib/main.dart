import 'package:deverse_host_app/ui/home_screen.dart';
import 'package:deverse_host_app/ui/setup/setup_model.dart';
import 'package:deverse_host_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await initDIContainer();
  // await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData _getAppTheme() {
    return ThemeData(
        primaryColor: Colors.lightBlueAccent,
        primaryIconTheme: const IconThemeData(
          color: Colors.lightBlueAccent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.lightBlueAccent,
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlueAccent),
        drawerTheme: DrawerThemeData()
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SetupModel()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _getAppTheme(),
        home: Builder(
          builder: (context) {
            return const HomeScreen(title: 'Flutter Demo Home Page');
          },
        )));
  }
}
