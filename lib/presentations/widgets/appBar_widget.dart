import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key, this.drawer, this.title, this.BackgroundColor});
  Drawer? drawer;
  String? title = '';
  Color? BackgroundColor = ColorPalette.primaryColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: BackgroundColor ?? ColorPalette.primaryColor,
      child: Row(
        children: [
          Expanded(
              child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: ColorPalette.backgroundColor,
          )),
          Expanded(child: Text(title ?? '')),
          Expanded(
              child: drawer != null
                  ? Drawer(
                      child: drawer,
                    )
                  : Container())
        ],
      ),
    );
  }
}
