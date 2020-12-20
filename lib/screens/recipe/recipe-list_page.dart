import 'package:flutter/material.dart';
import 'package:meal_planner/screens/recipe/recipe-add_page.dart';
import 'package:meal_planner/screens/recipe/recipe-view_page.dart';
import 'package:meal_planner/screens/recipe/recipe_repository.dart';
import 'package:meal_planner/widgets/image.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import 'recipe.dart';

class RecipeListPage extends StatelessWidget {
  final recipes = recipesStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe list'),
        actions: [
          InkWell(
              onTap: () => openAddRecipeScreen(context),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.add, size: 26.0),
              )),
        ],
      ),
      body: StreamProgressBuilder(
        stream: recipes,
        builder: (context, List<Recipe> list) => ListView(
          padding: EdgeInsets.all(15),
          children: list.map((recipe) => RecipeItem(recipe)).toList(),
        ),
      ),
    );
  }

  openAddRecipeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeAddPage()),
    );
  }
}

class RecipeStyle {
  final Color backgroundColor;
  final TextStyle title;
  final TextStyle subtitle;

  RecipeStyle({this.backgroundColor, this.title, this.subtitle});
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  RecipeItem(this.recipe);

  final themes = {
    Brightness.light: RecipeStyle(
      backgroundColor: Color(0xFFF7F5FF),
      title: TextStyle(fontSize: 20, color: Color(0xFF292550)),
      subtitle: TextStyle(fontSize: 12, color: Color(0xFF8A86AC)),
    ),
    Brightness.dark: RecipeStyle(
      backgroundColor: Color(0xFF424242),
      title: TextStyle(fontSize: 20, color: Colors.white),
      subtitle: TextStyle(fontSize: 12, color: Colors.white70),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = themes[brightness] ?? themes[Brightness.light];

    return Card(
      margin: EdgeInsets.only(bottom: 15),
      color: theme.backgroundColor,
      child: InkWell(
          onTap: () => openRecipeViewScreen(context),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ImageWidget(imageUrl: recipe.imageURL, width: 90, height: 90),
                  ),
                  Container(width: 15),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.title, style: theme.title),
                      Text('Portions: ${recipe.portion}', style: theme.subtitle),
                    ],
                  ))
                ],
              ))),
    );
  }

  openRecipeViewScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeViewScreen(recipe: recipe)),
    );
  }
}
