import 'package:flutter/material.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? type;
  int? price;
  String? name;
  String? State;
  String? Description;
  //String? hotelID;
  List<String> SubImages = [];
  RoomModel(
      {required this.roomID,
      required this.PrimaryImage,
      required this.name,
      required this.type,
      required this.price,
      required this.State,
      required this.SubImages,
      required this.Description});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'name': name,
        'type': type,
        'price': price.toString(),
        'PrimaryImage': PrimaryImage,
        'State': State,
        'SubImages': SubImages,
        'Description': Description
      };

  static RoomModel fromJson(Map<String, dynamic> json) {
    List<String> SubImages = [];
    return RoomModel(
        roomID: json['roomID'],
        name: json['name'],
        type: json['type'],
        price: int.parse(json['price']),
        PrimaryImage: json['PrimaryImage'],
        State: json['State'],
        SubImages: SubImages,
        Description: json['Description']);
  }
}
