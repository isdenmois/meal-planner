import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/screens/recipe/recipe-edit_page.dart';
import 'package:meal_planner/screens/recipe/recipe_repository.dart';
import 'package:meal_planner/screens/recipe/widgets/recipe-header.dart';

import 'recipe.dart';

class RecipeViewScreen extends StatelessWidget {
  final Recipe recipe;
  RecipeViewScreen({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Recipe>(
        stream: recipeStream(recipe.id),
        initialData: recipe,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return null;

          return RecipeView(recipe: snapshot.data);
        });
  }
}

class RecipeView extends StatelessWidget {
  final Recipe recipe;

  RecipeView({this.recipe});

  final headerStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 23);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: buildHeader,
        body: ListView(
          padding: EdgeInsets.only(left: 15, right: 15),
          children: [
            Text('Ingredients'),
            SizedBox(height: 30),
            Text('Steps', style: TextStyle(fontSize: 18)),
            ...buildSteps(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildHeader(BuildContext context, innerBoxIsScrolled) {
    return [
      RecipeHeader(
        image: recipe.imageURL != null
            ? CachedNetworkImage(imageUrl: recipe.imageURL, fit: BoxFit.cover)
            : Container(color: Colors.red),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(recipe.title, textAlign: TextAlign.center, style: headerStyle),
              ),
            ),
            InkWell(
              onTap: () => openEditRecipeScreen(context),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> buildSteps() {
    if (recipe.steps == null) return [];

    return recipe.steps
        .asMap()
        .entries
        .map((entry) => Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Text((entry.key + 1).toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 15),
                Flexible(child: Text(entry.value, style: TextStyle(fontSize: 14)))
              ],
            )))
        .toList();
  }

  openEditRecipeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeEditPage(recipe)),
    );
  }
}
