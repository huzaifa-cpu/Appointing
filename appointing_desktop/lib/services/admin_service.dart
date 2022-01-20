import 'dart:convert';

import 'package:appointing_desktop/constraints/custom_strings.dart';
import 'package:appointing_desktop/models/admin.dart';
import 'package:http/http.dart';

class AdminService {
  CustomString api = CustomString();

  // GET- Admin List
  Future<List<Admin>> getAdminList() async {
    Response response = await get('${api.endPoint}/admin',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Admin> admin =
          body.map((dynamic item) => Admin.fromJson(item)).toList();
      print(admin);
      return admin;
    } else {
      return null;
    }
  }

  // GET - Admin
  Future<Admin> getAdmin(int id) async {
    Response response = await get('${api.endPoint}/admin/$id',
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      print(body);
      Admin admin = Admin.fromJson(body);
      print(admin);
      return admin;
    } else {
      throw "Can't get Admin";
    }
  }

  // Post - Admin
  Future postAdmin(Admin admin) async {
    var adminJson = jsonEncode(admin);
    Response response = await post('${api.endPoint}/admin',
        body: adminJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "Can't post";
    }
  }
}
