// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  final String id;
  final int accountInitialAmount;
  final String accountName;

  Account({
    required this.id,
    required this.accountInitialAmount,
    required this.accountName,
  });

  Account copyWith({
    String? id,
    int? accountInitialAmount,
    String? accountName,
  }) =>
      Account(
        id: id ?? this.id,
        accountInitialAmount: accountInitialAmount ?? this.accountInitialAmount,
        accountName: accountName ?? this.accountName,
      );

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["_id"],
        accountInitialAmount: json["account_initial_amount"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "account_initial_amount": accountInitialAmount,
        "account_name": accountName,
      };
}
