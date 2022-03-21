// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

List<SettingsModel> settingsModelFromJson(String str) =>
    List<SettingsModel>.from(
        json.decode(str).map((x) => SettingsModel.fromJson(x)));

String settingsModelToJson(List<SettingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingsModel {
  SettingsModel({
    this.site,
    this.apiurl,
    this.interval,
    this.username,
    this.password,
    this.amin,
    this.amout,
    this.pmin,
    this.pmout,
    this.workexp,
  });

  String? site;
  String? interval;
  String? apiurl;
  String? username;
  String? password;
  String? amin;
  String? amout;
  String? pmin;
  String? pmout;
  String? workexp;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        site: json["site"],
        interval: json["interval"],
        apiurl: json["apiurl"],
        username: json["username"],
        password: json["password"],
        amin: json["amin"],
        amout: json["amout"],
        pmin: json["pmin"],
        pmout: json["pmout"],
        workexp: json["workexp"],
      );

  Map<String, dynamic> toJson() => {
        "site": site,
        "interval": interval,
        "apiurl": apiurl,
        "username": username,
        "password": password,
        "amin": amin,
        "amout": amout,
        "pmin": pmin,
        "pmout": pmout,
        "workexp": workexp,
      };
}
