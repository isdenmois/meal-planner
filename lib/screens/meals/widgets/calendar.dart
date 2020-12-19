import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meal_planner/screens/meals/meal.dart';

Set<String> createSet(List<Meal> meals) {
  final result = HashSet<String>();
  if (meals == null) return result;

  DateTime date;
  for (Meal meal in meals) {
    date = meal.from;

    while (date.difference(meal.to).isNegative) {
      result.add(format(date));
      date = date.add(Duration(days: 1));
    }
  }

  return result;
}

String format(DateTime date) {
  return '${date.month}-${date.day}';
}

final weekdays = [
  '',
  'mon',
  'tue',
  'wed',
  'thu',
  'fri',
  'sat',
  'sun',
];

class MealsCalendar extends StatelessWidget {
  final DateTime selected;
  final Set<String> mealDates;
  final now = DateTime.now();
  final onChange;

  MealsCalendar({this.selected, this.onChange, meals})
      : mealDates = createSet(meals);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xFFF7F5FF),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 40,
          itemCount: 30,
          itemBuilder: dayBuilder,
        ));
  }

  Widget dayBuilder(BuildContext context, int i) {
    final date = i > 0 ? now.add(Duration(days: i)) : now;
    final hasMeal = mealDates.contains(format(date));
    final isSelected = date.day == selected.day && date.month == selected.month;

    return Day(day: date, hasMeal: hasMeal, isSelected: isSelected, onChange: onChange);
  }
}

class Day extends StatelessWidget {
  final DateTime day;
  final bool hasMeal;
  final bool isSelected;
  final onChange;

  final s = BoxDecoration(
    color: Color(0xFF3AC3CC),
    borderRadius: BorderRadius.all(Radius.circular(3)),
  );
  final selected = BoxDecoration(
    color: Color(0xFF5C2CEC),
    borderRadius: BorderRadius.all(Radius.circular(13)),
  );

  Day({this.day, this.hasMeal, this.isSelected, this.onChange});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : Colors.black;

    return InkWell(
      onTap: () => onChange(day),
      child: Container(
        decoration: isSelected ? selected : null,
        padding: EdgeInsets.only(left: 6, right: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(weekdays[day.weekday],
                style: TextStyle(color: color, fontSize: 11)),
            SizedBox(height: 4),
            Text(day.day.toString().padLeft(2, '0'),
                style: TextStyle(
                    color: color, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Container(height: 6, width: 6, decoration: hasMeal ? s : null),
          ],
        ),
      ),
    );
  }
}
