import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rainbow_app/Components/Buttons/Button.dart';
import 'package:rainbow_app/Components/TextInputs/DropdownTextField.dart';

import '../../Backend/APIS/UserEmployeeService.dart';
import '../../Backend/Models/Employee.dart';
import '../../Backend/Models/Role.dart';
import '../../Backend/Models/UserModel.dart';
import '../../Components/Navigation.dart';
import '../../Components/OnlyReadFields/RField.dart';
import '../../Components/OnlyReadFields/RTextField.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double leaveBalance = 0;
  Employee employee = Employee(valid: true);
  bool photoSet = false;
  Uint8List bytes = Uint8List.fromList([]);
  String message = "";
  String image = "";

  @override
  void initState() {
    super.initState();
    setEmployeeInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 2,
          foregroundColor: RainbowColor.primary_1,
          bottomOpacity: 0,
          title: Text(AppLocalizations.of(context)!.profile,
              style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
          backgroundColor: RainbowColor.secondary,
        ),
        drawer: const Navigation(),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3.0),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(18.0),
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: DecorationImage(
                                  image: image.isNotEmpty
                                      ? Image.memory(
                                          base64Decode(image),
                                          fit: BoxFit.contain,
                                        ).image
                                      : Image.asset(
                                              'assets/images/blank-profile.png')
                                          .image)
                              .image,
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      color: Colors.grey[200],
                      height: 3,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.employeeCode,
                      content: employee.emCode ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.username,
                      content: LoggedInUser.loggedInUser?.username ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.name,
                      content: employee.emVoorNaam ?? "",
                      content_2: employee.emNaam,
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.email,
                      content: employee.email ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.telephone,
                      content: employee.emTelefoon ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.company,
                      content: employee.bedrijf?.beNaam ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.department,
                      content: employee.hrmAfdeling?.afOmschrijving ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.job,
                      content: employee.hrmFunctie?.fuOmschrijving ?? "",
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.inServiceSince,
                      content: showDate(employee.emInDienstDat),
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.leaveBalance,
                      content: leaveBalance.toString(),
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                    RField(
                      title: AppLocalizations.of(context)!.roles,
                      content: createLine(LoggedInUser.loggedInUser?.roles),
                      color: RainbowColor.primary_1,
                      bottomSpace: 2,
                      height: 50,
                    ),
                  ],
                ))));
  }

  void _editProfileImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 25.0,
                    color: RainbowColor.primary_1,
                  )),
                  InkWell(
                      child: Icon(
                    Icons.photo_album_outlined,
                    size: 25.0,
                    color: RainbowColor.primary_1,
                  )),
                  InkWell(
                      child: Icon(
                    Icons.delete_outline,
                    size: 25.0,
                    color: RainbowColor.primary_1,
                  )),
                ],
              ),
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ));
        });
  }

  String showDate(DateTime? date) {
    String formatter;
    if (date != null) {
      formatter = DateFormat.yMMMMd().format(date);
    } else {
      formatter = "";
    }
    return formatter;
  }

  void setEmployeeInfo() {
    UserEmployeeService service = UserEmployeeService();
    service.getEmployeeInfo().then((value) {
      setState(() {
        if (value.valid) {
          employee = value;
          if (employee.photo != null) {
            photoSet = true;
            if (employee.photo?.phImage != null) {
              image = employee.photo?.phImage ?? "";
            }
          }
        } else {
          message = value.response ?? "";
          SnackBar snackBar = SnackBar(
            duration: const Duration(seconds: 8),
            content: Text(message),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });
    service.getLeaveBalance().then((value) {
      setState(() {
        leaveBalance = leaveBalance + value;
      });
    });
  }

  String createLine(List<Role>? roles) {
    String content = "";
    if (roles != null) {
        for (int i = 0; i <= roles.length - 1; i++) {
          if(i == 0){
            content = (roles[i].roleName ?? "") + ", ";
          } else {
            content = content + (roles[i].roleName ?? "") + ", ";
          }
        }
    }
    return content;
  }
}
