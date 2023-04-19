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
  Map<String, dynamic> toJson() => {
        'RoomKindID': RoomKindID,
        'Name': Name,
        'Price': Price.toString(),
      };

  static RoomKindModel fromJson(Map<String, dynamic> json) {
    return RoomKindModel(
      RoomKindID: json['RoomKindID'],
      Name: json['Name'],
      Price: int.parse(json['Price']),
    );
  }

  static List<String> kindItems = [];
  static List<RoomKindModel> AllRoomKinds = [];

  static String getRoomKindName(String id) {
    RoomKindModel kindSelected = RoomKindModel.AllRoomKinds.where(
        (roomKind) => roomKind.RoomKindID! == id).first;
    return kindSelected.Name ?? '';
  }
}
