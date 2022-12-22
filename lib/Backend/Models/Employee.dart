class Employee {
  int? emId;
  String? emNaam;
  String? emVoorNaam;
  String? emStatus;
  Bedrijf? bedrijf;
  String? emCode;
  HrmFunctie? hrmFunctie;
  Filiaal? filiaal;
  HrmAfdeling? hrmAfdeling;
  String? emTelefoon;
  String? email;
  DateTime? emInDienstDat;
  Photo? photo;
  String? emIdNr;

  Employee({
    this.emId,
    this.emNaam,
    this.emVoorNaam,
    this.emStatus,
    this.bedrijf,
    this.emCode,
    this.hrmFunctie,
    this.filiaal,
    this.hrmAfdeling,
    this.emTelefoon,
    this.email,
    this.emInDienstDat,
    this.photo,
    this.emIdNr,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    final emId = json['emId'] as int;
    final emNaam = json['emNaam'] as String;
    final emVoorNaam = json['emVoorNaam'] as String;
    final emStatus = json['emStatus'] as String;
    Bedrijf _bedrijf = Bedrijf();
    _bedrijf.beCode = json['bedrijf']['beCode'] as int;
    _bedrijf.beNaam = json['bedrijf']['beNaam'] as String;
    _bedrijf.beAdres = json['bedrijf']['beAdres'] as String;
    _bedrijf.beLand = json['bedrijf']['beLand'] as String;
    _bedrijf.beTelefoon = json['bedrijf']['beTelefoon'] as String;
    _bedrijf.beVestiging = json['bedrijf']['beVestiging'] as String;
    final bedrijf = _bedrijf;
    final emCode = json['emCode'] as String;
    HrmFunctie _hrmFunctie = HrmFunctie();
    _hrmFunctie.fuCode = json['hrmFunctie']['fuCode'] as String;
    _hrmFunctie.fuOmschrijving = json['hrmFunctie']['fuOmschrijving'] as String;
    final hrmFunctie = _hrmFunctie;
    Filiaal _filiaal = Filiaal();
    _filiaal.fiCode = json['filiaal']['fiCode'] as String;
    _filiaal.fiOmschrijving = json['filiaal']['fiOmschrijving'] as String;
    final filiaal = _filiaal;
    HrmAfdeling _hrmAfdeling = HrmAfdeling();
    Division _division = Division();
    _division.diCode = json['hrmAfdeling']['division']['diCode'] as String;
    _division.diOmschrijving =
        json['hrmAfdeling']['division']['diOmschrijving'] as String;
    _hrmAfdeling.afCode = json['hrmAfdeling']['afCode'] as String;
    _hrmAfdeling.afOmschrijving =
        json['hrmAfdeling']['afOmschrijving'] as String;
    _hrmAfdeling.division = _division;
    final hrmAfdeling = _hrmAfdeling;
    final emTelefoon = json['emTelefoon'] as String;
    final email = json['email'] as String;
    final emInDienstDat =
        DateTime.fromMillisecondsSinceEpoch(json['emInDienstDat'] as int);
    final emIdNr = json['emIdNr'] as String;
    Photo _photo = Photo();
    if (json['photo'] != null) {
      _photo.phId = json['photo']['phId'] as int;
      _photo.phFile = json['photo'][0]['phFile'] as String;
      _photo.phImage = json['photo']['phImage'][0] as String;
      _photo.phType = json['photo'][0]['phType'] as String;
    }
    final photo = _photo;
    return Employee(
      emId: emId,
      emNaam: emNaam,
      emVoorNaam: emVoorNaam,
      emStatus: emStatus,
      bedrijf: bedrijf,
      emCode: emCode,
      hrmFunctie: hrmFunctie,
      filiaal: filiaal,
      hrmAfdeling: hrmAfdeling,
      emTelefoon: emTelefoon,
      email: email,
      emInDienstDat: emInDienstDat,
      photo: photo,
      emIdNr: emIdNr,
    );
  }
}

class Bedrijf {
  int? beCode;
  String? beNaam;
  String? beAdres;
  String? beLand;
  String? beTelefoon;
  String? beVestiging;

  Bedrijf({
    this.beCode,
    this.beNaam,
    this.beAdres,
    this.beLand,
    this.beTelefoon,
    this.beVestiging,
  });
}

class HrmFunctie {
  String? fuCode;
  String? fuOmschrijving;

  HrmFunctie({
    this.fuCode,
    this.fuOmschrijving,
  });
}

class Filiaal {
  String? fiCode;
  String? fiOmschrijving;
  Filiaal({
    this.fiCode,
    this.fiOmschrijving,
  });
}

class HrmAfdeling {
  String? afCode;
  String? afOmschrijving;
  Division? division;
  HrmAfdeling({
    this.afCode,
    this.afOmschrijving,
    this.division,
  });
}

class Division {
  String? diCode;
  String? diOmschrijving;
  Division({
    this.diCode,
    this.diOmschrijving,
  });
}

class Photo {
  int? phId;
  String? phFile;
  String? phImage;
  String? phType;
  Photo({
    this.phId,
    this.phFile,
    this.phImage,
    this.phType,
  });
}
