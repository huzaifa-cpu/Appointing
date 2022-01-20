import 'package:appointing_desktop/constraints/custom_colors.dart';
import 'package:appointing_desktop/models/patient_extra.dart';
import 'package:appointing_desktop/screens/book_appointment.dart';
import 'package:appointing_desktop/screens/book_test.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/widgets/custom_button.dart';
import 'package:appointing_desktop/widgets/custom_dropdown.dart';
import 'package:appointing_desktop/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePatient extends StatefulWidget {
  bool isTest;
  CreatePatient({this.isTest});
  @override
  _CreatePatientState createState() => _CreatePatientState();
}

class _CreatePatientState extends State<CreatePatient> {
  CustomColors _colors = CustomColors();
  final DoctorService doctorService = DoctorService();
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';
  String name;
  String age;
  String phone;
  double height = 430;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          content: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Column(children: [
                  Center(
                    child: Text(
                      "Create Patient",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: _colors.purple),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]+|\s')),
                      ],
                      labelText: "Name",
                      obscureText: false,
                      validation: (val) => val.isEmpty ? 'Enter name' : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      labelText: "Age",
                      obscureText: false,
                      validation: (val) => val.isEmpty ? 'Enter age' : null,
                      onChanged: (val) {
                        setState(() {
                          age = val;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropDown(
                    value: gender,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                    list: ['Male', 'Female'],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      labelText: "Phone no",
                      obscureText: false,
                      validation: (val) =>
                          val.isEmpty ? 'Enter phone no' : null,
                      onChanged: (val) {
                        setState(() {
                          phone = val;
                        });
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: "Add",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        PatientExtra patientExtra = PatientExtra(
                          image: null,
                          patientId: (phone + age).toString(),
                          name: name,
                          age: age,
                          gender: gender,
                          phoneNumber: phone,
                        );
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return widget.isTest
                                  ? BookTest(
                                      patientExtra: patientExtra,
                                      isAdd: true,
                                    )
                                  : BookAppointment(
                                      patientExtra: patientExtra,
                                      isAdd: true,
                                    );
                            });
                      } else {
                        setState(() {
                          height = 550;
                        });
                      }
                    },
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
