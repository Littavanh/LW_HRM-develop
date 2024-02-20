import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:LTL_HRM/src/models/messages/ot_item.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:LTL_HRM/src/models/messages/request_approve.dart';

class MyRequestDetails {
  MyRequestDetails({
    this.modelErrors,
    this.requestTitle,
    this.requestApproveds,
    this.requestLeaveItem,
    this.requestOtItem,
    this.statusCode,
    this.isSuccess,
    this.commonErrors,
  });

  String modelErrors;
  List<RequestTitle> requestTitle;
  List<RequestApproved> requestApproveds;
  List<RequestLeaveItem> requestLeaveItem;
  List<RequestOtItem> requestOtItem;
  int statusCode;
  bool isSuccess;
  dynamic commonErrors;

  factory MyRequestDetails.fromJson(Map<String, dynamic> json) =>
      MyRequestDetails(
        modelErrors: json["ModelErrors"],
        requestTitle: List<RequestTitle>.from(
            json["RequestTitleObject"].map((x) => RequestTitle.fromJson(x))),
        requestApproveds: json["ApprovedObject"] != null
            ? List<RequestApproved>.from(
                json["ApprovedObject"].map((x) => RequestApproved.fromJson(x)))
            : [],
        requestLeaveItem: List<RequestLeaveItem>.from(
            json["RequestLeaveItemObject"]
                .map((x) => RequestLeaveItem.fromJson(x))),
        requestOtItem: List<RequestOtItem>.from(
            json["RequestOTItemObject"].map((x) => RequestOtItem.fromJson(x))),
        statusCode: json["StatusCode"],
        isSuccess: json["IsSuccess"],
        commonErrors: json["CommonErrors"],
      );

  Map<String, dynamic> toJson() => {
        "ModelErrors": modelErrors,
        "RequestTitleObject":
            List<RequestTitle>.from(requestTitle.map((x) => x.toJson())),
        "ApprovedObject": requestApproveds,
        "RequestLeaveItemObject": List<RequestLeaveItem>.from(
            requestLeaveItem.map((x) => x.toJson())),
        "RequestOTItemObject":
            List<RequestOtItem>.from(requestOtItem.map((x) => x)),
        "StatusCode": statusCode,
        "IsSuccess": isSuccess,
        "CommonErrors": commonErrors,
      };
}
