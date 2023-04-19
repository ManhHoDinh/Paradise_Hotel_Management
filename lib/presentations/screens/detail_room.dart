import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/rental_form.dart';

import '../widgets/button_widget.dart';

class DetailRoom extends StatefulWidget {
  DetailRoom({super.key, required this.room});
  static final String routeName = 'detail_screen';
  RoomModel room;
  @override
  State<DetailRoom> createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoom> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

    return Scaffold(
      key: _globalKey,
      endDrawer: Drawer(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Book Room',
              color: ColorPalette.primaryColor,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RentalForm(room: widget.room,)));
              },
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Edit Room',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Delete',
              color: ColorPalette.primaryColor,
              onTap: () {
                if (widget.room.State == 'Available') {
                  DeleteRoom(widget.room.roomID ?? '');
                }
              },
              textColor: ColorPalette.backgroundColor,
            ),
          ),
        ]),
      ),
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.amber),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: Colors.blue)),
              child: Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Room : ' + (widget.room.roomID ?? ''),
                    style: TextStyles.defaultStyle.bold.copyWith(
                        fontSize: 24, color: ColorPalette.primaryColor),
                    textAlign: TextAlign.left,
                  ),
                )
              ]),
            ),
            flex: 7,
          ),
        ],
      )),
    );
  }

  void DeleteRoom(String roomID) async {
    try {
      await FirebaseStorage.instance.ref(roomID).listAll().then((value) {
        value.items.forEach((element) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        });
      });
      await FirebaseFirestore.instance.collection('Rooms').doc(roomID).delete();
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }
}
