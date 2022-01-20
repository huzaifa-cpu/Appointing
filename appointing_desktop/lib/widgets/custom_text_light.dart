import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextLight extends StatelessWidget {
  String name;
  CustomTextLight({this.name});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontFamily: "CenturyGothic",
        color: _colors.purple,
      ),
    );
  }
}
