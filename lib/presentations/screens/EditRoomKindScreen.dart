import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/widgets/question_yes_no_dialog.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/helpers/text_styles.dart';
import '../../core/models/room_kind_model.dart';
import '../widgets/button_default.dart';
import '../widgets/dialog.dart';
import '../widgets/inputTitleWidget.dart';

class EditRoomKindScreen extends StatefulWidget {
  EditRoomKindScreen({super.key, this.roomKindModel});
  RoomKindModel? roomKindModel;
  @override
  State<EditRoomKindScreen> createState() => _EditRoomKindScreenState();
}

class _EditRoomKindScreenState extends State<EditRoomKindScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.roomKindModel?.Name ?? '';
    priceController.text = widget.roomKindModel?.Price.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('NEW ROOM TYPE'),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 40),
            child: Text(
              'ROOM KIND',
              style: TextStyles.h2.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          InputTitleWidget(
            Title: 'Type name',
            controller: nameController,
            hintInput: 'Type here',
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: InputTitleWidget(
              Title: 'Price',
              controller: priceController,
              hintInput: 'Type here',
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 60),
              width: 150,
              child: ButtonDefault(
                  label: 'Save',
                  onTap: () {
                    UpdateRoomKind(
                        name: nameController.text,
                        price: int.parse(priceController.text));
                  })),
          Container(
              margin: EdgeInsets.only(top: 30),
              width: 150,
              child: ButtonDefault(
                label: 'Delete',
                backgroundColor: ColorPalette.redColor,
                onTap: () {
                  DeleteRoomKind();
                },
              )),
        ]),
      ),
    );
  }

  void UpdateRoomKind({required String name, required int price}) async {
    try {
      final docRoomKind = await FirebaseFirestore.instance
          .collection('RoomKind')
          .doc(widget.roomKindModel?.RoomKindID ?? '');
      RoomKindModel roomKindModel = new RoomKindModel(
          Name: name,
          Price: price,
          RoomKindID: widget.roomKindModel?.RoomKindID ?? '');
      final json = roomKindModel.toJson();
      await docRoomKind.update(json);
      final CollectionReference roomReference =
          FirebaseFirestore.instance.collection('Rooms');
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
              task: 'Update Room Kind',
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Update Room Kind',
              error: e.toString(),
            );
          });
    }
  }

  void DeleteRoomKind() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return QuestionYesNoDialog(
              task: 'Delete Room Kind',
              icon: FontAwesomeIcons.solidTrashCan,
              yesOnTap: () async {
                if (RoomModel.ExistRoomWithRoomID(
                    widget.roomKindModel?.RoomKindID ?? '')) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialogOverlay(
                          isSuccess: false,
                          task: 'Delete Room Kind',
                          error: 'Rooms have used this type!!!',
                        );
                      });
                } else {
                  final docRoomKind = await FirebaseFirestore.instance
                      .collection('RoomKind')
                      .doc(widget.roomKindModel?.RoomKindID ?? '');
                  await docRoomKind.delete();
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialogOverlay(
                          isSuccess: true,
                          task: 'Delete Room Kind',
                        );
                      }); //.whenComplete(() => Navigator.of(context).pop());
                }
              },
              noOnTap: () {
                Navigator.pop(context);
              },
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Delete Room Kind',
              error: e.toString(),
            );
          });
    }
  }
}

Future<bool> checkIfDocExists(String docId) async {
  bool result = false;
  await FirebaseFirestore.instance
      .collection('RoomKind')
      .doc(docId)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    print('-----before' + result.toString());
    result = documentSnapshot.exists;
    print('set-----' + result.toString());
  });
  print('Return' + result.toString());
  return result;
}
