import 'dart:convert';

List<EmpImage> empImageFromJson(String str) =>
    List<EmpImage>.from(json.decode(str).map((x) => EmpImage.fromJson(x)));

String empImageToJson(List<EmpImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpImage {
  EmpImage({
    this.id,
    this.image,
  });

  String? id;
  String? image;

  factory EmpImage.fromJson(Map<String, dynamic> json) => EmpImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
