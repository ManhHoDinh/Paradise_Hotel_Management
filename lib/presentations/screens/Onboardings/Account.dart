import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/screens/Onboardings/login_screen.dart';

import '../../widgets/button_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 74),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageHelper.loadFromAsset(AssetHelper.avatar,
                width: 110, height: 110),
            Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  '${AuthServices.CurrentUser == null ? "" : AuthServices.CurrentUser!.name}',
                  style: TextStyles.h4.copyWith(
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.w500),
                )),
            Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Official ${AuthServices.CurrentUser == null ? "" : AuthServices.CurrentUser!.position}',
                  style: TextStyles.h5.copyWith(
                      color: ColorPalette.grayText,
                      fontWeight: FontWeight.w400),
                )),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Identity Card',
                          style: TextStyles.h6
                              .copyWith(color: ColorPalette.primaryColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Icon(
                          FontAwesomeIcons.phone,
                          size: 15,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Icon(
                          FontAwesomeIcons.solidEnvelope,
                          size: 15,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          '${AuthServices.CurrentUser == null ? "" : AuthServices.CurrentUser!.id}',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.h6
                              .copyWith(color: ColorPalette.blackText),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          '${AuthServices.CurrentUser == null ? "" : AuthServices.CurrentUser!.phoneNumber}',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          style: TextStyles.h6
                              .copyWith(color: ColorPalette.blackText),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          '${AuthServices.CurrentUser == null ? "" : AuthServices.CurrentUser!.email}',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          style: TextStyles.h6
                              .copyWith(color: ColorPalette.blackText),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 120),
              child: ButtonWidget(
                label: 'Log out',
                color: Colors.redAccent,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  AuthServices.CurrentUser = null;
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
