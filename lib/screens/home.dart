import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_planner/screens/products/products-list_page.dart';
import 'package:meal_planner/screens/recipe/recipe-list_page.dart';
import 'package:meal_planner/services/change-navigation-bar-color.dart';

class HomeScreen extends StatelessWidget {
  final lightShadow = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  );

  final darkShadow = BoxDecoration(
    color: Color(0xFF212121),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    changeNavigationBarColor(theme.bottomNavigationBarTheme.backgroundColor, theme.brightness);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: Container(
              decoration: brightness == Brightness.light ? lightShadow : darkShadow,
              child: TabBar(
                indicator: BoxDecoration(),
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.assignment_outlined)),
                  Tab(icon: Icon(Icons.bookmark_outlined)),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              ProductListPage(),
              RecipeListPage(),
            ])));
  }
}
