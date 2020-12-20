import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/screens/meals/meal.dart';
import 'package:meal_planner/screens/meals/meals_repository.dart';
import 'package:meal_planner/screens/recipe/recipe.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import './widgets/calendar.dart';
import './widgets/current-meal.dart';

class MealsPage extends StatelessWidget {
  final _meals = mealsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal planner')),
      body: StreamProgressBuilder<List<Meal>>(
          stream: _meals,
          builder: (_, meals) => MealsBody(meals: meals),
      ),
    );
  }
}

class MealsBody extends StatefulWidget {
  final List<Meal> meals;

  MealsBody({this.meals});

  @override
  MealsBodyState createState() => MealsBodyState();
}

class MealsBodyState extends State<MealsBody> {
  DateTime selected;
  DocumentReference recipe;
  Stream<Recipe> _recipeStream;

  @override
  void initState() {
    selected = DateTime.now();

    super.initState();
  }

  changeDate(DateTime date) {
    setState(() {
      selected = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meals.firstWhere((m) => m.from.difference(selected).isNegative && selected.difference(m.to).isNegative, orElse: () => null);

    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        MealsCalendar(selected: selected, meals: widget.meals, onChange: changeDate),
        CurrentMeal(meal: meal, date: selected),
      ],
    );
  }
}
