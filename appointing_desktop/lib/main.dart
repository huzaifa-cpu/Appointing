import 'package:appointing_desktop/authentication/admin_login.dart';
import 'package:appointing_desktop/change_notifier/admin_provider.dart';
import 'package:appointing_desktop/change_notifier/appointment_provider.dart';
import 'package:appointing_desktop/change_notifier/doctor_provider.dart';
import 'package:appointing_desktop/change_notifier/patient_provider.dart';
import 'package:appointing_desktop/change_notifier/patient_test_provider.dart';
import 'package:appointing_desktop/change_notifier/test_provider.dart';
import 'package:appointing_desktop/models/admin.dart';
import 'package:appointing_desktop/screens/splash.dart';
import 'package:appointing_desktop/services/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:window_size/window_size.dart' as window_size;

import 'constraints/custom_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  window_size.getWindowInfo().then((window) {
    final screen = window.screen;
    if (screen != null) {
      final screenFrame = screen.visibleFrame;
      final width = math.max((screenFrame.width / 2).roundToDouble(), 1300.0);
      final height = math.max((screenFrame.height / 2).roundToDouble(), 700.0);
      final left = ((screenFrame.width - width) / 2).roundToDouble();
      final top = ((screenFrame.height - height) / 3).roundToDouble();
      final frame = Rect.fromLTWH(left, top, width, height);
      window_size.setWindowFrame(frame);
      window_size.setWindowMinSize(Size(0.9 * width, 1.0 * height));
      window_size.setWindowMaxSize(Size(1.5 * width, 1.5 * height));
      window_size.setWindowTitle('Appointing');
    }
  });
  runApp(MaterialApp(
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));

  final AdminService adminService = AdminService();
  List<Admin> admin = await adminService.getAdminList();

  runApp(MyApp(
    admin: admin,
  ));
}

class MyApp extends StatelessWidget {
  List<Admin> admin;
  MyApp({this.admin});
  CustomColors _colors = new CustomColors();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppointmentProvider>(
            create: (context) => AppointmentProvider(),
          ),
          ChangeNotifierProvider<PatientTestProvider>(
            create: (context) => PatientTestProvider(),
          ),
          ChangeNotifierProvider<DoctorProvider>(
            create: (context) => DoctorProvider(),
          ),
          ChangeNotifierProvider<PatientProvider>(
            create: (context) => PatientProvider(),
          ),
          ChangeNotifierProvider<TestProvider>(
            create: (context) => TestProvider(),
          ),
          ChangeNotifierProvider<AdminProvider>(
            create: (context) => AdminProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(primaryColor: _colors.green),
            debugShowCheckedModeBanner: false,
            home: Consumer<AdminProvider>(
              builder: (context, adminProvider, child) {
                adminProvider.admin = admin;
                return AdminLogin();
              },
            )));
  }
}
