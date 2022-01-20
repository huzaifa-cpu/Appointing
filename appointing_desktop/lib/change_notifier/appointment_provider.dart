import 'package:appointing_desktop/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appoint = [
    Appointment(
        appointmentId: null, doctor: null, date: null, time: null, state: false)
  ];

  List<Appointment> get appoint => _appoint;

  set appoint(List<Appointment> value) {
    _appoint = value;
    notifyListeners();
  }

  void updateState(String patientId, int doctorId, bool state) {
    for (var i in _appoint) {
      if (i.appointmentId.patientId == patientId &&
          i.appointmentId.doctorId == doctorId) {
        i.state = state;
        notifyListeners();
      }
    }
  }
}
