import 'package:rainbow_app/Backend/Models/Role.dart';

class LoginResponseModel {
  bool? valid;
  String? emId;
  String? emCode;
  String? username;
  String? firstName;
  String? lastName;
  String? departmentCode;
  String? departmentDescription;
  String? jobCode;
  String? jobDescription;
  int? leaveBalance;
  List<Role>? roles;
  String? selectedRoleId;
  String token;

  LoginResponseModel(
      {this.valid,
      this.emId,
      this.emCode,
      this.username,
      this.firstName,
      this.lastName,
      this.departmentCode,
      this.departmentDescription,
      this.jobCode,
      this.jobDescription,
      this.leaveBalance,
      this.roles,
      this.selectedRoleId,
      required this.token});

  LoginResponseModel getLoginResponse(Map<String, dynamic> json) {
    List<Role> roles = [];
    for (int i = 0; i <= json.length - 1; i++) {
      Role role = Role(
        roleId: json['roles']['roleId'] as int,
        groupNumber: json['roles']['groupNumber'] as int,
        roleName: json['roles']['roleName'] as String,
      );
      roles.add(role);
    }
    LoginResponseModel loginResponseModel = LoginResponseModel(
      token: json['token'] as String,
      valid: json['valid'] as bool,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      emCode: json['emCode'] as String,
      departmentDescription: json['departmentDescription'] as String,
      departmentCode: json['departmentCode'] as String,
      jobCode: json['jobCode'] as String,
      jobDescription: json['jobDescription'] as String,
      leaveBalance: json['leaveBalance'] as int,
      roles: roles,
    );

    return loginResponseModel;
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final valid = json['valid'] as bool;
    final token = json['token'] as String;
    if (valid) {
      final username = json['username'] as String;
      final firstName = json['firstName'] as String;
      final lastName = json['lastName'] as String;
      final emCode = json['emCode'] as String;
      final departmentDescription = json['departmentDescription'] as String;
      final departmentCode = json['departmentCode'] as String;
      final jobCode = json['jobCode'] as String;
      final jobDescription = json['jobDescription'] as String;
      final leaveBalance = json['leaveBalance'] as int;
      // final role = json['roles'][0]['roleName'] as String;

      List<Role> roles = [];
      for (int i = 0; i <= json['roles'].length - 1; i++) {
        Role role = Role(
          roleId: json['roles'][i]['roleId'] as int,
          groupNumber: json['roles'][i]['groupNumber'] as int,
          roleName: json['roles'][i]['roleName'] as String,
        );
        roles.add(role);
      }
      return LoginResponseModel(
          valid: valid,
          username: username,
          firstName: firstName,
          lastName: lastName,
          token: token,
          emCode: emCode,
          departmentCode: departmentCode,
          departmentDescription: departmentDescription,
          jobCode: jobCode,
          jobDescription: jobDescription,
          leaveBalance: leaveBalance,
          roles: roles);
    }
    return LoginResponseModel(valid: valid, token: '');
  }
}

class LoginRequestModel {
  String? url;
  String? username;
  String? password;

  LoginRequestModel({
    this.url,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'url': url?.trim(),
      'username': username?.trim(),
      'password': password?.trim(),
    };
    return map;
  }
}
