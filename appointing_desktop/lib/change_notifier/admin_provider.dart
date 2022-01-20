import 'package:appointing_desktop/models/admin.dart';
import 'package:flutter/cupertino.dart';

class AdminProvider extends ChangeNotifier {
  List<Admin> _admin = [
    Admin(
      id: null,
      email: null,
      password: null,
    )
  ];

  List<Admin> get admin => _admin;

  set admin(List<Admin> value) {
    _admin = value;
    notifyListeners();
  }

  void addAdmin(Admin value) {
    _admin.add(value);
    notifyListeners();
  }
}
