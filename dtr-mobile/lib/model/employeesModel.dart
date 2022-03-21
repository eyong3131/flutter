// To parse this JSON data, do
//
//     final employeesModel = employeesModelFromJson(jsonString);

import 'dart:convert';

List<EmployeesModel> employeesModelFromJson(String str) =>
    List<EmployeesModel>.from(
        json.decode(str).map((x) => EmployeesModel.fromJson(x)));

String employeesModelToJson(List<EmployeesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeesModel {
  EmployeesModel({
    this.id,
    this.name,
    this.firstname,
    this.middlename,
    this.lastname,
    this.image,
    this.position,
    this.department,
    this.guard,
    this.hash,
    this.email,
  });

  String? id;
  String? name;
  String? firstname;
  String? middlename;
  String? lastname;
  String? image;
  String? position;
  String? department;
  String? guard;
  String? hash;
  String? email;

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        id: json["id"],
        name: json["name"],
        firstname: json["firstname"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        image: json["image"],
        position: json["position"],
        department: json["department"],
        guard: json["guard"],
        hash: json["hash"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "image": image,
        "position": position,
        "department": department,
        "guard": guard,
        "hash": hash,
        "email": email,
      };
}
