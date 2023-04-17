import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';

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
      body: StreamBuilder(
        stream: FireBaseDataBase.readRoomKinds(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong! ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            RoomKindModel.AllRoomKinds = snapshot.data!;
            return Column(
              children:
                  RoomKindModel.AllRoomKinds.map((e) => Text(e.Name ?? ''))
                      .toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
