// To parse this JSON data, do
//
//     final addLeaveBody = addLeaveBodyFromJson(jsonString);

import 'dart:convert';

AddLeaveBody addLeaveBodyFromJson(String str) =>
    AddLeaveBody.fromJson(json.decode(str));

String addLeaveBodyToJson(AddLeaveBody data) => json.encode(data.toJson());

class AddLeaveBody {
  AddLeaveBody({
    this.tokenKey,
    this.lang,
    this.leaveRequestNo,
    this.empId,
    this.leaveTypeId,
    this.leaveDay,
    this.startDate,
    this.endDate,
    this.returnDate,
    this.amountDay,
    this.noted,
    this.delegateEmpId,
    this.fileAttached,
    this.transactionTypeId,
    // this.expDate,
    // this.referAdd,
  });

  String tokenKey;
  String lang;
  String leaveRequestNo;
  int empId;
  int leaveTypeId;
  String leaveDay;
  DateTime startDate;
  DateTime endDate;
  DateTime returnDate;
  double amountDay;
  String noted;
  int delegateEmpId;
  String fileAttached;
  int transactionTypeId;
  DateTime expDate;
  String referAdd;

  factory AddLeaveBody.fromJson(Map<String, dynamic> json) => AddLeaveBody(
        tokenKey: json["TokenKey"],
        lang: json["lang"],
        leaveRequestNo: json["leaveRequestNo"],
        empId: json["empID"],
        leaveTypeId: json["leaveTypeID"],
        leaveDay: json["leaveDay"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        returnDate: DateTime.parse(json["returnDate"]),
        amountDay: json["amountDay"],
        noted: json["noted"],
        delegateEmpId: json["delegateEmpID"],
        fileAttached: json["fileAttached"],
        transactionTypeId: json["transactionTypeID"],
        // expDate: DateTime.parse(json["expDate"]),
        // referAdd: json["referAdd"],
      );

  Map<String, dynamic> toJson() => {
        "TokenKey": tokenKey,
        "lang": lang,
        "leaveRequestNo": leaveRequestNo,
        "empID": empId,
        "leaveTypeID": leaveTypeId,
        "leaveDay": leaveDay,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "returnDate":
            "${returnDate.year.toString().padLeft(4, '0')}-${returnDate.month.toString().padLeft(2, '0')}-${returnDate.day.toString().padLeft(2, '0')}",
        "amountDay": amountDay,
        "noted": noted,
        "delegateEmpID": delegateEmpId,
        "fileAttached": fileAttached,
        "transactionTypeID": transactionTypeId,
        // "expDate":
        // "${expDate.year.toString().padLeft(4, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.day.toString().padLeft(2, '0')}",
        // "referAdd": referAdd,
      };
}
