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
  int leaveBalance = 0;
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
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          // _editProfileImage(context);
                        },
                        child: CircleAvatar(
                            radius: 65.0,
                            backgroundColor: RainbowColor.primary_1,
                            child: image.isNotEmpty
                                ? Image.memory(
                                    base64Decode(image),
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'assets/images/blank-profile.png')),
                      ),
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.employeeCode,
                      data_1: employee.emCode ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.username,
                      data_1: LoggedInUser.loggedInUser?.username ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.name,
                      data_1: employee.emVoorNaam,
                      data_2: employee.emNaam,
                      color_1: RainbowColor.primary_1,
                      color_2: RainbowColor.primary_1,
                      fontSize: 17.0,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.email,
                      data_1: employee.email ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    // RTextField(
                    //   title: AppLocalizations.of(context)!.status,
                    //   data_1: employee.emStatus ?? "",
                    //   fontSize: 17.0,
                    //   color_1: RainbowColor.primary_1,
                    // ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.telephone,
                      data_1: employee.emTelefoon ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.company,
                      data_1: employee.bedrijf?.beNaam ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.department,
                      data_1: employee.hrmAfdeling?.afOmschrijving ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.job,
                      data_1: employee.hrmFunctie?.fuOmschrijving ?? "",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.inServiceSince,
                      data_1: showDate(employee.emInDienstDat),
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.leaveBalance,
                      data_1: leaveBalance.toString(),
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    RTextField(
                      title: AppLocalizations.of(context)!.roles,
                      data_1:
                          LoggedInUser.loggedInUser?.roles?[0].roleName ?? "s",
                      fontSize: 17.0,
                      color_1: RainbowColor.primary_1,
                    ),

                    // DropdownTextField(
                    //   title: AppLocalizations.of(context)!.role,
                    //   dropdownList: roles,
                    //   fontSize: 17.0,
                    // ),
                    const SizedBox(
                      height: 6,
                    ),
                    // Button(
                    //     label: (AppLocalizations.of(context)!.changePassword),
                    //     onTap: () {})
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
}
