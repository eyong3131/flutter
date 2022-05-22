//this json class is created through
//
//https://app.quicktype.io/
//
import 'dart:convert';

List<Generator> generatorFromJson(String str) =>
    List<Generator>.from(json.decode(str).map((x) => Generator.fromJson(x)));

String generatorToJson(List<Generator> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Generator {
  Generator({
    this.id,
    this.hash,
    this.username,
  });

  int? id;
  String? hash;
  String? username;

  factory Generator.fromJson(Map<String, dynamic> json) => Generator(
        id: json["id"],
        hash: json["hash"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hash": hash,
        "username": username,
      };
}
