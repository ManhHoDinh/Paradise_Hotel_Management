import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class StaffDetail extends StatefulWidget {
  static final String routeName = 'staff_detail';
  const StaffDetail({super.key});
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
                      child: Text('ID $_s_id',
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
                    Container(
                      margin: EdgeInsets.all(8),
                      width: 105,
                      height: 98,
                      child: Image(image: AssetImage(AssetHelper.staff1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name,
                            style: TextStyles.h8.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _rank,
                              style: TextStyles.staffInforDetail.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 12, right: 8),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(AssetHelper.iconEdit),
                      ),
                    ))
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
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'S.ID',
                              style: TextStyles.titleInfoDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'ID',
                              style: TextStyles.titleInfoDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Icon(
                              FontAwesomeIcons.phone,
                              color:
                                  ColorPalette.primaryColor.withOpacity(0.44),
                              size: 13.47,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color:
                                  ColorPalette.primaryColor.withOpacity(0.44),
                              size: 15,
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
                              _s_id,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              _id,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              _phone,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              _gmail,
                              style: TextStyles.staffInforDetail,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 10, right: 8),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(AssetHelper.iconEdit),
                      ),
                    ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (size.width - 72) / 2,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 36, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Earning',
                                style: TextStyles.labelStaffDetail,
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(AssetHelper.iconEdit),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          width: (size.width - 72) / 2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorPalette.detailBorder,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 8),
                                width: 80,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Basic',
                                        style: TextStyles.titleInfoDetail,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Tax',
                                        style: TextStyles.titleInfoDetail,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Bonus',
                                        style: TextStyles.titleInfoDetail,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 20, top: 8),
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$_basic\$',
                                          style: TextStyles.staffInforDetail,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$_tax\$',
                                          style: TextStyles.staffInforDetail,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$_bonus\$',
                                          style: TextStyles.staffInforDetail,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (size.width - 72) / 2,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 36, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Deduction',
                                style: TextStyles.labelStaffDetail,
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(AssetHelper.iconEdit),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          width: (size.width - 72) / 2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorPalette.detailBorder,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 8),
                                width: 80,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Off',
                                        style: TextStyles.titleInfoDetail,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        'Loan',
                                        style: TextStyles.titleInfoDetail,
                                      ),
                                    ),
                                    SizedBox(height: 21),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 20, top: 8),
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$_off\$',
                                          style: TextStyles.staffInforDetail,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '$_loan\$',
                                          style: TextStyles.staffInforDetail,
                                        ),
                                      ),
                                      SizedBox(height: 21),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                alignment: Alignment.center,
                width: size.width - 60,
                height: 22,
                decoration: BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 27),
                      child: Text(
                        'Total',
                        style: TextStyles.labelStaffDetail.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 27),
                      child: Text(
                        '$_total\$',
                        style: TextStyles.labelStaffDetail.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 36, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text('Attendance Log',
                    style: TextStyles.h8.copyWith(
                      color: ColorPalette.primaryColor,
                      fontSize: 16,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                decoration: BoxDecoration(
                    color: ColorPalette.calendarGround.withOpacity(0.04),
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
                    outsideTextStyle: TextStyles.outsideMonth,
                    defaultTextStyle: TextStyles.defaultMonth,
                    weekendTextStyle: TextStyles.defaultMonth,
                    cellMargin: EdgeInsets.all(0),
                    defaultDecoration: BoxDecoration(
                      color: ColorPalette.primaryColor.withOpacity(0.25),
                    ),
                    weekendDecoration: BoxDecoration(
                      color: ColorPalette.primaryColor.withOpacity(0.25),
                    ),
                    selectedDecoration: BoxDecoration(
                        color: ColorPalette.lateDay, shape: BoxShape.rectangle),
                    selectedTextStyle: TextStyles.defaultMonth,
                    rangeStartTextStyle: TextStyles.defaultMonth,
                    rangeEndTextStyle: TextStyles.defaultMonth,
                    todayTextStyle: TextStyles.defaultMonth,
                    todayDecoration: BoxDecoration(
                      color: ColorPalette.primaryColor.withOpacity(0.25),
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return _selectedDays.contains(day);
                  },
                  onDaySelected: _onDaySelected,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidCircle,
                          color: ColorPalette.primaryColor.withOpacity(0.25),
                          size: 12,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Present',
                          style: TextStyles.calendarNote,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidCircle,
                          color: ColorPalette.absentDay.withOpacity(0.3),
                          size: 12,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Absent',
                          style: TextStyles.calendarNote,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidCircle,
                          color: ColorPalette.lateDay,
                          size: 12,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Late',
                          style: TextStyles.calendarNote,
                        ),
                      ],
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
