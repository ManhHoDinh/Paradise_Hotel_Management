import 'package:flutter/material.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? RoomKindID;
  int? price;
  String? State;
  String? Description;
  //String? hotelID;
  List<String> SubImages = [];
  RoomModel(
      {required this.roomID,
      required this.PrimaryImage,
      required this.RoomKindID,
      required this.price,
      required this.State,
      required this.SubImages,
      required this.Description});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'roomKindID': RoomKindID,
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
        RoomKindID: json['roomKindID'],
        price: int.parse(json['price']),
        PrimaryImage: json['PrimaryImage'],
        State: json['State'],
        SubImages: SubImages,
        Description: json['Description']);
  }
}
