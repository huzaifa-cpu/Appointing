import 'package:appointing_mobile/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appoint = [
    Appointment(
        appointmentId: null,
        doctor: null,
        date: null,
        time: null,
        state: false,
        patient: null)
  ];

  List<Appointment> get appoint => _appoint;

  set appoint(List<Appointment> value) {
    _appoint = value;
    notifyListeners();
  }

  bool checkIfAppointmentIsBooked(String pId, int dId) {
    for (var singleAppointment in _appoint) {
      if (singleAppointment.appointmentId.doctorId == dId &&
          singleAppointment.appointmentId.patientId == pId) {
        return true;
      }
    }
    return false;
  }

  void updateState(String pId, int dId, bool state) {
    for (var singleAppointment in _appoint) {
      if (singleAppointment.appointmentId.doctorId == dId &&
          singleAppointment.appointmentId.patientId == pId) {
        singleAppointment.state = state;
      }
    }
  }
}
