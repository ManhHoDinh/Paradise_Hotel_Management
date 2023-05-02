import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/guest_kind_model.dart';

class GuestModel {
  String? guestID;
  String? name;
  String? guestKindID;
  String? address;
  GuestModel({
    required this.guestID,
    required this.name,
    required this.guestKindID,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'GuestID': guestID,
        'Name': name,
        'GuestKindID': guestKindID,
        'Address': address,
      };

  static GuestModel fromJson(Map<String, dynamic> json) => GuestModel(
      guestID: json['GuestID'],
      name: json['Name'],
      guestKindID: json['GuestKindID'],
      address: json['Address']);
  static List<GuestModel> AllGuests = [];
  static String CollectionName = 'Guests';
  static bool IsSameGuestKind(String guestID, String guestKindID) {
    try {
      GuestModel guest =
          GuestModel.AllGuests.where((guest) => guest.guestID == guestID).first;
      return guest.guestKindID == guestKindID;
    } catch (e) {
      return false;
    }
  }
}
