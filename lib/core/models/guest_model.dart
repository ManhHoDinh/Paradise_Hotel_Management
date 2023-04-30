import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/guest_kind_model.dart';

class GuestModel {
  String? cmnd;
  String? name;
  String? guestKindID;
  String? address;
  GuestModel({
    required this.cmnd,
    required this.name,
    required this.guestKindID,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'CMND': cmnd,
        'Name': name,
        'GuestKindID': guestKindID,
        'Address': address,
      };

  static GuestModel fromJson(Map<String, dynamic> json) => GuestModel(
      cmnd: json['CMND'],
      name: json['Name'],
      guestKindID: json['GuestKindID'],
      address: json['Address']);
  static List<GuestModel> AllGuests = [];
  static String CollectionName = 'Guests';
  static bool IsForeignGuest(String id) {
    try {
      GuestModel guest =
          GuestModel.AllGuests.where((guest) => guest.cmnd == id).first;
      return GuestKindModel.getGuestKindName(guest.guestKindID ?? '') ==
          "Foreign";
    } catch (e) {
      return false;
    }
  }
}
