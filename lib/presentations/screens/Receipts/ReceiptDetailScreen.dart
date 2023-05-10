import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/presentations/screens/Receipts/RentalFormItem.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/models/receipt_model.dart';
import '../../../core/models/rental_form_model.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final ReceiptModel Receipt;
  const ReceiptDetailScreen({
    super.key,
    required this.Receipt,
    // required this.receiptModel,
  });

  @override
  State<ReceiptDetailScreen> createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  int currentId = 0;
  List<RentalFormModel> forms = [];
  late ReceiptModel receiptModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiptModel = widget.Receipt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text('RECEIPTS',
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
      // endDrawer: Drawer(
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Container(
      //           padding:
      //               EdgeInsets.only(top: 20, left: 25, right: 25),
      //           child: ButtonWidget(
      //             label: 'Book Room',
      //             color: ColorPalette.primaryColor,
      //             onTap: () {},
      //             textColor: ColorPalette.backgroundColor,
      //           ),
      //         ),
      //         Container(
      //           padding:
      //               EdgeInsets.only(top: 20, left: 25, right: 25),
      //           child: ButtonWidget(
      //             label: 'Edit Room',
      //             color: ColorPalette.primaryColor,
      //             onTap: () {},
      //             textColor: ColorPalette.backgroundColor,
      //           ),
      //         ),
      //         Container(
      //           padding:
      //               EdgeInsets.only(top: 20, left: 25, right: 25),
      //           child: ButtonWidget(
      //             label: 'Delete',
      //             color: ColorPalette.primaryColor,
      //             onTap: () {},
      //             textColor: ColorPalette.backgroundColor,
      //           ),
      //         ),
      //       ]),
      // ),
      body: StreamBuilder<List<RentalFormModel>>(
          stream: FireBaseDataBase.readRentalForms(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              forms = snapshot.data!;
              for (int i = 0; i < forms.length; i++) {
                if (!receiptModel.rentalFormIDs.contains(forms[i].RentalID)) {
                  forms.removeAt(i);
                  i--;
                }
              }

              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        // horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding * 3,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                            ),
                            child: Text(
                              'Booking Details',
                              style: TextStyles.h5.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            // height: 150,
                            decoration: BoxDecoration(
                                borderRadius: kDefaultBorderRadius,
                                border:
                                    Border.all(color: ColorPalette.grayText)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  child: Text(
                                    receiptModel.guestName!,
                                    style: TextStyles.h6.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.darkBlueText),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: kDefaultPadding,
                                        // right: kDefaultPadding,
                                        bottom: kDefaultPadding,
                                      ),
                                      child:
                                          Image.asset(AssetHelper.icoLocation),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: kDefaultPadding,
                                        right: kDefaultPadding,
                                        bottom: kDefaultPadding,
                                      ),
                                      child: Text(
                                        receiptModel.address!,
                                        style: TextStyles.h6.copyWith(
                                          color: ColorPalette.rankText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          // horizontal: kDefaultPadding * 1.5,
                          ),
                      child: Text(
                        'Receipt Details',
                        style: TextStyles.h5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ),
                    Container(
                        child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            RentalFormItem(rentalFormModel: forms[index]),
                        itemCount: forms.length,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          // horizontal: kDefaultPadding * 1.5,
                          vertical: kDefaultPadding),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'TOTAL',
                              style: TextStyles.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              receiptModel.total.toString() + ' VND',
                              style: TextStyles.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding * 2,
                        vertical: kDefaultPadding,
                      ),
                      child: ButtonDefault(
                        label: 'Print Receipt',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogOverlay(
                                  isSuccess: true,
                                  task: 'Print',
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else
              return Container();
          }),
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
    );
  }

  Widget items({
    required String image,
    required int counter,
  }) {
    return Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: kMinPadding),
      decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          border: Border.all(color: ColorPalette.grayText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(image),
          Text(
            counter.toString(),
            style: TextStyles.h6.copyWith(
                fontWeight: FontWeight.bold, color: ColorPalette.blackText),
          )
        ],
      ),
    );
  }
}
