import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/room_model.dart';

import 'guest_kind_model.dart';

class RentalFormModel {
  String RentalID;
  String RoomID;
  DateTime BeginDate;
  List<String> GuestIDs;
  String Status;

  int UnitPrice;
  double HighestGuestKindSurchargeRatio;
  String HighestGuestKindRatioName;
  double SurchargeRatio;
  int NumberGuestNoSubCharge;

  RentalFormModel(
      {required this.RoomID,
      required this.BeginDate,
      required this.GuestIDs,
      required this.RentalID,
      required this.Status,
      required this.UnitPrice,
      required this.HighestGuestKindRatioName,
      required this.HighestGuestKindSurchargeRatio,
      required this.NumberGuestNoSubCharge,
      required this.SurchargeRatio});
  Map<String, dynamic> toJson() => {
        'RoomID': RoomID,
        'BeginDate': Timestamp.fromDate(BeginDate!),
        'GuestIDs': GuestIDs,
        'RentalID': RentalID,
        'Status': Status,
        'HighestGuestKindRatioName': HighestGuestKindRatioName,
        'HighestGuestKindSurchargeRatio':
            HighestGuestKindSurchargeRatio.toString(),
        'NumberGuestNoSubCharge': NumberGuestNoSubCharge.toString(),
        'SurchargeRatio': SurchargeRatio.toString(),
        'UnitPrice': UnitPrice.toString()
      };
  static RentalFormModel fromJson(Map<String, dynamic> json) {
    return RentalFormModel(
        RoomID: json['RoomID'],
        BeginDate: (json['BeginDate'] as Timestamp).toDate(),
        GuestIDs: List.from(json['GuestIDs']),
        RentalID: json['RentalID'],
        Status: json['Status'],
        UnitPrice: int.parse(json['UnitPrice']),
        HighestGuestKindRatioName: json['HighestGuestKindRatioName'],
        HighestGuestKindSurchargeRatio:
            double.parse(json['HighestGuestKindSurchargeRatio']),
        NumberGuestNoSubCharge: int.parse(json['NumberGuestNoSubCharge']),
        SurchargeRatio: double.parse(json['SurchargeRatio']));
  }

  static String CollectionName = 'RentalForm';
  static List<RentalFormModel> AllRentalFormModels = [];
  static List<RentalFormModel> AllUnpaidRentalFormModels() {
    return AllRentalFormModels.where((rental) => rental.Status == 'Unpaid')
        .toList();
  }

  int ExcessCustomerSurcharge(int days) {
    if (GuestIDs.length > NumberGuestNoSubCharge)
      return (UnitPrice * days * (SurchargeRatio - 1)).toInt();
    return 0;
  }

  int Total(int days) {
    try {
      if (days < 0) throw Exception();
      int guestKindSurcharge = GuestKindSurcharge(days);
      int normalFee = UnitPrice * days;
      int excessCustomerSurcharge = ExcessCustomerSurcharge(days);
      return guestKindSurcharge + normalFee + excessCustomerSurcharge;
    } catch (e) {
      return 0;
    }
  }

  void UpdateInformation() {
    HighestGuestKindSurchargeRatio = HighestGuestKindRatio();
    RoomModel room = getRoom();
    UnitPrice = room.getPrice();
    NumberGuestNoSubCharge = room.NumberGuestNoSubCharge ?? 0;
    SurchargeRatio = room.SubChargeRatio ?? 0;
    HighestGuestKindRatioName = HighestGuestKindRatioSurchargeName();
  }

  HighestGuestKindRatio() {
    double Result = 0;
    for (String guestID in GuestIDs)
      if (GuestKindModel.getGuestKindRatioByGuestID(guestID) >= Result)
        Result = GuestKindModel.getGuestKindRatioByGuestID(guestID);
    return Result;
  }

  HighestGuestKindRatioSurchargeName() {
    double Ratio = 0;
    String Name = '';
    for (String guestID in GuestIDs) {
      if (GuestKindModel.getGuestKindRatioByGuestID(guestID) >= Ratio) {
        Ratio = GuestKindModel.getGuestKindRatioByGuestID(guestID);
        Name = GuestKindModel.getGuestKindNameByGuestID(guestID);
      }
    }
    return Name;
  }

  NumberOfHighestGuestKindRatioSurchargeGuest() {
    int count = 0;
    print(RentalID);
    for (String guestID in GuestIDs) {
      print(guestID);
      print(GuestKindModel.getGuestKindRatioByGuestID(guestID).toString() +
          ' ' +
          HighestGuestKindSurchargeRatio.toString());
      if (GuestKindModel.getGuestKindRatioByGuestID(guestID) ==
          HighestGuestKindSurchargeRatio) {
        count++;
      }
    }
    print(count);
    return count;
  }

  int GuestKindSurcharge(int days) {
    try {
      if (days < 0) throw Exception();
      if (HighestGuestKindSurchargeRatio < 1) throw Exception();
      return ((HighestGuestKindSurchargeRatio - 1) * UnitPrice * days).toInt();
    } catch (e) {
      return 0;
    }
  }

  RoomModel getRoom() {
    return RoomModel.AllRooms.where((element) => RoomID == element.roomID)
        .first;
  }
}
