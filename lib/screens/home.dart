import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_planner/screens/meals/meals_page.dart';
import 'package:meal_planner/screens/products/products-list_page.dart';
import 'package:meal_planner/screens/recipe/recipe-list_page.dart';
import 'package:meal_planner/services/change-navigation-bar-color.dart';

class HomeScreen extends StatelessWidget {
  static const lightShadow = BoxShadow(
    color: Colors.black26,
    spreadRadius: 0,
    blurRadius: 5,
    offset: Offset(0, 1),
  );

  static const darkShadow = BoxShadow(
    color: Colors.black54,
    spreadRadius: 0,
    blurRadius: 5,
    offset: Offset(0, 1),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    changeNavigationBarColor(theme.bottomNavigationBarTheme.backgroundColor, theme.brightness);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                boxShadow: [brightness == Brightness.light ? lightShadow : darkShadow],
              ),
              child: TabBar(
                indicator: BoxDecoration(),
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.assignment_outlined)),
                  Tab(icon: Icon(Icons.bookmark_outlined)),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              MealsPage(),
              ProductListPage(),
              RecipeListPage(),
            ])));
  }
}
