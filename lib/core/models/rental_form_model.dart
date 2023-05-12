import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';

import 'guest_kind_model.dart';

class RentalFormModel {
  String RentalID;
  String RoomID;
  DateTime BeginDate;
  List<String> GuestIDs;
  String Status;
  RentalFormModel({
    required this.RoomID,
    required this.BeginDate,
    required this.GuestIDs,
    required this.RentalID,
    required this.Status,
  });
  Map<String, dynamic> toJson() => {
        'RoomID': RoomID,
        'BeginDate': Timestamp.fromDate(BeginDate!),
        'GuestIDs': GuestIDs,
        'RentalID': RentalID,
        'Status': Status
      };
  static RentalFormModel fromJson(Map<String, dynamic> json) {
    return RentalFormModel(
        RoomID: json['RoomID'],
        BeginDate: (json['BeginDate'] as Timestamp).toDate(),
        GuestIDs: List.from(json['GuestIDs']),
        RentalID: json['RentalID'],
        Status: json['Status']);
  }

  static String CollectionName = 'RentalForm';
  static List<RentalFormModel> AllRentalFormModels = [];
  static List<RentalFormModel> AllUnpaidRentalFormModels() {
    return AllRentalFormModels.where((rental) => rental.Status == 'Unpaid')
        .toList();
  }
  int ExcessCustomerSurcharge() {
    return 10;
  }

  int Total(int days) {
    try {
      if (days < 0) throw Exception();
      int guestKindSurcharge =
          GuestKindSurcharge(days);
      int normalFee = RoomModel.getPriceWithRoomID(RoomID ) * days;
      int excessCustomerSurcharge = ExcessCustomerSurcharge();
      return guestKindSurcharge + normalFee + excessCustomerSurcharge;
    } catch (e) {
      return 0;
    }
  }
  
  HighestGuestKindRatio() {
    double Result = 0;
    for (String guestID in GuestIDs)
      if (GuestKindModel.getGuestKindRatio(guestID) >= Result)
        Result = GuestKindModel.getGuestKindRatio(guestID);
    return Result;
  }

  int GuestKindSurcharge(int days) {
    try {
      int unitPrice = RoomModel.getPriceWithRoomID(RoomID);
      double ratio = HighestGuestKindRatio();
      if (days < 0) throw Exception();
      if (ratio < 1) throw Exception();
      return ((ratio - 1) * unitPrice * days).toInt();
    } catch (e) {
      return 0;
    }
  }
  RoomModel getRoom()
  {
    return RoomModel.AllRooms.where((element) => RoomID==element.roomID).first;
  }
}
