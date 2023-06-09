import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

import '../../../core/models/firebase_request.dart';
import '../../../core/models/rental_form_model.dart';
import '../../../core/models/room_kind_model.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // ignore: non_constant_identifier_names
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.primaryColor.withOpacity(0.9),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            StreamBuilder(
                stream: FireBaseDataBase.readRoomKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    RoomKindModel.kindItems.clear();
                    RoomKindModel.AllRoomKinds = snapshot.data!;
                    for (RoomKindModel k in RoomKindModel.AllRoomKinds) {
                      RoomKindModel.kindItems.add(k.Name ?? '');
                    }
                  }
                  return Container();
                }),
            StreamBuilder(
                stream: FireBaseDataBase.readRentalForms(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    RentalFormModel.AllRentalFormModels = snapshot.data!;
                  }
                  return Container();
                }),
            Container(
              height: size.height * 1 / 2,
              color: ColorPalette.primaryColor,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Container(
                height: size.width * 4 / 9,
                width: size.width * 4 / 9,
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(size.width * 4 / 9),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Image.asset(
                AssetHelper.logo1,
                width: size.width * 2 / 7,
                height: size.width * 2 / 7,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * 1 / 2 - size.width * 2 / 7),
              child: Text(
                'Paradise',
                style: TextStyles.slo.copyWith(shadows: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6),
                ]),
              ),
            ),
          ],
        ));
  }
}
