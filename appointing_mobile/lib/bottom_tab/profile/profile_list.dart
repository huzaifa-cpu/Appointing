import 'dart:convert';

import 'package:appointing_mobile/bottom_tab/profile/test_history.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/services/auth_service.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/widgets/custom_alert_dialog.dart';
import 'package:appointing_mobile/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appointment_history.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String base64Image; //(Save that String in AVATAR field of API)

  Future _openGallery(
      BuildContext context, Patient patient, ProfileProvider prov) async {
    var image2 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    List<int> imageBytes = image2.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    print('string is');
    print(base64Image);
    Patient patientObj = Patient(
        patientId: patient.patientId,
        name: patient.name,
        age: patient.age,
        gender: patient.gender,
        image: base64Image ?? patient.image,
        phoneNumber: patient.phoneNumber,
        appointment: patient.appointment,
        patientTest: patient.patientTest);
    Fluttertoast.showToast(
        msg: "Profile updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey[500],
        textColor: Colors.white,
        fontSize: 14);
    prov.updateImage(
      base64Image ?? patient.image,
    );
    await patientService.updatePatientById(patientObj, patient.patientId);
    // Patient _patient = await patientService.getPatientById();
    // prov.patient = _patient;
  }

  PatientService patientService = new PatientService();
  String name;
  String number;
  String age;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  CustomColors _colors = CustomColors();
  @override
  Widget build(BuildContext context) {
    void editProfile(Patient patient) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) => CustomBottomSheet(
                  initialValue1: patient.name,
                  initialValue2: patient.phoneNumber,
                  initialValue3: patient.age,
                  onChanged1: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  onChanged2: (val) {
                    setState(() {
                      number = val;
                    });
                  },
                  onChanged3: (val) {
                    setState(() {
                      age = val;
                    });
                  },
                  validation1: (val) => val.isEmpty ? '' : null,
                  validation2: (String val) {
                    if (val.isEmpty || val.length > 11 || val.length < 11) {
                      return '';
                    } else {
                      return null;
                    }
                  },
                  validation3: (String val) {
                    if (val.isEmpty || val.length > 2 || val.length < 0) {
                      return '';
                    } else {
                      return null;
                    }
                  },
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onpressed2: () async {
                    if (_formKey.currentState.validate()) {
                      Patient patientObj = new Patient(
                          patientId: patient.patientId,
                          name: name ?? patient.name,
                          age: age ?? patient.age,
                          phoneNumber: number ?? patient.phoneNumber,
                          patientTest: patient.patientTest,
                          appointment: patient.appointment,
                          gender: patient.gender,
                          image: patient.image);

                      profileProvider.updateName(
                        name ?? patient.name,
                      );
                      profileProvider.updatePhone(
                        number ?? patient.phoneNumber,
                      );
                      profileProvider.updateAge(
                        age ?? patient.age,
                      );
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Profile updated",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.grey[500],
                          textColor: Colors.white,
                          fontSize: 14);
                      await patientService.updatePatientById(
                          patientObj, patient.patientId);

                      // Patient _patient = await patientService.getPatientById();
                      // profileProvider.patient = _patient;
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
              ),
            );
          });
    }

    return Scaffold(
        backgroundColor: _colors.colorTheme,
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(fontSize: 22.0, color: _colors.white),
          ),
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: _colors.colorTheme,
        ),
        body: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openGallery(
                            context, profileProvider.patient, profileProvider);
                      },
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
                                    image: profileProvider.patient.image == null
                                        ? AssetImage(
                                            "lib/images/profile_image.jpg")
                                        : MemoryImage(Base64Decoder().convert(
                                            profileProvider.patient.image)),
                                    fit: BoxFit.fill)),
                          )),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Text(
                          profileProvider.patient.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _colors.white,
                            fontSize: 19.0,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Text(
                          "Age:${profileProvider.patient.age}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _colors.white,
                            fontSize: 15.0,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Text(
                          profileProvider.patient.phoneNumber,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: _colors.white,
                              fontSize: 15.0),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              "History",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _colors.white,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                        NeuCard(
                            margin: EdgeInsets.only(
                                top: 20.0, left: 0.0, right: 0.0),
                            curveType: CurveType.flat,
                            bevel: 12,
                            decoration: NeumorphicDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _colors.colorTheme,
                            ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Column(children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.history,
                                          color: _colors.grey,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentHistory(
                                                            profileProvider
                                                                .patient
                                                                .appointment)));
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.0, top: 3.0),
                                              child: Text(
                                                'Appointment History',
                                                style: TextStyle(
                                                    color: _colors.white,
                                                    fontSize: 15.0),
                                              )),
                                        ),
                                      ]),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, right: 10.0),
                                    child: Container(
                                      height: 0.5,
                                      width: 250.0,
                                      color: _colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: _colors.grey,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TestHistory(
                                                              profileProvider
                                                                  .patient
                                                                  .patientTest)));
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15.0, top: 3.0),
                                                child: Text(
                                                  'Test History',
                                                  style: TextStyle(
                                                      color: _colors.white,
                                                      fontSize: 15.0),
                                                )),
                                          ),
                                        ]),
                                  )
                                ]))),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Others",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _colors.white,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 0.0),
                            child: NeuCard(
                                margin: EdgeInsets.only(
                                    top: 20.0, left: 0.0, right: 0.0),
                                curveType: CurveType.flat,
                                bevel: 12,
                                decoration: NeumorphicDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: _colors.colorTheme,
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(children: [
                                      GestureDetector(
                                        onTap: () {
                                          editProfile(profileProvider.patient);
                                        },
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: _colors.grey,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0, top: 3.0),
                                                  child: Text(
                                                    'Edit Profile',
                                                    style: TextStyle(
                                                        color: _colors.white,
                                                        fontSize: 15.0),
                                                  )),
                                            ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, right: 10.0),
                                        child: Container(
                                          height: 0.5,
                                          width: 250.0,
                                          color: _colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomAlertDialog(
                                                    title: "Want to logout?",
                                                    btn1Text: "Yes",
                                                    btn2Text: "No",
                                                    onPressed1: () async {
                                                      await _auth.signOut();
                                                      final SharedPreferences
                                                          prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          "userUid", null);
                                                      Navigator.pop(context);
                                                    },
                                                    onPressed2: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                });
                                          },
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: _colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0, top: 3.0),
                                                  child: Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                        color: _colors.white,
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ])))),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
