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
  final String? leaveBalance;
  final String? roles;
  final String? selectedRoleId;

  UserModel({
    this.emId,
    this.emCode,
    this.username,
    this.firstName,
    this.lastName,
    this.roles,
    this.departmentCode,
    this.departmentDescription,
    this.jobCode,
    this.jobDescription,
    this.leaveBalance,
    this.selectedRoleId,
  });
}

class UserRoleModel {
  final String? roleName;

  UserRoleModel(
    String? roles, {
    this.roleName,
  });
}

class LoggedInUser {
  static bool? loggedIn;

  static UserModel? loggedInUser;

  static UserRoleModel? role;

  static double? leaveBalance;

  LoggedInUser(
    bool loggedIn,
    UserModel loggedInUser,
    UserRoleModel role,
  ) {
    LoggedInUser.loggedIn = loggedIn;
    LoggedInUser.loggedInUser = loggedInUser;
    LoggedInUser.role = role;
  }

  static Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'firstName': loggedInUser?.firstName?.toString(),
      'lastName': loggedInUser?.lastName?.toString(),
    };
    return map;
  }
}
