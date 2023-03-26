import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  int? age;
  DateTime? birthday;
  User(
      {this.id = '',
      required this.name,
      required this.age,
      required this.birthday});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      birthday: DateTime.now());
}
