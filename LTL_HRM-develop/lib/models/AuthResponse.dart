class AuthResponse {
  AuthResponse({
    this.userId,
    this.userEmail,
    this.empNo,
    this.laoFullname,
    this.engFullname,
    this.empMobile,
    this.empTitle,
    this.empDep,
    this.empCompany,
    this.companyTel,
    this.empPhoto,
    this.tokenKey,
    this.roleId,
  });

  String userId;
  String userEmail;
  String empNo;
  String laoFullname;
  String engFullname;
  String empMobile;
  String empTitle;
  String empDep;
  String empCompany;
  String companyTel;
  dynamic empPhoto;
  String tokenKey;
  String roleId;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["UserId"],
        userEmail: json["userEmail"],
        empNo: json["emp_no"],
        laoFullname: json["lao_fullname"],
        engFullname: json["eng_fullname"],
        empMobile: json["emp_mobile"],
        empTitle: json["emp_title"],
        empDep: json["emp_dep"],
        empCompany: json["emp_company"],
        companyTel: json["companyTel"],
        empPhoto: json["emp_photo"],
        tokenKey: json["TokenKey"],
        roleId: json["roleID"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "userEmail": userEmail,
        "emp_no": empNo,
        "lao_fullname": laoFullname,
        "eng_fullname": engFullname,
        "emp_mobile": empMobile,
        "emp_title": empTitle,
        "emp_dep": empDep,
        "emp_company": empCompany,
        "companyTel": companyTel,
        "emp_photo": empPhoto,
        "TokenKey": tokenKey,
        "roleID": roleId,
      };
}
