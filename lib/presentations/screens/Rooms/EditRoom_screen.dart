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
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/Rooms/CreateRoom_screen.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/counter.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';

import '../../widgets/inputTitleWidget.dart';

class EditRoomScreen extends StatefulWidget {
  static String routeName = 'edit_room';
  late RoomModel room;
  EditRoomScreen({
    super.key,
    required this.room,
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
  late List<String> _images = [];
  bool isLoading = false, isUploaded = false;
  String PrimaryImageUrl = '';
  List<String> SubImageUrls = [];
  late RoomModel _room;
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController maxCapacityController = new TextEditingController();
  TextEditingController SurchargeRatioController = new TextEditingController();
  String? dropdownKindValue;
  List<String> BeforeSubImageUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _room = widget.room;
    UploadButton.ResetUploadButton();
    _images.clear();
    SubImageUrls.addAll(widget.room.SubImages);
    BeforeSubImageUrls.addAll(widget.room.SubImages);
    CounterView.maxCap = widget.room.maxCapacity ?? 0;
    CounterView.numberOfGuestNoSurcharge =
        widget.room.NumberGuestBeginSubCharge ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    roomID = widget.room.roomID ?? '';
    roomKindID = widget.room.RoomKindID ?? '';
    kindRoom = RoomKindModel.getRoomKindName(widget.room.RoomKindID!);
    _price = RoomKindModel.getRoomKindPrice(widget.room.RoomKindID ?? '');
    PrimaryImageUrl = widget.room.PrimaryImage ?? '';
    descriptionController.text = widget.room.Description ?? '';
    SurchargeRatioController.text = widget.room.SubChargeRatio.toString();
    _images.add(PrimaryImageUrl);
    for (int i = 0; i < SubImageUrls.length; i++) {
      _images.add(SubImageUrls[i]);
    }

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
                print(_room.maxCapacity);
                Navigator.pop(context, _room);
              },
              child: Container(
                child: Icon(FontAwesomeIcons.arrowLeft),
              ),
            ),
          ),
          title: Container(
            child: Text(
              'Edit Room',
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
          centerTitle: true,
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
                        'EDIT ROOM ' + roomID,
                        style: TextStyles.h4.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: Text(
                        'Room Kind',
                        style: TextStyles.h6.copyWith(
                            color: ColorPalette.darkBlueText,
                            fontWeight: FontWeight.w500),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      height: kDefaultIconSize * 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey)),
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
                                        widget.room.RoomKindID =
                                            kindSelected.RoomKindID ?? '';
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
                                  style: TextStyles.h6.copyWith(
                                      color: ColorPalette.darkBlueText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  _price.toString() + ' VND per night',
                                  style: TextStyles.defaultStyle.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: ColorPalette.primaryColor),
                                ),
                              )
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: kMaxPadding * 1.5,
                              vertical: kItemPadding * 2),
                        );
                      },
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
                        initNumber: CounterView.maxCap,
                        minNumber: 1,
                        type: 0,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding * 2),
                    ),
                    Container(
                      child: Text(
                        'Number Guest Begin Surcharge',
                        style: TextStyles.h6.copyWith(
                            color: ColorPalette.darkBlueText,
                            fontWeight: FontWeight.w500),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      child: CounterView(
                        initNumber: CounterView.numberOfGuestNoSurcharge,
                        minNumber: 1,
                        type: 1,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding * 2),
                    ),
                    InputTitleWidget(
                      Title: 'Surcharge Ratio',
                      controller: SurchargeRatioController,
                      hintInput: 'Type here',
                    ),
                    Container(
                      child: Text(
                        'Description',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
                    ),
                    Container(
                      child: InputDefault(
                        labelText: descriptionController.text,
                        controller: descriptionController,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMaxPadding * 1.5,
                          vertical: kItemPadding),
                    ),
                    Container(
                      child: Text(
                        'Old Images',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(
                          left: kMaxPadding * 1.5,
                          top: kItemPadding,
                          bottom: kItemPadding),
                    ),
                    showImages(),
                    Container(
                      child: Text(
                        'New Images',
                        style: TextStyles.h6
                            .copyWith(color: ColorPalette.darkBlueText),
                      ),
                      margin: const EdgeInsets.only(
                          left: kMaxPadding * 1.5, top: kItemPadding),
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
                      margin: const EdgeInsets.only(
                          top: kMediumPadding * 1.5,
                          left: kMaxPadding * 3,
                          right: kMaxPadding * 3,
                          bottom: kMaxPadding),
                      child: ButtonDefault(
                        backgroundColor: ColorPalette.primaryColor,
                        label: 'Save',
                        onTap: () {
                          updateRoom(
                              description: descriptionController.text,
                              PrimaryImagePath: UploadButton.PrimaryImagePath,
                              SubImagePaths: UploadButton.SubImagePath,
                              roomKindID: roomKindID,
                              maxCapacity: CounterView.maxCap,
                              price: _price,
                              State: 'Available',
                              RoomID: roomID,
                              NumberGuestNoSubCharge:
                                  CounterView.numberOfGuestNoSurcharge,
                              SubChargeRatio: SurchargeRatioController.text);
                        },
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(
                    //       vertical: kMediumPadding * 1.5,
                    //       horizontal: kMaxPadding * 3),
                    //   child: ButtonDefault(
                    //     backgroundColor: Colors.deepOrange,
                    //     label: 'Delete',
                    //     onTap: () {
                    //       if (widget.room.State == 'Available') {
                    //         DeleteRoom(widget.room.roomID ?? '');
                    //       }
                    //     },
                    //   ),
                    // ),
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

  Widget showImages() {
    return Container(
      height: 120,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: kMinPadding * 2),
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: ImageHelper.loadFromNetwork(
              _images[index],
              height: 120,
              fit: BoxFit.scaleDown,
              scale: 0.6,
            ),
          );
        },
        itemCount: _images.length,
      ),
    );
  }

  void updateRoom(
      {required String PrimaryImagePath,
      required List<String> SubImagePaths,
      required String roomKindID,
      required int maxCapacity,
      required int price,
      required String State,
      required String RoomID,
      required String description,
      required int NumberGuestNoSubCharge,
      required String SubChargeRatio}) async {
    setState(() {
      isLoading = true;
    });
    PrimaryImageUrl = '';
    SubImageUrls.clear();
    final docUser = FirebaseFirestore.instance.collection('Rooms').doc(RoomID);
    bool existId = await checkIfDocExists(RoomID);

    if (existId) {
      if (double.tryParse(SubChargeRatio) == null) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Update Room',
                error: 'Surcharge Ratio Error',
              );
            });
      } else {
        if (UploadButton.SubImagePath.isEmpty) {
          PrimaryImageUrl = widget.room.PrimaryImage ?? '';
          SubImageUrls.clear();
          SubImageUrls.addAll(BeforeSubImageUrls);
        } else {
          await UploadImages(
              PrimaryImagePath: UploadButton.PrimaryImagePath,
              SubImagePaths: UploadButton.SubImagePath);
        }

        _room = await RoomModel(
            roomID: roomID,
            PrimaryImage: PrimaryImageUrl,
            SubImages: SubImageUrls,
            RoomKindID: roomKindID,
            State: State,
            Description: description,
            maxCapacity: maxCapacity,
            SubChargeRatio: double.parse(SubChargeRatio),
            NumberGuestBeginSubCharge: NumberGuestNoSubCharge);
        final json = _room.toJson();
        BeforeSubImageUrls.clear();
        BeforeSubImageUrls.addAll(_room.SubImages);
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
          _images.clear();
          UploadButton.ResetUploadButton();
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(isSuccess: false, task: 'Edit');
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
    Reference ref = FirebaseStorage.instance.ref(roomID).child(name);
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
