import 'dart:convert';
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
import 'package:rainbow_app/Backend/APIS/AbsenceService.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Components/TextInputs/InputField.dart';
import 'package:rainbow_app/Components/TextInputs/MultiLineInputField.dart';
import 'package:rainbow_app/Components/Tiles/AbsenceTile.dart';

import '../../../Backend/APIS/UserEmployeeService.dart';
import '../../../Components/Buttons/Button.dart';
import '../../../Components/Navigation.dart';
import '../../../Components/TextInputs/DropdownTextField.dart';
import '../../../Components/TextInputs/SmallInputField.dart';
import '../../../Components/Tiles/Absence2Tile.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';
import '../Absence/AbsenceInfoPage.dart';
import '../AbsenceListPage/AbsenceListPage.dart';

class AbsenceRequestPage extends StatefulWidget {
  const AbsenceRequestPage({Key? key}) : super(key: key);
  static const String routeName = '/absenceRequest';

  @override
  State<AbsenceRequestPage> createState() => _AbsenceRequestPageState();
}

class _AbsenceRequestPageState extends State<AbsenceRequestPage> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String toDateString = "";
  bool typeDaysRequest = false;
  int selectedColor = 0;
  Color _color_1 = RainbowColor.primary_1;
  Color _color_2 = RainbowColor.primary_1;
  TextEditingController numberController = TextEditingController();
  TextEditingController controller_1 = TextEditingController();
  TextEditingController controller_2 = TextEditingController();
  TextEditingController controller_3 = TextEditingController();
  List<Absence> absences = [];
  int listLength = 0;
  String newValue = "";
  int userLeaveBalance = 0;
  String fileName = "Choose file";
  List<String> items = [];
  late File image;

  String fileAsString = "";
  // File image;

  @override
  void initState() {
    super.initState();
    setList();
    setUserLeaveBalance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return uiBuild(context);
  }

  clearAll() {
    controller_1.clear();
    controller_2.clear();
    controller_3.clear();
    numberController.clear();
    fileName = "Choose file";
    fileAsString = "";
  }

  Widget uiBuild(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
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
                          userLeaveBalance.toString() +
                              " " +
                              AppLocalizations.of(context)!.hours +
                              " (" +
                              userLeaveHoursToDays(userLeaveBalance) +
                              " " +
                              AppLocalizations.of(context)!.dayss +
                              ")",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: RainbowTextStyle.fontFamily),
                        ),
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                      controller: controller_1,
                      title: typeDaysRequest == true
                          ? AppLocalizations.of(context)!.from + ":"
                          : AppLocalizations.of(context)!.day + ":",
                      hint: DateFormat.yMd(locale).format(fromDate),
                      color: _color_1,
                      widget: IconButton(
                          onPressed: () {
                            _getFromDateFromUser(locale);
                            getDateDifferenceInHours(fromDate, toDate);
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: RainbowColor.primary_1,
                          ))),
                  InputField(
                      controller: controller_2,
                      title: AppLocalizations.of(context)!.towith + ":",
                      hint: toDateString,
                      color: _color_2,
                      widget: IconButton(
                          onPressed: () {
                            _getToDateFromUser(locale);
                            getDateDifferenceInHours(fromDate, toDate);
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: RainbowColor.primary_1,
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: RainbowColor.primary_1, width: 1.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: const EdgeInsets.only(bottom: 6),
                      child: DropdownButton(
                        value: newValue,
                        icon: const Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Icon(Icons.arrow_circle_down_sharp)),
                        iconEnabledColor: RainbowColor.primary_1, //Icon color
                        style: TextStyle(
                            color: RainbowColor.primary_1, //Font color
                            fontSize: 17, //font size on dropdown button
                            fontFamily: RainbowTextStyle.fontFamily),
                        dropdownColor:
                            RainbowColor.secondary, //dropdown background color
                        underline: Container(), //remove underline
                        isExpanded: false, //make true to make width 100%
                        items: items.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontFamily: RainbowTextStyle.fontFamily)),
                          );
                        }).toList(),
                        onChanged: (String? changedValue) {
                          setState(() {
                            newValue = changedValue!;
                          });
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SmallInputField(
                    controller: numberController,
                    title: AppLocalizations.of(context)!.hours + ":",
                    keyboardType: TextInputType.number,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MultiLineInputField(
                      controller: controller_3,
                      title: AppLocalizations.of(context)!.description + ":",
                      hint: AppLocalizations.of(context)!.giveDescription),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(3),
                      child: InkWell(
                          onTap: () => _chooseTypeOfFile(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: RainbowColor.primary_1,
                                size: 30,
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
                          ))),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(10),
                      child: Button(
                        label: AppLocalizations.of(context)!.request,
                        onTap: () {
                          sendLeaveRequest(userLeaveBalance, context);
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
                      itemCount: listLength,
                      itemBuilder: (BuildContext context, int index) {
                        return Absence2Tile(
                          absence: absences[index],
                        );
                      }),
                ))
          ]),
        ));
  }

  void sendLeaveRequest(int userLeaveBalance, BuildContext context) {
    if (userLeaveBalance > getDateDifferenceInDays(fromDate, toDate)) {
      if (numberController.text.isNotEmpty) {
        AbsenceRequest absenceRequest = AbsenceRequest(
          dateFrom: fromDateString(fromDate),
          dateTo: fromDateString(toDate),
          usId: newValue == AppLocalizations.of(context)!.sick
              ? 1004
              : newValue == AppLocalizations.of(context)!.maternity
                  ? 1009
                  : newValue == AppLocalizations.of(context)!.training
                      ? 1014
                      : 1003,
          days: getDateDifferenceInDays(fromDate, toDate),
          uaAantaluren: int.parse(numberController.text),
          uaOpmerking: controller_3.text,
          fileBytes: fileAsString,
          typeFile: fileName,
        );
        AbsenceService service = AbsenceService();
        Absence absence = Absence(valid: true);
        if (fromDate
                .isAfter(DateTime.now().subtract(const Duration(days: 1))) ||
            toDate.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
          service.request(absenceRequest)?.then((value) {
            if (value.valid) {
              absence = value;
              clearAll();
              SnackBar snackBar = SnackBar(
                content: Text(AppLocalizations.of(context)!.requestSuccesfull),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AbsenceInfoPage(
                          absence: absence,
                        )),
              );
            } else {
              SnackBar snackBar = SnackBar(
                content: SizedBox(
                    height: 40,
                    child: Column(children: [
                      Text(AppLocalizations.of(context)!.requestUnsuccesfull),
                      Text(AppLocalizations.of(context)!.reason +
                          " " +
                          value.response!),
                    ])),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(AppLocalizations.of(context)!.dateNotAllowed),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        SnackBar snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.forgotHours),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.notEnoughLeave),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _getFromDateFromUser(locale) async {
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
        if (pickDate.isAfter(DateTime.now())) {
          _color_1 = RainbowColor.primary_1;
          _color_2 = RainbowColor.primary_1;

          fromDate = pickDate;
          toDate = fromDate;
          toDateString = DateFormat.yMd(locale).format(toDate);
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(AppLocalizations.of(context)!.incorrectDate),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            _color_1 = Colors.red;
            _color_2 = Colors.red;
          });
        }
      });
      getDateDifferenceInHours(pickDate, toDate);
    } else {
      print(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }

  _getToDateFromUser(locale) async {
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
        if (pickDate.isAfter(DateTime.now())) {
          toDate = pickDate;
          toDateString = DateFormat.yMd(locale).format(toDate);
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(AppLocalizations.of(context)!.incorrectDate),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            _color_2 = Colors.red;
          });
        }
      });
      getDateDifferenceInHours(fromDate, pickDate);
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
                            pickImageFile(image);
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
                        XFile? xFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (xFile != null) {
                          setState(() {
                            choosePhotoFile(xFile);
                          });
                        }
                        Navigator.pop(context);
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
                        PlatformFile platformFile = result.files.first;
                        if (platformFile.path != "" ||
                            platformFile.path != null) {
                          setState(() {
                            choosePdfFile(platformFile);
                          });
                        }
                        // openFile(file);
                        Navigator.pop(context);
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

  Future<void> choosePdfFile(PlatformFile platformFile) async {
    String? path = platformFile.path;
    File file = File(path!);
    fileName = file.path.toString();
    List<int> bytes = await file.readAsBytes();
    fileAsString = base64Encode(bytes);
  }

  Future<void> choosePhotoFile(XFile xFile) async {
    String? path = xFile.path;
    File file = File(path);
    fileName = file.path.toString();
    List<int> bytes = await file.readAsBytes();
    fileAsString = base64Encode(bytes);
  }

  Future<void> pickImageFile(XFile image) async {
    fileName = this.image.path.toString();
    List<int> bytes = await image.readAsBytes();
    fileAsString = base64Encode(bytes);
    print(fileAsString);
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void setList() {
    AbsenceService absenceService = AbsenceService();
    AbsenceRequest absenceRequest = AbsenceRequest();
    absenceService.getList(absenceRequest).then((value) {
      setState(() {
        if (value != null) {
          absences = value;
          listLength = absences.length;
          items = <String>[
            AppLocalizations.of(context)!.sick,
            AppLocalizations.of(context)!.maternity,
            AppLocalizations.of(context)!.training,
            AppLocalizations.of(context)!.special,
          ];
          newValue = items[0];
        }
      });
    });
  }

  void setUserLeaveBalance() {
    UserEmployeeService employeeService = UserEmployeeService();
    employeeService.getLeaveBalance().then((value) {
      setState(() {
        userLeaveBalance = value;
      });
    });
  }

  fromDateString(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateString = formatter.format(date);
    return dateString;
  }

  getDateDifferenceInDays(DateTime fromDate, DateTime toDate) {
    if (fromDate != toDate) {
      Duration diff = toDate.difference(fromDate);
      return diff.inDays;
    }
    return 1;
  }

  getDateDifferenceInHours(DateTime fromDate, DateTime toDate) {
    if (numberController.text.isEmpty) {
      dateDifferenceInHours(fromDate, toDate);
    } else {
      numberController.clear;
      dateDifferenceInHours(fromDate, toDate);
    }
  }

  void dateDifferenceInHours(DateTime fromDate, DateTime toDate) {
    if (fromDate != toDate) {
      Duration diff = toDate.difference(fromDate);
      setState(() {
        numberController.text = ((diff.inDays * 8) + 8).toString();
      });
    } else {
      setState(() {
        numberController.text = 8.toString();
      });
    }
  }

  String userLeaveHoursToDays(int userLeaveBalance) {
    if (userLeaveBalance != 0) {
      double number = (userLeaveBalance / 8);
      return number.toString();
    }
    return "0";
  }
}
