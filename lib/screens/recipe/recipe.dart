class Recipe {
  String id;
  String title;
  int portion;
  String imageURL;
  String link;
  List<String> steps;

  Recipe({this.id, this.title, this.portion, this.imageURL, this.link, this.steps});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'portion': portion,
      'imageURL': imageURL,
      'link': link,
      'steps': steps,
    };
  }

  static Recipe fromJson(String id, Map<String, dynamic> map) => Recipe(
        id: id,
        title: map['title'],
        portion: map['portion'],
        imageURL: map['imageURL'],
        link: map['link'],
        steps: map['steps'] != null ? List<String>.from(map['steps']) : [],
      );
}
