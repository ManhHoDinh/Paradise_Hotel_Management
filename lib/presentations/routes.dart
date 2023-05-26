import 'package:flutter/material.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:paradise/presentations/screens/GuestKinds/AddGuestKindScreen.dart';
import 'package:paradise/presentations/screens/GuestKinds/GuestKindView.dart';
import 'package:paradise/presentations/screens/Onboardings/home_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/login_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/otp_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/register_form_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/register_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/splash_screen.dart';
import 'package:paradise/presentations/screens/Receipts/%20PrintReceipt.dart';
import 'package:paradise/presentations/screens/Receipts/AddReceipt.dart';
import 'package:paradise/presentations/screens/Receipts/SeeAllReceipt.dart';
import 'package:paradise/presentations/screens/RoomKinds/RoomKindView.dart';
import 'package:paradise/presentations/screens/Rooms/CreateRoom_screen.dart';
import 'package:paradise/presentations/screens/Rooms/seeAll_screen.dart';
import 'package:paradise/presentations/screens/RoomKinds/AddRoomKindScreen.dart';
import 'package:paradise/presentations/screens/Onboardings/main_screen.dart';
import 'package:paradise/presentations/screens/report_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
  RoomKindView.routeName: (context) => RoomKindView(),
  SeeAllRoomsScreen.routeName: (context) => SeeAllRoomsScreen(),
  AddRoomKindScreen.routeName: (context) => AddRoomKindScreen(),
  RentalForm.routeName: (context) => RentalForm(),
  GuestKindView.routeName: (context) => GuestKindView(),
  AddGuestKindScreen.routeName: (context) => AddGuestKindScreen(),
  AddReceipt.routeName: (context) => AddReceipt(),
  SeeAllReceipts.routeName: (context) => SeeAllReceipts(),
  ReportScreen.routeName: (context) => ReportScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  RegisterFormScreen.routeName: (context) => RegisterFormScreen(),
  MainScreen.routeName: (context) => MainScreen()
};
