// To parse this JSON data, do
//
//     final employeesModel = employeesModelFromJson(jsonString);

import 'dart:convert';

List<DtrModel> dtrModelFromJson(String str) =>
    List<DtrModel>.from(json.decode(str).map((x) => DtrModel.fromJson(x)));

String dtrModelToJson(List<DtrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DtrModel {
  DtrModel({
    this.id,
    this.curdate,
    this.amin,
    this.amout,
    this.pmin,
    this.pmout,
    this.diy,
    this.wik,
  });

  String? id;
  String? curdate;
  String? amin;
  String? amout;
  String? pmin;
  String? pmout;
  String? diy;
  String? wik;

  factory DtrModel.fromJson(Map<String, dynamic> json) => DtrModel(
        id: json["id"],
        curdate: json["curdate"],
        amin: json["amin"],
        amout: json["amout"],
        pmin: json["pmin"],
        pmout: json["pmout"],
        diy: json["diy"],
        wik: json["wik"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "curdate": curdate,
        "amin": amin,
        "amout": amout,
        "pmin": pmin,
        "pmout": pmout,
        "diy": diy,
        "wik": wik,
      };
}
