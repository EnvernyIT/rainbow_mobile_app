import 'package:rainbow_app/Backend/Models/Role.dart';

class UserModel {
  final String? emId;
  final String? emCode;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? departmentCode;
  final String? departmentDescription;
  final String? jobCode;
  final String? jobDescription;
  final double? leaveBalance;
  final List<Role>? roles;
  final String? selectedRoleId;
  final String token;

  UserModel({
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
    required this.token,
  });
}

class UserRoleModel {
  String? roleName;
  UserRoleModel({
    this.roleName,
  });
}

class LoggedInUser {
  static bool? loggedIn;

  static UserModel? loggedInUser;

  static String token = "";

  static double? leaveBalance;

  LoggedInUser(
    bool loggedIn,
    UserModel loggedInUser,
  ) {
    LoggedInUser.loggedIn = loggedIn;
    LoggedInUser.loggedInUser = loggedInUser;
  }

  LoggedInUser.setToken(String token) {
    LoggedInUser.token = token;
  }

  bool? getLoggedIn() {
    return loggedIn;
  }

  String getToken() {
    return token;
  }

  static Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'firstName': loggedInUser?.firstName?.toString(),
      'lastName': loggedInUser?.lastName?.toString(),
    };
    return map;
  }

  static void setLoggedIn(bool bool) {
    LoggedInUser.loggedIn = bool;
  }
}
