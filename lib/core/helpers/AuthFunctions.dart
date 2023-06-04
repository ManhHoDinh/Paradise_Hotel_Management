import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:paradise/presentations/screens/Onboardings/main_screen.dart';

import '../../presentations/widgets/dialog.dart';

class AuthServices {
  static UserModel? CurrentUser;
  static signUpUser(String email, String password, String name, String phoneNo,
      BuildContext buildContext) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      UserModel user = UserModel(
          ID: uid,
          Name: name,
          PhoneNumber: phoneNo,
          Email: email,
          Position: 'Manager');
      DocumentReference doc =
          FirebaseFirestore.instance.collection("Users").doc(uid);
      doc.set(user.toJson());
      Navigator.of(buildContext).pushNamed(MainScreen.routeName);
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
      UpdateCurrentUser();
      if (AuthServices.CurrentUser != null) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: true,
                task: 'login',
              );
            });
        Navigator.of(context).pushNamed(MainScreen.routeName);
      }
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

  static bool CurrentUserIsManager() {
    try {
      bool result = false;
      if (AuthServices.CurrentUser!.Position == 'Manager') result = true;
      return result;
    } catch (e) {
      return false;
    }
  }

  static UpdateCurrentUser() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      AuthServices.CurrentUser = UserModel(
        ID: value['ID'],
        Name: value['Name'],
        PhoneNumber: value['PhoneNumber'],
        Email: value['Email'],
        Position: value['Position'],
      );
    });
  }
}