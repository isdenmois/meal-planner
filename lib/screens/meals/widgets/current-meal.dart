import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_planner/screens/meals/meal.dart';
import 'package:meal_planner/screens/meals/meals_picker.dart';
import 'package:meal_planner/screens/recipe/recipe-view_page.dart';
import 'package:meal_planner/screens/recipe/recipe.dart';
import 'package:meal_planner/theme.dart';
import 'package:meal_planner/widgets/image.dart';

import '../meals_repository.dart';

class CurrentMeal extends StatelessWidget {
  final Meal meal;
  final DateTime date;

  final Stream<Recipe> _recipeStream;

  CurrentMeal({this.meal, this.date}) : _recipeStream = mealRecipe(meal);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Recipe>(
        stream: _recipeStream,
        builder: (_, snapshot) {
          if (meal != null && snapshot.hasData) {
            return MealPreview(meal: meal, recipe: snapshot.data);
          }

          return EmptyMeal(date: date);
        });
  }
}

class MealPreview extends StatelessWidget {
  final Meal meal;
  final Recipe recipe;
  final GlobalKey gkey;

  MealPreview({this.meal, this.recipe}) : gkey = GlobalKey(debugLabel: meal.id);

  @override
  Widget build(BuildContext context) {
    final colors = useColors(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.only(top: 30),
          color: colors.secondaryBackground,
          child: InkWell(
            onTap: () => openRecipeViewScreen(context),
            onLongPress: () => openMealMenu(context),
            key: gkey,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ImageWidget(imageUrl: recipe.imageURL, width: 90, height: 90),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.title, style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => changeDate(context),
                          child: Text(formatDate(meal.from), style: TextStyle(fontSize: 12, color: Color(0xFF8A86AC))),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 12, left: 20, right: 30, bottom: 10),
                              child: Text('${meal.days} ${meal.days > 1 ? "days" : "day"}',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF8A86AC))),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: FlatButton(
                                onPressed: substractDay,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                padding: EdgeInsets.only(right: 30),
                                child: SvgPicture.asset('assets/cookie-bite.svg'),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: FlatButton(
                                onPressed: addDay,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                padding: EdgeInsets.only(left: 20, right: 10),
                                child: SvgPicture.asset('assets/cookie.svg'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...buildIngredients(),
      ],
    );
  }

  List<Widget> buildIngredients() {
    if (recipe.ingredients.isEmpty) return [];

    return [
      SizedBox(height: 30),
      Text('Ingredients', style: TextStyle(fontSize: 18)),
      ...recipe.ingredients.map((ingredient) => IngredientWidget(ingredient)),
    ];
  }

  changeDate(BuildContext context) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: meal.from,
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (date != null && date != meal.from) {
      updateMeal(meal.id, {'date': date});
    }
  }

  addDay() {
    updateMeal(meal.id, {'days': meal.days + 1});
  }

  substractDay() {
    if (meal.days <= 1) return;

    updateMeal(meal.id, {'days': meal.days - 1});
  }

  openRecipeViewScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeViewScreen(recipe: recipe)),
    );
  }

  openMealMenu(BuildContext context) async {
    RenderBox box = gkey.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    RelativeRect position = RelativeRect.fromLTRB(0, offset.dy, 0, 0);

    final result = await showMenu(context: context, position: position, items: [
      PopupMenuItem(value: 'delete', child: Text("Delete")),
    ]);

    if (result == 'delete') {
      removeMeal(meal.id);
    }
  }
}

class EmptyMeal extends StatelessWidget {
  final DateTime date;

  EmptyMeal({this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(30), child: Image.asset('no-meal.jpg')),
              Text('No meal is selected', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('You have to choose or you will starve', style: TextStyle(fontSize: 14, color: Color(0xFF8A86AC))),
              SizedBox(height: 20),
              InkWell(
                onTap: () => openMealsPickerDialog(context),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color(0xFF5C2CEC), borderRadius: BorderRadius.all(Radius.circular(25))),
                  padding: EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
                  child: Text('Pick one', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  openMealsPickerDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => MealsPickerDialog.dialogBuilder(date: date));
  }
}

final weekdays = [
  '',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

String formatDate(DateTime date) {
  return '${date.day}.${date.month}, ${weekdays[date.weekday]}';
}
