// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  Transaction({
    this.transactionId,
    this.transactionName,
    this.transactionDescription,
  });

  int? transactionId;
  String? transactionName;
  String? transactionDescription;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["TRANSACTION_ID"],
        transactionName: json["TRANSACTION_NAME"],
        transactionDescription: json["TRANSACTION_DESCRIPTION"],
      );

  Map<String, dynamic> toJson() => {
        "TRANSACTION_ID": transactionId,
        "TRANSACTION_NAME": transactionName,
        "TRANSACTION_DESCRIPTION": transactionDescription,
      };
}
