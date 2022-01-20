import 'dart:convert';

import 'package:appointing_mobile/change_notifier/patient_test_provider.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/models/patient_extra.dart';
import 'package:appointing_mobile/models/patient_test.dart';
import 'package:appointing_mobile/models/patient_test_id.dart';
import 'package:appointing_mobile/models/test.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/services/patient_test_service.dart';
import 'package:appointing_mobile/services/test_service.dart';
import 'package:appointing_mobile/widgets/custom_button.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTest extends StatefulWidget {
  Test test;
  BookTest({this.test});
  @override
  _BookTestState createState() => _BookTestState();
}

class _BookTestState extends State<BookTest> {
  TestService _testService = new TestService();
  CustomColors _colors = new CustomColors();
  DatePickerController _controller = DatePickerController();
  PatientService patientService = new PatientService();
  PatientTestService patientTestService = new PatientTestService();
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
          height: scaffoldHeigth * 1,
          color: _colors.colorTheme,
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
              Consumer2<PatientTestProvider, ProfileProvider>(
                builder: (context, patientTestProvider, patientProvider,
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
                          String date =
                              "${_selectedValue.day.toString()}-${_selectedValue.month.toString()}-${_selectedValue.year.toString()}";
                          //CHECK if EXIST
                          bool existedtest =
                              patientTestProvider.checkIfTestIsBooked(
                                  patient.patientId, widget.test.testId);

                          if (existedtest) {
                            //UserID
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String userUid = prefs.getString("userUid");
                            //AppointmentBody
                            PatientTestId testId = PatientTestId(
                                patientId: userUid, testId: widget.test.testId);
                            PatientTest appointments = PatientTest(
                                patientTestId: testId,
                                test: widget.test,
                                date: date,
                                time: time(),
                                patient: patientExtra,
                                state: true);
                            var appointmentJson = jsonEncode(appointments);
                            print(appointmentJson);
                            //ReNew
                            await patientTestService.cancelAppointment(
                                appointmentJson, userUid, widget.test.testId);
                            //Real-Time update
                            Patient _patient =
                                await patientService.getPatientById();
                            patientTestProvider.test = _patient.patientTest;
                            //message
                            Fluttertoast.showToast(
                                msg: "Your test is rescheduled",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.grey[500],
                                textColor: _colors.white,
                                fontSize: 14);
                            Navigator.pop(context);
                          } else {
                            PatientTestId testId = PatientTestId(
                                patientId: patient.patientId,
                                testId: widget.test.testId);
                            PatientTest patienttest = PatientTest(
                                state: true,
                                date: date,
                                patient: patientExtra,
                                time: time(),
                                patientTestId: testId,
                                test: widget.test);

                            Patient _patient = Patient(
                              name: patient.name,
                              patientId: patient.patientId,
                              gender: patient.gender,
                              phoneNumber: patient.phoneNumber,
                              age: patient.age,
                              image: patient.image,
                              appointment: patient.appointment,
                              patientTest: [patienttest],
                            );
                            var patientJson = jsonEncode(_patient);
                            await patientTestService.insertTest(
                                patientJson, patient.patientId);
                            Fluttertoast.showToast(
                                msg: "Your test is booked",
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
