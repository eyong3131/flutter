// ignore: employeeModel

// ignore_for_file: file_names

import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(String str) =>
    List<EmployeeModel>.from(
        json.decode(str).map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(List<EmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeModel {
  EmployeeModel({
    this.id,
    this.lastname,
    this.firstname,
    this.middlename,
    this.position,
    this.emptype,
    this.email,
    this.username,
    this.password,
  });

  String? id;
  String? lastname;
  String? firstname;
  String? middlename;
  String? position;
  int? emptype;
  String? email;
  String? username;
  String? password;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        lastname: json["lastname"],
        firstname: json["firstname"],
        middlename: json["middlename"],
        position: json["position"],
        emptype: json["emptype"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lastname": lastname,
        "firstname": firstname,
        "middlename": middlename,
        "position": position,
        "emptype": emptype,
        "email": email,
        "username": username,
        "password": password,
      };
}
