class RequestTitle {
  RequestTitle({
    this.requestId,
    this.requestNo,
    this.requestType,
    this.otdate,
    this.managerName,
    this.submitDate,
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
  String managerName;
  String submitDate;
  String empName;
  String empPosition;
  String dateRequest;
  String fileName;
  dynamic attachedFile;
  String statusText;
  String empContact;
  dynamic empPhoto;
  String otTypeText;
  String requestTitle;
  String requestReason;

  factory RequestTitle.fromJson(Map<String, dynamic> json) => RequestTitle(
        requestId: json["requestID"],
        requestNo: json["requestNo"],
        requestType: json["requestType"],
        otdate: json["otdate"],
        managerName: json["managerName"],
        submitDate: json["submitDate"],
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
        "managerName": managerName,
        "SubmitDate": submitDate,
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
