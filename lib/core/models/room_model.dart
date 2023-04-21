import 'package:flutter/material.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? RoomKindID;
  int? price;
  String? State;
  String? Description;
  List<String> SubImages = [];
  int? maxCapacity;
  RoomModel(
      {required this.roomID,
      required this.PrimaryImage,
      required this.RoomKindID,
      required this.price,
      required this.State,
      required this.SubImages,
      required this.Description,
      required this.maxCapacity});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'roomKindID': RoomKindID,
        'price': price.toString(),
        'PrimaryImage': PrimaryImage,
        'State': State,
        'SubImages': SubImages,
        'Description': Description,
        'maxCapacity': maxCapacity.toString()
      };

  static RoomModel fromJson(Map<String, dynamic> json) {
    return RoomModel(
        roomID: json['roomID'],
        RoomKindID: json['roomKindID'],
        price: int.parse(json['price']),
        PrimaryImage: json['PrimaryImage'],
        State: json['State'],
        SubImages: List.from(json["SubImages"]),
        Description: json['Description'],
        maxCapacity: int.parse(json['maxCapacity']));
  }
}
