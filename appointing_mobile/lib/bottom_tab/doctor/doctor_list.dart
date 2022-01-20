import 'package:appointing_mobile/change_notifier/doctor_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/doctor.dart';
import 'package:appointing_mobile/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'doctor_card.dart';

class DoctorList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorListScreenState();
  }
}

class DoctorListScreenState extends State<DoctorList> {
  final DoctorService doctorService = DoctorService();
  @override
  Widget build(BuildContext context) {
    CustomColors _colors = CustomColors();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Doctors",
            style: TextStyle(
              fontSize: 22.0,
              color: _colors.white,
            ),
          ),
          backgroundColor: _colors.colorTheme,
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0),
      backgroundColor: _colors.colorTheme,
      resizeToAvoidBottomInset: false,
      body: Consumer<DoctorProvider>(builder: (context, doctorProvider, child) {
        List<Doctor> doctor = doctorProvider.doctor;
        return doctor.isEmpty
            ? Center(
                child: Text("No Doctors available",
                    style: TextStyle(
                        color: _colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              )
            : ListView.builder(
                itemCount: doctor.length,
                itemBuilder: (BuildContext context, int i) {
                  return DoctorCard(doctor: doctor[i]);
                });
      }),
    );
  }
}
