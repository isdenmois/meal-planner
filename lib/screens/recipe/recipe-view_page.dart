import 'package:flutter/material.dart';
import 'package:meal_planner/screens/products/product.dart';
import 'package:meal_planner/screens/products/product_repository.dart';
import 'package:meal_planner/screens/recipe/recipe-edit_page.dart';
import 'package:meal_planner/screens/recipe/recipe_repository.dart';
import 'package:meal_planner/screens/recipe/widgets/recipe-header.dart';
import 'package:meal_planner/widgets/image.dart';

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
  final sectionStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: buildHeader,
        body: ListView(
          padding: EdgeInsets.only(left: 15, right: 15),
          children: [
            Text('Ingredients', style: sectionStyle),
            ...buildIngredients(),
            SizedBox(height: 30),
            Text('Steps', style: sectionStyle),
            ...buildSteps(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildHeader(BuildContext context, innerBoxIsScrolled) {
    return [
      RecipeHeader(
        image: ImageWidget(imageUrl: recipe.imageURL),
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

  List<Widget> buildIngredients() {
    if (recipe.steps == null) return [];

    return recipe.ingredients.map((ingredient) => IngredientWidget(ingredient)).toList();
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

class IngredientWidget extends StatelessWidget {
  final String ingredient;

  IngredientWidget(this.ingredient);

  final countStyle = TextStyle(color: Color(0xFF8A86AC));

  @override
  Widget build(BuildContext context) {
    final parts = ingredient.split(':');
    final title = parts[0].trim();
    final count = parts.length > 1 ? parts[1].trim() : '';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () => addProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Text(count, style: countStyle),
          ]),
        ),
      ),
    );
  }

  addProduct(BuildContext context) {
    final parts = ingredient.split(':');
    final product = Product(
      title: parts[0].trim(),
      count: parts.length > 1 ? parts[1].trim() : null,
      bought: false,
    );

    createUniqueProduct(product);

    Scaffold.of(context).showSnackBar(SnackBar(content: Text('${product.title} has been added to product list')));
  }
}
