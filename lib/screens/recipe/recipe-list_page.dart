import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/screens/recipe/recipe-add_page.dart';
import 'package:meal_planner/screens/recipe/recipe_repository.dart';
import 'package:meal_planner/widgets/stream-progress-builder.dart';

import 'recipe-edit_page.dart';
import 'recipe.dart';

class RecipeListPage extends StatelessWidget {
  final recipes = recipesStream();
  final headerStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Recipe list', style: headerStyle),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          InkWell(
              onTap: () => openAddRecipeScreen(context),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.add, size: 26.0),
              )),
        ],
      ),
      backgroundColor: Colors.white,
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

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  RecipeItem(this.recipe);

  final titleStyle = TextStyle(fontSize: 20, color: Color(0xFF292550));
  final subtitleStyle = TextStyle(fontSize: 12, color: Color(0xFF8A86AC));

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      color: Color(0xFFF7F5FF),
      child: InkWell(
          onTap: () => openEditRecipeScreen(context),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'recipe/${recipe.id}',
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: recipe.imageURL != null
                            ? CachedNetworkImage(imageUrl: recipe.imageURL, fit: BoxFit.cover, width: 90, height: 90)
                            : Container(width: 90, height: 90, color: Colors.red)),
                  ),
                  Container(width: 15),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.title, style: titleStyle),
                      Text('Portions: ${recipe.portion}', style: subtitleStyle),
                    ],
                  ))
                ],
              ))),
    );
  }

  openEditRecipeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeEditPage(recipe)),
    );
  }
}
