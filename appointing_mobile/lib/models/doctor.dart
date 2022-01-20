// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

Doctor doctorModelFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.doctorId,
    this.name,
    this.fee,
    this.specialization,
    this.opd,
    this.image,
  });

  int doctorId;
  String name;
  String fee;
  String specialization;
  String opd;
  String image;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        doctorId: json["doctorId"],
        name: json["name"],
        fee: json["fee"],
        specialization: json["specialization"],
        opd: json["opd"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "name": name,
        "fee": fee,
        "specialization": specialization,
        "opd": opd,
        "image": image,
      };
}
