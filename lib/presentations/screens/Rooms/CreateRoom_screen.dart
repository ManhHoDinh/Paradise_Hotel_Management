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
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/check_box.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/inputTitleWidget.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/input_widget.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';

import '../../widgets/counter.dart';

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
  List<String> kindItems = [];
  String? dropdownKindValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UploadButton.ResetUploadButton();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: ColorPalette.primaryColor,
                  size: 100,
                ),
              )
            : SingleChildScrollView(
                child: Center(
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
                      InputTitleWidget(
                        Title: 'Room ID',
                        controller: roomIdController,
                        hintInput: 'Type here',
                      ),
                      Container(
                        child: Text(
                          'Type of room',
                          style: TextStyles.h6.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontWeight: FontWeight.w500),
                        ),
                        margin: const EdgeInsets.only(
                            left: kMaxPadding * 1.5, top: kDefaultPadding),
                      ),
                      Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: ColorPalette.detailBorder)),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            child: DropdownButton2(
                              alignment: Alignment.center,
                              iconStyleData: IconStyleData(
                                  iconEnabledColor: ColorPalette.primaryColor),
                              dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kMinPadding))),
                              hint: Center(
                                child: Text(
                                  'Choose here',
                                  style: TextStyles.defaultStyle.grayText,
                                ),
                              ),
                              items: RoomKindModel.kindItems
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      onTap: () {
                                        setState(() {
                                          RoomKindModel kindSelected =
                                              RoomKindModel.AllRoomKinds.where(
                                                      (roomKind) =>
                                                          roomKind.Name! == e)
                                                  .first;
                                          _price = kindSelected.Price ?? 0;
                                          roomKindID =
                                              kindSelected.RoomKindID ?? '';
                                        });
                                      },
                                      child: Center(
                                        child: Container(
                                          child: Text(
                                            e,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles
                                                .defaultStyle.grayText,
                                          ),
                                        ),
                                      )))
                                  .toList(),
                              buttonStyleData: const ButtonStyleData(
                                padding:
                                    const EdgeInsets.only(left: 65, right: 20),
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
                        child: Row(
                          children: [
                            Text(
                              'Price',
                              style: TextStyles.h6.copyWith(
                                  color: ColorPalette.darkBlueText,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                    margin: const EdgeInsets.only(
                                      right: kMaxPadding * 1.5,
                                    ),
                                    child: Text(
                                      _price.toString() + "VND per night",
                                      style: TextStyles.h6.italic.copyWith(
                                          color: ColorPalette.primaryColor),
                                    ));
                              },
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(
                            left: kMaxPadding * 1.5, top: kItemPadding * 2),
                      ),
                      Container(
                        child: Text(
                          'Max Capacity',
                          style: TextStyles.h6.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontWeight: FontWeight.w500),
                        ),
                        margin: const EdgeInsets.only(
                            left: kMaxPadding * 1.5, top: kItemPadding * 3),
                      ),
                      Container(
                        child: CounterView(
                          initNumber: 3,
                          minNumber: 1,
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: kMaxPadding * 1.5,
                            vertical: kItemPadding * 2),
                      ),
                      InputTitleWidget(
                        Title: 'Description',
                        controller: descriptionController,
                        hintInput: 'Type here',
                      ),
                      Container(
                        child: Text(
                          'Pictures',
                          style: TextStyles.h6.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontWeight: FontWeight.w500),
                        ),
                        margin: const EdgeInsets.only(
                            left: kMaxPadding * 1.5, top: kItemPadding * 2),
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
                                RoomID: roomIdController.text,
                                maxCap: CounterView.maxCap);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
            //alignment: Alignment.center,
          ),
          centerTitle: true,
          toolbarHeight: kToolbarHeight * 1.5,
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
      required String RoomID,
      required int maxCap}) async {
    PrimaryImageUrl = '';
    SubImageUrls.clear();

    if (RoomID == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Room',
              error: 'Check Input Room ID, please!!!',
            );
          });
    } else if (roomKindID == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Room',
              error: 'Select a Type of room, please!!!',
            );
          });
    } else if (await checkIfDocExists(RoomID)) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Room',
              error: 'Room ID Exist',
            );
          });
    } else if (UploadButton.PrimaryImagePath == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Room',
              error: 'Input Image',
            );
          });
    } else {
      setState(() {
        isLoading = true;
      });
      final docUser =
          FirebaseFirestore.instance.collection('Rooms').doc(RoomID);

      await UploadImages(
          PrimaryImagePath: UploadButton.PrimaryImagePath,
          SubImagePaths: UploadButton.SubImagePath);
      print("----------------------" + SubImageUrls.length.toString());
      RoomModel _room = await RoomModel(
          roomID: roomIdController.text,
          PrimaryImage: PrimaryImageUrl,
          RoomKindID: roomKindID,
          State: State,
          SubImages: SubImageUrls,
          Description: descriptionController.text,
          maxCapacity: maxCap);
      final json = _room.toJson();
      await docUser.set(json);
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              task: 'Create Room',
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
