import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:paradise/presentations/widgets/filter_containter_widget.dart';
import 'package:paradise/presentations/widgets/form_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../../core/models/guest_model.dart';

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
  final statusItems = ['All', 'Unpaid', 'Paid'];
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
      list.sort((a, b) => (b.BeginDate).compareTo(a.BeginDate));
    } else {
      list.sort((a, b) => (a.BeginDate).compareTo(b.BeginDate));
    }

    List<RentalFormModel> newList = List.from(list);

    switch (status) {
      case "All":
        newList = newList;
        break;
      case "Paid":
        newList = newList.where((form) => form.Status == status).toList();
        break;
      case "Unpaid":
        newList = newList.where((form) => form.Status == status).toList();
        break;
      default:
        newList = newList;
        break;
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPalette.primaryColor,
          child: Text(
            '+',
            style: TextStyles.h1.copyWith(color: ColorPalette.backgroundColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(RentalForm.routeName);
          },
        ),
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
            child: Text(
              'RENTAL FORMS',
              style: TextStyles.h8.bold.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(3, 6),
                    blurRadius: 6,
                  )
                ],
                letterSpacing: 1.175,
              ),
            ),
          ),
          centerTitle: true,
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          color: ColorPalette.backgroundColor,
          child: Column(
            children: [
              StreamBuilder(
                  stream: FireBaseDataBase.readGuestKinds(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GuestKindModel.kindItems.clear();

                      GuestKindModel.AllGuestKinds = snapshot.data!;
                      for (GuestKindModel k in GuestKindModel.AllGuestKinds) {
                        GuestKindModel.kindItems.add(k.Name);
                      }
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
              StreamBuilder(
                  stream: FireBaseDataBase.readRooms(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      RoomModel.AllRooms = snapshot.data!;
                    }
                    return Container();
                  }),
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
                                color: dateDecrease
                                    ? ColorPalette.primaryColor
                                    : ColorPalette.blackText,
                              ),
                              icon2: Icon(
                                FontAwesomeIcons.arrowUp,
                                size: 13,
                                color: dateDecrease
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
                    stream: FireBaseDataBase.readRentalForms(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        listRentalForm = snapshot.data!;
                        RentalFormModel.AllRentalFormModels = snapshot.data!;
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
      ),
    );
  }
}
