// To parse this JSON data, do
//
//     final progList = progListFromJson(jsonString);

import 'dart:convert';

List<ProgList> progListFromJson(String str) =>
    List<ProgList>.from(json.decode(str).map((x) => ProgList.fromJson(x)));

String progListToJson(List<ProgList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProgList {
  ProgList({
    this.programAcronym,
  });

  String? programAcronym;

  factory ProgList.fromJson(Map<String, dynamic> json) => ProgList(
        programAcronym: json["PROGRAM_ACRONYM"],
      );

  Map<String, dynamic> toJson() => {
        "PROGRAM_ACRONYM": programAcronym,
      };
}
