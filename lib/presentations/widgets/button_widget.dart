import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, title, onTap, color}) {
    Title = title;
    OnTap = onTap;
    _color = color;
  }
  String? Title = '';
  VoidCallback OnTap = () {};
  Color _color = Colors.amberAccent;
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
