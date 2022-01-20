import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';

class CustomButton extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  String name;
  VoidCallback onPressed;
  CustomButton({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: NeuCard(
          color: _colors.colorTheme,
          height: 55,
          curveType: CurveType.flat,
          bevel: 14,
          decoration: NeumorphicDecoration(
            color: _colors.colorTheme,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                color: _colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ));
  }
}
