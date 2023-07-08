import 'package:flutter/material.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';

import '../../core/models/firebase_request.dart';
import '../../core/models/rental_form_model.dart';

class FetchAllData extends StatelessWidget {
  FetchAllData({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireBaseDataBase.readRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RoomModel.AllRooms = snapshot.data!;
          }
          return StreamBuilder(
              stream: FireBaseDataBase.readRoomKinds(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RoomKindModel.AllRoomKinds = snapshot.data!;
                }
                return StreamBuilder(
                    stream: FireBaseDataBase.readGuests(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        GuestModel.AllGuests = snapshot.data!;
                      }
                      return StreamBuilder(
                          stream: FireBaseDataBase.readGuestKinds(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              GuestKindModel.AllGuestKinds = snapshot.data!;
                            }
                            return StreamBuilder(
                                stream: FireBaseDataBase.readRentalForms(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    RentalFormModel.AllRentalFormModels =
                                        snapshot.data!;
                                  }
                                  return StreamBuilder(
                                      stream: FireBaseDataBase.readReceipts(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          ReceiptModel.AllReceipts =
                                              snapshot.data!;
                                        }
                                        return child;
                                      });
                                });
                          });
                    });
              });
        });
  }
}
