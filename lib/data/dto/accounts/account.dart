// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  final String id;
  final double accountAmount;
  final String accountName;
  final double? accountCurrentAmount;

  Account({
    required this.id,
    required this.accountAmount,
    required this.accountName,
    this.accountCurrentAmount,
  });

  Account copyWith({
    String? id,
    double? accountAmount,
    String? accountName,
    double? accountCurrentAmount,
  }) =>
      Account(
        id: id ?? this.id,
        accountAmount: accountAmount ?? this.accountAmount,
        accountName: accountName ?? this.accountName,
        accountCurrentAmount: accountCurrentAmount ?? this.accountCurrentAmount,
      );

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["_id"],
        accountAmount: double.parse(json["account_amount"]),
        accountName: json["account_name"],
        accountCurrentAmount: json[
            "account_current_amount"], //no need to parse since the return is already double
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "account_amount": accountAmount,
        "account_name": accountName,
        "account_current_amount": accountCurrentAmount,
      };

  Map<String, dynamic> insertToJson() => {
        "_id": id,
        "account_amount": accountAmount,
        "account_name": accountName,
      };
}
