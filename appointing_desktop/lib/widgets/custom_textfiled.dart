import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constraints/custom_colors.dart';

class CustomTextfield extends StatelessWidget {
  CustomColors _colors = new CustomColors();
  bool obscureText;
  String hintText;
  String labelText;
  String initialValue;
  Function validate;
  Function onchanged;
  TextInputType keyboardType;
  Function onChanged;
  Function validation;
  TextEditingController controller;
  List<TextInputFormatter> inputFormatters;
  CustomTextfield(
      {this.obscureText,
      this.onchanged,
      this.controller,
      this.validate,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.validation,
      this.initialValue,
      this.inputFormatters,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validation,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontFamily: "CenturyGothic",
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: _colors.green,
              fontSize: 13,
              fontFamily: "CenturyGothic",
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
    );
  }
}
