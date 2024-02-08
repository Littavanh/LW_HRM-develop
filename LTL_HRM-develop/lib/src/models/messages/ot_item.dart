class RequestOtItem {
  RequestOtItem({
    this.itemId,
    this.otDate,
    this.otTitle,
    this.otDesript,
    this.strTime,
    this.endTime,
  });

  String itemId;
  String otDate;
  String otTitle;
  String otDesript;
  String strTime;
  String endTime;

  factory RequestOtItem.fromJson(Map<String, dynamic> json) => RequestOtItem(
        itemId: json["itemID"],
        otDate: json["OtDate"],
        otTitle: json["otTitle"],
        otDesript: json["otDesript"],
        strTime: json["strTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "OtDate": otDate,
        "otTitle": otTitle,
        "otDesript": otDesript,
        "strTime": strTime,
        "endTime": endTime,
      };
}
