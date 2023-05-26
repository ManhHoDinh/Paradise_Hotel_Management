import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 74),
        child: Column(
          children: [
            ImageHelper.loadFromAsset(AssetHelper.avatar,
                width: 110, height: 110),
            Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  'Manh Ho Dinh',
                  style: TextStyles.h5.copyWith(
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}
