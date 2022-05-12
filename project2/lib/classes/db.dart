import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import './json/transaction.dart';

class db {
  //late List<Transaction> json;

  _passData(String? id) async {
    //header
    var bytes = convert.utf8.encode('viral:viral');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //body and url
    var body = convert.json.encode({'id': id});
    var url = Uri.parse('http://192.168.1.12:3000/api/patient/remove');
    var client = http.Client();
    var response = await client.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("$id");
    }
  }
}
