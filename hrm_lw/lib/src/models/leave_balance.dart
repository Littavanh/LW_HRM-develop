class LeaveBalance {
  LeaveBalance({
    this.leaveName,
    this.leaveTotal,
    this.leaveDayCanUse,
  });

  String leaveName;
  String leaveTotal;
  String leaveDayCanUse;

  factory LeaveBalance.fromJson(Map<String, dynamic> json) => LeaveBalance(
        leaveName: json["LeaveName"],
        leaveTotal: json["leaveTotal"],
        leaveDayCanUse: json["leaveDayCanUse"],
      );

  Map<String, dynamic> toJson() => {
        "LeaveName": leaveName,
        "leaveTotal": leaveTotal,
        "leaveDayCanUse": leaveDayCanUse,
      };
}
