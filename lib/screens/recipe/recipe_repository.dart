import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './recipe.dart';

Stream<List<Recipe>> recipesStream() {
  return FirebaseFirestore.instance.collection('recipes').orderBy('title').snapshots().map((snapshot) {
    return snapshot.docs.map((e) => Recipe.fromJson(e.id, e.data())).toList();
  });
}

Stream<Recipe> recipeStream(String id) {
  return FirebaseFirestore.instance
      .collection('recipes')
      .doc(id)
      .snapshots()
      .map((snapshot) => Recipe.fromJson(snapshot.id, snapshot.data()));
}

Future createRecipe(Recipe recipe) {
  return FirebaseFirestore.instance.collection('recipes').add(recipe.toMap());
}

Future updateRecipe(Recipe recipe) {
  return FirebaseFirestore.instance.collection('recipes').doc(recipe.id).set(recipe.toMap());
}

typedef ProgressWidgetBuilder<T> = Widget Function(BuildContext context, T data);
