// To parse this JSON data, do
//
//     final leaveRequest = leaveRequestFromJson(jsonString);

import 'dart:convert';

LeaveRequest leaveRequestFromJson(String str) =>
    LeaveRequest.fromJson(json.decode(str));

String leaveRequestToJson(LeaveRequest data) => json.encode(data.toJson());

class LeaveRequest {
  LeaveRequest({
    this.leaveRequestId,
    this.leaveRequestNo,
    this.empId,
    this.empNo,
    this.empName,
    this.leaveTypeId,
    this.leaveTypeName,
    this.leaveDay,
    this.startDate,
    this.endDate,
    this.returnDate,
    this.amountDay,
    this.noted,
    this.delegateEmpName,
    this.fileAttached,
    this.managerName,
    this.transactionTypeName,
    this.expDate,
    this.referAdd,
    this.status,
    this.historyCount,
    this.managerEmpId,
    this.approveUserId,
  });

  String leaveRequestId;
  String leaveRequestNo;
  String empId;
  String empNo;
  String empName;
  String leaveTypeId;
  String leaveTypeName;
  String leaveDay;
  String startDate;
  String endDate;
  String returnDate;
  String amountDay;
  String noted;
  String delegateEmpName;
  String fileAttached;
  String managerName;
  String transactionTypeName;
  String expDate;
  String referAdd;
  String status;
  int historyCount;
  dynamic managerEmpId;
  int approveUserId;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        leaveRequestId: json["leaveRequestID"],
        leaveRequestNo: json["leaveRequestNo"],
        empId: json["empID"],
        empNo: json["empNo"],
        empName: json["empName"],
        leaveTypeId: json["leaveTypeID"],
        leaveTypeName: json["leaveTypeName"],
        leaveDay: json["leaveDay"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        returnDate: json["returnDate"],
        amountDay: json["amountDay"],
        noted: json["noted"],
        delegateEmpName: json["delegateEmpName"],
        fileAttached: json["fileAttached"],
        managerName: json["managerName"],
        transactionTypeName: json["transactionTypeName"],
        expDate: json["expDate"],
        referAdd: json["referAdd"],
        status: json["status"],
        historyCount: json["historyCount"],
        managerEmpId: json["managerEmpID"],
        approveUserId: json["approveUserID"],
      );

  Map<String, dynamic> toJson() => {
        "leaveRequestID": leaveRequestId,
        "leaveRequestNo": leaveRequestNo,
        "empID": empId,
        "empNo": empNo,
        "empName": empName,
        "leaveTypeID": leaveTypeId,
        "leaveTypeName": leaveTypeName,
        "leaveDay": leaveDay,
        "startDate": startDate,
        "endDate": endDate,
        "returnDate": returnDate,
        "amountDay": amountDay,
        "noted": noted,
        "delegateEmpName": delegateEmpName,
        "fileAttached": fileAttached,
        "managerName": managerName,
        "transactionTypeName": transactionTypeName,
        "expDate": expDate,
        "referAdd": referAdd,
        "status": status,
        "historyCount": historyCount,
        "managerEmpID": managerEmpId,
        "approveUserID": approveUserId,
      };
}
