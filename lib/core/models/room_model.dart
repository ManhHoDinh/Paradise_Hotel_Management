import 'package:flutter/material.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? type;
  int? price;
  String? name;
  String? State;
  //String? hotelID;
  List<String> SubImages = [];
  RoomModel(
      {this.roomID,
      this.PrimaryImage,
      this.name,
      this.type,
      this.price,
      this.State,
      required this.SubImages});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'name': name,
        'type': type,
        'price': price.toString(),
        'PrimaryImage': PrimaryImage,
        'State': State,
        'SubImages': SubImages
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
        SubImages: SubImages);
  }
}
