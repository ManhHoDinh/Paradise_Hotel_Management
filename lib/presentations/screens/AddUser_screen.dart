import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:paradise/core/models/user_model.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});
  static String routeName = 'add_user_screen';

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _ageController = TextEditingController();
    TextEditingController _birthdayController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        leading: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
            child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                  labelText: 'Age', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                  labelText: 'Birthday', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                createUser(
                  name: _nameController.text,
                  age: int.tryParse(_ageController.text),
                  birthday: DateTime.now(),
                );
                print('Data updated');
                Navigator.pop(context);
              },
              child: Text('Click me'),
            )
          ],
        )),
      ),
    );
  }

  void createUser(
      {required String name, required age, required birthday}) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc();
    User _user =
        User(name: name, age: age, birthday:birthday);
    _user.id = docUser.id;
    final json = _user.toJson();
    await docUser.set(json);
  }
}
