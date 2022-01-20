import 'package:appointing_mobile/bottom_tab/profile/profile_list.dart';
import 'package:appointing_mobile/bottom_tab/schedule/schedule.dart';
import 'package:appointing_mobile/bottom_tab/test/test_list.dart';
import 'package:appointing_mobile/change_notifier/appointment_provider.dart';
import 'package:appointing_mobile/change_notifier/doctor_provider.dart';
import 'package:appointing_mobile/change_notifier/patient_test_provider.dart';
import 'package:appointing_mobile/change_notifier/profile_provider.dart';
import 'package:appointing_mobile/change_notifier/test_provider.dart';
import 'package:appointing_mobile/constraints/custom_colors.dart';
import 'package:appointing_mobile/models/appointment.dart';
import 'package:appointing_mobile/models/doctor.dart';
import 'package:appointing_mobile/models/patient.dart';
import 'package:appointing_mobile/models/patient_test.dart';
import 'package:appointing_mobile/models/test.dart';
import 'package:appointing_mobile/screens/loader.dart';
import 'package:appointing_mobile/services/doctor_service.dart';
import 'package:appointing_mobile/services/patient_service.dart';
import 'package:appointing_mobile/services/test_service.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

import 'doctor/doctor_list.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  CustomColors _colors = new CustomColors();
  PatientService patientService = PatientService();
  DoctorService doctorService = DoctorService();
  TestService testService = TestService();

  bool test = false;
  bool profile = false;
  bool doctor = true;
  bool schedule = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _colors.colorTheme,
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: _colors.colorTheme,
          child: Consumer5<DoctorProvider, AppointmentProvider,
              PatientTestProvider, ProfileProvider, TestProvider>(
            builder: (context,
                    doctorProvider,
                    appointmentProvider,
                    patientTestProvider,
                    profileProvider,
                    testProvider,
                    child) =>
                FutureBuilder(
                    future: Future.wait([
                      doctorService.getDoctorList(),
                      patientService.getPatientById(),
                      testService.getTestList()
                    ]),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        List<Doctor> doctorList = snapshots.data[0];
                        Patient patient = snapshots.data[1];
                        List<Test> testList = snapshots.data[2];
                        List<Appointment> appointmentList = patient.appointment;
                        List<PatientTest> patientTestList = patient.patientTest;

                        //SET PROVIDER
                        doctorProvider.doctor = doctorList;
                        appointmentProvider.appoint = appointmentList;
                        patientTestProvider.test = patientTestList;
                        testProvider.test = testList;
                        profileProvider.patient = patient;

                        return Container(
                          alignment: Alignment.center,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              NeuCard(
                                width: 55,
                                height: 55,
                                bevel: 12,
                                curveType: CurveType.flat,
                                color: _colors.colorTheme,
                                decoration: NeumorphicDecoration(
                                    color: _colors.colorTheme,
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.person_add,
                                    color:
                                        doctor ? _colors.grey : _colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      doctorProvider.doctor = doctorList;
                                      doctor = true;
                                      test = false;
                                      profile = false;
                                      schedule = false;
                                    });
                                  },
                                ),
                              ),
                              NeuCard(
                                width: 55,
                                height: 55,
                                bevel: 12,
                                curveType: CurveType.flat,
                                decoration: NeumorphicDecoration(
                                    color: _colors.colorTheme,
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.list,
                                    color: test ? _colors.grey : _colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      testProvider.test = testList;
                                      doctor = false;
                                      test = true;
                                      profile = false;
                                      schedule = false;
                                    });
                                  },
                                ),
                              ),
                              NeuCard(
                                width: 55,
                                height: 55,
                                bevel: 12,
                                curveType: CurveType.flat,
                                color: _colors.colorTheme,
                                decoration: NeumorphicDecoration(
                                    color: _colors.colorTheme,
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.playlist_add_check,
                                    color:
                                        schedule ? _colors.grey : _colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      appointmentProvider.appoint =
                                          appointmentList;
                                      patientTestProvider.test =
                                          patientTestList;
                                      doctor = false;
                                      test = false;
                                      profile = false;
                                      schedule = true;
                                    });
                                  },
                                ),
                              ),
                              NeuCard(
                                width: 55,
                                height: 55,
                                bevel: 12,
                                curveType: CurveType.flat,
                                color: _colors.colorTheme,
                                decoration: NeumorphicDecoration(
                                    color: _colors.colorTheme,
                                    borderRadius: BorderRadius.circular(15)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.person,
                                    color:
                                        profile ? _colors.grey : _colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      profileProvider.patient = patient;
                                      doctor = false;
                                      test = false;
                                      profile = true;
                                      schedule = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Loader("Please wait...");
                    }),
          )),
      body: doctor
          ? DoctorList()
          : test
              ? TestList()
              : schedule
                  ? Schedule()
                  : Profile(),
    );
  }
}
