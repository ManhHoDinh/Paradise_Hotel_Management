import 'package:cloud_firestore/cloud_firestore.dart';

class RentalFormModel {
  DateTime beginDate;
  List<String> GuestIDs = [];
  String RentalID;
  String RoomID;
  String Status;
  RentalFormModel(
      {required this.RentalID,
      required this.GuestIDs,
      required this.beginDate,
      required this.RoomID,
      required this.Status});
  Map<String, dynamic> toJson() => {
        'BeginDate': beginDate,
        'GuestIDs': GuestIDs,
        'RentalID': RentalID,
        'RoomID': RoomID,
        'Status': Status,
      };
  static RentalFormModel fromJson(Map<String, dynamic> json) {
    Timestamp t = json['BeginDate'];
    DateTime day = t.toDate();
    return RentalFormModel(
        RentalID: json['RentalID'],
        beginDate: day,
        GuestIDs: List.from(json['GuestIDs']),
        RoomID: json['RoomID'],
        Status: json['Status']);
  }

  static List<RentalFormModel> AllForms = [];
}
