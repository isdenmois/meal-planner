import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/screens/meals/meal.dart';
import 'package:meal_planner/screens/meals/meals_repository.dart';

import './widgets/calendar.dart';
import './widgets/current-meal.dart';

class MealsPage extends StatelessWidget {
  final _meals = mealsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal planner')),
      // body: MealsBody(),
      body: StreamBuilder(
          stream: _meals,
          builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
            if (snapshot.hasData) {
              return MealsBody(meals: snapshot.data);
            }

            return CircularProgressIndicator();
          }),
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
    return ListView(
      children: [
        MealsCalendar(selected: selected, meals: widget.meals, onChange: changeDate),
        CurrentMeal(),
      ],
    );
  }
}
