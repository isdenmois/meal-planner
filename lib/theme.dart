import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 20),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.white,
        onPrimary: Colors.white,
        primaryVariant: Colors.white38,
        secondary: Colors.red,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Color(0xFF5C2CEC),
        unselectedLabelColor: Color(0xFFE0DFE6),
      ));

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        tabBarTheme: TabBarTheme(
          labelColor: Color(0xFF5C2CEC),
          unselectedLabelColor: Color(0xFFE0DFE6),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF212121),
        ),
      );
}
