import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/AddUser_screen.dart';
import 'package:paradise/presentations/screens/RoomKindView.dart';
import 'package:paradise/presentations/screens/detail_room.dart';
import 'package:paradise/presentations/screens/home_screen.dart';
import 'package:paradise/presentations/screens/login_screen.dart';
import 'package:paradise/presentations/screens/rental_form.dart';
import 'package:paradise/presentations/screens/seeAll_screen.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';
import 'package:paradise/presentations/screens/createRoom_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  AddUserScreen.routeName: (context) => AddUserScreen(),
  CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
  RoomKindView.routeName: (context) => RoomKindView(),
  SeeAllScreen.routeName: (context) => SeeAllScreen(),
  RentalForm.routeName: (context) => RentalForm(),
};
