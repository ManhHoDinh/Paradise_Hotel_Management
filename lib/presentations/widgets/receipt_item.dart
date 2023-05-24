// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/models/receipt_model.dart';

import '../../core/constants/dimension_constants.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/text_styles.dart';
import '../screens/Receipts/ReceiptDetailScreen.dart';

class ReceiptItem extends StatefulWidget {
  ReceiptModel Receipt;
  ReceiptItem({super.key, required this.Receipt});

  @override
  State<ReceiptItem> createState() => _ReceiptItemState();
}

class _ReceiptItemState extends State<ReceiptItem> {
  late ReceiptModel receiptModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiptModel = widget.Receipt;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ReceiptDetailScreen(
                      Receipt: widget.Receipt,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorPalette.primaryColor),
        ),
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
                textAlign: TextAlign.center,
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
                  child: Image.asset(AssetHelper.icoLocation),
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
            Row(
              children: [
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    // right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Icon(
                    FontAwesomeIcons.phone,
                    color: ColorPalette.primaryColor,
                    size: 13,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Text(
                    receiptModel.phoneNumber!,
                    style: TextStyles.h6.copyWith(
                      color: ColorPalette.rankText,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kMinPadding,
              ),
              decoration: BoxDecoration(
                  color: ColorPalette.primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              margin: const EdgeInsets.only(bottom: kMinPadding),
              child: Text(
                '${receiptModel.checkOutDate!.day} / ${receiptModel.checkOutDate!.month}',
                style: TextStyles.h6.copyWith(
                    color: ColorPalette.darkBlueText,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Center(
              child: Text(
                receiptModel.total.toString() + ' VND',
                style: TextStyles.h5.bold
                    .copyWith(color: ColorPalette.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
