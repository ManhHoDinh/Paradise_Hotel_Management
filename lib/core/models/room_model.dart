import 'package:flutter/material.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? RoomKindID;
  String? State;
  String? Description;
  List<String> SubImages = [];
  int? maxCapacity;
  RoomModel(
      {required this.roomID,
      required this.PrimaryImage,
      required this.RoomKindID,
      required this.State,
      required this.SubImages,
      required this.Description,
      required this.maxCapacity});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'roomKindID': RoomKindID,
        'PrimaryImage': PrimaryImage,
        'State': State,
        'SubImages': SubImages,
        'Description': Description,
        'maxCapacity': maxCapacity.toString()
      };

  static RoomModel fromJson(Map<String, dynamic> json) {
    //List<String> names = List.from(json['names']);
    return RoomModel(
        roomID: json['roomID'],
        RoomKindID: json['roomKindID'],
        PrimaryImage: json['PrimaryImage'],
        State: json['State'],
        SubImages: List.from(json['SubImages']),
        Description: json['Description'],
        maxCapacity: int.parse(json['maxCapacity']));
  }

  static List<RoomModel> AllRooms = [];

  int getPrice() {
    try {
      return RoomKindModel.getRoomKindPrice(roomID ?? '');
    } catch (e) {
      return 0;
    }
  }

  // String getRoomKindName() {
  //   return RoomKindModel.getRoomKindName(roomID ?? '');
  // }

  static bool ExistRoomWithRoomID(String id) {
    try {
      print(id);
      List<RoomModel> Rooms =
          RoomModel.AllRooms.where((room) => room.RoomKindID == id).toList();
      return Rooms.length != 0;
    } catch (e) {
      return false;
    }
  }

  static String getRoomImageByID(String id) {
    try {
      if (AllRooms.length == 0) {
        print('Khong co phan tu\n');
      }
      RoomModel room =
          RoomModel.AllRooms.where((roomCheck) => roomCheck.roomID! == id)
              .first;
      return room.PrimaryImage ?? '';
    } catch (e) {
      return '';
    }
  }
}
