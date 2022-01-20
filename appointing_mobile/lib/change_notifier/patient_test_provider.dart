import 'package:appointing_mobile/models/patient_test.dart';
import 'package:flutter/material.dart';

class PatientTestProvider extends ChangeNotifier {
  List<PatientTest> _test = [
    PatientTest(
        patientTestId: null,
        time: null,
        date: null,
        state: false,
        patient: null)
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

  bool checkIfTestIsBooked(String pId, int dId) {
    for (var singleAppointment in _test) {
      if (singleAppointment.patientTestId.testId == dId &&
          singleAppointment.patientTestId.patientId == pId) {
        return true;
      }
    }
    return false;
  }

  void updateState(String pId, int dId, bool state) {
    for (var singleTest in _test) {
      if (singleTest.patientTestId.testId == dId &&
          singleTest.patientTestId.patientId == pId) {
        singleTest.state = state;
      }
    }
  }
}
