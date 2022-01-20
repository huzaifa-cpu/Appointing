import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class CustomTextField extends StatelessWidget {
  CustomColors _colors = CustomColors();
  String initialValue;
  String hint;
  bool obscureText;
  Function validate;
  Function onchanged;
  TextInputType type;
  CustomTextField(
      {this.hint,
      this.onchanged,
      this.validate,
      this.type,
      this.obscureText,
      this.initialValue});
  @override
  Widget build(BuildContext context) {
    return NeuCard(
      height: 55,
      curveType: CurveType.emboss,
      bevel: 15.0,
      decoration: NeumorphicDecoration(
        borderRadius: BorderRadius.circular(30),
        color: _colors.colorTheme,
      ),
      child: TextFormField(
        keyboardType: type,
        initialValue: initialValue,
        onChanged: onchanged,
        validator: validate,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 5),
          hintText: hint,
          hintStyle: TextStyle(color: _colors.grey, fontSize: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
