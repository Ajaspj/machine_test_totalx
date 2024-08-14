import 'dart:convert';

class UserModel {
  final String? image;
  final String? name;
  final String? age;

  UserModel({
    this.image,
    this.name,
    this.age,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (image != null) {
      result.addAll({'image': image});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (age != null) {
      result.addAll({'age': age});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      image: map['image'],
      name: map['name'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
