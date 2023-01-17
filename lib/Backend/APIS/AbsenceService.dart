import 'dart:convert';
import 'dart:io';

import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ConstantUtil.dart';
import '../Models/UserModel.dart';
import 'package:http/http.dart' as http;

class AbsenceService {
  Future<List<Absence>?> getList(AbsenceRequest absenceRequest) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    LoginRequestModel requestModel = LoginRequestModel(
        url: preferences.getString("url") ?? "",
        username: preferences.getString("username") ?? "",
        password: preferences.getString("password") ?? "");

    List<Absence> absences = [];

    LoginService loginService = LoginService();
    loginService.login(requestModel).then((value) {
      if (value.valid == true) {
        LoggedInUser.setToken(value.token);
      } else {
        LoggedInUser.setToken("");
        absences
            .add(Absence(valid: false, response: ConstantUtil.TOKEN_EXPIRED));
        return absences;
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/hour/list"
        : preferences.getString("url")! + "/rest/api/v1/hour/list";

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(absenceRequest.toJson()),
          headers: <String, String>{
            'authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          });

      switch (response.statusCode) {
        case 200:
          Absence absence = Absence(valid: true);
          absences = absence.getAbsenceList(json.decode(response.body));
          return absences;
        default:
          return absences;
      }
    } on SocketException {
      absences.add(Absence(valid: false, response: ConstantUtil.NO_INTERNET));
      return absences;
    } on FormatException {
      absences.add(Absence(valid: false, response: ConstantUtil.BAD_RESPONSE));
      return absences;
    } on HttpException {
      absences
          .add(Absence(valid: false, response: ConstantUtil.SOMETHING_WRONG));
      return absences;
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
        LoggedInUser.setToken("");
        return Absence(valid: false, response: ConstantUtil.TOKEN_EXPIRED);
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/hour/request"
        : preferences.getString("url")! + "/rest/api/v1/hour/request";

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(absenceRequest.toAskJson()),
          headers: <String, String>{
            'authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          });

      switch (response.statusCode) {
        case 200:
          Absence absence = Absence.fromJson(json.decode(response.body));
          return absence;
        case 400:
          return Absence(valid: false, response: ConstantUtil.BAD_REQUEST);
        case 404:
          return Absence(valid: false, response: ConstantUtil.NOT_FOUND);
        case 408:
          return Absence(valid: false, response: ConstantUtil.REQUEST_TIMEOUT);
        case 500:
          return Absence(
              valid: false, response: ConstantUtil.INTERNAL_SERVER_ERROR);
        case 503:
          return Absence(
              valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE);
        default:
          return Absence(
            valid: false,
            response: ConstantUtil.CHECK_AGAIN,
          );
      }
    } on SocketException {
      return Absence(valid: false, response: ConstantUtil.NO_INTERNET);
    } on FormatException {
      return Absence(valid: false, response: ConstantUtil.BAD_RESPONSE);
    } on HttpException {
      return Absence(valid: false, response: ConstantUtil.SOMETHING_WRONG);
    }
  }
}
