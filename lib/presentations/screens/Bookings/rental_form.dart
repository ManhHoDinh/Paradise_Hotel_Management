import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../widgets/dialog.dart';

enum Sex { male, female }

String? gender = 'Male';

// ignore: must_be_immutable
class RentalForm extends StatefulWidget {
  static final String routeName = 'rental_form';
  RoomModel? room;
  RentalForm({super.key, this.room});
  @override
  State<RentalForm> createState() => _RentalFormState();
}

class DropDown extends StatefulWidget {
  //static final DropDown _singleton = DropDown._internal();
  String? dropdownKindValue;
  // factory DropDown() {
  //   return _singleton;
  // }

  String selectedValue() {
    return dropdownKindValue!;
  }

  DropDown({super.key});
  //DropDown._internal();
  // const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> kindGuestItems = [];
  @override
  Widget build(BuildContext context) {
    kindGuestItems = [];
    kindGuestItems.addAll(GuestKindModel.kindItems);
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        validator: (value) => value == null ? 'field required' : null,
        isExpanded: true,
        decoration: InputDecoration(border: InputBorder.none),

        alignment: Alignment.centerLeft,
        icon: Transform.translate(
            offset: Offset(-10, -4),
            child: Icon(
              FontAwesomeIcons.sortDown,
              size: 16,
            )),
        // iconStyleData:
        //     IconStyleData(iconEnabledColor: ColorPalette.primaryColor),
        // dropdownStyleData: DropdownStyleData(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(kMinPadding))),

        hint: Text(
          'Choose here',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.grayText.copyWith(fontSize: 12).italic,
        ),

        items: kindGuestItems
            .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: TextStyles.defaultStyle,
                )))
            .toList(),
        // buttonStyleData: const ButtonStyleData(
        //   padding: const EdgeInsets.only(left: 12),
        // ),
        // menuItemStyleData: const MenuItemStyleData(),
        value: widget.dropdownKindValue,

        onChanged: (value) {
          setState(() {
            widget.dropdownKindValue = value;
          });
        },
      ),
    );
  }
}

class _RentalFormState extends State<RentalForm> {
  bool isPressed = false;
  int currentId = 0;
  DateTime? _selectedDay;
  List<String> list = [];

  bool isErrorGuest = false;
  bool isErrorDate = false;

