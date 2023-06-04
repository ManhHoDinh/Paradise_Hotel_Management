import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:paradise/presentations/screens/Onboardings/register_form_screen.dart';
import 'package:paradise/presentations/screens/Staffs/staff_item.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';

class StaffScreen extends StatefulWidget {
  static final String routeName = "staff_screen";
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  List<UserModel> listUser = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPalette.primaryColor,
          child: Text(
            '+',
            style: TextStyles.h1.copyWith(color: ColorPalette.backgroundColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(RegisterFormScreen.routeName);
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
              child: Text('Receipts',
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
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            color: ColorPalette.backgroundColor,
            // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
            child: Column(children: [
              // StreamBuilder(
              //     stream: FireBaseDataBase.readUsers(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         listUser= snapshot.data!;
              //       }
              //       return Container();
              //     }),

              const SizedBox(height: 36),
              // Container(
              //   child: Container(
              //     child: SizedBox(
              //       height: 42,
              //       width: double.infinity,
              //       child: TextField(
              //         onChanged: (value) {
              //           setState(() {
              //             valueSearch = value;
              //           });
              //         },
              //         decoration: InputDecoration(
              //             contentPadding: const EdgeInsets.only(top: 4),
              //             prefixIcon: InkWell(
              //               customBorder: CircleBorder(),
              //               onTap: () {},
              //               child: Icon(
              //                 FontAwesomeIcons.magnifyingGlass,
              //                 size: 16,
              //                 color: ColorPalette.greenText,
              //               ),
              //             ),
              //             suffixIcon: InkWell(
              //                 customBorder: CircleBorder(),
              //                 onTap: () {
              //                   setState(() {
              //                     isVisibleFilter = !isVisibleFilter;
              //                   });
              //                 },
              //                 child: Image.asset(AssetHelper.iconFilter)),
              //             hintText: 'Search',
              //             hintStyle: TextStyle(
              //               fontSize: 14,
              //               color: ColorPalette.grayText,
              //             ),
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(
              //                     color: ColorPalette.primaryColor, width: 2))),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 24),
              // Container(
              //     alignment: Alignment.centerLeft,
              //     child: Visibility(
              //         visible: isVisibleFilter,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             FilterContainerWidget(
              //               name: 'Price',
              //               icon1: Icon(
              //                 FontAwesomeIcons.arrowDown,
              //                 size: 12,
              //                 color: priceDecrease
              //                     ? ColorPalette.primaryColor
              //                     : ColorPalette.blackText,
              //               ),
              //               icon2: Icon(
              //                 FontAwesomeIcons.arrowUp,
              //                 size: 12,
              //                 color: priceDecrease
              //                     ? ColorPalette.blackText
              //                     : ColorPalette.primaryColor,
              //               ),
              //               onTapIconDown: () {
              //                 setState(() {
              //                   priceDecrease = true;
              //                 });
              //               },
              //               onTapIconUp: () {
              //                 setState(() {
              //                   priceDecrease = false;
              //                 });
              //               },
              //             ),
              //             Container(
              //                 height: 28,
              //                 width: 140,
              //                 decoration: BoxDecoration(
              //                     border:
              //                         Border.all(color: ColorPalette.grayText),
              //                     borderRadius:
              //                         BorderRadius.circular(kMediumPadding)),
              //                 child: DropdownButtonHideUnderline(
              //                   child: DropdownButton2(
              //                     alignment: Alignment.centerLeft,
              //                     iconStyleData: IconStyleData(
              //                         iconEnabledColor:
              //                             ColorPalette.primaryColor),
              //                     dropdownStyleData: DropdownStyleData(
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.circular(
              //                                 kMinPadding))),
              //                     hint: Text(
              //                       'Kind',
              //                       style: TextStyles.defaultStyle.grayText,
              //                     ),
              //                     items: kindItems
              //                         .map((e) => DropdownMenuItem<String>(
              //                             value: e,
              //                             onTap: () {
              //                               setState(() {
              //                                 kindRoom = e;
              //                               });
              //                             },
              //                             child: Text(
              //                               e,
              //                               overflow: TextOverflow.ellipsis,
              //                               style: TextStyles
              //                                   .defaultStyle.grayText
              //                                   .copyWith(fontSize: 13),
              //                             )))
              //                         .toList(),
              //                     buttonStyleData: const ButtonStyleData(
              //                       padding: const EdgeInsets.only(left: 12),
              //                       height: 28,
              //                       width: 10,
              //                     ),
              //                     menuItemStyleData: const MenuItemStyleData(
              //                       height: 28,
              //                     ),
              //                     value: dropdownKindValue,
              //                     onChanged: (value) {
              //                       setState(() {
              //                         dropdownKindValue = value;
              //                       });
              //                     },
              //                   ),
              //                 ))
              //           ],
              //         ))),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 30),
                child: StreamBuilder<List<UserModel>>(
                    stream: FireBaseDataBase.readUsers(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        //Receipts = snapshot.data!;
                        listUser.clear();
                        List<UserModel> listData = snapshot.data!;
                        for (UserModel user in listData) {
                          if (user.position! == "Staff") {
                            listUser.add(user);
                          }
                        }

                        return GridView.count(
                            padding:
                                const EdgeInsets.only(bottom: kMediumPadding),
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.8,
                            children: listUser
                                .map((e) => StaffItem(
                                      userModel: e,
                                    ))
                                .toList());
                      } else
                        return Container();
                    }),
              )),
            ])));
  }
}
