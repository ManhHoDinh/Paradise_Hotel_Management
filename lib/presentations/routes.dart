import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/AddUser_screen.dart';
import 'package:paradise/presentations/screens/RoomKindView.dart';
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
  RentalForm.routeName: (context) => RentalForm(),
  RoomKindView.routeName: (context) => RoomKindView(),
  SeeAllScreen.routeName:(context) => SeeAllScreen(),
};
