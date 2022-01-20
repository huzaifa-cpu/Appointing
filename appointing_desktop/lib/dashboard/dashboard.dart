import 'package:appointing_desktop/change_notifier/admin_provider.dart';
import 'package:appointing_desktop/change_notifier/appointment_provider.dart';
import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/change_notifier/patient_provider.dart';
import 'package:appointing_desktop/change_notifier/patient_test_provider.dart';
import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/dashboard/doctors_tab/doctors_list.dart';
import 'package:appointing_desktop/dashboard/patients_tab/patients_list.dart';
import 'package:appointing_desktop/dashboard/settings_tab/settings.dart';
import 'package:appointing_desktop/dashboard/tests_tab/tests_list.dart';
import 'package:appointing_desktop/models/admin.dart';
import 'package:appointing_desktop/models/appointment.dart';
import 'package:appointing_desktop/models/booked_test.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:appointing_desktop/models/patient.dart';
import 'package:appointing_desktop/models/test.dart';
import 'package:appointing_desktop/screens/loader.dart';
import 'package:appointing_desktop/services/admin_service.dart';
import 'package:appointing_desktop/services/appointment_service.dart';
import 'package:appointing_desktop/services/book_test_service.dart';
import 'package:appointing_desktop/services/doctor_service.dart';
import 'package:appointing_desktop/services/patient_service.dart';
import 'package:appointing_desktop/services/test_service.dart';
import 'package:appointing_desktop/widgets/custom_admin_panel.dart';
import 'package:appointing_desktop/widgets/custom_dialog.dart';
import 'package:appointing_desktop/widgets/custom_textIcon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointing_desktop/main.dart' as app;

