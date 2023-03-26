import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/local_storage_helper.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/screens/login_screen.dart';

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
    NextIntroScreen();
  }

  // ignore: non_constant_identifier_names
  void NextIntroScreen() async {
    await (Future.delayed(Duration(seconds: 3)));
    Navigator.of(context).pushNamed(LoginScreen.routeName);
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ignoreIntro') as bool?;
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
    } else {
      LocalStorageHelper.setValue('ignoreIntro', true);
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil(IntroScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorPalette.primaryColor.withOpacity(0.9),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
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
