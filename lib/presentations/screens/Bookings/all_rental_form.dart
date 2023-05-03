import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/presentations/widgets/filter_containter_widget.dart';
import 'package:paradise/presentations/widgets/form_item.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../core/helpers/assets_helper.dart';

class AllRentalForm extends StatefulWidget {
  static final String routeName = 'all_rental_form';
  const AllRentalForm({super.key});

  @override
  State<AllRentalForm> createState() => _AllRentalFormState();
}

class _AllRentalFormState extends State<AllRentalForm> {
  bool isPressed = false;
  int currentId = 0;

  bool isVisibleFilter = false;
  bool idDecrease = false;
  bool dateDecrease = false;
  String? status;
  String? valueSearch;
  String? dropdownStatusValue;
  final statusItems = ['Unpaid', 'Paid'];
  late List<RentalFormModel> listRentalForm;
  DropdownMenuItem<String> buildMenuStatusItem(String item) => DropdownMenuItem(
      value: item,
      onTap: () {
        setState(() {
          status = item;
        });
      },
      child: Text(
        item,
        style: TextStyles.defaultStyle.grayText,
      ));
  List<RentalFormModel> loadListForms(List<RentalFormModel> list) {
    if (idDecrease) {
      list.sort((a, b) => b.RentalID.compareTo(a.RentalID));
    } else {
      list.sort((a, b) => a.RentalID.compareTo(b.RentalID));
    }

    if (dateDecrease) {
      list.sort((a, b) => (b.beginDate).compareTo(a.beginDate));
    } else {
      list.sort((a, b) => (a.beginDate).compareTo(b.beginDate));
    }

    List<RentalFormModel> newList = List.from(list);

    switch (status) {
      case "Paid":
        newList = newList.where((form) => form.Status == status).toList();
        break;
      case "Unpaid":
        newList = newList.where((form) => form.Status == status).toList();
        break;
      default:
        newList = newList;
    }

    if (valueSearch != null) {
      newList = newList
          .where((e) =>
              e.RentalID.toLowerCase().contains(valueSearch!.toLowerCase()))
          .toList();
    }

    return newList;
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
            child: Container(
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: isPressed
                    ? ColorPalette.primaryColor
                    : ColorPalette.backgroundColor,
              ),
            ),
          ),
          title: Align(
            child: Text(
              'RENTAL FORMS',
              style: TextStyles.h8.copyWith(letterSpacing: 3.05),
            ),
            alignment: Alignment.center,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          color: ColorPalette.backgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 36),
              Container(
                child: Container(
                  child: SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          valueSearch = value;
                        });
                      },
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
                              onTap: () {
                                setState(() {
                                  isVisibleFilter = !isVisibleFilter;
                                });
                              },
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
                                  color: ColorPalette.primaryColor, width: 2))),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: isVisibleFilter,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.filter,
                            size: 13.13,
                            color: ColorPalette.greenText,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Filter',
                            style: TextStyles.h9.copyWith(
                                color: ColorPalette.primaryColor, fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(height: 20.64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: FilterContainerWidget(
                              name: 'ID',
                              icon1: Icon(
                                FontAwesomeIcons.arrowDown,
                                size: 13,
                                color: idDecrease
                                    ? ColorPalette.primaryColor
                                    : ColorPalette.blackText,
                              ),
                              icon2: Icon(
                                FontAwesomeIcons.arrowUp,
                                size: 13,
                                color: idDecrease
                                    ? ColorPalette.blackText
                                    : ColorPalette.primaryColor,
                              ),
                              onTapIconDown: () {
                                setState(() {
                                  idDecrease = true;
                                });
                              },
                              onTapIconUp: () {
                                setState(() {
                                  idDecrease = false;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: FilterContainerWidget(
                              name: 'Date',
                              icon1: Icon(
                                FontAwesomeIcons.arrowDown,
                                size: 13,
                                color: idDecrease
                                    ? ColorPalette.primaryColor
                                    : ColorPalette.blackText,
                              ),
                              icon2: Icon(
                                FontAwesomeIcons.arrowUp,
                                size: 13,
                                color: idDecrease
                                    ? ColorPalette.blackText
                                    : ColorPalette.primaryColor,
                              ),
                              onTapIconDown: () {
                                setState(() {
                                  dateDecrease = true;
                                });
                              },
                              onTapIconUp: () {
                                setState(() {
                                  dateDecrease = false;
                                });
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorPalette.grayText),
                                borderRadius:
                                    BorderRadius.circular(kMediumPadding)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                alignment: Alignment.centerLeft,
                                value: dropdownStatusValue,
                                hint: Text(
                                  "Status",
                                  style: TextStyles.defaultStyle.grayText
                                      .copyWith(fontSize: 13),
                                ),
                                iconStyleData: IconStyleData(
                                    iconEnabledColor:
                                        ColorPalette.primaryColor),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownStatusValue = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: const EdgeInsets.only(left: 12),
                                  height: 28,
                                  width: 100,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 28,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kMinPadding))),
                                items: statusItems
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        onTap: () {
                                          setState(() {
                                            status = e;
                                            print(status);
                                          });
                                        },
                                        child: Text(
                                          e,
                                          style:
                                              TextStyles.defaultStyle.grayText,
                                        )))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: StreamBuilder<List<RentalFormModel>>(
                    stream: FireBaseDataBase.readRentalForm(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        listRentalForm = snapshot.data!;
                        RentalFormModel.AllForms = snapshot.data!;
                        return GridView.count(
                            padding:
                                const EdgeInsets.only(bottom: kMediumPadding),
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.8,
                            children: loadListForms(listRentalForm)
                                .map((e) => FormItem(
                                      form: e,
                                    ))
                                .toList());
                      } else
                        return Container();
                    }),
              )),
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
