// To parse this JSON data, do
//
//     final patientJson = patientJsonFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<PatientJson> patientJsonFromJson(String str) => List<PatientJson>.from(
    json.decode(str).map((x) => PatientJson.fromJson(x)));

String patientJsonToJson(List<PatientJson> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientJson {
  PatientJson({
    this.id,
    this.pId,
    this.illness,
    this.date,
    this.status,
    this.secondStatus,
  });

  int? id;
  int? pId;
  String? illness;
  DateTime? date;
  Status? status;
  DateTime? secondStatus;

  factory PatientJson.fromJson(Map<String, dynamic> json) => PatientJson(
        id: json["id"],
        pId: json["P_id"],
        illness: json["illness"],
        date: DateTime.parse(json["date"]),
        status: statusValues.map[json["status"]],
        secondStatus: DateTime.parse(json["second_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "P_id": pId,
        "illness": illness,
        "date": date!.toIso8601String(),
        "status": statusValues.reverse[status],
        "second_status": secondStatus?.toIso8601String(),
      };
}

enum Status { CURED, STATUS_CURED, DECEASED }

final statusValues = EnumValues({
  "CURED": Status.CURED,
  "Deceased": Status.DECEASED,
  "Cured": Status.STATUS_CURED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (reverseMap == null) {
      // ignore: unnecessary_new
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
