
class RequestApproved {
  String approvedName;
  String comment;
  String approvedDate;

  RequestApproved({this.approvedName, this.comment, this.approvedDate});

  RequestApproved.fromJson(Map<String, dynamic> json) {
    approvedName = json['approvedName'];
    comment = json['comment'];
    approvedDate = json['approvedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approvedName'] = this.approvedName;
    data['comment'] = this.comment;
    data['approvedDate'] = this.approvedDate;
    return data;
  }
}
