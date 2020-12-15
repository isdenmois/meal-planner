import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './recipe.dart';

Stream<List<Recipe>> recipesStream() {
  return FirebaseFirestore.instance.collection('recipes').orderBy('title').snapshots().map((snapshot) {
    return snapshot.docs.map((e) => Recipe.fromJson(e.id, e.data())).toList();
  });
}

Future createRecipe(Recipe recipe) {
  return FirebaseFirestore.instance.collection('recipes').add(recipe.toMap());
}

Future updateRecipe(Recipe recipe) {
  return FirebaseFirestore.instance.collection('recipes').doc(recipe.id).set(recipe.toMap());
}

typedef ProgressWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class StreamProgressBuilder<T> extends StreamBuilder<T> {
  StreamProgressBuilder({Key key, Stream<T> stream, ProgressWidgetBuilder<T> builder})
      : super(
            key: key,
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return builder(context, snapshot.data);
              }

              return CircularProgressIndicator();
            });
}
