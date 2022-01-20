import 'dart:convert';

import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/screens/book_doctor.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

import '../../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  CustomColors _colors = CustomColors();
  Doctor doctor;
  DoctorCard({this.doctor});
  @override
  Widget build(BuildContext context) {
    void bookNow(Doctor doctor) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BookDoctor(doctor: doctor);
          });
    }

    return NeuCard(
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        curveType: CurveType.flat,
        bevel: 12,
        decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(25),
          color: _colors.colorTheme,
        ),
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: NeuCard(
                    curveType: CurveType.flat,
                    height: 100.0,
                    width: 100.0,
                    bevel: 12,
                    decoration: NeumorphicDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: _colors.colorTheme,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: doctor.image == null
                                  ? AssetImage("lib/images/profile_image.jpg")
                                  : MemoryImage(
                                      Base64Decoder().convert(doctor.image)),
                              fit: BoxFit.fill)),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.specialization,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: _colors.white,
                        fontSize: 14),
                  ),
                  Text(
                    doctor.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _colors.white,
                        fontSize: 16),
                  ),
                  Text(
                    "Fee: ${doctor.fee}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: _colors.white,
                        fontSize: 14),
                  ),
                  Text(
                    doctor.opd,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: _colors.white,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomSquareButton(
                    onPressed: () {
                      bookNow(doctor);
                    },
                    attribute: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: _colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Book now",
                          style: TextStyle(fontSize: 13, color: _colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
