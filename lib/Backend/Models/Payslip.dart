import 'dart:convert';
import 'dart:typed_data'; //Bundled with Dart

import 'package:flutter/services.dart';
import 'package:rainbow_app/Backend/Models/Employee.dart';

import 'UserModel.dart';

class Payslip {
  int? beCode;
  String? beNaam;
  String? beAdres;
  String? beLand;
  DateTime? peDatumVan;
  DateTime? peDatumTm;
  String? vaCode;
  String? klant;
  String? emCode;
  String? employeeNaam;
  int? emId;
  String? emIdNr;
  String? emNaam;
  String? emVoornaam;
  String? emAdres;
  String? emWoonplaats;
  int? hsJaar;
  int? hsPeriode;
  DateTime? emIndienstDat;
  DateTime? emUitdienstDat;
  String? afCode;
  String? afOmschrijving;
  String? fiCode;
  String? fiOmschrijving;
  String? scCode;
  String? scOmschrijving;
  String? fuCode;
  String? fuOmschrijving;
  String? emLoonType;
  num? emPerLoon;
  num? emUurLoon;
  String? btType1;
  String? btOmschrijving1;
  String? hsRekening1;
  String? hsBank1;
  double? hsBedrag1;
  String? hsVaCode1;
  String? beTaalLoonslip;
  num? hsVacantieSaldo;
  num? debet;
  String? loOmschrijving;
  int? loCode;
  String? loType;
  String? loKlasse;
  String? loSalderend;
  String? loVaCode;
  String? loNette;
  String? loLoonslip;
  String? loBijzloon;
  String? loBelastbaar;
  String? loCalculatie;
  String? hmExtraVerw;
  num? hmFactor;
  num? hmPerBedrag;
  double? hmExtraBedrag1;
  double? hmBelastVrij;
  double? hmRente;
  double? hmCumVa;
  double? hmCumBedrag;
  String? hmActief;
  num? hsDagLoon;
  double? hsUrenPerWeek;
  String? wtCode;
  String? beVaCode;
  String? beTelefoon;
  String? logo;
  String? orderBy;
  String? applicationName;
  String? historical;
  String? response;
  bool valid;

  Payslip({
    this.beCode,
    this.beNaam,
    this.beAdres,
    this.beLand,
    this.peDatumVan,
    this.peDatumTm,
    this.vaCode,
    this.klant,
    this.emCode,
    this.employeeNaam,
    this.emId,
    this.emIdNr,
    this.emNaam,
    this.emVoornaam,
    this.emAdres,
    this.emWoonplaats,
    this.hsJaar,
    this.hsPeriode,
    this.emIndienstDat,
    this.emUitdienstDat,
    this.afCode,
    this.afOmschrijving,
    this.fiCode,
    this.fiOmschrijving,
    this.scCode,
    this.scOmschrijving,
    this.fuCode,
    this.fuOmschrijving,
    this.emLoonType,
    this.emPerLoon,
    this.emUurLoon,
    this.btType1,
    this.btOmschrijving1,
    this.hsRekening1,
    this.hsBank1,
    this.hsBedrag1,
    this.hsVaCode1,
    this.beTaalLoonslip,
    this.hsVacantieSaldo,
    this.debet,
    this.loOmschrijving,
    this.loCode,
    this.loType,
    this.loKlasse,
    this.loSalderend,
    this.loVaCode,
    this.loNette,
    this.loLoonslip,
    this.loBijzloon,
    this.loBelastbaar,
    this.loCalculatie,
    this.hmExtraVerw,
    this.hmFactor,
    this.hmPerBedrag,
    this.hmExtraBedrag1,
    this.hmBelastVrij,
    this.hmRente,
    this.hmCumVa,
    this.hmCumBedrag,
    this.hmActief,
    this.hsDagLoon,
    this.hsUrenPerWeek,
    this.wtCode,
    this.beVaCode,
    this.beTelefoon,
    this.logo,
    this.orderBy,
    this.applicationName,
    this.historical,
    this.response,
    required this.valid,
  });

  String fromFileJson(List<dynamic> json) {
    return json[0].toString();
  }

