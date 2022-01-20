import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextDark extends StatelessWidget {
  String name;
  CustomTextDark({this.name});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        color: _colors.purple,
        fontFamily: "CenturyGothic",
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
