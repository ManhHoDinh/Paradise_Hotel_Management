import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';

enum Sex { male, female }

class EditForm extends StatefulWidget {
  static final String routeName = 'edit_form';
  const EditForm({super.key});
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  bool isPressed = false;
  int currentId = 0;
  int _gia = 150000;
  int _soNgay = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  bool isChecked = false;
  Sex? _GT = Sex.male;

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;

    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                alignment: Alignment.center,
                child: Text('Edit Form',
                    style: TextStyles.h9.copyWith(
                      color: ColorPalette.primaryColor,
                      fontSize: 18,
                    )),
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
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon: InkWell(
                                    customBorder: CircleBorder(),
                                    onTap: () {},
                                    child: Icon(FontAwesomeIcons.sortDown)),
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
                              title: const Text('Male'),
                              leading: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => getColor(states)),
                                value: Sex.male,
                                groupValue: _GT,
                                onChanged: (value) {
                                  setState(() {
                                    _GT = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 2 - 36,
                            child: ListTile(
                              title: const Text('Female'),
                              leading: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => getColor(states)),
                                value: Sex.female,
                                groupValue: _GT,
                                onChanged: (value) {
                                  setState(() {
                                    _GT = value;
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
                            _soNgay = 1;
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
                          Text(
                            '${_soNgay * _gia} VND',
                            style: TextStyles.h8.copyWith(
                                color: ColorPalette.greenText, fontSize: 12),
                          ),
                          Text(
                            '$_gia VND per night',
                            style: TextStyles.h8.copyWith(
                                color: Color(0xff9B9B9B),
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width / 3,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorPalette.primaryColor.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Save',
                          style: TextStyles.h8.copyWith(
                              color: ColorPalette.backgroundColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: size.width / 3,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffE45826).withOpacity(0.75),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Delete',
                          style: TextStyles.h8.copyWith(
                              color: ColorPalette.backgroundColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: 70)
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
