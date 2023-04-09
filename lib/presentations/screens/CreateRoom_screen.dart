import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/rental_form.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/check_box.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = 'CreateRoom_screen';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  int currentId = 0, _price = 150000, _value = 1;
  bool isPressed = false;
  TextEditingController roomIdController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  String PrimaryImageUrl = '';
  List<String> SubImageUrls = [];
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
              'ROOMS',
              style: TextStyles.slo.bold.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(3, 6),
                    blurRadius: 6,
                  )
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        endDrawer: Drawer(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kMaxPadding),
                  child: Text(
                    'ROOM OPTIONS',
                    style: TextStyles.h2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor),
                  ),
                ),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: ButtonDefault(
                        label: 'Book Room',
                        onTap: () {
                          Navigator.of(context).pushNamed(RentalForm.routeName);
                        })),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child:
                        ButtonDefault(label: 'Create New Room', onTap: () {})),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: ButtonDefault(label: 'Edit Room', onTap: () {})),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                child: Text(
                  'CREATE NEW ROOM',
                  style: TextStyles.h4.copyWith(
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
              Container(
                child: Text(
                  'Room ID',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                child: InputDefault(
                  labelText: 'Type here',
                  controller: roomIdController,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              ),
              Container(
                child: Text(
                  'Name of room',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                child: InputDefault(
                  labelText: 'Type here',
                  controller: nameController,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              ),
              Container(
                child: Text(
                  'Type of room',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                child: InputDefault(
                    labelText: 'Type here', controller: typeController),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              ),
              Container(
                child: Text(
                  'Price',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding * 1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckBoxWidget(
                          label: '150.000',
                          value: 1,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _price = 150000;
                              _value = 1;
                            });
                          },
                        ),
                        CheckBoxWidget(
                          label: '170.000',
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _price = 170000;
                              _value = 2;
                            });
                          },
                        ),
                        CheckBoxWidget(
                          label: '200.000',
                          value: 3,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _price = 200000;
                              _value = 3;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                child: Text(
                  'Note',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                child: InputDefault(
                  labelText: 'Type here',
                  controller: descriptionController,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              ),
              Container(
                child: Text(
                  'Pictures',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                // padding: const EdgeInsets.only(top: 200),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
                child: UploadButton(
                  label: 'Upload here',
                  icon: AssetHelper.icoUpload,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: kMediumPadding * 1.5,
                    horizontal: kMaxPadding * 3),
                child: ButtonDefault(
                  label: 'Create',
                  onTap: () {
                    createRoom(
                        PrimaryImagePath: UploadButton.PrimaryImagePath,
                        name: nameController.text,
                        type: typeController.text,
                        State: 'Available',
                        price: _price,
                        RoomID: roomIdController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  void createRoom(
      {required String PrimaryImagePath,
      required String type,
      required int price,
      required String name,
      required String State,
      required String RoomID}) async {
    PrimaryImageUrl = '';
    SubImageUrls.clear();

    final docUser = FirebaseFirestore.instance.collection('Rooms').doc(RoomID);
    bool existId = await checkIfDocExists(RoomID);
    if (existId) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
            );
          });
    } else {
      await UploadImages(
          PrimaryImagePath: UploadButton.PrimaryImagePath,
          SubImagePaths: UploadButton.SubImagePath);
      print("----------------------" + SubImageUrls.length.toString());
      RoomModel _room = await RoomModel(
          roomID: roomIdController.text,
          PrimaryImage: PrimaryImageUrl,
          type: type,
          price: price,
          name: name,
          State: State,
          SubImages: SubImageUrls);
      final json = _room.toJson();
      await docUser.set(json);
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
            );
          });
      setState(() {
        roomIdController.text = '';
        nameController.text = '';
        descriptionController.text = '';
        typeController.text = '';
        _value = 1;
        price = 150000;
        UploadButton.ResetUploadButton();
      });
    }
  }

  UploadImages(
      {required String PrimaryImagePath,
      required List<String> SubImagePaths}) async {
    await UploadImage(
        imagePath: PrimaryImagePath,
        name: 'PrimaryImage.png',
        isPrimaryImage: true);
    for (int i = 0; i < SubImagePaths.length; i++)
      await UploadImage(
          imagePath: SubImagePaths[i],
          name: 'SubImage' + '${i}' + '.png',
          isPrimaryImage: false);
  }

  UploadImage(
      {required String imagePath,
      required String name,
      required isPrimaryImage}) async {
    var imageFile = File(imagePath);
    Reference ref =
        FirebaseStorage.instance.ref(roomIdController.text).child(name);
    await ref.putFile(imageFile);
    await ref.getDownloadURL().then((value) {
      print(value);
      if (isPrimaryImage)
        PrimaryImageUrl = value.toString();
      else
        SubImageUrls.add(value.toString());
    });
  }
}

Future<bool> checkIfDocExists(String docId) async {
  bool result = false;
  await FirebaseFirestore.instance
      .collection('Rooms')
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
