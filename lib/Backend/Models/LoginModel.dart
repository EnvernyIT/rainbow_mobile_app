class LoginResponseModel {
  final bool? valid;
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

  LoginResponseModel({
    this.valid,
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
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final valid = json['valid'] as bool;
    final username = json['username'] as String;
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;

    return LoginResponseModel(
        valid: valid,
        username: username,
        firstName: firstName,
        lastName: lastName);
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
