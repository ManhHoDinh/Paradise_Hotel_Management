import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/color_palatte.dart';
import '../../../../core/helpers/text_styles.dart';
import '../../../core/constants/dimension_constants.dart';
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
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leadingWidth: kDefaultIconSize * 3,
        leading: Container(
          width: double.infinity,
          child: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {},
            splashColor: ColorPalette.primaryColor,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(FontAwesomeIcons.arrowLeft),
            ),
          ),
        ),
        title: Container(
          child: Text(
            'NEW GUEST KIND',
            style: TextStyles.h8.bold.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(3, 6),
                  blurRadius: 6,
                )
              ],
              letterSpacing: 1.175,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 40),
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
