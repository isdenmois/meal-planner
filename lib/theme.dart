import 'package:flutter/material.dart';

class AppColors {
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color textColor;
  final Color secondaryBackground;
  final Color cardColor;
  final ColorScheme colorScheme;

  AppColors({
    this.primaryColor,
    this.accentColor,
    this.backgroundColor,
    this.textColor,
    this.secondaryBackground,
    this.cardColor,
    this.colorScheme,
  });
}

final lightTheme = AppColors(
  primaryColor: Color(0xFF5C2CEC),
  accentColor: Color(0xFF3AC3CC),
  backgroundColor: Colors.white,
  textColor: Colors.black,
  secondaryBackground: Color(0xFFF7F5FF),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    onPrimary: Colors.white,
    primaryVariant: Colors.white38,
    secondary: Colors.red,
  ),
);

final darkTheme = AppColors(
  primaryColor: Color(0xFF278EA5),
  accentColor: Color(0xFF21E6C1),
  backgroundColor: Color(0xFF071E3D),
  textColor: Colors.white,
  secondaryBackground: Color(0xFF1F4287),
  cardColor: Color(0xFF1F4287),
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.white,
    primaryVariant: Colors.white38,
    secondary: Colors.red,
  ),
);

AppColors useColors(BuildContext context) => Theme.of(context).brightness == Brightness.light ? lightTheme : darkTheme;

class AppTheme {
  static ThemeData create(Brightness brightness) {
    final colors = brightness == Brightness.light ? lightTheme : darkTheme;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colors.backgroundColor,
      appBarTheme: AppBarTheme(
        color: colors.backgroundColor,
        elevation: 0,
        textTheme: TextTheme(
          headline6: TextStyle(color: colors.textColor, fontSize: 20),
        ),
        iconTheme: IconThemeData(
          color: colors.textColor,
        ),
      ),
      primaryColor: colors.primaryColor,
      accentColor: colors.accentColor,
      backgroundColor: colors.backgroundColor,
      colorScheme: colors.colorScheme,
      cardColor: colors.cardColor,
      iconTheme: IconThemeData(
        color: colors.textColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.backgroundColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.accentColor,
        foregroundColor: colors.backgroundColor,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colors.primaryColor,
        unselectedLabelColor: Color(0xFFE0DFE6),
      ),
    );
  }

  static ThemeData light() => create(Brightness.light);
  static ThemeData dark() => create(Brightness.dark);
}
