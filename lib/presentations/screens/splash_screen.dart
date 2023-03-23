import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/local_storage_helper.dart';

import '../../core/models/user_model.dart';

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
    TextEditingController _nameController = TextEditingController();
    return Scaffold();
  }
}
