import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:paradise/presentations/screens/Rooms/EditRoom_screen.dart';

import '../../../core/helpers/assets_helper.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/dialog.dart';
import '../../widgets/question_yes_no_dialog.dart';

class DetailRoom extends StatefulWidget {
  DetailRoom({super.key, required this.room});
  static final String routeName = 'detail_screen';
  RoomModel room;

  @override
  State<DetailRoom> createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoom> {
  bool isPressed = false;
  PageController _pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    int _currenImage = 0;
    Size size = MediaQuery.of(context).size;
    RoomModel roomModel = widget.room;
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: FireBaseDataBase.readRooms(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    RoomModel.AllRooms = snapshot.data!;
                    try {
                      roomModel = RoomModel.AllRooms.where(
                              (element) => element.roomID == roomModel.roomID)
                          .first;
                    } catch (e) {}
                  }
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              reverse: true,
                              onPageChanged: (value) {
                                setState(() {
                                  _currenImage = value;
                                });
                              },
                              itemCount: (roomModel.SubImages.length + 1),
                              itemBuilder: (context, index) {
                                _currenImage = index;
                                return Container(
                                  height: 250,
                                  alignment: Alignment.bottomCenter,
                                  child: (index == 0)
                                      ? ImageHelper.loadFromNetwork(
                                          roomModel.PrimaryImage ??
                                              AssetHelper.roomDetail1,
                                          fit: BoxFit.fill,
                                          height: 250,
                                          width: size.width,
                                        )
                                      : Image.network(
                                          roomModel.SubImages[index - 1],
                                          fit: BoxFit.fill,
                                          height: 250,
                                          width: size.width,
                                        ),
                                );
                              },
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 90,
                                  padding: EdgeInsets.only(
                                      left: 42, right: 42, top: 50),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          color: isPressed
                                              ? ColorPalette.primaryColor
                                              : ColorPalette.backgroundColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(roomModel.roomID ?? '',
                                              style: TextStyles.h9.copyWith(
                                                letterSpacing: 3.05,
                                                color: ColorPalette
                                                    .backgroundColor,
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          width: 21 *
                                              (roomModel.SubImages.length + 1),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                (roomModel.SubImages.length +
                                                    1),
                                            itemBuilder: (context, index) {
                                              return imageIndicator(
                                                  index == _currenImage);
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: size.width,
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            width: 55,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10)),
                                              color: roomModel.State == 'Booked'
                                                  ? Colors.orangeAccent
                                                      .withOpacity(0.8)
                                                  : Colors.greenAccent
                                                      .withOpacity(0.8),
                                            ),
                                            child: Text(
                                              roomModel.State ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyles.calendarNote
                                                  .copyWith(
                                                fontSize: 10,
                                                color: ColorPalette
                                                    .backgroundColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff12276).withOpacity(0.05),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Row(
                                children: [
                                  Text(
                                    '${roomModel.roomID} - ${RoomKindModel.getRoomKindName(roomModel.RoomKindID ?? '')}',
                                    style: TextStyles.labelStaffDetail.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xff12276).withOpacity(0.05),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(AssetHelper.iconMoney),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${RoomKindModel.getRoomKindPrice(roomModel.RoomKindID ?? '')}VND',
                                              style: TextStyles.inforRoomDetail,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'PER NIGHT',
                                              style: TextStyles.inforRoomDetail
                                                  .copyWith(
                                                color: ColorPalette.rankText,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(AssetHelper.iconCircleUser),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${roomModel.maxCapacity} PEOPLE',
                                              style: TextStyles.inforRoomDetail,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'MAX CAPACITY',
                                              style: TextStyles.inforRoomDetail
                                                  .copyWith(
                                                color: ColorPalette.rankText,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  'PHOTOS',
                                  style: TextStyles.inforRoomDetail.copyWith(
                                    color: ColorPalette.rankText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: (size.width - 125) / 3,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        child: (roomModel.SubImages.length > 0)
                                            ? Image.network(
                                                roomModel.SubImages.first)
                                            : Image.asset(
                                                AssetHelper.nullImage)),
                                  ),
                                  Container(
                                    width: (size.width - 125) / 3,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: (roomModel.SubImages.length > 1)
                                          ? Image.network(
                                              roomModel.SubImages.last)
                                          : Image.asset(AssetHelper.nullImage),
                                    ),
                                  ),
                                  Container(
                                    width: (size.width - 125) / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: (roomModel.SubImages.length > 2)
                                          ? Image.network(
                                              roomModel.SubImages.elementAt(
                                                  (roomModel.SubImages.length /
                                                          2)
                                                      .toInt()))
                                          : Image.asset(AssetHelper.nullImage),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width - 80,
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(16),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xff12276).withOpacity(0.05),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyles.h9.copyWith(
                                      color: ColorPalette.darkBlueText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    '${roomModel.Description}',
                                    style: TextStyles.descriptionRoom,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width - 80,
                              padding: EdgeInsets.only(
                                  top: 16, left: 30, right: 30, bottom: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xffE6F6F4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                          Text(
                                            'P',
                                            style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Parking',
                                        style: TextStyles.iconInDetailRoom
                                            .copyWith(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xffE6F6F4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.wifi,
                                            size: 19,
                                            color: ColorPalette.primaryColor,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Wi-fi',
                                        style: TextStyles.iconInDetailRoom
                                            .copyWith(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xffE6F6F4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.cutlery,
                                            size: 20,
                                            color: ColorPalette.primaryColor,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Resto',
                                        style: TextStyles.iconInDetailRoom
                                            .copyWith(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Color(0xffE6F6F4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.restroom,
                                            size: 20,
                                            color: ColorPalette.primaryColor,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'WC',
                                        style: TextStyles.iconInDetailRoom
                                            .copyWith(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ButtonWidget(
                                  label: 'Book',
                                  color: ColorPalette.primaryColor,
                                  onTap: () async {
                                    if (roomModel.State == 'Available') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  RentalForm(room: roomModel)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogOverlay(
                                              isSuccess: false,
                                              task:
                                                  'Book room ${roomModel.roomID}',
                                              error:
                                                  'Room ${roomModel.RoomKindID} is booked!!!',
                                            );
                                          });
                                    }
                                  },
                                  textColor: ColorPalette.backgroundColor,
                                ),
                              ),
                            ),
                            AuthServices.CurrentUserIsManager()
                                ? Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: ButtonWidget(
                                        label: 'Edit',
                                        color: ColorPalette.primaryColor,
                                        onTap: () {
                                          if (roomModel.State == 'Available')
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditRoomScreen(
                                                            room: roomModel)));
                                          else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogOverlay(
                                                    isSuccess: false,
                                                    task: 'Edit Room',
                                                    error:
                                                        'Room ${roomModel.roomID} have booked!',
                                                  );
                                                });
                                          }
                                        },
                                        textColor: ColorPalette.backgroundColor,
                                      ),
                                    ),
                                  )
                                : Container(),
                            AuthServices.CurrentUserIsManager()
                                ? Expanded(
                                    child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: ButtonWidget(
                                      label: 'Delete',
                                      color: Colors.redAccent,
                                      onTap: () {
                                        DeleteRoom(roomModel);
                                      },
                                      textColor: ColorPalette.backgroundColor,
                                    ),
                                  ))
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  );
                })),
      ),
    );
  }

  Widget imageIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.center,
      child: Icon(
        FontAwesomeIcons.solidCircle,
        size: 9,
        color: isActive ? Color(0xffE5E5E5) : ColorPalette.detailBorder,
      ),
    );
  }

  void DeleteRoom(RoomModel roomModel) async {
    try {
      showDialog(
          context: context,
          builder: (_context) {
            return QuestionYesNoDialog(
              task: 'Delete Room Kind',
              icon: FontAwesomeIcons.solidTrashCan,
              yesOnTap: () async {
                if (roomModel.State != 'Available') {
                  Navigator.pop(_context);
                  showDialog(
                      context: _context,
                      builder: (context) {
                        return DialogOverlay(
                          isSuccess: false,
                          task: 'Delete Room ${widget.room.RoomKindID}',
                          error: 'Room ${widget.room.RoomKindID} is booked!!!',
                        );
                      });
                } else {
                  await FirebaseStorage.instance
                      .ref(roomModel.roomID)
                      .listAll()
                      .then((value) {
                    value.items.forEach((element) {
                      FirebaseStorage.instance.ref(element.fullPath).delete();
                    });
                  });
                  await FirebaseFirestore.instance
                      .collection('Rooms')
                      .doc(roomModel.roomID)
                      .delete();

                  Navigator.pop(_context);
                  showDialog(
                      context: _context,
                      builder: (context) {
                        return DialogOverlay(
                          isSuccess: true,
                          task: 'Delete Room ${widget.room.RoomKindID}',
                        );
                      }).whenComplete(() => Navigator.of(context).pop());
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
              task: 'Delete Room',
              error: e.toString(),
            );
          });
    }
  }
}
