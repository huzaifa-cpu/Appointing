import 'package:appointing_desktop/models/patient.dart';
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {
  List<Patient> _patient = [
    Patient(
      patientId: null,
      image: null,
      phoneNumber: null,
      age: null,
      gender: null,
      name: null,
      appointment: null,
      patientTest: null,
    )
  ];

  List<Patient> get patient => _patient;

  set patient(List<Patient> value) {
    _patient = value;
    notifyListeners();
  }

  //DELETE
  void deletePatient(Patient patient, String id) {
    for (var i in _patient) {
      if (i.patientId == id) {
        _patient.remove(patient);
        notifyListeners();
      }
    }
  }
}
