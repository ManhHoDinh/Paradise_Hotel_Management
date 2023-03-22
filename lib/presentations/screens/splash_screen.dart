import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/local_storage_helper.dart';

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
    await (Future.delayed(Duration(seconds: 2)));
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
    return Scaffold(
      body: Container(
        child: Image.asset(AssetHelper.avatar),
      ),
    );
  }
}
