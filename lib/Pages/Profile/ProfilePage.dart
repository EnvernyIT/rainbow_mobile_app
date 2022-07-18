import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/Components/Buttons/Button.dart';
import 'package:rainbow_app/Components/TextInputs/DropdownTextField.dart';

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
  List<String> roles = [
    "Employee",
    "Supervisor",
    "Payroll officer",
    "Crewleader"
  ];
  @override
  Widget build(BuildContext context) {
    String firstName, lastName;
    if (LoggedInUser.loggedInUser != null) {
      firstName = LoggedInUser.loggedInUser?.firstName ?? "";
      lastName = LoggedInUser.loggedInUser?.lastName ?? "";
    } else {
      firstName = "User";
      lastName = "";
    }
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
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          _editProfileImage(context);
                        },
                        child: CircleAvatar(
                          radius: 65.0,
                          child: const CircleAvatar(
                              radius: 60.0,
                              backgroundImage: AssetImage(
                                  'assets/images/blank-profile.png')),
                          backgroundColor: RainbowColor.primary_1,
                        ))),
                RTextField(
                  title: AppLocalizations.of(context)!.username,
                  data_1: LoggedInUser.loggedInUser?.username ?? "",
                  fontSize: 17.0,
                ),
                const SizedBox(
                  height: 8,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.name,
                  data_1: LoggedInUser.loggedInUser?.firstName ?? "",
                  data_2: LoggedInUser.loggedInUser?.lastName ?? "",
                  fontSize: 17.0,
                ),
                const SizedBox(
                  height: 8,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.department,
                  data_1:
                      LoggedInUser.loggedInUser?.departmentDescription ?? "",
                  fontSize: 17.0,
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownTextField(
                  title: AppLocalizations.of(context)!.role,
                  dropdownList: roles,
                  fontSize: 17.0,
                ),
                const SizedBox(
                  height: 8,
                ),
                Button(
                    label: (AppLocalizations.of(context)!.changePassword),
                    onTap: () {})
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
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
}
