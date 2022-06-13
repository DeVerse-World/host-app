import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: Colors.lightBlueAccent,
      primaryIconTheme: const IconThemeData(
        color: Colors.lightBlueAccent,
      ),
      iconTheme: const IconThemeData(
        color: Colors.lightBlueAccent,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.lightBlueAccent),
      drawerTheme: const DrawerThemeData(),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white
      )
      // textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //         backgroundColor: MaterialStateProperty.resolveWith(_resolveColor),
      //         textStyle: MaterialStateProperty.resolveWith(_resolveStyle))),
    );
  }

  static Color _resolveColor(Set<MaterialState> states) {
    return Colors.lightBlueAccent;
  }

  static TextStyle _resolveStyle(Set<MaterialState> states) {
    var style = const TextStyle(
        color : Colors.white,

    );
    return style;
  }
}