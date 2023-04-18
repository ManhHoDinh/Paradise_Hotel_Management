import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/helpers/text_styles.dart';
import '../../core/models/room_kind_model.dart';
import '../widgets/button_default.dart';
import '../widgets/dialog.dart';
import '../widgets/inputTitleWidget.dart';

class AddRoomKindScreen extends StatefulWidget {
  AddRoomKindScreen({super.key});
  static final String routeName = 'add_room_kind_view';

  @override
  State<AddRoomKindScreen> createState() => _AddRoomKindScreenState();
}

class _AddRoomKindScreenState extends State<AddRoomKindScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('NEW ROOM TYPE'),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
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
                    label: 'Create',
                    onTap: () {
                      createRoomKind(
                          name: nameController.text,
                          price: priceController.text);
                    })),
          ]),
        ),
      ),
    );
  }

  void createRoomKind({required String name, required String price}) async {
    try {
      if (name == '') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Create Room Kind',
                error: "Input Type Name, please!!!",
              );
            });
      } else if (price == '' || int.tryParse(price) == null) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Create Room Kind',
                error: "Check input price, please!!!",
              );
            });
      } else {
        final docRoomKind =
            await FirebaseFirestore.instance.collection('RoomKind').doc();
        RoomKindModel roomKindModel = new RoomKindModel(
            Name: name, Price: int.parse(price), RoomKindID: docRoomKind.id);

        final json = roomKindModel.toJson();

        await docRoomKind.set(json);
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: true,
                task: 'Create Room Kind',
              );
            });
        nameController.text = '';
        priceController.text = '';
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Room Kind',
              error: e.toString(),
            );
          });
    }
  }
}
