import 'dart:convert';

import 'package:LTL_HRM/models/GetEmployeesInfo.dart';
import 'package:LTL_HRM/models/emp_person.dart';
import 'package:LTL_HRM/models/leave_type.dart';
import 'package:LTL_HRM/models/permission.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/web_api.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class UtilsService {
  WebApi _webApi = WebApi();

  Future<ApiResponse> fetchUserPermission(token) async {
    final body = {'Tokenkey': token};
    ApiResponse apiResponse = ApiResponse(hasError: true, authorized: false);

    http.Response response = await _webApi.postUserPermission(body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["StatusCode"] == 200) {
        final List parsed = jsonResponse['ResultObject'];
        List<Permission> permissions = [];

        parsed.forEach((element) {
          permissions.add(Permission.fromJson(element));
        });
        apiResponse.data = permissions;

        apiResponse.authorized = true;
        apiResponse.hasError = false;
      } else {
        apiResponse.hasError = true;
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
      }
    } else {
      print('fetchUserPermission: error ${response.statusCode}');
      // print("fetchUserPermission Error: ${jsonResponse["ModelErrors"]}");
      apiResponse.hasError = true;
    }

    return apiResponse;
  }

  Future<ApiResponse> fetchTypeOfLeave() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    try {
      final response = await _webApi.postGetTypeOfLeave(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["StatusCode"] == 200) {
          final List parsed = json['ResultObject'];
          final leaveTypes =
              parsed.map((item) => LeaveType.fromJson(item)).toList();
          apiResponse.data = leaveTypes;
        } else {
          apiResponse.hasError = true;
        }
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> fetchResponsiblePerson() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    try {
      final response = await _webApi.postGetResponsiblePerson(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["StatusCode"] == 200 && json["ResultObject"] != null) {
          final List parsed = json['ResultObject'];
          List<EmpPerson> _empList = parsed.map<EmpPerson>((json) {
            return EmpPerson.fromJson(json);
          }).toList();
          apiResponse.data = _empList;
        } else {
          apiResponse.hasError = true;
        }
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> fetchEmployeeInfo(token) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG),
      "empID": globalMyLocalPrefes.getInt(AppConstant.USER_ID) ?? "",
      "monthView": 0,
      "yearView": 0
    };

    try {
      final response = await _webApi.postGetEmployeeInfo(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["StatusCode"] == 200 && json["ResultObject"] != null) {
          final List parsed = json['ResultObject'];
          List<GetEmployeesInfo> _empList =
              parsed.map<GetEmployeesInfo>((json) {
            return GetEmployeesInfo.fromJson(json);
          }).toList();
          apiResponse.data = _empList;
        } else {
          apiResponse.hasError = true;
        }
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }
}
