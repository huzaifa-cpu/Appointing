import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  String value;
  Function onChanged;
  List<String> list;
  String label;
  CustomDropDown({this.value, this.onChanged, this.list, this.label});
  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: _colors.green,
            fontSize: 13,
            fontFamily: "CenturyGothic",
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value: value,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: _colors.green,
          fontFamily: "CenturyGothic",
        ),
        onChanged: onChanged,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
