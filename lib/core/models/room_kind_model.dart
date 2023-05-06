import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/firebase_request.dart';

class RoomKindModel {
  //static List<RoomKindModel> AllRoomKinds = [];
  String? RoomKindID;
  int? Price;
  String? Name;
  RoomKindModel({
    required this.Name,
    required this.Price,
    required this.RoomKindID,
  });
<<<<<<< HEAD
  static String CollectionName = 'RoomKind';
  Map<String, dynamic> toJson() => {
        'RoomKindID': RoomKindID,
        'Name': Name,
        'Price': Price.toString(),
      };

  static RoomKindModel fromJson(Map<String, dynamic> json) {
=======
  factory RoomKindModel.fromJson(Map<String, dynamic> json) {
>>>>>>> dev_VoCongBinh
    return RoomKindModel(
      RoomKindID: json['RoomKindID'],
      Name: json['Name'],
      Price: int.parse(json['Price']),
    );
  }
  Map<String, dynamic> toJson() => {
        'RoomKindID': RoomKindID,
        'Name': Name,
        'Price': Price.toString(),
      };

  // static RoomKindModel fromJson(Map<String, dynamic> json) {
  //   return RoomKindModel(
  //     RoomKindID: json['RoomKindID'],
  //     Name: json['Name'],
  //     Price: int.parse(json['Price']),
  //   );
  // }

  static List<String> kindItems = [];
  static List<RoomKindModel> AllRoomKinds = [];

  static String getRoomKindName(String id) {
    try {
      RoomKindModel kindSelected = RoomKindModel.AllRoomKinds.where(
          (roomKind) => roomKind.RoomKindID! == id).first;
      return kindSelected.Name ?? '';
    } catch (e) {
      return '';
    }
  }

  static int getRoomKindPrice(String id) {
    try {
      RoomKindModel kindSelected = RoomKindModel.AllRoomKinds.where(
          (roomKind) => roomKind.RoomKindID! == id).first;
      return kindSelected.Price ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
