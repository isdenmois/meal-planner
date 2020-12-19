import 'package:cloud_firestore/cloud_firestore.dart';

import 'meal.dart';

CollectionReference get _collection {
  return FirebaseFirestore.instance.collection('meals');
}

Stream<List<Meal>> mealsList() {
  return _collection.orderBy('date').snapshots().map((snapshot) {
    return snapshot.docs.map((s) => Meal.fromJson(s.id, s.data())).toList();
  });
}
