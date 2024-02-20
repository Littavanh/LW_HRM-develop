// To parse this JSON data, do
//
//     final otRequest = otRequestFromJson(jsonString);

import 'dart:convert';

OTRequest otRequestFromJson(String str) => OTRequest.fromJson(json.decode(str));

String otRequestToJson(OTRequest data) => json.encode(data.toJson());

class OTRequest {
  OTRequest({
    this.otRequestId,
    this.otRequestNo,
    this.empName,
    this.otTypeName,
    this.startDate,
    this.endDate,
    this.otStartTime,
    this.otEndTime,
    this.noted,
    this.managerNoted,
    this.fileAttached,
    this.managerName,
    this.qtyHour,
    this.status,
    this.historyCount,
    this.managerEmpId,
    this.delegateId,
    this.approveUserId,
  });

  String otRequestId;
  String otRequestNo;
  String empName;
  String otTypeName;
  String startDate;
  String endDate;
  String otStartTime;
  String otEndTime;
  String noted;
  dynamic managerNoted;
  String fileAttached;
  String managerName;
  String qtyHour;
  String status;
  String historyCount;
  dynamic managerEmpId;
  dynamic delegateId;
  dynamic approveUserId;

  factory OTRequest.fromJson(Map<String, dynamic> json) => OTRequest(
        otRequestId: json["otRequestID"],
        otRequestNo: json["otRequestNo"],
        empName: json["empName"],
        otTypeName: json["otTypeName"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        otStartTime: json["otStartTime"],
        otEndTime: json["otEndTime"],
        noted: json["noted"],
        managerNoted: json["managerNoted"],
        fileAttached: json["fileAttached"],
        managerName: json["managerName"],
        qtyHour: json["qtyHour"],
        status: json["status"],
        historyCount: json["historyCount"],
        managerEmpId: json["managerEmpID"],
        delegateId: json["delegateID"],
        approveUserId: json["approveUserID"],
      );

  Map<String, dynamic> toJson() => {
        "otRequestID": otRequestId,
        "otRequestNo": otRequestNo,
        "empName": empName,
        "otTypeName": otTypeName,
        "startDate": startDate,
        "endDate": endDate,
        "otStartTime": otStartTime,
        "otEndTime": otEndTime,
        "noted": noted,
        "managerNoted": managerNoted,
        "fileAttached": fileAttached,
        "managerName": managerName,
        "qtyHour": qtyHour,
        "status": status,
        "historyCount": historyCount,
        "managerEmpID": managerEmpId,
        "delegateID": delegateId,
        "approveUserID": approveUserId,
      };
}
