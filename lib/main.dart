import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/routes.dart';
import 'package:paradise/presentations/screens/detail_room.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';
import 'core/constants/color_palatte.dart';
import 'core/helpers/local_storage_helper.dart';
import 'core/models/firebase_request.dart';

Future main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseDataBase.initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradise',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
      home: SplashScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
