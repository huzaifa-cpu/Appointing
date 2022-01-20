import 'dart:convert';

import 'package:http/http.dart';
import 'package:appointing_mobile/constraints/custom_strings.dart';

import '../models/doctor.dart';

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
}
