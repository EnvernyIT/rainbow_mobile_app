import 'dart:convert';

import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserModel.dart';
import 'package:http/http.dart' as http;

class AbsenceService {
  Future<List<Absence>?> getList(AbsenceRequest absenceRequest) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    LoginRequestModel requestModel = LoginRequestModel(
        url: preferences.getString("url") ?? "",
        username: preferences.getString("username") ?? "",
        password: preferences.getString("password") ?? "");

    LoginService loginService = LoginService();
    loginService.login(requestModel).then((value) {
      if (value.valid == true) {
        LoggedInUser.setToken(value.token);
      } else {
        throw Exception("The token is not valid anymore!");
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;

    final response = await http.post(Uri.parse(absenceRequest.urlList),
        body: jsonEncode(absenceRequest.toJson()),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      Absence absence = Absence();
      List<Absence> absences =
          absence.getAbsenceList(json.decode(response.body));
      return absences;
    } else {
      throw Exception("Failed to absence list load data!");
    }
  }

  Future<Absence>? request(AbsenceRequest absenceRequest) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    LoginRequestModel requestModel = LoginRequestModel(
        url: preferences.getString("url") ?? "",
        username: preferences.getString("username") ?? "",
        password: preferences.getString("password") ?? "");

    LoginService loginService = LoginService();
    loginService.login(requestModel).then((value) {
      if (value.valid == true) {
        LoggedInUser.setToken(value.token);
      } else {
        throw Exception("The token is not valid anymore!");
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;

    final response = await http.post(Uri.parse(absenceRequest.urlRequest),
        body: jsonEncode(absenceRequest.toAskJson()),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      Absence absence = Absence.fromJson(json.decode(response.body));
      return absence;
    } else {
      throw Exception("Failed to send an absence request!");
    }
  }
}
