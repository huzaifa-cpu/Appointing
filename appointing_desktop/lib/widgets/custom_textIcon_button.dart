import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  String name;
  Function onPressed;
  bool boolCondition;
  IconData icon;
  CustomTextIconButton(
      {this.name, this.onPressed, this.boolCondition, this.icon});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        elevation: boolCondition ? 30 : 0.0,
        color: boolCondition ? _colors.green : _colors.purple,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: boolCondition ? _colors.white : _colors.green,
          size: 18,
        ),
        label: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: boolCondition ? FontWeight.w800 : FontWeight.w400,
            fontFamily: "CenturyGothic",
          ),
        ));
  }
}
