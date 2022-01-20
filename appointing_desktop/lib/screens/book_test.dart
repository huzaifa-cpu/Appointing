import 'package:appointing_desktop/change_notifier/patient_test_provider.dart';
import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/booked_test.dart';
import 'package:appointing_desktop/models/booked_test_id.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:appointing_desktop/models/patient_extra.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/book_test_service.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:appointing_desktop/widgets/custom_button.dart';
import 'package:appointing_desktop/widgets/custom_dropdown.dart';
import 'package:appointing_desktop/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookTest extends StatefulWidget {
  bool isAdd;
  PatientTest app;
  PatientExtra patientExtra;
  BookTest({this.isAdd, this.app, this.patientExtra});
  @override
  _BookTestState createState() => _BookTestState();
}

class _BookTestState extends State<BookTest> {
  CustomColors _colors = CustomColors();
  final TestService testService = TestService();
  final _formKey = GlobalKey<FormState>();
  final PatientTestService patientTestService = PatientTestService();
  String time = "10:00-12:00 AM";
  String date;
  String testName;
  double height = 360;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: testService.getTestList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Test> test = snapshot.data;
                List<String> names = [];
                for (var i in test) {
                  names.add(i.name);
                }
                return AlertDialog(
                  content: Container(
                    height: height,
                    child: Column(
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
                          child: Text(
                            "Book Test",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "CenturyGothic",
                                color: _colors.purple),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomDropDown(
                          label: "Test",
                          value: testName,
                          onChanged: (val) {
                            setState(() {
                              testName = val;
                            });
                          },
                          list: names,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDropDown(
                          label: "Time",
                          value: time,
                          onChanged: (val) {
                            setState(() {
                              time = val;
                            });
                          },
                          list: [
                            "10:00-12:00 AM",
                            "12:00-02:00 PM",
                            "02:00-04:00 PM",
                            "04:00-06:00 PM",
                            "06:00-08:00 PM",
                            "08:00-10:00 PM"
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
                          ],
                          labelText: "Date",
                          obscureText: false,
                          hintText: "25-10-2020",
                          initialValue: widget.isAdd ? null : widget.app.date,
                          validation: (val) =>
                              val.isEmpty ? 'Enter date' : null,
                          onChanged: (val) {
                            setState(() {
                              date = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<PatientTestProvider>(
                          builder: (context, patientTestProvider, child) =>
                              CustomButton(
                            text: "Book",
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Loader("Booking...")));
                                if (widget.isAdd) {
                                  int testId;
                                  for (var i in test) {
                                    if (i.name == testName) {
                                      testId = i.testId;
                                    }
                                  }
                                  Test tes = await testService.getTest(testId);
                                  print("selected value ${testName}");
                                  print(testId);
                                  PatientTestId id = PatientTestId(
                                    testId: tes.testId,
                                    patientId: widget.patientExtra.patientId,
                                  );
                                  PatientTest patientTest = PatientTest(
                                      patientTestId: id,
                                      test: tes,
                                      date: date,
                                      time: time,
                                      patient: widget.patientExtra,
                                      state: true);
                                  Patient pat = Patient(
                                    image: null,
                                    patientId: widget.patientExtra.patientId,
                                    name: widget.patientExtra.name,
                                    age: widget.patientExtra.age,
                                    gender: widget.patientExtra.gender,
                                    phoneNumber:
                                        widget.patientExtra.phoneNumber,
                                    patientTest: [patientTest],
                                    appointment: [],
                                  );
                                  await patientTestService.postPatientTest(pat);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content:
                                  //             Text("Test has been booked")));
                                } else {
                                  PatientTest patientTest = PatientTest(
                                      patientTestId: widget.app.patientTestId,
                                      test: widget.app.test,
                                      date: date ?? widget.app.date,
                                      time: time ?? widget.app.time,
                                      patient: widget.app.patient,
                                      state: true);
                                  await patientTestService.cancelPatientTest(
                                      patientTest,
                                      widget.app.patientTestId.patientId,
                                      widget.app.patientTestId.testId);
                                  Navigator.pop(context);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             "Booked test has been rescheduled")));
                                }
                                List<PatientTest> patientTestList =
                                    await patientTestService
                                        .getPatientTestList();
                                patientTestProvider.test = patientTestList;
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  height = 380;
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Loader("Please wait..."),
                );
              }
            }),
      ),
    );
  }
}
