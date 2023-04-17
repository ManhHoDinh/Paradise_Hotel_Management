import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';

enum Sex { male, female }

String? gender = 'Male';

class RentalForm extends StatefulWidget {
  static final String routeName = 'rental_form';
  const RentalForm({super.key});
  @override
  State<RentalForm> createState() => _RentalFormState();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: ColorPalette.primaryColor,
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
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('BOOKING',
                          style: TextStyles.h8.copyWith(letterSpacing: 3.05)),
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 36),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Booked room',
                    style: TextStyles.h9.copyWith(
                      color: ColorPalette.primaryColor,
                      fontSize: 16,
                    )),
              ),
              SizedBox(height: 20),
              Container(
                child: Container(
                  child: SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 4),
                          prefixIcon: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 16,
                              color: ColorPalette.greenText,
                            ),
                          ),
                          suffixIcon: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {},
                              child: Image.asset(AssetHelper.iconFilter)),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: ColorPalette.grayText,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P001',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Nguyen Phuoc Thien',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '2 - 3 March',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P002',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Buu Dang',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '1 - 3 April',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P003',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Ho Dinh Manh',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '3 May',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P004',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Pham Thanh Tuong',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '2 - 4 May',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P005',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Vo Cong Binh',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '6 - 10 June',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: ColorPalette.yellowColor),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.room1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                'P006',
                                style: TextStyles.h8.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: ColorPalette.darkBlueText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2, right: 8),
                              child: Row(
                                children: [
                                  Image.asset(AssetHelper.iconInRoom),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      'Nguyen Phuoc Thien',
                                      style: TextStyles.h8.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: ColorPalette.yellowColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                width: itemWidth - 45,
                                child: Image.asset(AssetHelper.iconLine),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 2, bottom: 2),
                              child: Text(
                                '10 - 12 June',
                                style: TextStyles.h8.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.darkBlueText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 15)
                          ]),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Container(
                child: Text(
                  'Create New Rental Form',
                  style: TextStyles.h9
                      .copyWith(fontSize: 14, color: ColorPalette.primaryColor),
                ),
              ),
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
                                hintText: 'Type here',
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
                        'Guest Name',
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
                            controller: _GuestNameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                hintText: 'Type here',
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
                        'Sex',
                        style: TextStyles.h8.copyWith(
                            fontSize: 12,
                            color: ColorPalette.darkBlueText,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width / 2 - 60,
                            child: ListTile(
                              title: const Text(
                                'Male',
                                style: TextStyles.defaultStyle,
                              ),
                              leading: Radio<String>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => getColor(states)),
                                value: "Male",
                                groupValue: gender,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 2 - 36,
                            child: ListTile(
                              title: const Text(
                                'Female',
                                style: TextStyles.defaultStyle,
                              ),
                              leading: Radio<String>(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => getColor(states)),
                                value: "Female",
                                groupValue: gender,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Guest ID',
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
                            controller: _GuestIDController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                hintText: 'Type here',
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
                        'Phone number',
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
                            controller: _PhoneNumberController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                hintText: 'Type here',
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
                        'Note',
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
                            controller: _NoteController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                hintText: 'Type here',
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
                          Map<String, String> inForUser = {
                            'RoomID': '${_RoomIDController.text}',
                            'GuestName': '${_GuestNameController.text}',
                            'GuestID': '${_GuestIDController.text}',
                            'PhoneNumber': '${_PhoneNumberController.text}',
                            'Note': '${_NoteController.text}',
                            'Sex': '${gender}',
                            'DateRegister':
                                '${_soNgay > 1 ? "${_rangeStart} - ${_rangeEnd}" : "${_rangeStart}"}'
                          };

                          // FirebaseFirestore.instance
                          //     .collection('Users')
                          //     .add(inForUser);
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
                          CollectionReference roomCollection =
                              FirebaseFirestore.instance.collection('Rooms');

                          FirebaseFirestore.instance
                              .collection('Rooms')
                              .where("RoomID",
                                  isEqualTo: "${_RoomIDController.text}")
                              .get()
                              .then((value) {
                            DocumentReference document =
                                roomCollection.doc(value.docs[0].id);
                            //  document.update({"State": "Booked"});

                            print(value.docs[0]["name"]);
                          });
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
