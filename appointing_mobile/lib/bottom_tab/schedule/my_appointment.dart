import 'dart:convert';

import 'package:appointing_mobile/change_notifier/appointment_provider.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/appointment.dart';
import 'package:appointing_mobile/models/appointment_id.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/models/patient_extra.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/appointment_service.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/widgets/custom_alert_dialog.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<AppointmentList> {
  CustomColors _colors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colors.colorTheme,
      resizeToAvoidBottomInset: false,
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          List<Appointment> appointwithState = appointmentProvider.appoint;
          List<Appointment> appoints = [];
          for (var i in appointwithState) {
            if (i.state == true) {
              appoints.add(i);
            }
          }
          return appoints.length == 0
              ? Center(
                  child: Text("No appointments yet",
                      style: TextStyle(
                          color: _colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                )
              : ListView.builder(
                  itemCount: appoints.length,
                  itemBuilder: (context, i) {
                    return AppointmentTestCard(
                        appointment: appoints[i], index: i);
                  });
        },
      ),
    );
  }
}

class AppointmentTestCard extends StatelessWidget {
  CustomColors _colors = CustomColors();
  Appointment appointment;
  int index;
  AppointmentTestCard({this.appointment, this.index});
  AppointmentService appointmentService = AppointmentService();
  PatientService patientService = PatientService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10, left: 15, right: 15),
      child: NeuCard(
        color: _colors.colorTheme,
        bevel: 8,
        curveType: CurveType.flat,
        decoration: NeumorphicDecoration(
            borderRadius: BorderRadius.circular(15), color: _colors.colorTheme),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appointment.date,
                    style: TextStyle(color: _colors.white, fontSize: 16),
                  ),
                  Text("Rs: ${appointment.doctor.fee}",
                      style: TextStyle(
                          color: _colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Text(appointment.time,
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appointment.doctor.name,
                      style: TextStyle(
                        color: _colors.white,
                        fontSize: 16,
                      )),
                  Consumer2<AppointmentProvider, ProfileProvider>(builder:
                      (context, appointmentProvider, profileProvider, child) {
                    return CustomSquareButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                title: "Cancel appointment?",
                                btn1Text: "Yes",
                                btn2Text: "No",
                                onPressed1: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Loader("Cancelling...")));
                                  //Patient body
                                  Patient patient = profileProvider.patient;
                                  PatientExtra patientExtra = PatientExtra(
                                      patientId: patient.patientId,
                                      name: patient.name,
                                      age: patient.age,
                                      gender: patient.gender,
                                      phoneNumber: patient.phoneNumber,
                                      image: patient.image);
                                  //UserID
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String userUid = prefs.getString("userUid");
                                  //AppointmentBody
                                  AppointmentId appoitnId = AppointmentId(
                                      patientId: userUid,
                                      doctorId: appointment.doctor.doctorId);
                                  Appointment appointments = Appointment(
                                      appointmentId: appoitnId,
                                      doctor: appointment.doctor,
                                      patient: patientExtra,
                                      date: appointment.date,
                                      time: appointment.time,
                                      state: false);
                                  var appointmentJson =
                                      jsonEncode(appointments);
                                  print(appointmentJson);
                                  appointmentProvider.updateState(userUid,
                                      appointment.doctor.doctorId, false);

                                  //CANCELLING
                                  await appointmentService.cancelAppointment(
                                      appointmentJson,
                                      userUid,
                                      appointment.doctor.doctorId);
                                  //Real-Time update
                                  Patient patients =
                                      await patientService.getPatientById();
                                  appointmentProvider.appoint =
                                      patients.appointment;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  //message
                                  Fluttertoast.showToast(
                                      msg: "Your appointment is cancelled",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey[500],
                                      textColor: _colors.white,
                                      fontSize: 14);
                                },
                                onPressed2: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      attribute: Text("cancel",
                          style: TextStyle(
                            color: _colors.grey,
                            fontSize: 12,
                          )),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
