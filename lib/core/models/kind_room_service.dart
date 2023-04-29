import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/models/room_kind_model.dart';

class KindRoomService {
  FirebaseFirestore? _instance;
  List<RoomKindModel> list = [];
  List<RoomKindModel> getRoomKinds() {
    return list;
  }

  Future<void> getRoomKindCollection() async {
    _instance = FirebaseFirestore.instance;

    var snapshot =
        await FirebaseFirestore.instance.collection('GuestKinds').get();
    list = snapshot.docs.map((e) => RoomKindModel.fromJson(e.data())).toList();
  }
}
