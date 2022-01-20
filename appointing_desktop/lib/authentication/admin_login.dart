import 'package:appointing_desktop/change_notifier/admin_provider.dart';
import 'package:appointing_desktop/dashboard/dashboard.dart';
import 'package:appointing_desktop/models/admin.dart';
import 'package:appointing_desktop/services/admin_service.dart';
import 'package:appointing_desktop/widgets/custom_admin_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constraints/custom_colors.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  CustomColors _colors = new CustomColors();
  final AdminService adminService = AdminService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool verified;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg3.jpg"), fit: BoxFit.fill)),
          ),
          Consumer<AdminProvider>(
            builder: (context, adminProvider, child) => CustomAdminPanel(
              title: "Admin Login",
              buttonText: "Log In",
              email: email,
              password: password,
              isCancel: false,
              onPressed: () async {
                if (email.text.isEmpty ||
                    password.text.isEmpty ||
                    email.text.length < 4 ||
                    password.text.length < 4) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Username or Password may invalid or empty.")));
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    }
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashBoard()));
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
