class LeaveType {
  LeaveType({
    this.typeId,
    this.typeName,
    this.typeName1,
    this.typeName2,
    this.typeShotname,
  });

  String typeId;
  String typeName;
  String typeName1;
  String typeName2;
  String typeShotname;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        typeId: json["TypeID"],
        typeName: json["TypeName"],
        typeName1: json["TypeName1"],
        typeName2: json["TypeName2"],
        typeShotname: json["TypeShotname"],
      );

  Map<String, dynamic> toJson() => {
        "TypeID": typeId,
        "TypeName": typeName,
        "TypeName1": typeName1,
        "TypeName2": typeName2,
        "TypeShotname": typeShotname,
      };
}
