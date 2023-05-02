import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/firebase_options.dart';

class FireBaseDataBase {
  static CollectionReference? referenceRooms;
  static Stream<List<RoomModel>> readRooms() => FirebaseFirestore.instance
      .collection('Rooms')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => RoomModel.fromJson(doc.data())).toList());
  static initializeDB() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    referenceRooms = await FirebaseFirestore.instance.collection('Rooms');
  }

  static Stream<List<RoomKindModel>> readRoomKinds() =>
      FirebaseFirestore.instance.collection('RoomKind').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => RoomKindModel.fromJson(doc.data()))
              .toList());
  static Stream<List<RentalFormModel>> readRentalForm() =>
      FirebaseFirestore.instance.collection('RentalForm').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => RentalFormModel.fromJson(doc.data()))
              .toList());
  static Stream<List<GuestKindModel>> readGuestKinds() =>
      FirebaseFirestore.instance.collection('GuestKinds').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => GuestKindModel.fromJson(doc.data()))
              .toList());
}
