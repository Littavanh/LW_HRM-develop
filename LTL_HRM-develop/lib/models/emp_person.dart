// To parse this JSON data, do
//
//     final empPerson = empPersonFromJson(jsonString);

import 'dart:convert';

EmpPerson empPersonFromJson(String str) => EmpPerson.fromJson(json.decode(str));

String empPersonToJson(EmpPerson data) => json.encode(data.toJson());

class EmpPerson {
  EmpPerson({
    this.empId,
    this.empName,
  });

  String empId;
  String empName;

  factory EmpPerson.fromJson(Map<String, dynamic> json) => EmpPerson(
        empId: json["empID"],
        empName: json["empName"],
      );

  Map<String, dynamic> toJson() => {
        "empID": empId,
        "empName": empName,
      };
}
