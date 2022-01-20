import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/user.dart';
import 'package:appointing_mobile/services/auth_service.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neumorphic/neumorphic.dart';

import '../widgets/custom_button.dart';
import '../state_management/router.dart';
import 'loader.dart';

class PersonInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonInfoScreenState();
  }
}

class PersonInfoScreenState extends State<PersonInfo> {
  String name = "";
  String age = "";
  String gender = 'Male';
  String phoneNumber = "";
  CustomColors _colors = CustomColors();
  PatientService patientService = PatientService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticatedUser>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AuthenticatedUser data = snapshot.data;
            return Form(
              key: _formKey,
              child: Scaffold(
                  backgroundColor: _colors.colorTheme,
                  resizeToAvoidBottomInset: false,
                  body: ListView(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Person info',
                                style: TextStyle(
                                    color: _colors.white,
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                'Name',
                                style: TextStyle(
                                    color: _colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                type: TextInputType.name,
                                hint: "eg. Xyz",
                                obscureText: false,
                                validate: (val) => val.isEmpty ? '' : null,
                                onchanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Age',
                                style: TextStyle(
                                    color: _colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                  type: TextInputType.number,
                                  obscureText: false,
                                  hint: "eg. 24",
                                  validate: (String val) {
                                    if (val.isEmpty ||
                                        val.length > 2 ||
                                        val.length < 0) {
                                      return '';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onchanged: (val) {
                                    setState(() {
                                      age = val;
                                    });
                                  }),
                              SizedBox(
                                height: 17.0,
                              ),
                              Text(
                                'Phone number',
                                style: TextStyle(
                                    color: _colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                  type: TextInputType.number,
                                  hint: "eg. 03333333333",
                                  validate: (String val) {
                                    if (val.isEmpty ||
                                        val.length > 11 ||
                                        val.length < 11) {
                                      return '';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: false,
                                  onchanged: (val) {
                                    setState(() {
                                      phoneNumber = val;
                                    });
                                  }),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'Gender',
                                style: TextStyle(
                                    color: _colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 0.0),
                                child: NeuCard(
                                  margin: EdgeInsets.only(
                                      top: 5.0,
                                      left: 13.0,
                                      right: 5.0,
                                      bottom: 30.0),
                                  curveType: CurveType.emboss,
                                  height: 50.0,
                                  width: 120.0,
                                  bevel: 12,
                                  decoration: NeumorphicDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: _colors.colorTheme,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 25.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: gender,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: _colors.grey),
                                        onChanged: (String val) {
                                          setState(() {
                                            gender = val;
                                          });
                                        },
                                        items: <String>[
                                          'Male',
                                          'Female',
                                          'Other'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomButton(
                                name: "Continue",
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Loader("Please wait...")));
                                    //POST patient info
                                    await patientService.insertPatientInfo(
                                        name: name,
                                        age: age,
                                        gender: gender,
                                        phoneNumber: phoneNumber,
                                        patientId: data.uid);
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Routers()));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Data may invalid or empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.grey[500],
                                        textColor: _colors.white,
                                        fontSize: 14);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              )
                            ],
                          )),
                    ],
                  )),
            );
          }
          return Loader("Please wait...");
        });
  }
}
