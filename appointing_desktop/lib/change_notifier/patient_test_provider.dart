import 'package:appointing_desktop/models/booked_test.dart';
import 'package:flutter/material.dart';

class PatientTestProvider extends ChangeNotifier {
  List<PatientTest> _test = [
    PatientTest(patientTestId: null, time: null, date: null, state: false)
  ];

  List<PatientTest> get test => _test;

  set test(List<PatientTest> value) {
    _test = value;
    notifyListeners();
  }

  Future updateStatus(int index, bool state) async {
    _test[index].state = state;
    notifyListeners();
  }
}
