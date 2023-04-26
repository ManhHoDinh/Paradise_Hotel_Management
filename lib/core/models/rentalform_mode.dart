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
      RoomID: json['RoomKindID'],
      BeginDate: json['Name'],
      GuestIDs: List.from(json['GuestIDs']),
      RentalID: json['RentalID'],
    );
  }
}
