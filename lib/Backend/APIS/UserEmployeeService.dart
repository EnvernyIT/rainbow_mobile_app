import 'dart:convert';

import 'package:http/http.dart' as http;

class UserEmployeeService {
  Future<String> getLeaveBalance(String username) async {
    final response = await http.get(
      Uri.parse(
          "http://10.0.2.2:8080/module.web/rest/api/v1/employee/get-user-leave-balance?username=$username"),
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      print(json.decode(response.body));
      return json.decode(response.body).toString();
    } else {
      throw Exception("Failed te retrieve user leave balance!");
    }
  }
}
