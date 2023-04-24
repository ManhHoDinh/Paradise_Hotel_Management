import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../core/models/guest_kind_model.dart';

enum Sex { male, female }

String? gender = 'Male';

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
  final typeGuest = ['Domestic', 'Foreign'];
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
  int _gia = 150000;
  int _soNgay = 0;
  int currentId = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<String> list = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  Sex? _GT = Sex.male;
  late TextEditingController _RoomIDController;
  late TextEditingController _GuestNameController;
  late TextEditingController _GuestIDController;
  late TextEditingController _PhoneNumberController;
  late TextEditingController _NoteController;
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
  @override
  void initState() {
    super.initState();
    _RoomIDController = TextEditingController();
    _GuestNameController = TextEditingController();
    _GuestIDController = TextEditingController();
    _PhoneNumberController = TextEditingController();
    _NoteController = TextEditingController();
  }

  String? kindRoom;

  int _countGuest = 1;
  String? dropdownKindValue;
  void addGuest() {
    //
    // DropDown._singleton.resetValue();
    // setState(() {
    TextEditingController _nameGuestController = TextEditingController();
    TextEditingController _cardIdGuestController = TextEditingController();
    TextEditingController _addressGuestController = TextEditingController();
    DropDown dropDown = new DropDown();
    listRow.add(TableRow(children: [
      Container(alignment: Alignment.center, child: Text('$_countGuest')),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: dropDown,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
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
            if (value!.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
              return "Id is invalid!";
            } else
              return null;
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
            if (value!.isEmpty ||
                !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
              return "Address is invalid!";
            } else
              return null;
          },
          controller: _addressGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
    ]));
    // }
    // );

    _countGuest++;
    setState(() {});
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
          'Id card',
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
      )
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: kMaxPadding * 2.5,
          elevation: 5,
          //
          backgroundColor: ColorPalette.primaryColor.withOpacity(0.75),
          leading: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {
              setState(() {
                isPressed = param;
              });
            },
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
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('BOOKING', style: TextStyles.h8),
                    )),
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Image.asset(AssetHelper.iconMenu),
                ))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          //       padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                StreamBuilder(
                    stream: FireBaseDataBase.readGuestKinds(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        GuestKindModel.kindItems.clear();

                        GuestKindModel.AllGuestKinds = snapshot.data!;
                        for (GuestKindModel k in GuestKindModel.AllGuestKinds) {
                          GuestKindModel.kindItems.add(k.Name ?? '');
                        }
                      }
                      return Container();
                    }),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'All guest',
                          style: TextStyles.h8.copyWith(
                              fontSize: 12,
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
                            },
                            children: listRow),
                      ),
                      InkWell(
                        onTap: () {
                          int? maxCapacity;
                          maxCapacity = widget.room!.maxCapacity;
                          if (_countGuest <= maxCapacity!) {
                            addGuest();
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return AlertDialog(
                                      title: Column(
                                    children: [
                                      Image.asset(AssetHelper.icoCanceled),
                                      Text(
                                        'Exceed the maximum capacity!',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.defaultStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ColorPalette.primaryColor),
                                      )
                                    ],
                                  ));
                                });
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
                                      color: ColorPalette.grayText, width: 1),
                                  right: BorderSide(
                                      color: ColorPalette.grayText, width: 1),
                                  top: BorderSide(
                                      color: ColorPalette.grayText, width: 1),
                                  bottom: BorderSide(
                                      color: ColorPalette.grayText, width: 1)),
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
                              fontSize: 12,
                              color: ColorPalette.darkBlueText,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  ColorPalette.calendarGround.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(8)),
                          child: TableCalendar(
                            focusedDay: _focusedDay,
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
                              selectedTextStyle: TextStyle(color: Colors.white),
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
                              rangeHighlightColor: ColorPalette.primaryColor,
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
                          'Total Price',
                          style: TextStyles.h8.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: ColorPalette.darkBlueText),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${_soNgay * _gia}',
                                      style: TextStyles.h8.copyWith(
                                          color: ColorPalette.greenText,
                                          fontSize: 12,
                                          letterSpacing: 1.5),
                                    ),
                                    Text(
                                      ' VND',
                                      style: TextStyles.h8.copyWith(
                                          color: ColorPalette.greenText,
                                          fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '$_gia',
                                      style: TextStyles.h8.copyWith(
                                          color: Color(0xff9B9B9B),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.5),
                                    ),
                                    Text(
                                      ' VND per night',
                                      style: TextStyles.h8.copyWith(
                                          color: Color(0xff9B9B9B),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: ColorPalette.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.black38,
                          onTap: () {
                            Map<String, dynamic> formRental = {
                              'Name': 'Binh',
                              'Price': '10000',
                              'RoomKindId': "4",
                            };

                            FirebaseFirestore.instance
                                .collection("RoomKind")
                                .add(formRental);
                            if (formKey.currentState!.validate() &&
                                _selectedDay != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        title: Column(
                                          children: [
                                            Image.asset(AssetHelper.checked),
                                            Text(
                                              'Create successful!',
                                              style: TextStyles.defaultStyle
                                                  .copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                            )
                                          ],
                                        ));
                                  });

                              addNewGuest();
                              addRentalForm();
                              changeStateRoom();
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
                                        'Id card',
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
                                ;
                                _RoomIDController.text = "";
                                _countGuest = 1;
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        title: Column(
                                          children: [
                                            Image.asset(
                                                AssetHelper.icoCanceled),
                                            Text(
                                              'Create Failure!',
                                              style: TextStyles.defaultStyle
                                                  .copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                            )
                                          ],
                                        ));
                                  });
                              if (_selectedDay == null) {
                                setState(() {
                                  isErrorDate = true;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: size.width / 3,
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              'Create',
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
        ),
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: currentId,
            onTap: (id) {
              setState(() {
                currentId = id;
              });
            },
            items: [
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.house,
                    size: 20,
                  ),
                  title: Text('Home')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.gear,
                    size: 20,
                  ),
                  title: Text('Setting')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    size: 20,
                  ),
                  title: Text('Notification')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.user,
                    size: 20,
                  ),
                  title: Text('Account')),
            ]),
      ),
    );
  }

  void changeStateRoom() {
    CollectionReference roomCollection =
        FirebaseFirestore.instance.collection('Rooms');
    FirebaseFirestore.instance
        .collection('Rooms')
        .where("roomID", isEqualTo: '${widget.room!.roomID}')
        .get()
        .then((value) {
      DocumentReference document = roomCollection.doc(value.docs[0].id);
      document.update({"State": "Booked"});
    });
  }

  void addRentalForm() {
    Map<String, dynamic> formRental = {
      'RoomID': '${_RoomIDController.text}',
      'BeginDate': '${_selectedDay}',
      'GuestIDs': list,
    };
    FirebaseFirestore.instance.collection('RentalForm').add(formRental);
  }

  void addNewGuest() {
    for (int i = 1; i < _countGuest; i++) {
      Padding padding1 = (listRow[i].children![2]) as Padding;
      Padding padding2 = (listRow[i].children![3]) as Padding;
      Padding padding3 = (listRow[i].children![1]) as Padding;
      Padding padding4 = (listRow[i].children![4]) as Padding;
      TextFormField nameGuest = padding1.child as TextFormField;
      TextFormField cartIdGuest = padding2.child as TextFormField;
      TextFormField addressGuest = padding4.child as TextFormField;
      DropDown typeGuest = padding3.child as DropDown;

      Map<String, String> inForUser = {
        'GuestKindID': '${typeGuest.selectedValue()}',
        'RoomID': '${widget.room!.roomID}',
        'Name': '${nameGuest.controller!.text}',
        'CMND': '${cartIdGuest.controller!.text}',
        'Address': '${addressGuest.controller!.text}'
      };
      FirebaseFirestore.instance.collection('Guests').add(inForUser);
      list.add(cartIdGuest.controller!.text);
    }
  }
}
