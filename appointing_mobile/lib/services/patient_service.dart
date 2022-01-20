import 'dart:convert';

import 'package:appointing_mobile/models/patient.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appointing_mobile/constraints/custom_strings.dart';

class PatientService {
  CustomString api = CustomString();
  //post patient Info
  Future insertPatientInfo(
      {String name,
      String age,
      String gender,
      String patientId,
      String phoneNumber}) async {
    Patient patient = Patient(
        patientId: patientId,
        name: name,
        phoneNumber: phoneNumber,
        age: age,
        gender: gender,
        appointment: [],
        patientTest: []);
    var patientJson = jsonEncode(patient);
    print(patientJson);
    Response response = await post("${api.endPoint}/patient",
        body: patientJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post patient";
    }
  }

  // update a patient
  Future updatePatientById(Patient patient, String id) async {
    var patientJson = jsonEncode(patient);
    Response response = await put("${api.endPoint}/patient/$id",
        body: patientJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't update patient";
    }
  }

  // get a patient
  Future<Patient> getPatientById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userUid");
    print("userUid: $id");
    Response response = await get("${api.endPoint}/patient/$id",
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    print('body: [${response.body}]');
    if (response.body.isNotEmpty) {
      dynamic patientObj = jsonDecode(response.body);
      Patient patient = Patient.fromJson(patientObj);
      print(patient);
      return patient;
    } else {
      throw "can't get patient";
    }
  }

  Future insertTest(var patient, String id) async {
    Response response = await put("${api.endPoint}/patientTest/$id",
        body: patient, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post test";
    }
  }

//Update state of Appointment
  Future cancelTest(var patient, String patientId, int testId) async {
    Response response = await put(
        "${api.endPoint}/patientTestStatus/$patientId/$testId",
        body: patient,
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't cancel test";
    }
  }
}
