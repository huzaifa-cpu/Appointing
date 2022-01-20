import 'package:appointing_mobile/models/doctor.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _doctor = [
    Doctor(
        doctorId: null,
        image: null,
        specialization: null,
        fee: null,
        opd: null,
        name: null)
  ];

  List<Doctor> get doctor => _doctor;

  set doctor(List<Doctor> value) {
    _doctor = value;
    notifyListeners();
  }

  //ADD
  void addDoctor(Doctor doctor) {
    _doctor.add(doctor);
    notifyListeners();
  }

  //UPDATE
  void updateDoctor(Doctor doctor, int id) {
    for (var i in _doctor) {
      if (i.doctorId == id) {
        i.doctorId = doctor.doctorId;
        i.name = doctor.name;
        i.specialization = doctor.specialization;
        i.opd = doctor.opd;
        i.image = doctor.image;
        i.fee = doctor.fee;
        notifyListeners();
      }
    }
  }

  //DELETE
  void deleteDoctor(Doctor doctor) {
    for (var i in _doctor) {
      if (i.doctorId == doctor.doctorId) {
        _doctor.remove(doctor);
      }
    }
    notifyListeners();
  }
}
