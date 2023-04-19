import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:paradise/presentations/screens/AddUser_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

enum Sex { male, female }

String? gender = 'Male';

class RentalForm extends StatefulWidget {
  static final String routeName = 'rental_form';
  const RentalForm({super.key});
  @override
  State<RentalForm> createState() => _RentalFormState();
}

class DropDown extends StatefulWidget {
  static final DropDown _singleton = DropDown._internal();
  String? dropdownKindValue;
  factory DropDown() {
    return _singleton;
  }
  String selectedValue() {
    return dropdownKindValue!;
  }

  void resetValue() {
    dropdownKindValue = null;
  }

  DropDown._internal();
  // const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final typeGuest = ['Domestic', 'Foreign'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
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

        items: typeGuest
            .map((e) => DropdownMenuItem<String>(
                value: e,
                // onTap: () {
                //   setState(() {
                //     kindRoom = e;
                //   });
                // },
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
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  Sex? _GT = Sex.male;
  late TextEditingController _RoomIDController;
  late TextEditingController _GuestNameController;
  late TextEditingController _GuestIDController;
  late TextEditingController _PhoneNumberController;
  late TextEditingController _NoteController;
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
    DropDown._singleton.resetValue();
    // setState(() {
    TextEditingController _nameGuestController = TextEditingController();
    TextEditingController _cardIdGuestController = TextEditingController();

    listRow.add(TableRow(children: [
      Container(alignment: Alignment.center, child: Text('$_countGuest')),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: DropDown(),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          controller: _nameGuestController,
          decoration: InputDecoration(
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          controller: _cardIdGuestController,
          decoration: InputDecoration(
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
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Id card',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;

    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kMaxPadding * 2.5,
          elevation: 5,
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
                      child: Text('RENTAL FORM',
                          style: TextStyles.h8.copyWith(
                              fontSize: 24,
                              letterSpacing: 4,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 3.0,
                                  color: Colors.black12,
                                ),
                              ])),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 42,
                          width: double.infinity,
                          child: TextField(
                            controller: _RoomIDController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                hintText: 'Choose here',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: ColorPalette.grayText,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorPalette.primaryColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(25),
                                )),
                          ),
                        ),
                      ),
                    ),

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
                    Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(
                            color: ColorPalette.grayText,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4))),
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(4),
                          3: FlexColumnWidth(3),
                        },
                        children: listRow),
                    InkWell(
                      onTap: () {
                        addGuest();
                        // RawAutocomplete a =
                        //     (listRow[1].children![1]) as RawAutocomplete;

                        // print(a.textEditingController!.text);
                        // var a = listRow[1].children![1];
                        // DropdownButtonHideUnderline b =
                        //     a as DropdownButtonHideUnderline;
                        // DropdownButtonFormField c =
                        //     b.child as DropdownButtonFormField;
                        // print);
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

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     child: SizedBox(
                    //       height: 42,
                    //       width: double.infinity,
                    //       child: TextField(
                    //         controller: _GuestNameController,
                    //         textAlign: TextAlign.center,
                    //         decoration: InputDecoration(
                    //             contentPadding:
                    //                 EdgeInsets.symmetric(horizontal: 25),
                    //             hintText: 'Type here',
                    //             hintStyle: TextStyle(
                    //               fontSize: 14,
                    //               color: ColorPalette.grayText,
                    //             ),
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //             ),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                   color: ColorPalette.primaryColor,
                    //                   width: 2),
                    //               borderRadius: BorderRadius.circular(25),
                    //             )),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   width: size.width / 2 - 60,
                          //   child: ListTile(
                          //     title: const Text(
                          //       'Male',
                          //       style: TextStyles.defaultStyle,
                          //     ),
                          //     leading: Radio<String>(
                          //       fillColor: MaterialStateColor.resolveWith(
                          //           (states) => getColor(states)),
                          //       value: "Male",
                          //       groupValue: gender,
                          //       onChanged: (String? value) {
                          //         setState(() {
                          //           gender = value;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: size.width / 2 - 36,
                          //   child: ListTile(
                          //     title: const Text(
                          //       'Female',
                          //       style: TextStyles.defaultStyle,
                          //     ),
                          //     leading: Radio<String>(
                          //       fillColor: MaterialStateColor.resolveWith(
                          //           (states) => getColor(states)),
                          //       value: "Female",
                          //       groupValue: gender,
                          //       onChanged: (String? value) {
                          //         setState(() {
                          //           gender = value;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
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
                            rangeStartDecoration: BoxDecoration(
                                color: ColorPalette.primaryColor,
                                shape: BoxShape.circle),
                            rangeEndDecoration: BoxDecoration(
                                color: ColorPalette.primaryColor,
                                shape: BoxShape.circle),
                            rangeHighlightColor: ColorPalette.primaryColor,
                            withinRangeTextStyle:
                                TextStyle(color: Colors.white),
                          ),
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          rangeStartDay: _rangeStart,
                          rangeEndDay: _rangeEnd,
                          rangeSelectionMode: _rangeSelectionMode,
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                _rangeStart = null; // Important to clean those
                                _rangeEnd = null;
                                _rangeSelectionMode =
                                    RangeSelectionMode.toggledOff;
                              });
                            }
                          },
                          onRangeSelected: (start, end, focusedDay) {
                            setState(() {
                              _selectedDay = null;
                              _focusedDay = focusedDay;
                              _rangeStart = start;
                              _rangeEnd = end ?? start;
                              _rangeSelectionMode =
                                  RangeSelectionMode.toggledOn;
                            });
                            soNgayDuocChon = DateTimeRange(
                                start: _rangeStart ?? DateTime.now(),
                                end: _rangeEnd ?? DateTime.now());
                            _soNgay = soNgayDuocChon.duration.inDays + 1;
                          },
                        ),
                      ),
                    ),
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
                          for (int i = 1; i < _countGuest; i++) {
                            TextField nameGuest =
                                (listRow[i].children![2]) as TextField;
                            TextField cartIdGuest =
                                (listRow[i].children![3]) as TextField;
                            DropDown typeGuest =
                                (listRow[i].children![1]) as DropDown;

                            Map<String, String> inForUser = {
                              'Type': '${typeGuest.selectedValue()}',
                              'RoomID': '${_RoomIDController.text}',
                              'GuestName': '${nameGuest.controller!.text}',
                              'GuestID': '${cartIdGuest.controller!.text}',
                              'DateRegister': '${_rangeStart}'
                            };
                            FirebaseFirestore.instance
                                .collection('Guests')
                                .add(inForUser);
                          }
                          // Map<String, String> inForUser = {
                          //   'RoomID': '${_RoomIDController.text}',
                          //   'GuestName': '${_GuestNameController.text}',
                          //   'GuestID': '${_GuestIDController.text}',
                          //   'PhoneNumber': '${_PhoneNumberController.text}',
                          //   'Note': '${_NoteController.text}',
                          //   'Sex': '${gender}',
                          //   'DateRegister':
                          //       '${_soNgay > 1 ? "${_rangeStart} - ${_rangeEnd}" : "${_rangeStart}"}'
                          // };

                          // showDialog(
                          //     //barrierColor: Colors.transparent,
                          //     context: context,
                          //     builder: (context) {
                          //       Future.delayed(Duration(seconds: 2), () {
                          //         Navigator.of(context).pop(true);
                          //       });
                          //       return AlertDialog(
                          //           backgroundColor: Colors.transparent,
                          //           elevation: 0,
                          //           title: Column(
                          //             children: [
                          //               Image.asset(AssetHelper.checked),
                          //               Text(
                          //                 'Create successful!',
                          //                 style: TextStyles.defaultStyle
                          //                     .copyWith(
                          //                         fontSize: 20,
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white),
                          //               )
                          //             ],
                          //           ));
                          //     });
                          // CollectionReference roomCollection =
                          //     FirebaseFirestore.instance.collection('RoomKind');

                          // FirebaseFirestore.instance
                          //     .collection('RoomKind')
                          //     .where("RoomKindID", isEqualTo: "1")
                          //     .get()
                          //     .then((value) {
                          //   DocumentReference document =
                          //       roomCollection.doc(value.docs[0].id);
                          //   //  document.update({"State": "Booked"});

                          //   print(value.docs[0]['Name']);
                          // });
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
}
