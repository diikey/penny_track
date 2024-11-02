// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Record loginResponseFromJson(String str) => Record.fromJson(json.decode(str));

String loginResponseToJson(Record data) => json.encode(data.toJson());

class Record extends Equatable {
  final String id;
  final String recordAccount;
  final String? recordAccountTransfer;
  final double recordAmount;
  final String recordCreatedAt;
  final String recordNotes;
  final String recordType;

  const Record({
    required this.id,
    required this.recordAccount,
    this.recordAccountTransfer,
    required this.recordAmount,
    required this.recordCreatedAt,
    required this.recordNotes,
    required this.recordType,
  });

  @override
  List<Object?> get props => [
        id,
        recordAccount,
        recordAccountTransfer,
        recordAmount,
        recordCreatedAt,
        recordNotes,
        recordType
      ];

  Record copyWith({
    String? id,
    String? recordAccount,
    String? recordAccountTransfer,
    double? recordAmount,
    String? recordCreatedAt,
    String? recordNotes,
    String? recordType,
  }) =>
      Record(
        id: id ?? this.id,
        recordAccount: recordAccount ?? this.recordAccount,
        recordAccountTransfer:
            recordAccountTransfer ?? this.recordAccountTransfer,
        recordAmount: recordAmount ?? this.recordAmount,
        recordCreatedAt: recordCreatedAt ?? this.recordCreatedAt,
        recordNotes: recordNotes ?? this.recordNotes,
        recordType: recordType ?? this.recordType,
      );

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
        recordAccount: json["record_account"],
        recordAccountTransfer: json["record_account_transfer"],
        recordAmount: double.parse(json["record_amount"]),
        recordCreatedAt: json["record_created_at"],
        recordNotes: json["record_notes"],
        recordType: json["record_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "record_account": recordAccount,
        "record_account_transfer": recordAccountTransfer,
        "record_amount": recordAmount,
        "record_created_at": recordCreatedAt,
        "record_notes": recordNotes,
        "record_type": recordType,
      };
}
