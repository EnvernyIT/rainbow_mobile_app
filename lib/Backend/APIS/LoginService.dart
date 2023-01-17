import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rainbow_app/Backend/Constants/ConstantUtil.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String? username = loginRequestModel.username;
    String? password = loginRequestModel.password;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    bool _validURL = Uri.parse(loginRequestModel.url!).isAbsolute;
    if (_validURL) {
      bool checkUrl = loginRequestModel.url!.endsWith("/");
      String url = checkUrl
          ? "rest/api/v1/authenticate/authenticate-user"
          : "/rest/api/v1/authenticate/authenticate-user";
      try {
        final response = await http.post(
          Uri.parse(loginRequestModel.url! + url),
          body: loginRequestModel.toJson(),
          headers: <String, String>{
            'authorization': basicAuth,
          },
        );
        switch (response.statusCode) {
          case 200:
            return LoginResponseModel.fromJson(json.decode(response.body));
          case 400:
            return LoginResponseModel(
                valid: false, token: '', response: ConstantUtil.BAD_REQUEST);
          case 404:
            return LoginResponseModel(
                valid: false, token: '', response: ConstantUtil.NOT_FOUND);
          case 408:
            return LoginResponseModel(
                valid: false,
                token: '',
                response: ConstantUtil.REQUEST_TIMEOUT);
          case 500:
            return LoginResponseModel(
                valid: false,
                token: '',
                response: ConstantUtil.INTERNAL_SERVER_ERROR);

          case 503:
            return LoginResponseModel(
                valid: false,
                token: '',
                response: ConstantUtil.SERVICE_UNAVAILABLE);
          default:
            return LoginResponseModel(
              valid: false,
              token: '',
              response: ConstantUtil.CHECK_AGAIN,
            );
        }
      } on SocketException {
        return LoginResponseModel(
            valid: false, token: '', response: ConstantUtil.NO_INTERNET);
      } on FormatException {
        return LoginResponseModel(
            valid: false, token: '', response: ConstantUtil.BAD_RESPONSE);
      } on HttpException {
        return LoginResponseModel(
            valid: false, token: '', response: ConstantUtil.SOMETHING_WRONG);
      }
    } else {
      return LoginResponseModel(
        valid: false,
        token: '',
        response: ConstantUtil.URL_NOT_VALID,
      );
    }
  }
}
