import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_app/Backend/Models/LoginModel.dart';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String? username = loginRequestModel.username;
    String? password = loginRequestModel.password;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    bool _validURL = Uri.parse(loginRequestModel.url!).isAbsolute;
    if (_validURL) {
      final response = await http.post(
        Uri.parse(loginRequestModel.url!),
        body: loginRequestModel.toJson(),
        headers: <String, String>{
          'authorization': basicAuth,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        return LoginResponseModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load data!");
      }
    } else {
      throw Exception("URL is incorrect!");
    }
  }
}
