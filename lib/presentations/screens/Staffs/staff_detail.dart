import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

import '../../../core/constants/dimension_constants.dart';

class StaffDetail extends StatefulWidget {
  static final String routeName = 'staff_detail';
  final UserModel userModel;
  const StaffDetail({super.key, required this.userModel});

  @override
  State<StaffDetail> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  bool isPressed = false;
  int currentId = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  String _s_id = '001';
  String _name = 'Nguyen Phuoc Thien';
  String _id = '21521462';
  String _rank = 'Manager';
  String _phone = '0917192680';
  String _gmail = '21521462@gm.uit.edu.vn';
  int _basic = 210;
  int _tax = 4;
  int _bonus = 50;
  int _off = 10;
  int _loan = 104;
  int _total = 150;
  int _ngayNghi = 0;
  int _ngayTre = 0;

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );

  @override
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
        _ngayNghi--;
      } else {
        _selectedDays.add(selectedDay);
        _ngayNghi++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KeyboardDismisser(
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
              child: Text('USER DETAIL',
                  style: TextStyles.slo.bold.copyWith(
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(3, 6),
                        blurRadius: 6,
                      )
                    ],
                  ))),
          centerTitle: true,
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 42),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Staff details',
                  style: TextStyles.labelStaffDetail,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: ColorPalette.detailBorder,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel.Name!,
                            style: TextStyles.h8.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.userModel.Position!,
                              style: TextStyles.staffInforDetail.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 36, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Details',
                  style: TextStyles.labelStaffDetail,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorPalette.detailBorder,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 8),
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'CCCD',
                              style: TextStyles.titleInfoDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'Email',
                              style: TextStyles.titleInfoDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'Phone No',
                              style: TextStyles.titleInfoDetail,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 8),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              widget.userModel.identification ?? '',
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              widget.userModel.Email!,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              widget.userModel.PhoneNumber!,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
