import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_planner/screens/recipe/recipe.dart';

import 'meal.dart';

CollectionReference get _collection {
  return FirebaseFirestore.instance.collection('meals');
}

Stream<List<Meal>> mealsList() {
  return _collection.orderBy('date').snapshots().map((snapshot) {
    return snapshot.docs.map((s) => Meal.fromJson(s.id, s.data())).toList();
  });
}

Stream<Recipe> mealRecipe(Meal meal) {
  if (meal == null) return null;

  return meal.recipe.snapshots().map((s) => Recipe.fromJson(s.id, s.data()));
}

Future createMeal(Recipe recipe, DateTime date, int people) {
  return _collection.add({
    'recipe': FirebaseFirestore.instance.collection('recipes').doc(recipe.id),
    'days': recipe.portion > 0 ? recipe.portion ~/ people : 1,
    'date': date,
  });
}

Future updateMeal(String id, Map<String, dynamic> data) {
  return _collection.doc(id).update(data);
}

Future removeMeal(String id) {
  return _collection.doc(id).delete();
}
