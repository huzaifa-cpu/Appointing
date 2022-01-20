import 'dart:convert';

import 'package:appointing_mobile/change_notifier/appointment_provider.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/appointment.dart';
import 'package:appointing_mobile/models/appointment_id.dart';
import 'package:appointing_mobile/models/doctor.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/models/patient_extra.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/appointment_service.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/widgets/custom_button.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDoctor extends StatefulWidget {
  Doctor doctor;
  BookDoctor({this.doctor});
  @override
  _BookDoctorState createState() => _BookDoctorState();
}

class _BookDoctorState extends State<BookDoctor> {
  AppointmentService _appointmentService = new AppointmentService();
  CustomColors _colors = new CustomColors();
  DatePickerController _controller = DatePickerController();
  PatientService patientService = new PatientService();
  DateTime _selectedValue = DateTime.now();
  bool btn1 = true;
  bool btn2 = false;
  bool btn3 = false;
  bool btn4 = false;
  bool btn5 = false;
  bool btn6 = false;
  String time() {
    if (btn1) {
      return "10:00-12:00 AM";
    } else if (btn2) {
      return "12:00-02:00 PM";
    } else if (btn3) {
      return "02:00-04:00 PM";
    } else if (btn4) {
      return "04:00-06:00 PM";
    } else if (btn5) {
      return "06:00-08:00 PM";
    } else if (btn6) {
      return "08:00-10:00 PM";
    }
    return "10:00-12:00 AM";
  }

  @override
  Widget build(BuildContext context) {
    ///
    double scaffoldHeigth = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    ///
    return ListView(
      children: [
        Container(
          color: _colors.colorTheme,
          height: scaffoldHeigth * 1,
          child: Padding(
            padding: EdgeInsets.only(
                top: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: 20,
                left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: _colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Text(
                "Select Date",
                style: TextStyle(
                    color: _colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              NeuCard(
                curveType: CurveType.flat,
                bevel: 10,
                color: _colors.colorTheme,
                decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _colors.colorTheme),
                child: DatePicker(
                  DateTime.now(),
                  width: 60,
                  height: 70,
                  controller: _controller,
                  dayTextStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _colors.white,
                  ),
                  monthTextStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _colors.white,
                  ),
                  dateTextStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _colors.white,
                  ),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: _colors.grey,
                  selectedTextColor: _colors.colorTheme,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Select Time",
                style: TextStyle(
                    color: _colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = true;
                        btn2 = false;
                        btn3 = false;
                        btn4 = false;
                        btn5 = false;
                        btn6 = false;
                      });
                    },
                    attribute: Text(
                      "10:00-12:00 AM",
                      style: TextStyle(
                          color: btn1 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = false;
                        btn2 = true;
                        btn3 = false;
                        btn4 = false;
                        btn5 = false;
                        btn6 = false;
                      });
                    },
                    attribute: Text(
                      "12:00-2:00 PM",
                      style: TextStyle(
                          color: btn2 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = false;
                        btn2 = false;
                        btn3 = true;
                        btn4 = false;
                        btn5 = false;
                        btn6 = false;
                      });
                    },
                    attribute: Text(
                      "2:00-4:00 PM",
                      style: TextStyle(
                          color: btn3 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = false;
                        btn2 = false;
                        btn3 = false;
                        btn4 = true;
                        btn5 = false;
                        btn6 = false;
                      });
                    },
                    attribute: Text(
                      "4:00-6:00 PM",
                      style: TextStyle(
                          color: btn4 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = false;
                        btn2 = false;
                        btn3 = false;
                        btn4 = false;
                        btn5 = true;
                        btn6 = false;
                      });
                    },
                    attribute: Text(
                      "6:00-8:00 PM",
                      style: TextStyle(
                          color: btn5 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                  CustomSquareButton(
                    onPressed: () {
                      setState(() {
                        btn1 = false;
                        btn2 = false;
                        btn3 = false;
                        btn4 = false;
                        btn5 = false;
                        btn6 = true;
                      });
                    },
                    attribute: Text(
                      "8:00-10:00 PM",
                      style: TextStyle(
                          color: btn6 ? _colors.red : _colors.grey,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer2<AppointmentProvider, ProfileProvider>(
                builder: (context, appointmentProvider, patientProvider,
                        child) =>
                    CustomButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loader("Booking...")));
                          Patient patient = patientProvider.patient;
                          //Patient body
                          PatientExtra patientExtra = PatientExtra(
                              patientId: patient.patientId,
                              name: patient.name,
                              age: patient.age,
                              gender: patient.gender,
                              phoneNumber: patient.phoneNumber,
                              image: patient.image);
                          //DATE-TIME
                          String date =
                              "${_selectedValue.day.toString()}-${_selectedValue.month.toString()}-${_selectedValue.year.toString()}";
                          //CHECK if EXIST
                          bool existedAppoinment =
                              appointmentProvider.checkIfAppointmentIsBooked(
                                  patient.patientId, widget.doctor.doctorId);

                          if (existedAppoinment) {
                            //UserID
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String userUid = prefs.getString("userUid");

                            //AppointmentBody
                            AppointmentId appoitnId = AppointmentId(
                                patientId: userUid,
                                doctorId: widget.doctor.doctorId);
                            Appointment appointments = Appointment(
                                appointmentId: appoitnId,
                                patient: patientExtra,
                                doctor: widget.doctor,
                                date: date,
                                time: time(),
                                state: true);
                            var appointmentJson = jsonEncode(appointments);
                            print(appointmentJson);
                            //ReNew
                            await _appointmentService.cancelAppointment(
                                appointmentJson,
                                userUid,
                                widget.doctor.doctorId);
                            //Real-Time update
                            Patient _patient =
                                await patientService.getPatientById();
                            appointmentProvider.appoint = _patient.appointment;
                            //message
                            Fluttertoast.showToast(
                                msg: "Your appointment is rescheduled",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.grey[500],
                                textColor: _colors.white,
                                fontSize: 14);
                            Navigator.pop(context);
                          } else {
                            AppointmentId appointmentId = AppointmentId(
                                patientId: patient.patientId,
                                doctorId: widget.doctor.doctorId);
                            Appointment appointment = Appointment(
                                date: date,
                                time: time(),
                                state: true,
                                appointmentId: appointmentId,
                                patient: patientExtra,
                                doctor: widget.doctor);

                            Patient _patient = Patient(
                              name: patient.name,
                              patientId: patient.patientId,
                              gender: patient.gender,
                              phoneNumber: patient.phoneNumber,
                              age: patient.age,
                              image: patient.image,
                              appointment: [appointment],
                              patientTest: patient.patientTest,
                            );
                            var patientJson = jsonEncode(_patient);
                            await _appointmentService.insertAppointment(
                                patientJson, patient.patientId);

                            Fluttertoast.showToast(
                                msg: "Your appoinment is booked",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.grey[500],
                                textColor: _colors.white,
                                fontSize: 14);
                            Navigator.pop(context);
                          }
                          Navigator.pop(context);
                        },
                        name: "Confirm"),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
