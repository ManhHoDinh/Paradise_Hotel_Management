import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? position;
  String? identification;
  String? birthday;
  UserModel(
      {this.id = '',
      this.name,
      this.phoneNumber,
      this.position,
      this.email,
      this.birthday,
      this.identification});

  Map<String, dynamic> toJson() => {
        'Email': email,
        'ID': id,
        'Name': name,
        'PhoneNumber': phoneNumber,
        'Position': position,
        'Identification': identification,
        'BirthDay': birthday,
      };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      id: json['ID'],
      name: json['Name'],
      phoneNumber: json['PhoneNumber'],
      position: json['Position'],
      email: json['Email'],
      birthday: json['BirthDay'],
      identification: json['Identification']);
  static UserModel currentUser = UserModel(
      name: '',
      email: '',
      position: '',
      phoneNumber: '',
      birthday: '',
      identification: '');
  String getUserId() {
    return id!;
  }

  String getPosition() {
    return position!;
  }

  String getName() {
    return name!;
  }

  String getPhoneNumber() {
    return phoneNumber!;
  }

  String getEmail() {
    return email!;
  }
}
