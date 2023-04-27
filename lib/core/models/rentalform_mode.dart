import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/firebase_request.dart';

class RentalFormModel {
  //static List<RoomKindModel> AllRoomKinds = [];
  String? RentalID;
  String? RoomID;
  DateTime? BeginDate;
  List<String>? GuestIDs;
  RentalFormModel({
    required this.RoomID,
    required this.BeginDate,
    required this.GuestIDs,
    required this.RentalID,
  });
  Map<String, dynamic> toJson() => {
        'RoomID': RoomID,
        'BeginDate': BeginDate,
        'GuestIDs': GuestIDs,
        'RentalID': RentalID,
      };
  static RentalFormModel fromJson(Map<String, dynamic> json) {
    return RentalFormModel(
      RoomID: json['RoomID'],
      BeginDate: DateTime(2023, 4, 26),
      GuestIDs: List.from(json['GuestIDs']),
      RentalID: json['RentalID'],
    );
  }

  
}
