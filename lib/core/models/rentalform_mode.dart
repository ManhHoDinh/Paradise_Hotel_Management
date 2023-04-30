import 'package:cloud_firestore/cloud_firestore.dart';

class RentalFormModel {
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
        'BeginDate': Timestamp.fromDate(BeginDate!),
        'GuestIDs': GuestIDs,
        'RentalID': RentalID,
      };
  static RentalFormModel fromJson(Map<String, dynamic> json) {
    return RentalFormModel(
      RoomID: json['RoomID'],
      BeginDate: (json['BeginDate'] as Timestamp).toDate(),
      GuestIDs: List.from(json['GuestIDs']),
      RentalID: json['RentalID'],
    );
  }

  static String CollectionName = 'RentalForm';
  static List<RentalFormModel> AllRentalFormModels = [];
}
