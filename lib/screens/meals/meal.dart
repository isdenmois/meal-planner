import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String id;
  DateTime from;
  DateTime to;
  int days;
  DocumentReference recipe;

  Meal(this.id, {this.from, this.to, this.days, this.recipe});

  static Meal fromJson(String id, Map<String, dynamic> data) => Meal(id,
    from: data['date'].toDate(),
    to: data['date'].toDate().add(Duration(days: data['days'])),
    days: data['days'],
    recipe: data['recipe'],
  );
}
