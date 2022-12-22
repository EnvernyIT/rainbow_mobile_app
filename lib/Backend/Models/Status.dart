import 'package:rainbow_app/Backend/Models/HourType.dart';

class Status {
  int? statusNumber;
  String? ksOmschrijving;
  Proces? proces;
  String? caption;

  Status({
    this.statusNumber,
    this.ksOmschrijving,
    this.proces,
    this.caption,
  });
}

class Standardstatus {
  static final int PR_70_REGISTERED = 104;
  static final int PR_70_APPROVED = 105;
  static final int PR_70_REJECTED = 106;
  static final int PR_70_LEAVE_BALANCE_ADJUSTED = 1070;

  static final int PR_510_OPEN = 510;
  static final int PR_510_CLOSED_TIMEKEEPING = 511;
  static final int PR_510_CLOSED_PAY_PERIOD = 512;
  static final int PR_510_PRE_CALCULATION = 513;
  static final int PR_510_CORRECTION_CALCULATION = 514;
  static final int PR_510_TOESLAAN_AFSLUITING = 515;
  static final int PR_510_GENERATE_HOURS = 528;
  static final int PR_510_PROCESS_CHECKINOUT_TIME = 540;

  static final int PR_7200_TOESTEMMING_GEVEN = 7201;
  static final int PR_7200_TOESTEMMING_EXPORTEREN = 7202;
  static final int PR_7200_TOESTEMMING_GEEXPORTEERD = 7203;
}
