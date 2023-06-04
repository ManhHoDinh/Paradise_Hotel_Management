import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/notification_model.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:paradise/firebase_options.dart';
import 'package:paradise/core/models/rental_form_model.dart';

class FireBaseDataBase {
  static CollectionReference? referenceRooms;
  static Stream<List<RoomModel>> readRooms() => FirebaseFirestore.instance
      .collection(RoomModel.CollectionName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => RoomModel.fromJson(doc.data())).toList());
  static initializeDB() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    referenceRooms = await FirebaseFirestore.instance.collection('Rooms');
  }

  static Stream<List<UserModel>> readUsers() =>
      FirebaseFirestore.instance.collection('Users').snapshots().map((event) =>
          event.docs.map((e) => UserModel.fromJson(e.data())).toList());

  static Stream<List<RoomKindModel>> readRoomKinds() =>
      FirebaseFirestore.instance
          .collection(RoomKindModel.CollectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => RoomKindModel.fromJson(doc.data()))
              .toList());
  static Stream<List<GuestKindModel>> readGuestKinds() => FirebaseFirestore
      .instance
      .collection(GuestKindModel.CollectionName)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => GuestKindModel.fromJson(doc.data()))
          .toList());
  static Stream<List<RentalFormModel>> readRentalForms() =>
      FirebaseFirestore.instance
          .collection(RentalFormModel.CollectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => RentalFormModel.fromJson(doc.data()))
              .toList());
  static Stream<List<ReceiptModel>> readReceipts() => FirebaseFirestore.instance
      .collection(ReceiptModel.CollectionName)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ReceiptModel.fromJson(doc.data()))
          .toList());
  static Stream<List<GuestModel>> readGuests() => FirebaseFirestore.instance
      .collection(GuestModel.CollectionName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => GuestModel.fromJson(doc.data())).toList());
  static Stream<List<NotificationModel>> readNotification() =>
      FirebaseFirestore.instance
          .collection(NotificationModel.CollectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromJson(doc.data()))
              .toList());
}
