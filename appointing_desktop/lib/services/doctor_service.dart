import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/doctor.dart';
import 'package:http/http.dart';

class DoctorService {
  CustomString api = CustomString();

  // GET - Doctor List
  Future<List<Doctor>> getDoctorList() async {
    Response response = await get('${api.endPoint}/doctor',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Doctor> doctors =
          body.map((dynamic item) => Doctor.fromJson(item)).toList();
      print(doctors);
      return doctors;
    } else {
      throw "Can't get List";
    }
  }

  // GET - Doctor
  Future<Doctor> getDoctor(int id) async {
    Response response = await get('${api.endPoint}/doctor/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      print(body);
      Doctor doctor = Doctor.fromJson(body);
      print(doctor);
      return doctor;
    } else {
      throw "Can't get doctor";
    }
  }

  // Post - Doctor
  Future postDoctor(Doctor doctor) async {
    var doctorJson = jsonEncode(doctor);
    Response response = await post('${api.endPoint}/doctor',
        body: doctorJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't post";
    }
  }

  // Put - Doctor
  Future putDoctor(Doctor doctor, int id) async {
    var doctorJson = jsonEncode(doctor);
    Response response = await put('${api.endPoint}/doctor/$id',
        body: doctorJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't put";
    }
  }

  // delete - Doctor
  Future deleteDoctor(int id) async {
    Response response = await delete('${api.endPoint}/doctor/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't delete";
    }
  }
}