  List<Payslip> configureListFromJson(List<dynamic> json) {
    List<Payslip> payslips = [];
    for (int q = 0; q <= json.length - 1; q++) {
      if (json[q]["list"][0]["list"] != null) {
        List<dynamic> data = json[q]["list"][0]["list"];
        for (int i = 0; i <= data.length - 1; i++) {
          // Payslip payslip = Payslip.fromJson(json[i]);
          if (data[i]['loCode'] == 9997) {
            Payslip payslip = Payslip(valid: true);
            payslip.response = "";
            payslip.beCode = data[i]['beCode'] as int;
            payslip.beNaam = data[i]['beNaam'] as String;
            payslip.beAdres = data[i]['beAdres'] as String;
            payslip.beLand = data[i]['beLand'] as String;
            payslip.peDatumVan =
                DateTime.parse(data[i]['peDatumVan'] as String);
            payslip.peDatumTm = DateTime.parse(data[i]['peDatumTm'] as String);
            payslip.vaCode = data[i]['vaCode'] as String;
            payslip.klant = data[i]['klant'] as String;
            payslip.emCode = data[i]['emCode'] as String;
            payslip.employeeNaam = data[i]['employeeNaam'] as String;
            payslip.emId = data[i]['emId'] as int;
            payslip.emIdNr = data[i]['emIdNr'] as String;
            payslip.emNaam = data[i]['emNaam'] as String;
            payslip.emVoornaam = data[i]['emVoornaam'] as String;
            payslip.emAdres = data[i]['emAdres'] as String;
            payslip.emWoonplaats = data[i]['emWoonplaats'] as String;
            payslip.hsJaar = data[i]['hsJaar'] as int;
            payslip.hsPeriode = data[i]['hsPeriode'] as int;
            payslip.emIndienstDat =
                DateTime.parse(data[i]['emIndienstDat'] as String);
            // final emUitdienstDat = DateTime.parse(json['emUitdienstDat'] as String);
            payslip.afCode = data[i]['afCode'] as String;
            payslip.afOmschrijving = data[i]['afOmschrijving'] as String;
            payslip.fiCode = data[i]['fiCode'] as String;
            payslip.fiOmschrijving = data[i]['fiOmschrijving'] as String;
            payslip.scCode = data[i]['scCode'] as String;
            payslip.scOmschrijving = data[i]['scOmschrijving'] as String;
            payslip.fuCode = data[i]['fuCode'] as String;
            payslip.fuOmschrijving = data[i]['fuOmschrijving'] as String;
            payslip.emLoonType = data[i]['emLoonType'] as String;
            payslip.emPerLoon = double.tryParse(data[i]['emPerLoon'].toString());
            payslip.emUurLoon = double.tryParse(data[i]['emUurLoon'].toString());
            payslip.btType1 = data[i]['btType1'] as String;
            payslip.btOmschrijving1 = data[i]['btOmschrijving1'] as String;
            payslip.hsRekening1 = data[i]['hsRekening1'] as String;
            payslip.hsBank1 = data[i]['hsBank1'] as String;
            payslip.hsBedrag1 = double.tryParse(data[i]['hsBedrag1'].toString());
            payslip.hsVaCode1 = data[i]['hsVaCode1'] as String;
            payslip.beTaalLoonslip = data[i]['beTaalLoonslip'] as String;
            payslip.hsVacantieSaldo = data[i]['hsVacantieSaldo'] as double?;
            payslip.debet = data[i]['debet'] as num;
            payslip.loOmschrijving = data[i]['loOmschrijving'] as String;
            payslip.loCode = data[i]['loCode'] as int;
            payslip.loType = data[i]['loType'] as String;
            payslip.loKlasse = data[i]['loKlasse'] as String;
            payslip.loSalderend = data[i]['loSalderend'] as String;
            payslip.loVaCode = data[i]['loVaCode'] as String;
            payslip.loNette = data[i]['loNette'] as String;
            payslip.loLoonslip = data[i]['loLoonslip'] as String;
            payslip.loBijzloon = data[i]['loBijzloon'] as String;
            payslip.loBelastbaar = data[i]['loBelastbaar'] as String;
            payslip.loCalculatie = data[i]['loCalculatie'] as String;
            payslip.hmExtraVerw = data[i]['hmExtraVerw'] as String;
            payslip.hmFactor = data[i]['hmFactor'] as num;
            payslip.hmPerBedrag = data[i]['hmPerBedrag'] as num;
            // payslip.hmExtraBedrag1 = json[i]['hmExtraBedrag1'] as num;
            // payslip.hmBelastVrij = json[i]['hmBelastVrij'] as num;
            // payslip.hmRente = json[i]['hmRente'] as num;
            // payslip.hmCumVa = json[i]['hmCumVa'] as num;
            // payslip.hmCumBedrag = json[i]['hmCumBedrag'] as num;
            payslip.hmActief = data[i]['hmActief'] as String;
            payslip.hsDagLoon = data[i]['hsDagLoon'] as double?;
            payslip.hsUrenPerWeek = double.tryParse(data[i]['hsUrenPerWeek'].toString());
            payslip.wtCode = data[i]['wtCode'] as String;
            payslip.beVaCode = data[i]['beVaCode'] as String;
            payslip.beTelefoon = data[i]['beTelefoon'] as String;
            payslip.logo = data[i]['logo'] as String;
            payslip.orderBy = data[i]['orderBy'] as String;
            payslip.applicationName = data[i]['applicationName'] as String;
            payslip.historical = data[i]['historical'] as String;
            payslip.valid = true;
            payslip.response = "";
            payslips.add(payslip);
          }
        }
      }
    }

    return payslips;
  }

