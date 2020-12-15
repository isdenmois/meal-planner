import 'package:flutter/material.dart';
import 'package:meal_planner/screens/home.dart';
import 'package:meal_planner/screens/login.dart';
import 'package:meal_planner/services/auth.dart';

class AuthSwitcher extends StatelessWidget {
  AuthSwitcher({Key key}) : super(key: key);
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return LoginView();
          }

          return HomeScreen();
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
