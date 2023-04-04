import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/presentations/routes.dart';
import 'package:paradise/presentations/screens/UserViewer.dart';
import 'package:paradise/presentations/screens/home_screen.dart';
import 'package:paradise/presentations/screens/login_screen.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';
import 'core/constants/color_palatte.dart';
import 'core/helpers/local_storage_helper.dart';

Future main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  WidgetsFlutterBinding.ensureInitialized();
  FireBaseDataBase.initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradise',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
      home: HomeScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
