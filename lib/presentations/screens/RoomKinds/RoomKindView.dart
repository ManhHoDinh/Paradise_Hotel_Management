import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/presentations/widgets/appBar_widget.dart';

import '../../widgets/room_kind_widget.dart';
import 'AddRoomKindScreen.dart';

class RoomKindView extends StatefulWidget {
  const RoomKindView({super.key});
  static final String routeName = 'room_kind_view';
  @override
  State<RoomKindView> createState() => _RoomKindViewState();
}

class _RoomKindViewState extends State<RoomKindView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('ROOM TYPE'),
         toolbarHeight: kToolbarHeight * 1.5,
         centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.primaryColor,
        child: Text(
          '+',
          style: TextStyles.h1.copyWith(color: ColorPalette.backgroundColor),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddRoomKindScreen.routeName);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FireBaseDataBase.readRoomKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong! ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    RoomKindModel.AllRoomKinds = snapshot.data!;
                    return Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 80),
                      child: Column(
                        children: RoomKindModel.AllRoomKinds.map(
                            (e) => RoomKindWidget(
                                  roomKind: e,
                                )).toList(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
