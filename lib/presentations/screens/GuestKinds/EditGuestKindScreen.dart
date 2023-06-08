import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/presentations/widgets/question_yes_no_dialog.dart';

import '../../../../core/constants/color_palatte.dart';
import '../../../../core/helpers/text_styles.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dialog.dart';
import '../../widgets/inputTitleWidget.dart';

class EditGuestKindScreen extends StatefulWidget {
  EditGuestKindScreen({super.key, this.guestKind});
  GuestKindModel? guestKind;
  @override
  State<EditGuestKindScreen> createState() => _EditGuestKindScreenState();
}

class _EditGuestKindScreenState extends State<EditGuestKindScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController RatioController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.guestKind?.Name ?? '';
    RatioController.text = widget.guestKind?.ratio.toString() ?? '';
  }

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
            'EDIT GUEST KIND',
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
      body: SingleChildScrollView(
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
              controller: RatioController,
              hintInput: 'Type here',
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 60),
              width: 150,
              child: ButtonDefault(
                  label: 'Save',
                  onTap: () {
                    UpdateGuestKind(
                        name: nameController.text, Ratio: RatioController.text);
                  })),
          Container(
              margin: EdgeInsets.only(top: 30),
              width: 150,
              child: ButtonDefault(
                label: 'Delete',
                backgroundColor: ColorPalette.redColor,
                onTap: () {
                  DeleteGuestKind();
                },
              )),
        ]),
      ),
    );
  }

  void UpdateGuestKind({required String name, required String Ratio}) async {
    try {
      if (name == '') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Edit Guest Kind',
                error: "Input Type Name, please!!!",
              );
            });
      } else if (Ratio == '' || double.tryParse(Ratio) == null) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Edit Guest Kind',
                error: "Check input Ratio, please!!!",
              );
            });
      } else {
        final docGuestKind = await FirebaseFirestore.instance
            .collection(GuestKindModel.CollectionName)
            .doc(widget.guestKind?.GuestKindID ?? '');
        GuestKindModel guestKind = new GuestKindModel(
            Name: name,
            ratio: double.parse(Ratio),
            GuestKindID: widget.guestKind?.GuestKindID ?? '');
        final json = guestKind.toJson();
        await docGuestKind.update(json);
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: true,
                task: 'Update Room Kind',
              );
            });
      }
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

  void DeleteGuestKind() async {
    try {
      showDialog(
          context: context,
          builder: (_context) {
            return QuestionYesNoDialog(
              task: 'Delete Guest Kind',
              icon: FontAwesomeIcons.solidTrashCan,
              yesOnTap: () async {
                if (GuestModel.ExistGuestWithGuestKindID(
                    widget.guestKind?.GuestKindID ?? '')) {
                  Navigator.pop(context);
                  showDialog(
                      context: _context,
                      builder: (_context) {
                        return DialogOverlay(
                          isSuccess: false,
                          task: 'Delete Guest Kind',
                          error: 'Guests have used this type!!!',
                        );
                      });
                } else {
                  final docGuestKind = await FirebaseFirestore.instance
                      .collection(GuestKindModel.CollectionName)
                      .doc(widget.guestKind?.GuestKindID ?? '');
                  await docGuestKind.delete();
                  Navigator.pop(context);
                  await showDialog(
                      context: _context,
                      builder: (_context) {
                        return DialogOverlay(
                          isSuccess: true,
                          task: 'Delete Guest Kind',
                        );
                      });
                  Navigator.of(context).pop();
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
              task: 'Delete Guest Kind',
              error: e.toString(),
            );
          });
    }
  }
}

Future<bool> checkIfDocExists(String docId) async {
  bool result = false;
  await FirebaseFirestore.instance
      .collection('GuestKind')
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
