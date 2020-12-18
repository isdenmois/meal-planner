import 'package:cloud_firestore/cloud_firestore.dart';

import './recipe.dart';

CollectionReference get _collection {
  return FirebaseFirestore.instance.collection('recipes');
}

Stream<List<Recipe>> recipesStream() {
  return _collection.orderBy('title').snapshots().map((snapshot) {
    return snapshot.docs.map((e) => Recipe.fromJson(e.id, e.data())).toList();
  });
}

Stream<Recipe> recipeStream(String id) {
  return _collection.doc(id).snapshots().map((snapshot) => Recipe.fromJson(snapshot.id, snapshot.data()));
}

Future createRecipe(Recipe recipe) {
  return _collection.add(recipe.toMap());
}

Future updateRecipe(Recipe recipe) {
  return _collection.doc(recipe.id).set(recipe.toMap());
}
