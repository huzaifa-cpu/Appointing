import 'package:flutter/material.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';

class CustomMediumButton extends StatelessWidget {
  String name;
  Function onPressed;
  IconData icon;
  Color color;
  CustomMediumButton({this.name, this.onPressed, this.icon, this.color});
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
      height: 28,
      width: 20,
      child: RaisedButton.icon(
        icon: Icon(
          icon,
          size: 13,
          color: _colors.white,
        ),
        color: color,
        onPressed: onPressed,
        label: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
            fontFamily: "CenturyGothic",
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
