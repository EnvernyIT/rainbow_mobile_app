import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import '../Constants/ConstantUtil.dart';
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

    List<Payslip> payslips = [];

    LoginService loginService = LoginService();
    loginService.login(requestModel).then((value) {
      if (value.valid == true) {
        LoggedInUser.setToken(value.token);
      } else {
        LoggedInUser.setToken("");
        payslips
            .add(Payslip(valid: false, response: ConstantUtil.TOKEN_EXPIRED));
        return payslips;
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/payslip/list"
        : preferences.getString("url")! + "/rest/api/v1/payslip/list";

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(payslipRequestModel.toJson()),
          headers: <String, String>{
            'authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          });
      switch (response.statusCode) {
        case 200:
          Payslip payslip = Payslip(valid: true);
          payslips = payslip.configureListFromJson(json.decode(response.body));
          return payslips;
        case 400:
          payslips.add(Payslip(
              valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE));
          return payslips;
        case 404:
          payslips.add(Payslip(valid: false, response: ConstantUtil.NOT_FOUND));
          return payslips;
        case 408:
          payslips.add(
              Payslip(valid: false, response: ConstantUtil.REQUEST_TIMEOUT));
          return payslips;
        case 500:
          payslips.add(Payslip(
              valid: false, response: ConstantUtil.INTERNAL_SERVER_ERROR));
          return payslips;
        case 503:
          payslips.add(Payslip(
              valid: false, response: ConstantUtil.SERVICE_UNAVAILABLE));
          return payslips;
        default:
          payslips.add(Payslip(
            valid: false,
            response: ConstantUtil.CHECK_AGAIN,
          ));
          return payslips;
      }
    } on SocketException {
      payslips.add(Payslip(valid: false, response: ConstantUtil.NO_INTERNET));
      return payslips;
    } on FormatException {
      payslips.add(Payslip(valid: false, response: ConstantUtil.BAD_RESPONSE));
      return payslips;
    } on HttpException {
      payslips
          .add(Payslip(valid: false, response: ConstantUtil.SOMETHING_WRONG));
      return payslips;
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
        LoggedInUser.setToken("");
        return ConstantUtil.TOKEN_EXPIRED;
      }
    });

    String token = 'Bearer ' + LoggedInUser.token;
    bool checkUrl = preferences.getString("url")!.endsWith("/");
    String url = checkUrl
        ? preferences.getString("url")! + "rest/api/v1/payslip/get"
        : preferences.getString("url")! + "/rest/api/v1/payslip/get";

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(payslipRequestModel.toFileJson()),
          headers: <String, String>{
            'authorization': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Connection': 'keep-alive',
          });
      switch (response.statusCode) {
        case 200:
          Payslip payslip = Payslip(valid: true);
          String data = payslip.fromFileJson(json.decode(response.body));
          return data;
        case 400:
          return ConstantUtil.BAD_REQUEST;
        case 404:
          return ConstantUtil.NOT_FOUND;
        case 408:
          return ConstantUtil.REQUEST_TIMEOUT;
        case 500:
          return ConstantUtil.INTERNAL_SERVER_ERROR;
        case 503:
          return ConstantUtil.SERVICE_UNAVAILABLE;
        default:
          return "";
      }
    } on SocketException {
      return ConstantUtil.NO_INTERNET;
    } on FormatException {
      return ConstantUtil.BAD_RESPONSE;
    } on HttpException {
      return ConstantUtil.SOMETHING_WRONG;
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
