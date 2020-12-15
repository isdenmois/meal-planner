import 'package:flutter/material.dart';
import 'package:meal_planner/screens/product-store.dart';
import 'package:meal_planner/screens/recipe/recipe-list_page.dart';

class HomeScreen extends StatelessWidget {
  final shadow = BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: Container(
              decoration: shadow,
              child: TabBar(
                labelColor: Color(0xFF5C2CEC),
                unselectedLabelColor: Color(0xFFE0DFE6),
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
