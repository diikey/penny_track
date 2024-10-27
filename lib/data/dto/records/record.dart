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
  final int recordAmount;
  final String recordCreatedAt;
  final String recordNotes;
  final String recordTypes;

  const Record({
    required this.id,
    required this.recordAccount,
    required this.recordAmount,
    required this.recordCreatedAt,
    required this.recordNotes,
    required this.recordTypes,
  });

  @override
  List<Object?> get props => [
        id,
        recordAccount,
        recordAmount,
        recordCreatedAt,
        recordNotes,
        recordTypes
      ];

  Record copyWith({
    String? id,
    String? recordAccount,
    int? recordAmount,
    String? recordCreatedAt,
    String? recordNotes,
    String? recordTypes,
  }) =>
      Record(
        id: id ?? this.id,
        recordAccount: recordAccount ?? this.recordAccount,
        recordAmount: recordAmount ?? this.recordAmount,
        recordCreatedAt: recordCreatedAt ?? this.recordCreatedAt,
        recordNotes: recordNotes ?? this.recordNotes,
        recordTypes: recordTypes ?? this.recordTypes,
      );

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
        recordAccount: json["record_account"],
        recordAmount: json["record_amount"],
        recordCreatedAt: json["record_created_at"],
        recordNotes: json["record_notes"],
        recordTypes: json["record_types"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "record_account": recordAccount,
        "record_amount": recordAmount,
        "record_created_at": recordCreatedAt,
        "record_notes": recordNotes,
        "record_types": recordTypes,
      };
}
