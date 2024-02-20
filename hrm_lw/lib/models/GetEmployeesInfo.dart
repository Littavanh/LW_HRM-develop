// To parse this JSON data, do
//
//     final getEmployeesInfo = getEmployeesInfoFromJson(jsonString);

import 'dart:convert';

GetEmployeesInfo getEmployeesInfoFromJson(String str) =>
    GetEmployeesInfo.fromJson(json.decode(str));

String getEmployeesInfoToJson(GetEmployeesInfo data) =>
    json.encode(data.toJson());

class GetEmployeesInfo {
  GetEmployeesInfo({
    this.empId,
    this.empNo,
    this.empTitleName,
    this.firstName1,
    this.lastName1,
    this.nickName1,
    this.firstName2,
    this.lastName2,
    this.nickName2,
    this.genderId,
    this.dob,
    this.fstatusId,
    this.nationalityId,
    this.ethnicId,
    this.religionId,
    this.idCrad,
    this.passport,
    this.address1,
    this.districtId1,
    this.provId1,
    this.empMobile,
    this.empEmail,
    this.empPhoto,
    this.paymentPercent,
    this.mgrid,
    this.spName,
    this.spMobile,
    this.spEmail,
    this.spAddress,
    this.spJob,
    this.spJobAddress,
    this.workingStatus,
    this.empPosition,
    this.empUnitId,
    this.empCompanyId,
    this.empDeptId,
    this.empEmpLevelId,
    this.empEmpGroupId,
    this.empMgrid,
    this.empShiftWorkingId,
    this.empCostCenterId,
    this.empHireDay,
    this.empAssignmemtLocation,
    this.empCurrentAddress,
    this.empEmpTypeId,
    this.empTaxTypeId,
    this.empPositionId,
  });

  String empId;
  String empNo;
  String empTitleName;
  String firstName1;
  String lastName1;
  String nickName1;
  String firstName2;
  String lastName2;
  String nickName2;
  String genderId;
  DateTime dob;
  String fstatusId;
  String nationalityId;
  String ethnicId;
  String religionId;
  String idCrad;
  String passport;
  String address1;
  String districtId1;
  String provId1;
  String empMobile;
  String empEmail;
  String empPhoto;
  String paymentPercent;
  String mgrid;
  String spName;
  String spMobile;
  String spEmail;
  String spAddress;
  String spJob;
  String spJobAddress;
  String workingStatus;
  String empPosition;
  String empUnitId;
  String empCompanyId;
  String empDeptId;
  String empEmpLevelId;
  String empEmpGroupId;
  String empMgrid;
  String empShiftWorkingId;
  String empCostCenterId;
  DateTime empHireDay;
  String empAssignmemtLocation;
  String empCurrentAddress;
  String empEmpTypeId;
  String empTaxTypeId;
  String empPositionId;

  factory GetEmployeesInfo.fromJson(Map<String, dynamic> json) =>
      GetEmployeesInfo(
        empId: json["empID"],
        empNo: json["empNo"],
        empTitleName: json["empTitleName"],
        firstName1: json["firstName1"],
        lastName1: json["lastName1"],
        nickName1: json["nickName1"],
        firstName2: json["firstName2"],
        lastName2: json["lastName2"],
        nickName2: json["nickName2"],
        genderId: json["genderID"],
        dob: DateTime.parse(json["dob"]),
        fstatusId: json["fstatusID"],
        nationalityId: json["nationalityID"],
        ethnicId: json["ethnicID"],
        religionId: json["religionID"],
        idCrad: json["IDCrad"],
        passport: json["passport"],
        address1: json["address1"],
        districtId1: json["district_id1"],
        provId1: json["ProvID1"],
        empMobile: json["empMobile"],
        empEmail: json["empEmail"],
        empPhoto: json["empPhoto"],
        paymentPercent: json["paymentPercent"],
        mgrid: json["mgrid"],
        spName: json["spName"],
        spMobile: json["spMobile"],
        spEmail: json["spEmail"],
        spAddress: json["spAddress"],
        spJob: json["spJob"],
        spJobAddress: json["spJobAddress"],
        workingStatus: json["workingStatus"],
        empPosition: json["emp_position"],
        empUnitId: json["emp_unitID"],
        empCompanyId: json["emp_companyID"],
        empDeptId: json["emp_deptID"],
        empEmpLevelId: json["emp_empLevelID"],
        empEmpGroupId: json["emp_empGroupID"],
        empMgrid: json["emp_mgrid"],
        empShiftWorkingId: json["emp_shiftWorkingID"],
        empCostCenterId: json["emp_costCenterID"],
        empHireDay: DateTime.parse(json["emp_hireDay"]),
        empAssignmemtLocation: json["emp_AssignmemtLocation"],
        empCurrentAddress: json["emp_CurrentAddress"],
        empEmpTypeId: json["emp_empTypeID"],
        empTaxTypeId: json["emp_TaxTypeID"],
        empPositionId: json["emp_positionID"],
      );

  Map<String, dynamic> toJson() => {
        "empID": empId,
        "empNo": empNo,
        "empTitleName": empTitleName,
        "firstName1": firstName1,
        "lastName1": lastName1,
        "nickName1": nickName1,
        "firstName2": firstName2,
        "lastName2": lastName2,
        "nickName2": nickName2,
        "genderID": genderId,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "fstatusID": fstatusId,
        "nationalityID": nationalityId,
        "ethnicID": ethnicId,
        "religionID": religionId,
        "IDCrad": idCrad,
        "passport": passport,
        "address1": address1,
        "district_id1": districtId1,
        "ProvID1": provId1,
        "empMobile": empMobile,
        "empEmail": empEmail,
        "empPhoto": empPhoto,
        "paymentPercent": paymentPercent,
        "mgrid": mgrid,
        "spName": spName,
        "spMobile": spMobile,
        "spEmail": spEmail,
        "spAddress": spAddress,
        "spJob": spJob,
        "spJobAddress": spJobAddress,
        "workingStatus": workingStatus,
        "emp_position": empPosition,
        "emp_unitID": empUnitId,
        "emp_companyID": empCompanyId,
        "emp_deptID": empDeptId,
        "emp_empLevelID": empEmpLevelId,
        "emp_empGroupID": empEmpGroupId,
        "emp_mgrid": empMgrid,
        "emp_shiftWorkingID": empShiftWorkingId,
        "emp_costCenterID": empCostCenterId,
        "emp_hireDay":
            "${empHireDay.year.toString().padLeft(4, '0')}-${empHireDay.month.toString().padLeft(2, '0')}-${empHireDay.day.toString().padLeft(2, '0')}",
        "emp_AssignmemtLocation": empAssignmemtLocation,
        "emp_CurrentAddress": empCurrentAddress,
        "emp_empTypeID": empEmpTypeId,
        "emp_TaxTypeID": empTaxTypeId,
        "emp_positionID": empPositionId,
      };
}
