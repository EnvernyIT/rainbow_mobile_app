import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Backend/Models/DateInfo.dart';
import 'package:rainbow_app/Components/Tiles/PayslipTile.dart';

import '../../../Backend/Models/Payslip.dart';
import '../../../Components/Navigation.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class PayslipListPage extends StatefulWidget {
  PayslipListPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/payslips';

  @override
  State<PayslipListPage> createState() => _PayslipListPageState();
}

class _PayslipListPageState extends State<PayslipListPage> {
  List<Payslip> payslipList = Payslip.payslips;
  int listLength = Payslip.payslips.length;
  late String locale = Localizations.localeOf(context).languageCode;
  late String month = DateFormat.MMMM(locale).format(DateTime.now()).toString();
  late String year = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var months = DateInfo(context: context, locale: locale);
    var years = DateInfo(context: context, locale: locale);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          foregroundColor: RainbowColor.primary_1,
          bottomOpacity: 0,
          title: Text(AppLocalizations.of(context)!.payslips,
              style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
          backgroundColor: RainbowColor.secondary,
        ),
        drawer: const Navigation(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton(
                          iconEnabledColor: RainbowColor.primary_1, //Icon color
                          isExpanded: false, //make true to make width 100%
                          value: month,
                          style: TextStyle(
                              color: RainbowColor.primary_1, //Font color
                              fontSize: 17, //font size on dropdown button
                              fontFamily: RainbowTextStyle.fontFamily),
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(Icons.arrow_circle_down_sharp),
                          ),
                          items: months.getMonths().map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,
                                  style: TextStyle(
                                      fontFamily: RainbowTextStyle.fontFamily)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              month = newValue!;
                            });
                          }),
                      DropdownButton(
                          isExpanded: false, //make true to make width 100%
                          iconEnabledColor: RainbowColor.primary_1, //Icon color
                          value: year,
                          style: TextStyle(
                              color: RainbowColor.primary_1, //Font color
                              fontSize: 17, //font size on dropdown button
                              fontFamily: RainbowTextStyle.fontFamily),
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(Icons.arrow_circle_down_sharp),
                          ),
                          items: years.getYears().map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,
                                  style: TextStyle(
                                      fontFamily: RainbowTextStyle.fontFamily)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              year = newValue!;
                            });
                          }),
                      InkWell(
                        onTap: () {
                          setState(() {
                            setList(month, year);
                          });
                        },
                        child: Icon(
                          Icons.search_outlined,
                          color: RainbowColor.primary_1,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                RefreshIndicator(
                    backgroundColor: RainbowColor.secondary,
                    color: RainbowColor.primary_1,
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listLength,
                            itemBuilder: (BuildContext context, int index) {
                              return PayslipTile(payslip: payslipList[index]);
                            }))),
              ],
            ),
          ),
        ));
  }

  Future refresh() async {
    setState(() {});
  }

  void setList(String? month, String? year) {
    List<Payslip> newPayslipList = [];
    for (int i = 0; i <= (Payslip.payslips.length - 1); i++) {
      if (DateFormat.MMMM(Localizations.localeOf(context).languageCode)
                  .format(Payslip.payslips[i].date) ==
              month &&
          Payslip.payslips[i].date.year.toString() == year) {
        newPayslipList.add(Payslip.payslips[i]);
      }
    }
    setState(() {
      payslipList = newPayslipList;
      listLength = payslipList.length;
    });
  }
}
