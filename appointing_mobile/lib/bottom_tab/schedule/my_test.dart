import 'dart:convert';

import 'package:appointing_mobile/change_notifier/patient_test_provider.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/models/patient_extra.dart';
import 'package:appointing_mobile/models/patient_test.dart';
import 'package:appointing_mobile/models/patient_test_id.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/widgets/custom_square_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_alert_dialog.dart';

class MyTest extends StatefulWidget {
  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  CustomColors _colors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _colors.colorTheme,
      body: Consumer<PatientTestProvider>(
        builder: (context, testProvider, child) {
          List<PatientTest> appointwithState = testProvider.test;
          List<PatientTest> tests = [];
          for (var i in appointwithState) {
            if (i.state == true) {
              tests.add(i);
            }
          }
          return tests.length == 0
              ? Center(
                  child: Text("No tests yet",
                      style: TextStyle(
                          color: _colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                )
              : ListView.builder(
                  itemCount: tests.length,
                  itemBuilder: (context, i) {
                    return PatientTestCard(patientTest: tests[i], index: i);
                  });
        },
      ),
    );
  }
}

class PatientTestCard extends StatelessWidget {
  CustomColors _colors = CustomColors();
  PatientTest patientTest;

  int index;
  PatientTestCard({this.patientTest, this.index});
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
                    patientTest.date,
                    style: TextStyle(color: _colors.white, fontSize: 16),
                  ),
                  Text("Rs: ${patientTest.test.fee}",
                      style: TextStyle(
                          color: _colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Text(patientTest.time,
                  style: TextStyle(
                      color: _colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(patientTest.test.name,
                      style: TextStyle(
                        color: _colors.white,
                        fontSize: 14,
                      )),
                  Consumer2<PatientTestProvider, ProfileProvider>(
                      builder: (context, testProvider, profileProvider, child) {
                    return CustomSquareButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                title: "Cancel test?",
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
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String userUid = prefs.getString("userUid");
                                  PatientTestId testId = PatientTestId(
                                      patientId: userUid,
                                      testId: patientTest.test.testId);
                                  PatientTest tests = PatientTest(
                                      patientTestId: testId,
                                      test: patientTest.test,
                                      patient: patientExtra,
                                      date: patientTest.date,
                                      time: patientTest.time,
                                      state: false);

                                  var testJson = jsonEncode(tests);
                                  print(testJson);
                                  testProvider.updateState(
                                      userUid, patientTest.test.testId, false);
                                  await patientService.cancelTest(testJson,
                                      userUid, patientTest.test.testId);
                                  Patient patients =
                                      await patientService.getPatientById();
                                  testProvider.test = patients.patientTest;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "Your test is cancelled",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey[500],
                                      textColor: Colors.white,
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
