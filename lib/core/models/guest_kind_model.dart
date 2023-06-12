import 'package:paradise/core/models/guest_model.dart';

class GuestKindModel {
  String GuestKindID;
  String Name;
  double ratio;
  GuestKindModel({
    required this.GuestKindID,
    required this.Name,
    required this.ratio,
  });
  static String CollectionName = 'GuestKinds';
  Map<String, dynamic> toJson() => {
        'GuestKindID': GuestKindID,
        'GuestKindName': Name,
        'Ratio': ratio.toString(),
      };

  static GuestKindModel fromJson(Map<String, dynamic> json) {
    return GuestKindModel(
      GuestKindID: json['GuestKindID'],
      Name: json['GuestKindName'],
      ratio: double.parse(json['Ratio']),
    );
  }

  static List<String> kindItems = [];
  static List<GuestKindModel> AllGuestKinds = [];

  static String getGuestKindNameByGuestID(String GuestID) {
    try {
      GuestModel guest =
          GuestModel.AllGuests.where((guest) => guest.guestID == GuestID).first;
      GuestKindModel kindSelected = GuestKindModel.AllGuestKinds.where(
          (guestKind) => guestKind.GuestKindID == guest.guestKindID).first;
      return kindSelected.Name;
    } catch (e) {
      return '';
    }
  }

  static String getGuestKindID(String name) {
    try {
      GuestKindModel kindSelected = GuestKindModel.AllGuestKinds.where(
          (guestKind) => guestKind.Name == name).first;
      return kindSelected.GuestKindID;
    } catch (e) {
      return '';
    }
  }

  static double getGuestKindRatioByGuestID(String GuestID) {
    try {
      GuestModel guest =
          GuestModel.AllGuests.where((guest) => guest.guestID == GuestID).first;
      GuestKindModel kindSelected = GuestKindModel.AllGuestKinds.where(
          (guestKind) => guestKind.GuestKindID == guest.guestKindID).first;

      print(kindSelected.ratio);
      return kindSelected.ratio;
    } catch (e) {
      print("Error");
      return 0;
    }
  }
}
