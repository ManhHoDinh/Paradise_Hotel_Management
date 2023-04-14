import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';

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
    return Scaffold(
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
}
