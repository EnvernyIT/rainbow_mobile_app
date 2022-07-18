import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Components/TextInputs/InputField.dart';
import 'package:rainbow_app/Components/TextInputs/MultiLineInputField.dart';
import 'package:rainbow_app/Components/Tiles/AbsenceTile.dart';

import '../../../Components/Buttons/Button.dart';
import '../../../Components/Navigation.dart';
import '../../../Components/TextInputs/DropdownTextField.dart';
import '../../../Components/TextInputs/SmallInputField.dart';
import '../../../Components/Tiles/Absence2Tile.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class AbsenceRequestPage extends StatefulWidget {
  const AbsenceRequestPage({Key? key}) : super(key: key);
  static const String routeName = '/absenceRequest';

  @override
  State<AbsenceRequestPage> createState() => _AbsenceRequestPageState();
}

class _AbsenceRequestPageState extends State<AbsenceRequestPage> {
  DateTime fromDate = DateTime.now();
  late DateTime toDate;
  String toDateString = "";
  String fileName = "filename.co";
  bool typeDaysRequest = false;
  int selectedColor = 0;
  TextEditingController numberController = TextEditingController();
  TextEditingController controller_1 = TextEditingController();
  TextEditingController controller_2 = TextEditingController();
  TextEditingController controller_3 = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    return uiBuild(context);
  }

  Widget uiBuild(BuildContext context) {
    var items = [
      AppLocalizations.of(context)!.sick,
      AppLocalizations.of(context)!.personal,
      AppLocalizations.of(context)!.medical,
      AppLocalizations.of(context)!.maternity,
      AppLocalizations.of(context)!.training,
      AppLocalizations.of(context)!.special,
    ];
    String value = AppLocalizations.of(context)!.sick;
    String locale = Localizations.localeOf(context).languageCode;
    int userLeaveBalance =
        int.parse(LoggedInUser.loggedInUser?.leaveBalance ?? "12");
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: RainbowColor.primary_1,
              labelColor: RainbowColor.primary_1,
              indicatorWeight: 4,
              tabs: [
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 5),
                    height: 50,
                    text: AppLocalizations.of(context)!.request,
                    icon: const Icon(Icons.add)),
                Tab(
                    iconMargin: const EdgeInsets.only(bottom: 5),
                    height: 50,
                    text: AppLocalizations.of(context)!.list,
                    icon: const Icon(Icons.list)),
              ],
            ),
            elevation: 2,
            backgroundColor: RainbowColor.secondary,
            foregroundColor: RainbowColor.primary_1,
            title: Text(AppLocalizations.of(context)!.requestLeave,
                style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
          ),
          body: TabBarView(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.leaveBalance + ": ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: RainbowTextStyle.fontFamily),
                        ),
                        Text(
                          userLeaveBalance.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: RainbowTextStyle.fontFamily),
                        ),
                      ]),
                  InputField(
                      controller: controller_1,
                      title: typeDaysRequest == true
                          ? AppLocalizations.of(context)!.from + ":"
                          : AppLocalizations.of(context)!.day + ":",
                      hint: DateFormat.yMd(locale).format(fromDate),
                      widget: IconButton(
                          onPressed: () {
                            _getFromDateFromUser();
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: RainbowColor.primary_1,
                          ))),
                  InputField(
                      controller: controller_2,
                      title: AppLocalizations.of(context)!.towith + ":",
                      hint: toDateString,
                      widget: IconButton(
                          onPressed: () {
                            _getToDateFromUser(locale);
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: RainbowColor.primary_1,
                          ))),
                  SmallInputField(
                    controller: numberController,
                    title: AppLocalizations.of(context)!.hours + ":",
                    keyboardType: TextInputType.number,
                    width: 100,
                    hint: '8',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownTextField(
                    title: AppLocalizations.of(context)!.type,
                    dropdownList: items,
                    mainAxisAlignment: MainAxisAlignment.start,
                    fontSize: 18,
                  ),
                  MultiLineInputField(
                      controller: controller_3,
                      title: AppLocalizations.of(context)!.description + ":",
                      hint: AppLocalizations.of(context)!.giveDescription),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => _chooseTypeOfFile(context),
                            child: Icon(
                              Icons.upload_file,
                              color: RainbowColor.primary_1,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: InkWell(
                                  onTap: () => _chooseTypeOfFile(context),
                                  child: Text(
                                    fileName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                        fontFamily:
                                            RainbowTextStyle.fontFamily),
                                  )))
                        ],
                      )),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(10),
                      child: Button(
                        label: AppLocalizations.of(context)!.request,
                        onTap: () {
                          Absence absence = Absence(
                              startDay: DateTime.parse(controller_1.text),
                              endDay: DateTime.parse(controller_2.text),
                              accepted: false,
                              description: controller_3.text,
                              typeOfLeave: value,
                              hours: controller_2.text != null ||
                                      controller_2.text != ""
                                  ? double.parse(controller_2.text)
                                  : 0,
                              days: true);

                          Absence.absences.add(absence);
                        },
                      ))
                ],
              )),
            ),
            Container(
                color: RainbowColor.secondary,
                child: RefreshIndicator(
                  backgroundColor: RainbowColor.secondary,
                  color: RainbowColor.primary_1,
                  onRefresh: refresh,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Absence.absences.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Absence2Tile(
                          absence: Absence.absences[index],
                        );
                      }),
                ))
          ]),
        ));
  }

  _getFromDateFromUser() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    ColorScheme.light(primary: RainbowColor.primary_1)),
            child: child!,
          );
        });

    if (pickDate != null) {
      setState(() {
        fromDate = pickDate;
      });
    } else {
      print(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }

  _getToDateFromUser(locale) async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 5)),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    ColorScheme.light(primary: RainbowColor.primary_1)),
            child: child!,
          );
        });

    if (pickDate != null) {
      setState(() {
        toDate = pickDate;
        toDateString = DateFormat.yMd(locale).format(toDate);
      });
    } else {
      print(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }

  Future refresh() async {
    setState(() {});
  }

  void _chooseTypeOfFile(BuildContext context) {
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
                      onTap: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image == null) return;

                          final imageTemporary = File(image.path);
                          this.image = imageTemporary;
                          setState(() {
                            fileName = this.image!.path.toString();
                            print(fileName);
                          });
                          Navigator.pop(context);
                        } on PlatformException catch (e) {
                          print('Failed to pick image: $e');
                        }
                      },
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 25.0,
                        color: RainbowColor.primary_1,
                      )),
                  InkWell(
                      onTap: () async {
                        // final result = await FilePicker.platform.pickFiles(
                        //   allowMultiple: false,
                        //   type: FileType.image,
                        // );
                        // if (result != null) {
                        //   fileName = result.files.toString();
                        // }
                        // if (result == null) return;

                        // //Open single file
                        // final file = result.files.first;
                        // openFile(file);

                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                      },
                      child: Icon(
                        Icons.photo,
                        size: 25.0,
                        color: RainbowColor.primary_1,
                      )),
                  InkWell(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['pdf']);
                        if (result != null) {
                          fileName = result.files.toString();
                        }
                        if (result == null) return;

                        //Open single file
                        final file = result.files.first;
                        openFile(file);

                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                      },
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
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

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  colorPallette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.color,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(
          height: 18.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0
                          ? Colors.lightBlueAccent
                          : index == 1
                              ? Colors.redAccent
                              : Colors.greenAccent,
                      child: selectedColor == index
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            )
                          : Container(),
                    )));
          }),
        )
      ],
    );
  }
}
