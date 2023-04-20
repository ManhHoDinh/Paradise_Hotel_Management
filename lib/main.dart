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
  static final List<String> sub = [
    'assets/images/room_detail12.png',
    'assets/images/room_detail13.png',
    'assets/images/room_detail14.png'
  ];
  static final RoomModel abc = RoomModel(
      roomID: 'P001',
      PrimaryImage: 'assets/images/room_detail11.png',
      RoomKindID: 'TYPE1',
      price: 150000,
      State: '3 PEOPLE',
      SubImages: sub,
      Description:
          'Ramayana Prambanan is a show that combines dance and drama without dialogue, based on the Ramayana story, it\'s performed near Prambanan Temple on Java Island, Indonesia. Ramayana Prambanan performs since 1961.',
      maxCapacity: 3);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradise',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
      home: DetailRoom(
        room: abc,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
