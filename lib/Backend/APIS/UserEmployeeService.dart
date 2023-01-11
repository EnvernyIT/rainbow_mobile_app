import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_app/Backend/APIS/LoginService.dart';
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
        throw Exception("The token is not valid anymore!");
      }
    });
    String token = 'Bearer ' + LoggedInUser.token;

    final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/module.web/rest/api/v1/hour/get"),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception("Failed te retrieve user leave balance!");
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
        throw Exception("The token is not valid anymore!");
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;

    final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/module.web/rest/api/v1/employee/get"),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed te retrieve user employee information!");
    }
  }
}
