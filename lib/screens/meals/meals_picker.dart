import 'package:flutter/material.dart';
import 'package:meal_planner/screens/recipe/recipe.dart';
import 'package:meal_planner/screens/recipe/recipe_repository.dart';
import 'package:meal_planner/widgets/image.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import 'meals_repository.dart';

class MealsPickerDialog extends StatefulWidget {
  final DateTime date;

  MealsPickerDialog({this.date});

  @override
  _MealsPickerDialogState createState() => _MealsPickerDialogState();

  static Widget dialogBuilder({DateTime date}) => MealsPickerDialog(date: date);
}

class _MealsPickerDialogState extends State<MealsPickerDialog> {
  final _recipes = recipesStream();
  Recipe selected;
  int people = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a meal', style: TextStyle(fontSize: 20)),
      titlePadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.minPositive,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamProgressBuilder<List<Recipe>>(
              stream: _recipes,
              builder: (context, recipes) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  children: recipes
                      .map((recipe) => RecipeItem(
                            recipe: recipe,
                            selected: selected != null && selected.id == recipe.id,
                            onSelect: selectRecipe,
                          ))
                      .toList(),
                );
              },
            ),
            ...buildFooter(context),
          ],
        ),
      ),
    );
  }

  decreasePeople() {
    if (people <= 1) return;

    setState(() {
      people--;
    });
  }

  increasePeople() {
    setState(() {
      people++;
    });
  }

  List<Widget> buildFooter(BuildContext context) {
    if (selected == null) return [];
    final theme = Theme.of(context);

    return [
      Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: const [
            const BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          FlatButton(child: Text('−'), onPressed: decreasePeople),
          Text(people > 1 ? '$people people' : 'only for one'),
          FlatButton(child: Text('+'), onPressed: increasePeople),
        ]),
      ),
      Row(children: [
        Expanded(
          child: InkWell(
            onTap: () => addMeal(context),
            child: Container(
              height: 50,
              color: Color(0xFF5C2CEC),
              child: Center(child: Text('Select', style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
      ])
    ];
  }

  selectRecipe(Recipe recipe) {
    setState(() {
      selected = recipe;
    });
  }

  addMeal(context) {
    Navigator.of(context).pop();

    createMeal(selected, widget.date, people);
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final bool selected;
  final onSelect;

  const RecipeItem({this.recipe, this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 15),
      onTap: select,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ImageWidget(imageUrl: recipe.imageURL, width: 60, height: 60),
      ),
      title: Text(recipe.title),
      trailing: selected ? Icon(Icons.check, color: Color(0xFF5C2CEC)) : null,
    );
  }

  select() {
    onSelect(recipe);
  }
}
