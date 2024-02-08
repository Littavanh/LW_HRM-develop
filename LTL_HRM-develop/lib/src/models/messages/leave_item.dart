class RequestLeaveItem {
  RequestLeaveItem({
    this.itemId,
    this.itemType,
    this.duration,
    this.strDate,
    this.endDate,
    this.returnDate,
    this.requestFor,
    this.requestReason,
    this.responseName,
    this.managerName,
    this.entryDate,
  });

  String itemId;
  String itemType;
  String duration;
  String strDate;
  String endDate;
  String returnDate;
  String requestFor;
  String requestReason;
  String responseName;
  String managerName;
  String entryDate;

  factory RequestLeaveItem.fromJson(Map<String, dynamic> json) =>
      RequestLeaveItem(
        itemId: json["itemID"],
        itemType: json["itemType"],
        duration: json["duration"],
        strDate: json["strDate"],
        endDate: json["endDate"],
        returnDate: json["returnDate"],
        requestFor: json["requestFor"],
        requestReason: json["requestReason"],
        responseName: json["responseName"],
        managerName: json["managerName"],
        entryDate: json["entryDate"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "itemType": itemType,
        "duration": duration,
        "strDate": strDate,
        "endDate": endDate,
        "returnDate": returnDate,
        "RequestFor": requestFor,
        "requestReason": requestReason,
        "responseName": responseName,
        "managerName": managerName,
        "entryDate": entryDate,
      };
}
