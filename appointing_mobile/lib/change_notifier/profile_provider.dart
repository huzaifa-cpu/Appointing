import 'package:appointing_mobile/models/patient.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  Patient _patient = Patient(
    patientId: "",
    name: "",
    age: "",
    gender: "",
    phoneNumber: "",
    patientTest: [],
    appointment: [],
  );

  Patient get patient => _patient;

  set patient(Patient value) {
    _patient = value;
    notifyListeners();
  }

  void updateName(String name) {
    _patient.name = name;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _patient.phoneNumber = phone;
    notifyListeners();
  }

  void updateAge(String age) {
    _patient.age = age;
    notifyListeners();
  }

  void updateImage(String image) {
    _patient.image = image;
    notifyListeners();
  }
}
