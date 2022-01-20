import 'package:appointing_desktop/models/appointment.dart';
import 'package:appointing_desktop/models/booked_test.dart';

class Patient {
  Patient(
      {this.patientId,
      this.name,
      this.age,
      this.gender,
      this.image,
      this.patientTest,
      this.appointment,
      this.phoneNumber});

  String patientId;
  String image;
  String name;
  String age;
  String gender;
  String phoneNumber;
  List<PatientTest> patientTest;
  List<Appointment> appointment;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        patientId: json["patientId"],
        name: json["name"],
        age: json["age"],
        image: json["image"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        patientTest: List<PatientTest>.from(
            json["patientTest"].map((x) => PatientTest.fromJson(x))),
        appointment: List<Appointment>.from(
            json["appointment"].map((x) => Appointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "name": name,
        "age": age,
        "gender": gender,
        "image": image,
        "phoneNumber": phoneNumber,
        "patientTest": List<dynamic>.from(patientTest.map((x) => x.toJson())),
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
      };
}
