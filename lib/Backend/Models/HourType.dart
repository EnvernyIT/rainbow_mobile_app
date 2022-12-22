import 'dart:core';
import 'dart:core';

class HourType {
  int? usId;
  String? usCode;
  String? usOmschrijving;
  String? usAccorderen;
  String? usInduren;
  String? uuType;
  Proces? proces;
  String? usCategorie;
  String? balance;
  String? indActive;
  String? caption;

  HourType({
    this.usId,
    this.usCode,
    this.usOmschrijving,
    this.usAccorderen,
    this.usInduren,
    this.uuType,
    this.proces,
    this.usCategorie,
    this.balance,
    this.indActive,
    this.caption,
  });
}

enum HourTypeId {
  WORK(1000),
  TURN(1001),
  OVER(1002),
  SPEC(1003),
  SICK(1004),
  ANNU(1005),
  UNP(1006),
  SUSP(1007),
  AWP(1008),
  BEVA(1009),
  HUWE(1010),
  OVERL(1011),
  JUBI(1012),
  VERHUI(1013),
  TRAIN(1014),
  OVERSA(1018),
  OVERSU(1019),
  OVERHO(1020),
  OVERNIGHT(1021),
  OVERPRE(1022);

  const HourTypeId(this.value);
  final num value;
}

class Proces {
  int? kpId;
  String? kpOmschrijving;
  String? kpSchedule;
  String? kpSendReminder;
  String? kpType;
  String? caption;

  Proces({
    this.kpId,
    this.kpOmschrijving,
    this.kpSchedule,
    this.kpSendReminder,
    this.kpType,
    this.caption,
  });
}
