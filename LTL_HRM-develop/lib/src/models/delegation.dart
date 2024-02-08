// To parse this JSON data, do
//
//     final delegation = delegationFromJson(jsonString);

import 'dart:convert';

Delegation delegationFromJson(String str) =>
    Delegation.fromJson(json.decode(str));

String delegationToJson(Delegation data) => json.encode(data.toJson());

class Delegation {
  Delegation({
    this.delegateId,
    this.empId,
    this.empName,
    this.delegateEmpId,
    this.delegateEmpName,
    this.noted,
    this.strDate,
    this.endDate,
    this.reCallDate,
    this.strDate2,
    this.endDate2,
    this.reCallDate2,
    this.status,
    this.delegateNoted,
  });

  String delegateId;
  String empId;
  String empName;
  String delegateEmpId;
  String delegateEmpName;
  String noted;
  String strDate;
  String endDate;
  String reCallDate;
  DateTime strDate2;
  DateTime endDate2;
  DateTime reCallDate2;
  String status;
  dynamic delegateNoted;

  factory Delegation.fromJson(Map<String, dynamic> json) => Delegation(
        delegateId: json["delegateID"],
        empId: json["empID"],
        empName: json["empName"],
        delegateEmpId: json["delegateEmpID"],
        delegateEmpName: json["delegateEmpName"],
        noted: json["noted"],
        strDate: json["strDate"],
        endDate: json["endDate"],
        reCallDate: json["reCallDate"],
        strDate2: DateTime.parse(json["strDate2"]),
        endDate2: DateTime.parse(json["endDate2"]),
        reCallDate2: DateTime.parse(json["reCallDate2"]),
        status: json["status"],
        delegateNoted: json["delegateNoted"],
      );

  Map<String, dynamic> toJson() => {
        "delegateID": delegateId,
        "empID": empId,
        "empName": empName,
        "delegateEmpID": delegateEmpId,
        "delegateEmpName": delegateEmpName,
        "noted": noted,
        "strDate": strDate,
        "endDate": endDate,
        "reCallDate": reCallDate,
        "strDate2":
            "${strDate2.year.toString().padLeft(4, '0')}-${strDate2.month.toString().padLeft(2, '0')}-${strDate2.day.toString().padLeft(2, '0')}",
        "endDate2":
            "${endDate2.year.toString().padLeft(4, '0')}-${endDate2.month.toString().padLeft(2, '0')}-${endDate2.day.toString().padLeft(2, '0')}",
        "reCallDate2":
            "${reCallDate2.year.toString().padLeft(4, '0')}-${reCallDate2.month.toString().padLeft(2, '0')}-${reCallDate2.day.toString().padLeft(2, '0')}",
        "status": status,
        "delegateNoted": delegateNoted,
      };
}
