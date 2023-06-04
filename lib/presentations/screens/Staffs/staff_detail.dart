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
                      child: Text('DETAIL',
                          style: TextStyles.h9.copyWith(
                            letterSpacing: 2,
                            color: ColorPalette.backgroundColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          )),
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
                            widget.userModel.name!,
                            style: TextStyles.h8.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.userModel.position!,
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
                              widget.userModel.identification!,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              widget.userModel.email!,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              widget.userModel.phoneNumber!,
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
                    color: ColorPalette.primaryColor,
                    size: 20,
                  ),
                  title: Text('Home')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.gear,
                    color: ColorPalette.primaryColor,
                    size: 20,
                  ),
                  title: Text('Setting')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    color: ColorPalette.primaryColor,
                    size: 20,
                  ),
                  title: Text('Notification')),
              SalomonBottomBarItem(
                  icon: Icon(
                    FontAwesomeIcons.user,
                    color: ColorPalette.primaryColor,
                    size: 20,
                  ),
                  title: Text('Account')),
            ]),
      ),
    );
  }
}
