class FlutterNameEntity {
  FlutterNameAnimals animals;

  FlutterNameEntity({this.animals});

  FlutterNameEntity.fromJson(Map<String, dynamic> json) {
    animals = json['animals'] != null
        ? new FlutterNameAnimals.fromJson(json['animals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animals != null) {
      data['animals'] = this.animals.toJson();
    }
    return data;
  }
}

class FlutterNameAnimals {
  List<FlutterNameAnimalsDog> dog;

  FlutterNameAnimals({this.dog});

  FlutterNameAnimals.fromJson(Map<String, dynamic> json) {
    if (json['dog'] != null) {
      dog = new List<FlutterNameAnimalsDog>();
      (json['dog'] as List).forEach((v) {
        dog.add(new FlutterNameAnimalsDog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dog != null) {
      data['dog'] = this.dog.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlutterNameAnimalsDog {
  String name;
  int age;

  FlutterNameAnimalsDog({this.name, this.age});

  FlutterNameAnimalsDog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }
}
