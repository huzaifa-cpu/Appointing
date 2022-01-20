import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:appointing_desktop/widgets/custom_text_dark.dart';
import 'package:appointing_desktop/widgets/custom_text_light.dart';
import 'package:flutter/material.dart';

class PatientInfo extends StatefulWidget {
  Patient patient;
  PatientInfo(this.patient);
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  CustomColors _colors = new CustomColors();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    color: _colors.purple,
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    border: Border.all(color: _colors.purple, width: 1),
                    image: DecorationImage(
                      image: widget.patient.image == null
                          ? AssetImage("images/profile_image.jpg")
                          : MemoryImage(
                              Base64Decoder().convert(widget.patient.image)),
                    )),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextDark(
                  name: "Name: ",
                ),
                CustomTextLight(
                  name: "${widget.patient.name}",
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextDark(
                  name: "Age: ",
                ),
                CustomTextLight(
                  name: "${widget.patient.age}",
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextDark(
                  name: "Gender: ",
                ),
                CustomTextLight(
                  name: "${widget.patient.gender}",
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextDark(
                  name: "PhoneNo: ",
                ),
                CustomTextLight(
                  name: "${widget.patient.phoneNumber}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
