import 'dart:convert';

List<LogsModel> logsModelFromJson(String str) =>
    List<LogsModel>.from(json.decode(str).map((x) => LogsModel.fromJson(x)));

String logsModelToJson(List<LogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogsModel {
  LogsModel({
    this.id,
    this.name,
    this.date,
    this.time,
    this.status,
    this.image,
  });

  String? id;
  String? name;
  String? date;
  String? time;
  String? status;
  String? image;

  factory LogsModel.fromJson(Map<String, dynamic> json) => LogsModel(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "time": time,
        "status": status,
        "image": image,
      };
}