  factory Payslip.fromJson(Map<String, dynamic> json) {
    final beCode = json['beCode'] as int;
    final beNaam = json['beNaam'] as String;
    final beAdres = json['beAdres'] as String;
    final beLand = json['beLand'] as String;
    final peDatumVan = DateTime.parse(json['peDatumVan'] as String);
    final peDatumTm = DateTime.parse(json['peDatumTm'] as String);
    final vaCode = json['vaCode'] as String;
    final klant = json['klant'] as String;
    final emCode = json['emCode'] as String;
    final employeeNaam = json['employeeNaam'] as String;
    final emId = json['emId'] as int;
    final emIdNr = json['emIdNr'] as String;
    final emNaam = json['emNaam'] as String;
    final emVoornaam = json['emVoornaam'] as String;
    final emAdres = json['emAdres'] as String;
    final emWoonplaats = json['emWoonplaats'] as String;
    final hsJaar = json['hsJaar'] as int;
    final hsPeriode = json['hsPeriode'] as int;
    final emIndienstDat = DateTime.parse(json['emIndienstDat'] as String);
    // final emUitdienstDat = DateTime.parse(json['emUitdienstDat'] as String);
    final afCode = json['afCode'] as String;
    final afOmschrijving = json['afOmschrijving'] as String;
    final fiCode = json['fiCode'] as String;
    final fiOmschrijving = json['fiOmschrijving'] as String;
    final scCode = json['scCode'] as String;
    final scOmschrijving = json['scOmschrijving'] as String;
    final fuCode = json['fuCode'] as String;
    final fuOmschrijving = json['fuOmschrijving'] as String;
    final emLoonType = json['emLoonType'] as String;
    final emPerLoon = json['emPerLoon'] as num;
    final emUurLoon = json['emUurLoon'] as num;
    final btType1 = json['btType1'] as String;
    final btOmschrijving1 = json['btOmschrijving1'] as String;
    final hsRekening1 = json['hsRekening1'] as String;
    final hsBank1 = json['hsBank1'] as String;
    final hsBedrag1 = json['hsBedrag1'] as double;
    final hsVaCode1 = json['hsVaCode1'] as String;
    final beTaalLoonslip = json['beTaalLoonslip'] as String;
    final hsVacantieSaldo = json['hsVacantieSaldo'] as num;
    final debet = json['debet'] as num;
    final loOmschrijving = json['loOmschrijving'] as String;
    final loCode = json['loCode'] as int;
    final loType = json['loType'] as String;
    final loKlasse = json['loKlasse'] as String;
    final loSalderend = json['loSalderend'] as String;
    final loVaCode = json['loVaCode'] as String;
    final loNette = json['loNette'] as String;
    final loLoonslip = json['loLoonslip'] as String;
    final loBijzloon = json['loBijzloon'] as String;
    final loBelastbaar = json['loBelastbaar'] as String;
    final loCalculatie = json['loCalculatie'] as String;
    final hmExtraVerw = json['hmExtraVerw'] as String;
    final hmFactor = json['hmFactor'] as num;
    final hmPerBedrag = json['hmPerBedrag'] as num;
    // final hmExtraBedrag1 = json['hmExtraBedrag1'] as double;
    // final hmBelastVrij = json['hmBelastVrij'] as double;
    // final hmRente = json['hmRente'] as double;
    // final hmCumVa = json['hmCumVa'] as double;
    // final hmCumBedrag = json['hmCumBedrag'] as double;
    final hmActief = json['hmActief'] as String;
    final hsDagLoon = json['hsDagLoon'] as num;
    final hsUrenPerWeek = double.tryParse(json['hsUrenPerWeek'].toString());
    final wtCode = json['wtCode'] as String;
    final beVaCode = json['beVaCode'] as String;
    final beTelefoon = json['beTelefoon'] as String;
    final logo = json['logo'] as String;
    final orderBy = json['orderBy'] as String;
    final applicationName = json['applicationName'] as String;
    final historical = json['historical'] as String;

    return Payslip(
      beCode: beCode,
      beNaam: beNaam,
      beAdres: beAdres,
      beLand: beLand,
      peDatumVan: peDatumVan,
      peDatumTm: peDatumTm,
      vaCode: vaCode,
      klant: klant,
      emCode: emCode,
      employeeNaam: employeeNaam,
      emId: emId,
      emIdNr: emIdNr,
      emNaam: emNaam,
      emVoornaam: emVoornaam,
      emAdres: emAdres,
      emWoonplaats: emWoonplaats,
      hsJaar: hsJaar,
      hsPeriode: hsPeriode,
      emIndienstDat: emIndienstDat,
      // emUitdienstDat: emUitdienstDat,
      afCode: afCode,
      afOmschrijving: afOmschrijving,
      fiCode: fiCode,
      fiOmschrijving: fiOmschrijving,
      scCode: scCode,
      scOmschrijving: scOmschrijving,
      fuCode: fuCode,
      fuOmschrijving: fuOmschrijving,
      emLoonType: emLoonType,
      emPerLoon: emPerLoon,
      emUurLoon: emUurLoon,
      btType1: btType1,
      btOmschrijving1: btOmschrijving1,
      hsRekening1: hsRekening1,
      hsBank1: hsBank1,
      hsBedrag1: hsBedrag1,
      hsVaCode1: hsVaCode1,
      beTaalLoonslip: beTaalLoonslip,
      hsVacantieSaldo: hsVacantieSaldo,
      debet: debet,
      loOmschrijving: loOmschrijving,
      loCode: loCode,
      loType: loType,
      loKlasse: loKlasse,
      loSalderend: loSalderend,
      loVaCode: loVaCode,
      loNette: loNette,
      loLoonslip: loLoonslip,
      loBijzloon: loBijzloon,
      loBelastbaar: loBelastbaar,
      loCalculatie: loCalculatie,
      hmExtraVerw: hmExtraVerw,
      hmFactor: hmFactor,
      hmPerBedrag: hmPerBedrag,
      // hmExtraBedrag1: hmExtraBedrag1,
      // hmBelastVrij: hmBelastVrij,
      // hmRente: hmRente,
      // hmCumVa: hmCumVa,
      // hmCumBedrag: hmCumBedrag,
      hmActief: hmActief,
      hsDagLoon: hsDagLoon,
      hsUrenPerWeek: hsUrenPerWeek,
      wtCode: wtCode,
      beVaCode: beVaCode,
      beTelefoon: beTelefoon,
      logo: logo,
      orderBy: orderBy,
      applicationName: applicationName,
      historical: historical,
      response: '', valid: true,
    );
  }
}

class PayslipRequestModel {
  String? token = LoggedInUser.loggedInUser!.token;
  int? year;
  int? period;

  PayslipRequestModel({required this.year, this.period});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "beCode": 10,
      "peJaar": year,
      "languageNumber": 1,
      "sortSlip": 1,
      "concept": "N"
    };
    return map;
  }

  Map<String, dynamic> toFileJson() {
    Map<String, dynamic> map = {
      "peJaar": year,
      "peCode": period,
      "typeVerw": "N",
    };
    return map;
  }
}
