class EmpRequest {
  EmpRequest({
    this.requestId,
    this.requestNo,
    this.requestType,
    this.otdate,
    this.empName,
    this.empPosition,
    this.dateRequest,
    this.fileName,
    this.attachedFile,
    this.statusText,
    this.empContact,
    this.empPhoto,
    this.otTypeText,
    this.requestTitle,
    this.requestReason,
  });

  String requestId;
  String requestNo;
  String requestType;
  String otdate;
  String empName;
  String empPosition;
  String dateRequest;
  String fileName;
  String attachedFile;
  String statusText;
  String empContact;
  String empPhoto;
  String otTypeText;
  String requestTitle;
  String requestReason;

  factory EmpRequest.fromJson(Map<String, dynamic> json) => EmpRequest(
        requestId: json["requestID"],
        requestNo: json["requestNo"],
        requestType: json["requestType"],
        otdate: json["otdate"],
        empName: json["empName"],
        empPosition: json["empPosition"],
        dateRequest: json["dateRequest"],
        fileName: json["fileName"],
        attachedFile: json["attachedFile"],
        statusText: json["statusText"],
        empContact: json["empContact"],
        empPhoto: json["empPhoto"],
        otTypeText: json["otTypeText"],
        requestTitle: json["requestTitle"],
        requestReason: json["requestReason"],
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "requestNo": requestNo,
        "requestType": requestType,
        "otdate": otdate,
        "empName": empName,
        "empPosition": empPosition,
        "dateRequest": dateRequest,
        "fileName": fileName,
        "attachedFile": attachedFile,
        "statusText": statusText,
        "empContact": empContact,
        "empPhoto": empPhoto,
        "otTypeText": otTypeText,
        "requestTitle": requestTitle,
        "requestReason": requestReason,
      };
}
