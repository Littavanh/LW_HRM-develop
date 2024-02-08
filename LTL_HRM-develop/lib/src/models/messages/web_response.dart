import 'dart:convert';

WebResponse webResponseFromJson(String str) =>
    WebResponse.fromJson(json.decode(str));

String webResponseToJson(WebResponse data) => json.encode(data.toJson());

class WebResponse {
  WebResponse({
    this.modelErrors,
    this.resultObject,
    this.statusCode,
    this.isSuccess,
    this.commonErrors,
  });

  String modelErrors;
  dynamic resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  factory WebResponse.fromJson(Map<String, dynamic> json) => WebResponse(
        modelErrors: json["ModelErrors"],
        resultObject: json["ResultObject"],
        statusCode: json["StatusCode"],
        isSuccess: json["IsSuccess"],
        commonErrors: json["CommonErrors"],
      );

  Map<String, dynamic> toJson() => {
        "ModelErrors": modelErrors,
        "ResultObject": resultObject,
        "StatusCode": statusCode,
        "IsSuccess": isSuccess,
        "CommonErrors": commonErrors,
      };
}
