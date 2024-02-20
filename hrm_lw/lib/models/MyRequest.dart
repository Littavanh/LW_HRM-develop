class MyRequest {
  MyRequest({
    this.requestId,
    this.requestNo,
    this.requestType,
    this.otdate,
    this.managerName,
    this.submitDate,
    this.statusText,
    this.fileName,
    this.attachedFile,
  });

  String requestId;
  String requestNo;
  String requestType;
  String otdate;
  String managerName;
  String submitDate;
  String statusText;
  String fileName;
  dynamic attachedFile;

  factory MyRequest.fromJson(Map<String, dynamic> json) => MyRequest(
        requestId: json["requestID"],
        requestNo: json["requestNo"],
        requestType: json["requestType"],
        otdate: json["otdate"],
        managerName: json["managerName"],
        submitDate: json["submitDate"],
        statusText: json["statusText"],
        fileName: json["fileName"],
        attachedFile: json["attachedFile"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "requestNo": requestNo,
        "requestType": requestType,
        "otdate": otdate,
        "managerName": managerName,
        "submitDate": submitDate,
        "statusText": statusText,
        "fileName": fileName,
        "attachedFile": attachedFile,
      };
}
