import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/color_palatte.dart';
import '../../../../core/helpers/text_styles.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dialog.dart';
import '../../widgets/inputTitleWidget.dart';

class AddGuestKindScreen extends StatefulWidget {
  AddGuestKindScreen({super.key});
  static final String routeName = 'add_guest_kind_view';

  @override
  State<AddGuestKindScreen> createState() => _AddGuestKindScreenState();
}

class _AddGuestKindScreenState extends State<AddGuestKindScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ratioController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('NEW GUEST TYPE'),
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
                'GUEST KIND',
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
                Title: 'Ratio',
                controller: ratioController,
                hintInput: 'Type here',
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 60),
                width: 150,
                child: ButtonDefault(
                    label: 'Create',
                    onTap: () {
                      createGuestKind(
                          name: nameController.text,
                          ratio: ratioController.text);
                    })),
          ]),
        ),
      ),
    );
  }

  void createGuestKind({required String name, required String ratio}) async {
    try {
      if (name == '') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Create Guest Kind',
                error: "Input Type Name, please!!!",
              );
            });
      } else if (ratio == '' || double.tryParse(ratio) == null) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Create Guest Kind',
                error: "Check input ratio, please!!!",
              );
            });
      } else {
        final docGuestKind = await FirebaseFirestore.instance
            .collection(GuestKindModel.CollectionName)
            .doc();
        GuestKindModel guestKindModel = new GuestKindModel(
            Name: name,
            ratio: double.parse(ratio),
            GuestKindID: docGuestKind.id);

        final json = guestKindModel.toJson();

        await docGuestKind.set(json);
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: true,
                task: 'Create Guest Kind',
              );
            });
        nameController.text = '';
        ratioController.text = '';
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Guest Kind',
              error: e.toString(),
            );
          });
    }
  }
}
