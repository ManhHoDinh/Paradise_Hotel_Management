import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/core/models/user_model.dart';

import 'package:paradise/presentations/screens/Onboardings/home_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/main_screen.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/dialog.dart';
import '../Staffs/staff_screen.dart';

class AuthServices {
  static signUpUser(String email, String password, String name, String phoneNo,
      String birthday, String cccd, BuildContext buildContext) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      // await FirebaseAuth.instance.currentUser!.updateEmail(email);
      // String uid = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        'ID': userCredential.user!.uid,
        'Name': name,
        'PhoneNumber': phoneNo,
        'Email': email,
        'Position': 'Staff',
        'BirthDay': birthday,
        'Identification': cccd
      });
      Navigator.of(buildContext).pushNamed(StaffScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
              task: 'login',
            );
          });
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("currentUser", FirebaseAuth.instance.currentUser!.uid);
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
  }
}
