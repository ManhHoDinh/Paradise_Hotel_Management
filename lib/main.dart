import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paradise/core/models/kind_room_service.dart';
import 'package:paradise/presentations/routes.dart';
import 'package:paradise/presentations/screens/Onboardings/home_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/splash_screen.dart';
import 'package:paradise/presentations/screens/report_screen.dart';
import 'package:provider/provider.dart';
import 'core/constants/color_palatte.dart';
import 'core/helpers/local_storage_helper.dart';
import 'core/models/firebase_request.dart';

Future main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseDataBase.initializeDB();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  bool isLogin = false;
  // checkLogin() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user != null && mounted) {
  //       setState(() {
  //         isLogin = true;
  //       });
  //     } else
  //       isLogin = false;
  //   });
  // }

  @override
  void initState() {
    // checkLogin();
    super.initState();
  }

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