  final formKey = GlobalKey<FormState>();
  List<String> listKind = [];
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color(0xffD9D9D9);
    }
    return Color(0xffD9D9D9);
  }

  final typeGuest = ['Domestic', 'Foreign'];
  DateTimeRange soNgayDuocChon = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  String roomIDSelected = '';
  List<String> AvailableRoomID = [];
  RoomModel? room;

  @override
  void initState() {
    super.initState();

    roomIDSelected = widget.room?.roomID ?? '';
    room = widget.room;
    initAvailableRoomID();
  }

  void initAvailableRoomID() {
    if (roomIDSelected == '')
      for (RoomModel r in RoomModel.AllRooms) {
        if (r.State == 'Available') AvailableRoomID.add(r.roomID ?? '');
      }
    else
      AvailableRoomID.add(roomIDSelected);
  }

  String? dropdownKindValue;
  void addGuest() {
    //
    // DropDown._singleton.resetValue();
    // setState(() {
    TextEditingController _nameGuestController = TextEditingController();
    TextEditingController _cardIdGuestController = TextEditingController();
    TextEditingController _addressGuestController = TextEditingController();
    DropDown dropDown = new DropDown();
    int currentIndex = listRow.length;

    listRow.add(TableRow(children: [
      Container(),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: dropDown,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Name is invalid!";
            } else
              return null;
          },
          controller: _nameGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (!RegExp(r'^[0-9]').hasMatch(value!) ||
                checkGuestID(value) >= 2) {
              return "Id is invalid!";
            } else {
              return null;
            }
          },
          controller: _cardIdGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Address is invalid!";
            }
          },
          controller: _addressGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Container(
        child: GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            UpdateDeleteRow(currentIndex);
          },
        ),
      )
    ]));
    // }
    // );
    for (int i = 1; i < listRow.length; i++) {
      setState(() {
        currentIndex = i;
      });
      listRow[i].children![0] = Container(
        alignment: Alignment.center,
        child: Text('${currentIndex}'),
      );
    }
  }

  List<TableRow> listRow = [
    TableRow(children: [
      Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'No',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Type',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Name',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'ID card',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Address',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container()
    ]),
  ];
  void UpdateDeleteRow(int index) {
    setState(() {
      print(index);
      listRow.removeAt(index);
      for (int i = 1; i < listRow.length; i++) {
        listRow[i].children![0] = Container(
          alignment: Alignment.center,
          child: Text('${i}'),
        );
        listRow[i].children![5] = GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            UpdateDeleteRow(i);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: kMaxPadding * 1.5,
          backgroundColor: ColorPalette.primaryColor.withOpacity(0.75),
          leading: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: isPressed
                    ? ColorPalette.primaryColor
                    : ColorPalette.backgroundColor,
              ),
            ),
          ),
          title: Container(
            child: Text('BOOKING', style: TextStyles.h8),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          //       padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              StreamBuilder(
                  stream: FireBaseDataBase.readGuestKinds(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GuestKindModel.AllGuestKinds = snapshot.data!;
                    }
                    return Container();
                  }),
              StreamBuilder(
                  stream: FireBaseDataBase.readGuests(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GuestModel.AllGuests = snapshot.data!;
                    }
                    return Container();
                  }),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Room ID',
                              style: TextStyles.h8.copyWith(
                                  fontSize: 12,
                                  color: ColorPalette.darkBlueText,
                                  fontWeight: FontWeight.w500),
                            ),
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
                                      iconEnabledColor:
                                          ColorPalette.primaryColor),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMinPadding))),
                                  hint: Text(
                                    roomIDSelected,
                                    style: TextStyles.defaultStyle.grayText,
                                  ),
                                  items: AvailableRoomID.map(
                                      (e) => DropdownMenuItem<String>(
                                          value: e,
                                          onTap: () {
                                            setState(() {
                                              roomIDSelected = e;
                                              room = RoomModel.AllRooms.where(
                                                  (element) =>
                                                      element.roomID ==
                                                      roomIDSelected).first;
                                            });
                                          },
                                          child: Text(
                                            e,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles
                                                .defaultStyle.grayText,
                                          ))).toList(),
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
                                horizontal: kMaxPadding,
                                vertical: kItemPadding),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'All guest',
                              style: TextStyles.h8.copyWith(
                                  fontSize: 14,
                                  color: ColorPalette.darkBlueText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(
                                    color: ColorPalette.grayText,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4))),
                                columnWidths: {
                                  0: FixedColumnWidth(40),
                                  1: FixedColumnWidth(100),
                                  2: FixedColumnWidth(140),
                                  3: FixedColumnWidth(120),
                                  4: FixedColumnWidth(160),
                                  5: FixedColumnWidth(50)
                                },
                                children: listRow),
                          ),
                          InkWell(
                            onTap: () {
                              int? maxCapacity;
                              if (room == null) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogOverlay(
                                        isSuccess: false,
                                        task: 'Add Guests',
                                        error: 'Chose Room ID, Please!',
                                      );
                                    });
                              } else {
                                maxCapacity = room!.maxCapacity;

                                if (listRow.length <= (maxCapacity ?? 0)) {
                                  addGuest();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogOverlay(
                                          isSuccess: false,
                                          task: 'Add Guests',
                                          error: 'Exceed the maximum capacity!',
                                        );
                                      });
                                }
                              }
                              //     .get()
                              //     .then((value) {
                              //   maxCapacity =
                              //       int.parse(value.docs[0]['maxCapacity']);

                              // });
                            },
                            child: Container(
                              height: kMediumPadding * 1.5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: ColorPalette.grayText,
                                          width: 1),
                                      right: BorderSide(
                                          color: ColorPalette.grayText,
                                          width: 1),
                                      top: BorderSide(
                                          color: ColorPalette.grayText,
                                          width: 1),
                                      bottom: BorderSide(
                                          color: ColorPalette.grayText,
                                          width: 1)),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4))),
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Dates',
                              style: TextStyles.h8.copyWith(
                                  fontSize: 14,
                                  color: ColorPalette.darkBlueText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorPalette.calendarGround
                                      .withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(8)),
                              child: TableCalendar(
                                focusedDay: _selectedDay ?? DateTime.now(),
                                firstDay: DateTime(2010),
                                lastDay: DateTime(2030),
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                headerStyle: HeaderStyle(
                                  titleCentered: true,
                                  formatButtonVisible: false,
                                ),
                                calendarStyle: CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                      color: ColorPalette.primaryColor,
                                      shape: BoxShape.circle),
                                  selectedTextStyle:
                                      TextStyle(color: Colors.white),
                                  withinRangeDecoration: BoxDecoration(
                                    color: ColorPalette.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  // rangeStartDecoration: BoxDecoration(
                                  //     color: ColorPalette.primaryColor,
                                  //     shape: BoxShape.circle),
                                  // rangeEndDecoration: BoxDecoration(
                                  //     color: ColorPalette.primaryColor,
                                  //     shape: BoxShape.circle),
                                  rangeHighlightColor:
                                      ColorPalette.primaryColor,
                                  withinRangeTextStyle:
                                      TextStyle(color: Colors.white),
                                ),
                                selectedDayPredicate: (day) =>
                                    isSameDay(_selectedDay, day),
                                // rangeStartDay: _rangeStart,
                                // rangeEndDay: _rangeEnd,
                                // rangeSelectionMode: _rangeSelectionMode,
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(_selectedDay, selectedDay)) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      // _focusedDay = focusedDay;
                                      // _rangeStart =
                                      //     null; // Important to clean those
                                      // _rangeEnd = null;
                                      // _rangeSelectionMode =
                                      //     RangeSelectionMode.toggledOff;
                                    });
                                  }
                                },
                                // onRangeSelected: (start, end, focusedDay) {
                                //   setState(() {
                                //     _selectedDay = null;
                                //     _focusedDay = focusedDay;
                                //     _rangeStart = start;
                                //     _rangeEnd = end ?? start;
                                //     _rangeSelectionMode =
                                //         RangeSelectionMode.toggledOn;
                                //   });
                                //   soNgayDuocChon = DateTimeRange(
                                //       start: _rangeStart ?? DateTime.now(),
                                //       end: _rangeEnd ?? DateTime.now());
                                //   _soNgay = soNgayDuocChon.duration.inDays + 1;
                                // },
                              ),
                            ),
                          ),
                          Visibility(
                              visible: isErrorDate,
                              child: Text(
                                'Please choose days!',
                                style: TextStyles.defaultStyle
                                    .copyWith(color: Colors.red),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Unit Price per night',
                              style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: ColorPalette.darkBlueText),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${RoomKindModel.getRoomKindPrice(room?.RoomKindID ?? '')} VND',
                              style: TextStyles.h8.copyWith(
                                  color: ColorPalette.greenText,
                                  fontSize: 12,
                                  letterSpacing: 1.5),
                            ),
                          ),
                          Material(
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.black38,
                              onTap: () {
                                bookRoom();
                              },
                              child: Container(
                                width: size.width / 3,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  'Book',
                                  style: TextStyles.h8.copyWith(
                                      color: ColorPalette.backgroundColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeStateRoom() {
    try {
      CollectionReference roomCollection =
          FirebaseFirestore.instance.collection('Rooms');
      FirebaseFirestore.instance
          .collection('Rooms')
          .where("roomID", isEqualTo: '${room!.roomID}')
          .get()
          .then((value) {
        DocumentReference document = roomCollection.doc(value.docs[0].id);
        document.update({"State": "Booked"});
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Book Room ${room!.roomID} Failed',
              error: e.toString(),
            );
          });
    }
  }

  void addRentalForm() {
    try {
      DocumentReference doc =
          FirebaseFirestore.instance.collection('RentalForm').doc();
      RentalFormModel ren = new RentalFormModel(
          RoomID: roomIDSelected,
          BeginDate: _selectedDay ?? DateTime.now(),
          GuestIDs: list,
          RentalID: doc.id,
          Status: 'Unpaid',
          SurchargeRatio: 0,
          NumberGuestBeginSubCharge: 0,
          HighestGuestKindRatioName: '',
          UnitPrice: 0,
          HighestGuestKindSurchargeRatio: 0);
      ren.UpdateInformation();
      doc.set(ren.toJson());
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Book Room ${room!.roomID} Failed',
              error: e.toString(),
            );
          });
    }
  }

  void addNewGuest() {
    try {
      for (int i = 1; i < listRow.length; i++) {
        Padding padding1 = (listRow[i].children[2]) as Padding;
        Padding padding2 = (listRow[i].children[3]) as Padding;
        Padding padding3 = (listRow[i].children[1]) as Padding;
        Padding padding4 = (listRow[i].children[4]) as Padding;
        TextFormField nameGuest = padding1.child as TextFormField;
        TextFormField cartIdGuest = padding2.child as TextFormField;
        TextFormField addressGuest = padding4.child as TextFormField;
        DropDown typeGuest = padding3.child as DropDown;

        GuestModel guest = new GuestModel(
            guestID: cartIdGuest.controller!.text,
            name: nameGuest.controller!.text,
            guestKindID:
                GuestKindModel.getGuestKindID(typeGuest.selectedValue()),
            address: addressGuest.controller!.text);
        final Json = guest.toJson();
        FirebaseFirestore.instance
            .collection(GuestModel.CollectionName)
            .doc(cartIdGuest.controller!.text)
            .set(Json);
        list.add(cartIdGuest.controller!.text);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Book Room ${room!.roomID} Failed',
              error: e.toString(),
            );
          });
    }
  }

  void bookRoom() {
    if (listRow.length == 0) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Book Room ${room!.roomID}',
              error: 'Guests can not Empty!!!',
            );
          });
    } else if (formKey.currentState!.validate() && _selectedDay != null) {
      addNewGuest();
      addRentalForm();
      changeStateRoom();
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
              task: 'Book Room ${room!.roomID}',
            );
          }).whenComplete(() {
        return Navigator.of(context).pop();
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Book Room ${room!.roomID} Failed',
              error: 'Check Information, please!!!',
            );
          });
      if (_selectedDay == null) {
        setState(() {
          isErrorDate = true;
        });
      }
    }
  }

  void ResetView() {
    setState(() {
      listRow = [
        TableRow(children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'No',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Type',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Name',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'ID card',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Address',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ];
    });
  }

  int checkGuestID(String value) {
    int result = 0;
    for (int i = 1; i < listRow.length; i++) {
      Padding padding = (listRow[i].children[3]) as Padding;
      TextFormField cartIdGuest = padding.child as TextFormField;
      if (cartIdGuest.controller!.text == value) result++;
    }
    return result;
  }
}
