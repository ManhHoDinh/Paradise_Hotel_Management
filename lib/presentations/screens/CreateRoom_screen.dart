import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';
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
  int currentId = 0, _price = 0;
  bool isPressed = false;
  String roomKindID = '';
  TextEditingController roomIdController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController maxCapacityController = new TextEditingController();
  String PrimaryImageUrl = '';
  List<String> SubImageUrls = [];
  bool isLoading = false;
  String kindRoom = 'Kind';
  List<String> kindItems = [];
  String? dropdownKindValue;
  List<RoomKindModel> kindlist = [];
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
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: ColorPalette.primaryColor,
                  size: 100,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding * 2),
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
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      child: InputDefault(
                        labelText: 'Type here',
                        controller: roomIdController,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding),
                    ),
                    Container(
                      child: Text(
                        'Type of room',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          child: DropdownButton2(
                            alignment: Alignment.centerLeft,
                            iconStyleData: IconStyleData(
                                iconEnabledColor: ColorPalette.primaryColor),
                            dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kMinPadding))),
                            hint: Text(
                              'Kind',
                              style: TextStyles.defaultStyle.grayText,
                            ),
                            items: RoomKindModel.kindItems
                                .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    onTap: () {
                                      setState(() {
                                        kindRoom = e;
                                        RoomKindModel kindSelected =
                                            RoomKindModel.AllRoomKinds.where(
                                                (roomKind) =>
                                                    roomKind.Name! == e).first;
                                        _price = kindSelected.Price ?? 0;
                                        roomKindID =
                                            kindSelected.RoomKindID ?? '';
                                      });
                                    },
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.defaultStyle.grayText,
                                    )))
                                .toList(),
                            buttonStyleData: const ButtonStyleData(
                              padding: const EdgeInsets.only(left: 12),
                              height: 28,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 28,
                            ),
                            value: dropdownKindValue,
                            onChanged: (value) {
                              setState(() {
                                dropdownKindValue = value;
                                print(dropdownKindValue);
                              });
                            },
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding * 2),
                    ),
                    Container(
                      child: Text(
                        'Price',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: kMaxPadding * 1.5, vertical: 10),
                            child: Center(child: Text(_price.toString())));
                      },
                    ),
                    Container(
                      child: Text(
                        'Max Capacity',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      child: InputDefault(
                        labelText: 'Type here',
                        controller: maxCapacityController,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding),
                    ),
                    Container(
                      child: Text(
                        'Note',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      child: InputDefault(
                        labelText: 'Type here',
                        controller: descriptionController,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding),
                    ),
                    Container(
                      child: Text(
                        'Pictures',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      // padding: const EdgeInsets.only(top: 200),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding),
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
                              roomKindID: roomKindID,
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
      required String roomKindID,
      required int price,
      required String State,
      required String RoomID}) async {
    setState(() {
      isLoading = true;
    });
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
          RoomKindID: roomKindID,
          price: price,
          State: State,
          SubImages: SubImageUrls,
          Description: descriptionController.text,
          maxCapacity: int.tryParse(maxCapacityController.text));
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
        isLoading = false;
      });
      setState(() {
        roomIdController.text = '';
        descriptionController.text = '';
        price = 0;
        roomKindID = '';
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
