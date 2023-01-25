import 'dart:convert';
import 'dart:io';

import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/ConstantUtil.dart';
import '../Models/HourType.dart';
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

  Future<double> getScheduledHours(AbsenceRequest absenceRequest) async {
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
        ? preferences.getString("url")! + "rest/api/v1/hour/getScheduledHours"
        : preferences.getString("url")! + "/rest/api/v1/hour/getScheduledHours";

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
          return double.parse(json.decode(response.body).toString());
        case 400:
          return -1;
        case 404:
          return -1;
        case 408:
          return -1;
        case 500:
          return -1;
        case 503:
          return -1;
        default:
          return -1;
      }
    } on SocketException {
      return -1;
    } on FormatException {
      return -1;
    } on HttpException {
      return -1;
    }
  }

  Future<List<HourType>> listHourTypes() async {
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

    List<HourType> types = [];

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/hour/listHourTypes"
        : preferences.getString("url")! + "/rest/api/v1/hour/listHourTypes";

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          });

      switch (response.statusCode) {
        case 200:
          HourType type = HourType(valid: true);
          types = type.getTypesList(json.decode(response.body));
          return types;
        case 400:
          types.add(HourType(valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE));
          return types;

        case 404:
          types.add(HourType(valid: false, response: ConstantUtil.NOT_FOUND));
          return types;

        case 408:
          types.add(HourType(valid: false, response: ConstantUtil.REQUEST_TIMEOUT));
          return types;

        case 500:
          types.add(HourType(valid: false, response: ConstantUtil.INTERNAL_SERVER_ERROR));
          return types;

        case 503:
          types.add(HourType(valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE));
          return types;

        default:
          types.add(HourType(valid: false, response: ConstantUtil.CHECK_AGAIN));
          return types;

      }
    } on SocketException {
      types.add(HourType(valid: false, response: ConstantUtil.NO_INTERNET));
      return types;
    } on FormatException {
      types.add(HourType(valid: false, response: ConstantUtil.BAD_RESPONSE));
      return types;
    } on HttpException {
      types
          .add(HourType(valid: false, response: ConstantUtil.SOMETHING_WRONG));
      return types;
    }
  }
}
