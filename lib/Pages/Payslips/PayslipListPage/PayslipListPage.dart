import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Backend/APIS/PayslipService.dart';
import 'package:rainbow_app/Backend/Models/DateInfo.dart';
import 'package:rainbow_app/Components/Tiles/PayslipTile.dart';

import '../../../Backend/APIS/UserEmployeeService.dart';
import '../../../Backend/Models/Payslip.dart';
import '../../../Components/Navigation.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

Future<List<Payslip>?> setList(year) async {
  PayslipService payslipService = PayslipService();
  PayslipRequestModel payslipRequestModel = PayslipRequestModel(year: year);
  return await payslipService.getList(payslipRequestModel);
}

class PayslipListPage extends StatefulWidget {
  PayslipListPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/payslips';

  @override
  State<PayslipListPage> createState() => _PayslipListPageState();
}

class _PayslipListPageState extends State<PayslipListPage> {
  late Future<List<Payslip>?> futurePayslips;

  // List<Payslip> payslipList = [];
  // int listLength = 0;
  late PayslipRequestModel payslipRequestModel;
  late String locale = Localizations.localeOf(context).languageCode;
  List<int> years = [];
  int year = DateTime.now().year;
  bool _isLoading = false;
  String message = "";

  @override
  void initState() {
    super.initState();
    futurePayslips = setList(year);
    setEmployeeYears();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RainbowColor.secondary,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.payslips,
                style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
            DropdownButton(
              underline: Container(),
              //remove underline
              icon: const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Icon(Icons.arrow_circle_down_sharp)),
              iconEnabledColor: RainbowColor.primary_1,
              //Icon color
              style: TextStyle(
                  color: RainbowColor.primary_1, //Font color
                  fontSize: 18, //font size on dropdown button
                  fontFamily: RainbowTextStyle.fontFamily),
              dropdownColor: RainbowColor.secondary,
              //dropdown background color
              isExpanded: false,
              //make true to make width 100%
              value: year,
              items: years.map((e) {
                return DropdownMenuItem(value: e, child: Text(e.toString()));
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  _isLoading = false;
                  year = value!;
                  futurePayslips = setList(year);
                });
              },
            ),
          ],
        ),
        backgroundColor: RainbowColor.secondary,
      ),
      drawer: const Navigation(),
      body: FutureBuilder<List<Payslip>?>(
        future: futurePayslips,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int? dataLength = snapshot.data?.length;
            if(dataLength != null && dataLength > 0) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PayslipTile(payslip: snapshot.data![index]);
                  });
            }else{
              return  Center(
                child: Text(AppLocalizations.of(context)!.noPayslipsFound,
                    style: TextStyle(fontFamily: RainbowTextStyle.fontFamily,fontSize: 20)),
              );
            }
            // return Text('${snapshot.data?.length}');
          } else if (snapshot.hasError) {
            print(snapshot.stackTrace);
            return Text('${snapshot.stackTrace}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  // Future refresh() async {
  //   setState(() {
  //     setList(year);
  //   });
  // }

  // void setList(int year) {
  //   PayslipService payslipService = PayslipService();
  //   payslipRequestModel = PayslipRequestModel(year: year);
  //   payslipService.getList(payslipRequestModel).then((value) {
  //     setState(() {
  //       if (value != null) {
  //         if (value.length == 1) {
  //           if (value.first.valid) {
  //             payslipList = value;
  //             listLength = payslipList.length;
  //             _isLoading = true;
  //           } else {
  //             message = value.first.response!;
  //             _isLoading = true;
  //           }
  //         } else {
  //           payslipList = value;
  //           listLength = payslipList.length;
  //           _isLoading = true;
  //         }
  //       }
  //     });
  //   });
  // }

  void setEmployeeYears() {
    UserEmployeeService service = UserEmployeeService();
    service.getEmployeeInfo().then((value) {
      setState(() {
        if (value.valid) {
          if (value.emInDienstDat != null) {
            final startYear = value.emInDienstDat?.year;
            int i = year - startYear!;
            setYearList(i);
          }
        }
      });
    });
  }

  void setYearList(int yearsAsEmployee) {
    for (int i = 0; i <= yearsAsEmployee; i++) {
      years.add(year - i);
    }
  }
}
