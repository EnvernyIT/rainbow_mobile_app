import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Constants/ConstantUtil.dart';
import 'package:rainbow_app/Backend/Models/Employee.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserModel.dart';

class UserEmployeeService {
  Future<int> getLeaveBalance() async {
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
        return -1;
      }
    });
    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/hour/get"
        : preferences.getString("url")! + "/rest/api/v1/hour/get";

    final response = await http.post(Uri.parse(url), headers: <String, String>{
      'authorization': token,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      return 0;
    }
  }

  Future<Employee> getEmployeeInfo() async {
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
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/employee/get"
        : preferences.getString("url")! + "/rest/api/v1/employee/get";

    try {
      final response =
          await http.post(Uri.parse(url), headers: <String, String>{
        'authorization': token,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      });

      switch (response.statusCode) {
        case 200:
          return Employee.fromJson(json.decode(response.body));
        case 400:
          return Employee(valid: false, response: ConstantUtil.BAD_REQUEST);
        case 404:
          return Employee(valid: false, response: ConstantUtil.NOT_FOUND);
        case 408:
          return Employee(valid: false, response: ConstantUtil.REQUEST_TIMEOUT);
        case 500:
          return Employee(
              valid: false, response: ConstantUtil.INTERNAL_SERVER_ERROR);
        case 503:
          return Employee(
              valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE);
        default:
          return Employee(
            valid: false,
            response: ConstantUtil.CHECK_AGAIN,
          );
      }
    } on SocketException {
      return Employee(valid: false, response: ConstantUtil.NO_INTERNET);
    } on FormatException {
      return Employee(valid: false, response: ConstantUtil.BAD_RESPONSE);
    } on HttpException {
      return Employee(valid: false, response: ConstantUtil.SOMETHING_WRONG);
    }
  }
}
