import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'recipe-form.dart';
import 'recipe.dart';
import 'recipe_repository.dart';

class RecipeEditPage extends StatelessWidget {
  final Recipe recipe;

  RecipeEditPage(this.recipe);

  @override
  Widget build(BuildContext context) {
    return RecipeForm(updateRecipe, initial: recipe);
  }
}
