import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/LoginModel.dart';
import '../Models/Payslip.dart';

class PayslipService {
  Future<List<Payslip>?> getList(
      PayslipRequestModel payslipRequestModel) async {
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

    final response = await http.post(Uri.parse(payslipRequestModel.url),
        body: jsonEncode(payslipRequestModel.toJson()),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      Payslip payslip = Payslip();
      List<Payslip> payslips =
          payslip.configureListFromJson(json.decode(response.body));
      return payslips;
    } else {
      throw Exception("Failed to payslip list load data!");
    }
  }

  Future<String> getPayslipFile(PayslipRequestModel payslipRequestModel) async {
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

    final response = await http.post(Uri.parse(payslipRequestModel.urlFile),
        body: jsonEncode(payslipRequestModel.toFileJson()),
        headers: <String, String>{
          'authorization': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        });

    if (response.statusCode == 200 || response.statusCode == 400) {
      Payslip payslip = Payslip();
      String data = payslip.fromFileJson(json.decode(response.body));
      return data;
    } else {
      throw Exception("Failed to load payslip image file!");
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _localFile(List<int> bytes, String name) async {
    final path = await _localPath;
    File file = File('$path/$name');
    file.writeAsBytesSync(bytes, flush: true);
    await file.writeAsBytes(bytes, flush: true).then((value) =>
        value.create().then((value) => OpenFile.open('$path/$name')));
  }
}
