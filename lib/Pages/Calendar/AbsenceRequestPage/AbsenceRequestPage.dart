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
import 'package:rainbow_app/Components/TextInputs/InputField.dart';
import 'package:rainbow_app/Components/TextInputs/MultiLineInputField.dart';

import '../../../Backend/APIS/UserEmployeeService.dart';
import '../../../Backend/Models/HourType.dart';
import '../../../Components/Buttons/Button.dart';
import '../../../Components/Navigation.dart';
import '../../../Components/ProgressHUD.dart';
import '../../../Components/TextInputs/DateInputField.dart';
import '../../../Components/TextInputs/DropdownTextField.dart';
import '../../../Components/TextInputs/SmallInputField.dart';
import '../../../Components/Tiles/Absence2Tile.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';
import '../Absence/AbsenceInfoPage.dart';

class AbsenceRequestPage extends StatefulWidget {
  const AbsenceRequestPage({Key? key}) : super(key: key);
  static const String routeName = '/absenceRequest';

  @override
  State<AbsenceRequestPage> createState() => _AbsenceRequestPageState();
}

class _AbsenceRequestPageState extends State<AbsenceRequestPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  DateTime fromDate = DateTime.now().add(const Duration(days: 1));
  DateTime toDate = DateTime.now().add(const Duration(days: 1));
  String toDateString = "";
  String fromDateString = "";
  bool typeDaysRequest = false;
  int selectedColor = 0;
  Color _color_1 = RainbowColor.primary_1;
  Color _color_2 = RainbowColor.primary_1;
  TextEditingController numberController = TextEditingController();
  TextEditingController controller_1 = TextEditingController();
  TextEditingController controller_2 = TextEditingController();
  TextEditingController controller_3 = TextEditingController();
  double hoursAllowed = 8;
  double fullDayHours = 8;
  double halfDayHours = 4;
  double hours = 8;
  List<Absence> absences = [];
  int listLength = 0;
  HourType newValue = HourType(valid: true);
  double userLeaveBalance = 0;
  String fileName = "Add an attachment";
  List<String> items = [];
  late File image;
  bool isApiCallProcess = false;
  int fullDay = 1;
  String fileAsString = "";

  List<HourType> hourTypes = [];
  String message = "";

  //Colors of days half, full and custom
  Color? colors_1a = Colors.white;
  Color? colors_1b = Colors.grey[500];
  Color? colors_2a = RainbowColor.primary_1;
  Color? colors_2b = Colors.white;
  Color? colors_3a = RainbowColor.primary_1;
  Color? colors_3b = Colors.white;
  int color = 1;

  // this will control the button clicks and tab changing
  late TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  late AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  late AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List _icons = [
    Icons.add,
    Icons.list,
  ];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;

  // active button's background color
  Color _backgroundOn = Colors.blue;
  Color _backgroundOff = Colors.grey;

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  int request = 0;

  bool custom = false;

  @override
  void initState() {
    super.initState();
    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: 2);
    // this will execute the function every time there's a swipe animation
    _controller.animation?.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);

    _animationControllerOff = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
    setList();
    setUserLeaveBalance();
    setUserHours();
    setHourTypeList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: uiBuild(context), inAsyncCall: isApiCallProcess, opacity: 0.5);
  }

  clearAll() {
    setState(() {
      controller_1.clear();
      controller_2.clear();
      controller_3.clear();
      numberController.clear();
      fileName = "Choose file";
      toDateString = "";
      fromDateString = "";
      fileAsString = "";
      DateTime fromDate = DateTime.now().add(const Duration(days: 1));
      DateTime toDate = DateTime.now().add(const Duration(days: 1));
    });
  }

  Widget uiBuild(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: RainbowColor.secondary,
        foregroundColor: RainbowColor.primary_1,
        title: Text(AppLocalizations.of(context)!.requestLeave,
            style: TextStyle(
              fontFamily: RainbowTextStyle.fontFamily,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                  if (request == 0) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    await Future.delayed(const Duration(milliseconds: 300));
                    setState(() {
                      _controller.index = 1;
                      request = 1;
                      setList();
                    });
                  } else {
                    setState(() {
                      _controller.index = 0;
                      request = 0;
                    });
                  }
              },
              icon: Icon(
                request == 0 ? Icons.list : Icons.add,
                size: 30,
              )),
        ],
      ),
      drawer: const Navigation(),
      body: Column(children: [
        const SizedBox(
          height: 5,
        ),
        Flexible(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    child: Form(
                        key: globalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.leaveBalance +
                                        ": ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            RainbowTextStyle.fontFamily),
                                  ),
                                  Text(
                                    userLeaveBalance.toString() +
                                        " " +
                                        AppLocalizations.of(context)!.hours +
                                        " | " +
                                        userLeaveHoursToDays(userLeaveBalance) +
                                        " " +
                                        AppLocalizations.of(context)!.dayss,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            RainbowTextStyle.fontFamily),
                                  ),
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(4, 8),
                                    )
                                  ],
                                ),
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(),
                                    child: DropdownButton(
                                      value:
                                          (newValue != null) ? newValue : null,
                                      focusColor: RainbowColor.primary_1,
                                      iconSize: 30,
                                      icon: const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                          )),
                                      iconEnabledColor: RainbowColor.primary_1,
                                      //Icon color
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          //Font color
                                          fontSize: 18,
                                          //font size on dropdown button
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              RainbowTextStyle.fontFamily),
                                      dropdownColor: RainbowColor.secondary,
                                      //dropdown background color
                                      underline: Container(
                                        width: 0,
                                        height: 0,
                                      ),
                                      //remove underline
                                      isExpanded: true,
                                      //make true to make width 100%
                                      items: hourTypes.map((HourType value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value.usOmschrijving!,
                                              style: TextStyle(
                                                  fontFamily: RainbowTextStyle
                                                      .fontFamily)),
                                        );
                                      }).toList(),
                                      onChanged: (HourType? changedValue) {
                                        setState(() {
                                          newValue = changedValue!;
                                        });
                                      },
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            DateInputField(
                              startDate: fromDateString,
                              endDate: toDateString,
                              onTap: () {
                                _getFromDateFromUser(locale);
                              },
                              onTap_1: () {
                                _getToDateFromUser(locale);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              // height: 50,
                              decoration: BoxDecoration(
                                color: RainbowColor.primary_1,
                                border: Border.all(
                                    color: RainbowColor.primary_1,
                                    width: 3,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(4, 8),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              changeButtonColors(1);
                                              custom = false;
                                              fullDay = 1;
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: colors_1a,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15))),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .wholeDay,
                                                style: TextStyle(
                                                    color: colors_1b,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )))),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            changeButtonColors(2);
                                            custom = false;
                                            fullDay = 2;
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: colors_2a),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .halfDay,
                                                style: TextStyle(
                                                    color: colors_2b,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )))),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            changeButtonColors(3);
                                            custom = true;
                                            fullDay = 3;
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: colors_3a,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15))),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .custom,
                                                style: TextStyle(
                                                    color: colors_3b,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )))),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custom
                                ? Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(4, 8),
                                        )
                                      ],
                                    ),
                                    child: TextField(
                                      controller: numberController,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily:
                                              RainbowTextStyle.fontFamily),
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[500],
                                            fontFamily:
                                                RainbowTextStyle.fontFamily),
                                        border: InputBorder.none,
                                      ),
                                    ))
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            MultiLineInputField(
                                controller: controller_3,
                                title: AppLocalizations.of(context)!.reason),
                            const SizedBox(
                              height: 15,
                            ),
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
                                                onTap: () =>
                                                    _chooseTypeOfFile(context),
                                                child: Text(
                                                  fileName,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          RainbowTextStyle
                                                              .fontFamily),
                                                )))
                                      ],
                                    ))),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(4, 8),
                                    )
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if (validateAndSave()) {
                                      setState(() {
                                        isApiCallProcess = true;
                                      });
                                      sendLeaveRequest(context);
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: RainbowColor.primary_1),
                                      child: Text(
                                        AppLocalizations.of(context)!.request,
                                        style: TextStyle(
                                            color: RainbowColor.secondary,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                RainbowTextStyle.fontFamily),
                                      )),
                                ))
                          ],
                        ))),
              ),
              RefreshIndicator(
                backgroundColor: RainbowColor.secondary,
                color: RainbowColor.primary_1,
                onRefresh: () async {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  await Future.delayed(const Duration(milliseconds: 500));
                  refresh();
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: absences.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Absence2Tile(
                        absence: absences[index],
                      );
                    }),
              )
            ]))
      ]),
    );
  }

  void changeButtonColors(int i) {
    setState(() {
      if (i == 1) {
        colors_1a = Colors.white;
        colors_1b = RainbowColor.primary_1;
        colors_2a = RainbowColor.primary_1;
        colors_2b = Colors.white;
        colors_3a = RainbowColor.primary_1;
        colors_3b = Colors.white;
      } else if (i == 2) {
        colors_1a = RainbowColor.primary_1;
        colors_1b = Colors.white;
        colors_2a = Colors.white;
        colors_2b = RainbowColor.primary_1;
        colors_3a = RainbowColor.primary_1;
        colors_3b = Colors.white;
      } else if (i == 3) {
        colors_1a = RainbowColor.primary_1;
        colors_1b = Colors.white;
        colors_2a = RainbowColor.primary_1;
        colors_2b = Colors.white;
        colors_3a = Colors.white;
        colors_3b = RainbowColor.primary_1;
      }
    });
  }

  void sendLeaveRequest(BuildContext context) {
    if (hours <= hoursAllowed) {
      AbsenceRequest absenceRequest = AbsenceRequest(
        dateFrom: getDateString(fromDate),
        dateTo: getDateString(toDate),
        usId: newValue.usId,
        days: getDateDifferenceInDays(fromDate, toDate),
        uaAantaluren: (fullDay == 1)
            ? fullDayHours
            : (fullDay == 2)
                ? halfDayHours
                : double.parse(numberController.text),
        uaOpmerking: controller_3.text,
        fileBytes: fileAsString,
        typeFile: fileName,
      );
      AbsenceService service = AbsenceService();
      Absence absence = Absence(valid: true);
      if (fromDate.isAfter(DateTime.now()) || toDate.isAfter(DateTime.now())) {
        service.request(absenceRequest)?.then((value) {
          if (value.valid) {
            absence = value;
            clearAll();
            setList();
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
            setState(() {
              isApiCallProcess = false;
            });
          } else {
            setState(() {
              isApiCallProcess = false;
            });
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
        setState(() {
          isApiCallProcess = false;
        });
        SnackBar snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.dateNotAllowed),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        isApiCallProcess = false;
      });
      SnackBar snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.tooManyHours),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _getFromDateFromUser(locale) async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: fromDate,
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
          fromDateString = DateFormat.yMd(locale).format(fromDate);
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
    } else {
      print(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }

  _getToDateFromUser(locale) async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: toDate,
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
        if (pickDate.isAfter(fromDate) || isSameDate(pickDate, fromDate)) {
          toDate = pickDate;
          toDateString = DateFormat.yMd(locale).format(toDate);
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(AppLocalizations.of(context)!.dateAfterFrom),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      // getDateDifferenceInHours(fromDate, pickDate);
    } else {
      print(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }

  Future refresh() async {
    setState(() {
      listLength = 0;
    });
    setList();
    setState(() {
      isApiCallProcess = false;
    });
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
          if (value.length == 1) {
            if (value.first.valid) {
              absences = value;
              listLength = absences.length;
              isApiCallProcess = false;
            } else {
              message = value.first.response!;
              isApiCallProcess = false;
            }
          } else {
            absences = value;
            listLength = absences.length;
            isApiCallProcess = false;
          }
        }
      });
    });
  }

  void setUserLeaveBalance() {
    UserEmployeeService employeeService = UserEmployeeService();
    employeeService.getLeaveBalance().then((value) {
      setState(() {
        userLeaveBalance = value;
        fileName = AppLocalizations.of(context)!.addAttachment;
      });
    });
  }

  getDateString(DateTime date) {
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

  String userLeaveHoursToDays(double userLeaveBalance) {
    if (userLeaveBalance != 0) {
      double number = (userLeaveBalance / 8);
      return number.toStringAsFixed(2).toString();
    }
    return "0";
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  void setUserHours() {
    AbsenceRequest absenceRequest = AbsenceRequest();
    absenceRequest.usId = 0;
    absenceRequest.dateFrom = "";
    absenceRequest.dateTo = "";
    absenceRequest.uaAantaluren = 0;
    absenceRequest.days = 0;
    absenceRequest.uaOpmerking = "";
    absenceRequest.fileBytes = "";
    absenceRequest.typeFile = "";
    AbsenceService absenceService = AbsenceService();
    absenceService.getScheduledHours(absenceRequest).then((value) {
      setState(() {
        hoursAllowed = value;
        fullDayHours = value;
        halfDayHours = (value / 2);
        hours = value;
      });
    });
  }

  void setHourTypeList() {
    AbsenceService service = AbsenceService();
    service.listHourTypes().then((value) {
      setState(() {
        if (value != null) {
          if (value.length == 1) {
            if (value.first.valid) {
              hourTypes = value;
              newValue = value.first;
            } else {
              message = value.first.response!;
            }
          } else {
            hourTypes = value;
            newValue = value.first;
          }
        }
      });
    });
  }

  bool isSameDate(DateTime pickDate, DateTime fromDate) {
    String date = getDateString(pickDate);
    String otherDate = getDateString(fromDate);
    if (pickDate.year == fromDate.year &&
        pickDate.month == fromDate.month &&
        pickDate.day == fromDate.day) {
      return true;
    }
    return false;
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation!.value ?? 0;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return RainbowColor.primary_1;
    } else {
      // if the button is inactive
      return RainbowColor.secondary;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return Colors.white;
    } else {
      return RainbowColor.primary_1;
    }
  }
}
