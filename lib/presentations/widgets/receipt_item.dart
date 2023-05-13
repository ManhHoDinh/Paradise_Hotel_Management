// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/models/receipt_model.dart';

import '../screens/Receipts/ReceiptDetailScreen.dart';

class ReceiptItem extends StatefulWidget {
  ReceiptModel Receipt;
  ReceiptItem({super.key, required this.Receipt});

  @override
  State<ReceiptItem> createState() => _ReceiptItemState();
}

class _ReceiptItemState extends State<ReceiptItem> {
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
          border: Border.all(color: ColorPalette.grayText),
        ),
        child: Column(children: [
          Text(widget.Receipt.guestName??''),
          //widget.Receipt. Icon(FontAwesomeIcons.mars)
          //Icon(FontAwesomeIcons.moon)
        ]),
      ),
    );
  }
}