import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'recipe-form.dart';
import 'recipe_repository.dart';

class RecipeAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeForm(createRecipe);
  }
}
