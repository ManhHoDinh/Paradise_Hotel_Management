import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/CreateRoom_screen.dart';
import 'package:paradise/presentations/screens/rental_form.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/check_box.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/drop_down_widget.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';

class EditRoomScreen extends StatefulWidget {
  static String routeName = 'edit_room';
  final RoomModel roomModel;
  const EditRoomScreen({
    super.key,
    required this.roomModel,
  });

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  late String roomID;
  late String kindRoom;
  late String roomKindID;
  late int _price;
  late String description;
  late String primaryImage;
  bool isLoading = false;
  String PrimaryImageUrl = '';
  List<String> SubImageUrls = [];
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController maxCapacityController = new TextEditingController();
  String? dropdownKindValue;

  @override
  Widget build(BuildContext context) {
    roomID = widget.roomModel.roomID ?? '';
    roomKindID = widget.roomModel.RoomKindID ?? '';
    kindRoom = RoomKindModel.getRoomKindName(widget.roomModel.RoomKindID!);
    _price = widget.roomModel.price ?? 0;
    description = widget.roomModel.Description ?? '';
    primaryImage = widget.roomModel.PrimaryImage ?? '';

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
          ),
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        // endDrawer: Drawer(
        //   child: Container(
        //     margin:
        //         const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2.5),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           margin: const EdgeInsets.symmetric(vertical: kMaxPadding),
        //           child: Text(
        //             'ROOM OPTIONS',
        //             style: TextStyles.h2.copyWith(
        //                 fontWeight: FontWeight.bold,
        //                 color: ColorPalette.primaryColor),
        //           ),
        //         ),
        //         Container(
        //             margin:
        //                 const EdgeInsets.symmetric(vertical: kDefaultPadding),
        //             child: ButtonDefault(
        //                 label: 'Book Room',
        //                 onTap: () {
        //                   Navigator.of(context).pushNamed(RentalForm.routeName);
        //                 })),
        //         Container(
        //             margin:
        //                 const EdgeInsets.symmetric(vertical: kDefaultPadding),
        //             child:
        //                 ButtonDefault(label: 'Create New Room', onTap: () {})),
        //         Container(
        //             margin:
        //                 const EdgeInsets.symmetric(vertical: kDefaultPadding),
        //             child: ButtonDefault(label: 'Edit Room', onTap: () {})),
        //       ],
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                child: Text(
                  'EDIT ROOM ' + roomID,
                  style: TextStyles.h4.copyWith(
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
              Container(
                child: Text(
                  'Room Type',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                height: kDefaultIconSize * 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey
                    )),
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
                        kindRoom,
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
                                  widget.roomModel.price = kindSelected.Price ?? 0;
                                  _price = widget.roomModel.price ?? 0;
                                  widget.roomModel.RoomKindID = kindSelected.RoomKindID ?? '';
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
                    vertical: kItemPadding),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Price',
                            style:
                                TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: Text(_price.toString() + ' VND per night',
                            style: TextStyles.defaultStyle.copyWith(
                              fontStyle: FontStyle.italic,
                              color: ColorPalette.primaryColor
                            ),
                          ),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding * 2),
                  );
                },
              ),
              Container(
                child: Text(
                  'Description',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              Container(
                child: InputDefault(
                  labelText: description,
                  controller: descriptionController,
                  ),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              ),
              Container(
                child: Text(
                  'Images',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.darkBlueText),
                ),
                margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
              ),
              primaryImage != ''
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: kMinPadding * 2),
                    child: ImageHelper.loadFromNetwork(primaryImage,
                      height: 105,
                      fit: BoxFit.fitWidth, 
                    ),
                    // child: Text(image),
                  )
                : Container(),
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
                  color: ColorPalette.primaryColor,
                  label: 'Save',
                  onTap: () {
                    updateRoom(
                      PrimaryImagePath: UploadButton.PrimaryImagePath, 
                      roomKindID: roomKindID, 
                      price: _price, 
                      State: 'Available', 
                      RoomID: roomID,
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    // vertical: kMediumPadding * 1.5,
                    horizontal: kMaxPadding * 3),
                child: ButtonDefault(
                  color: Colors.deepOrange,
                  label: 'Delete',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogOverlay(
                            task: 'Delete',
                            isSuccess: false,
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: SalomonBottomBar(
        //   currentIndex: currentId,
        //   onTap: (id) {
        //     setState(() {
        //       currentId = id;
        //     });
        //   },
        //   items: [
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.house,
        //         size: 20,
        //       ),
        //       title: Text('Home')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.gear,
        //         size: 20,
        //       ),
        //       title: Text('Setting')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.bell,
        //         size: 20,
        //       ),
        //       title: Text('Notification')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.user,
        //         size: 20,
        //       ),
        //       title: Text('Account')
        //     ),
        //   ]
        // ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  void updateRoom({
    required String PrimaryImagePath,
    required String roomKindID,
    required int price,
    required String State,
    required String RoomID
  }) async {
    setState(() {
      isLoading = true;
    });
    PrimaryImageUrl = '';
    SubImageUrls.clear();

    final docUser = FirebaseFirestore.instance.collection('Rooms').doc(RoomID);
    bool existId = await checkIfDocExists(RoomID);

    if (existId) {
      await UploadImages(
        PrimaryImagePath: UploadButton.PrimaryImagePath, 
        SubImagePaths: UploadButton.SubImagePath);

        print("----------------------" + SubImageUrls.length.toString());
        RoomModel _room = await RoomModel(
            roomID: roomID,
            PrimaryImage: PrimaryImageUrl,
            RoomKindID: roomKindID,
            price: _price,
            State: State,
            SubImages: SubImageUrls,
            Description: descriptionController.text,
            maxCapacity: int.tryParse(maxCapacityController.text),
        );
        final json = _room.toJson();
        await docUser.set(json);
        showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
              task: 'Edit',
            );
        });
        setState(() {
          isLoading = false;
        });
        setState(() {
          // descriptionController.text = '';
          // price = 0;
          // roomKindID = '';
          UploadButton.ResetUploadButton();
        });
    } else {
      showDialog(context: context, builder: (context) {
        return DialogOverlay(
          isSuccess: false,
          task: 'Edit'
        );
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
        FirebaseStorage.instance.ref(roomID).child(name);
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