import 'appointments_tab/appointments_list.dart';
import 'booked_tests_tab/booked_tests_list.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final AppointmentService appointmentService = AppointmentService();
  final PatientTestService patientTestService = PatientTestService();
  final PatientService patientService = PatientService();
  final DoctorService doctorService = DoctorService();
  final TestService testService = TestService();
  final AdminService adminService = AdminService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool verified;
  bool b1 = true;
  bool b2 = false;
  bool b3 = false;
  bool b4 = false;
  bool b5 = false;
  bool b6 = false;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: Text(
            "  Main Dashboard",
            style: TextStyle(
              fontFamily: "CenturyGothic",
            ),
          ),
          actions: [
            Row(
              children: [
                RaisedButton.icon(
                  elevation: 0,
                  color: Colors.green[800],
                  label: Text(
                    "Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CenturyGothic",
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Consumer<AdminProvider>(
                            builder: (context, adminProvider, child) =>
                                CustomAdminPanel(
                              title: "Verify yourself!",
                              buttonText: "Verify",
                              email: email,
                              password: password,
                              isCancel: true,
                              onPressed: () async {
                                if (email.text.isEmpty ||
                                    password.text.isEmpty ||
                                    email.text.length < 4 ||
                                    password.text.length < 4) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Username or Password may invalid or empty.")));
                                } else {
                                  List<Admin> admins = adminProvider.admin;
                                  if (admins.isNotEmpty) {
                                    for (var i in admins) {
                                      if (i.email == email.text &&
                                          i.password == password.text) {
                                        verified = true;
                                        break;
                                      }
                                    }
                                    if (verified) {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomAdminPanel(
                                              title: "Registration",
                                              buttonText: "Register",
                                              email: email,
                                              password: password,
                                              isCancel: true,
                                              onPressed: () async {
                                                if (email.text.isEmpty ||
                                                    password.text.isEmpty ||
                                                    email.text.length < 4 ||
                                                    password.text.length < 4) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Username or Password may invalid or empty.")));
                                                } else {
                                                  Admin admin = Admin(
                                                      email: email.text,
                                                      password: password.text);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Loader(
                                                                "Please wait..."),
                                                      ));
                                                  await adminService
                                                      .postAdmin(admin);
                                                  List<Admin> newAdmins =
                                                      await adminService
                                                          .getAdminList();
                                                  adminProvider.admin =
                                                      newAdmins;
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "New Admin created.")));
                                                }
                                                Navigator.pop(context);
                                                email.clear();
                                                password.clear();
                                              },
                                            );
                                          });
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomAdminPanel(
                                            title: "Registration",
                                            buttonText: "Register",
                                            email: email,
                                            password: password,
                                            isCancel: true,
                                            onPressed: () async {
                                              if (email.text.isEmpty ||
                                                  password.text.isEmpty ||
                                                  email.text.length < 4 ||
                                                  password.text.length < 4) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Username or Password may empty.")));
                                              } else {
                                                Admin admin = Admin(
                                                    email: email.text,
                                                    password: password.text);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Loader(
                                                              "Please wait..."),
                                                    ));
                                                await adminService
                                                    .postAdmin(admin);
                                                List<Admin> newAdmins =
                                                    await adminService
                                                        .getAdminList();
                                                adminProvider.admin = newAdmins;
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "New Admin created.")));
                                              }
                                              Navigator.pop(context);
                                              email.clear();
                                              password.clear();
                                            },
                                          );
                                        });
                                  }
                                  email.clear();
                                  password.clear();
                                }
                              },
                            ),
                          );
                        });
                  },
                ),
                RaisedButton.icon(
                  elevation: 0,
                  color: Colors.green[800],
                  label: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CenturyGothic",
                    ),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                            title: "Want to logout?",
                            btn1Text: "Yes",
                            btn2Text: "No",
                            onPressed1: () async {
                              Navigator.pop(context);
                              app.main();
                            },
                            onPressed2: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
        body: Consumer5<AppointmentProvider, PatientTestProvider,
            DoctorProvider, PatientProvider, TestProvider>(
          builder: (context, appointmentProvider, patientTestProvider,
                  doctorProvider, patientProvider, testProvider, child) =>
              FutureBuilder(
                  future: Future.wait([
                    appointmentService.getAppointmentList(),
                    patientTestService.getPatientTestList(),
                    patientService.getPatientList(),
                    doctorService.getDoctorList(),
                    testService.getTestList(),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Appointment> appointmentList = snapshot.data[0];
                      List<PatientTest> patientTestList = snapshot.data[1];
                      List<Patient> patientList = snapshot.data[2];
                      List<Doctor> doctorList = snapshot.data[3];
                      List<Test> testList = snapshot.data[4];
                      //SET PROVIDERS
                      appointmentProvider.appoint = appointmentList;
                      patientTestProvider.test = patientTestList;
                      doctorProvider.doctor = doctorList;
                      testProvider.test = testList;
                      patientProvider.patient = patientList;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: mediaQuery.size.width * .18,
                              color: Color(0xFF1a0033),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextIconButton(
                                      name: "Appointments",
                                      boolCondition: b1,
                                      icon: Icons.playlist_play,
                                      onPressed: () {
                                        setState(() {
                                          appointmentProvider.appoint =
                                              appointmentList;
                                          b1 = true;
                                          b2 = false;
                                          b3 = false;
                                          b4 = false;
                                          b5 = false;
                                          b6 = false;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextIconButton(
                                        onPressed: () {
                                          setState(() {
                                            patientTestProvider.test =
                                                patientTestList;
                                            b1 = false;
                                            b2 = true;
                                            b3 = false;
                                            b4 = false;
                                            b5 = false;
                                            b6 = false;
                                          });
                                        },
                                        icon: Icons.playlist_play,
                                        boolCondition: b2,
                                        name: "Booked Tests"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextIconButton(
                                        onPressed: () {
                                          setState(() {
                                            doctorProvider.doctor = doctorList;
                                            b1 = false;
                                            b2 = false;
                                            b3 = true;
                                            b4 = false;
                                            b5 = false;
                                            b6 = false;
                                          });
                                        },
                                        icon: Icons.person_add,
                                        boolCondition: b3,
                                        name: "Doctors"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextIconButton(
                                        onPressed: () {
                                          setState(() {
                                            testProvider.test = testList;
                                            b1 = false;
                                            b2 = false;
                                            b3 = false;
                                            b4 = true;
                                            b5 = false;
                                            b6 = false;
                                          });
                                        },
                                        icon: Icons.add_business_outlined,
                                        boolCondition: b4,
                                        name: "Tests"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextIconButton(
                                        onPressed: () {
                                          setState(() {
                                            patientProvider.patient =
                                                patientList;
                                            b1 = false;
                                            b2 = false;
                                            b3 = false;
                                            b4 = false;
                                            b5 = true;
                                            b6 = false;
                                          });
                                        },
                                        icon: Icons.person_outline,
                                        boolCondition: b5,
                                        name: "Patients"),
                                    Spacer(),
                                    CustomTextIconButton(
                                      onPressed: () {
                                        setState(() {
                                          b1 = false;
                                          b2 = false;
                                          b3 = false;
                                          b4 = false;
                                          b5 = false;
                                          b6 = true;
                                        });
                                      },
                                      icon: Icons.settings,
                                      boolCondition: b6,
                                      name: "Settings",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: mediaQuery.size.width * .82,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("images/bg1.jpg"),
                                          fit: BoxFit.fill)),
                                ),
                                b6
                                    ? SettingsTab()
                                    : Card(
                                        elevation: 30,
                                        margin: EdgeInsets.all(60),
                                        child: Container(
                                          margin: EdgeInsets.all(40),
                                          color: Colors.white,
                                          width: mediaQuery.size.width * .67,
                                          child: b5
                                              ? PatientsTab()
                                              : b4
                                                  ? TestsTab()
                                                  : b2
                                                      ? BookedTestsTab()
                                                      : b3
                                                          ? DoctorsTab()
                                                          : b1
                                                              ? AppointmentsTab()
                                                              : DoctorsTab(),
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Loader("Please wait..."),
                      );
                    }
                  }),
        ));
  }
}
