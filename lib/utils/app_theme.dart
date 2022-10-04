import 'package:fluent_ui/fluent_ui.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(activeColor: Colors.red
        // primaryColor: Colors.lightBlueAccent,
        // primaryIconTheme: const IconThemeData(
        //   color: Colors.lightBlueAccent,
        // ),
        // iconTheme: const IconThemeData(
        //   color: Colors.lightBlueAccent,
        // ),
        // appBarTheme: const AppBarTheme(backgroundColor: Colors.lightBlueAccent),
        // drawerTheme: const DrawerThemeData(),
        // inputDecorationTheme: const InputDecorationTheme(
        //   filled: true,
        //   fillColor: Colors.white
        // ),
        // scrollbarTheme: ScrollbarThemeData(
        //   thumbVisibility: MaterialStateProperty.all<bool>(true)
        // )
        // textButtonTheme: TextButtonThemeData(
        //     style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.resolveWith(_resolveColor),
        //         textStyle: MaterialStateProperty.resolveWith(_resolveStyle))),
        );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(brightness: Brightness.dark);
  }

// static Color _resolveColor(Set<MaterialState> states) {
//   return Colors.lightBlueAccent;
// }

// static TextStyle _resolveStyle(Set<MaterialState> states) {
//   var style = const TextStyle(
//       color : Colors.white,
//
//   );
//   return style;
// }
}
