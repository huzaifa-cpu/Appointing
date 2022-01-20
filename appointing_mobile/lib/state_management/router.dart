import 'package:appointing_mobile/models/user.dart';
import 'package:appointing_mobile/services/auth_service.dart';
import 'package:appointing_mobile/state_management/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routers extends StatefulWidget {
  @override
  _RoutersState createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthenticatedUser>.value(
        value: AuthService().user, child: Wrapper());
  }
}
