import 'dart:convert';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/models/messages/my_request_details.dart';

import '../../main.dart';
import '../web_api.dart';

class EmpRequestService {
  WebApi _webApi = WebApi();

  Future<ApiResponse> getEmpRequests() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    int userId = globalMyLocalPrefes.getInt(AppConstant.USER_ID);
    String lang = globalMyLocalPrefes.getString(AppConstant.LANG);
    String stdate = "0";
    String enddate = "0";
    String status = "0";
    final body = {
      'Tokenkey': token,
      'managerID': "$userId",
      'lang': lang,
      'stdate': stdate,
      'enddate': enddate,
      'status': status
    };

    try {
      final response = await _webApi.postEmpRequests(body);
      print(response.toString());
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<LeaveRequest> data = List<LeaveRequest>.from(
            json['ResultObject'].map((x) => LeaveRequest.fromJson(x)));
        apiResponse.data = data;
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> getEmpRequestDetails(String reqId) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "requestID": reqId,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    try {
      final response = await _webApi.postEmpRequestDetails(body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final requestDetails = MyRequestDetails.fromJson(json);
        // print(requestDetails.toJson().toString());
        apiResponse.data = requestDetails;
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> rejectEmpRequestLeave(
      int approveType, String requestId, String comment) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    final body = {
      "TokenKey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "RequestID": requestId,
      "noted": comment,
      "deptID": 0,
      "approveTypeID": approveType,
      "isApprove": 0 // isApprove = 0 (reject)
    };

    try {
      final response = await _webApi.postApproveEmpRequest(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> approveEmpRequestLeave(
      int approveType, String requestId, String comment) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    final body = {
      "TokenKey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "RequestID": requestId,
      "noted": comment,
      "deptID": 0,
      "approveTypeID": approveType,
      "isApprove": 1 // isApprove = 1 (Approve)
    };

    try {
      final response = await _webApi.postApproveEmpRequest(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  approveEmpRequesOT(String requestId, String comment) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    Map body = {
      "TokenKey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "requestID": requestId,
      "approvedescription": comment
    };
    print('$body');

    try {
      final response = await _webApi.postApproveEmpRequestOT(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('response = ${json.toString()}');
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }
  }

  Future<ApiResponse> getEmpOTRequestList() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    String lang = globalMyLocalPrefes.getString(AppConstant.LANG);
    final body = {'Tokenkey': token, 'lang': lang};

    try {
      final response = await _webApi.postEmpOTRequests(body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        if (json['ResultObject'] != null) {
          List<OTRequest> data = List<OTRequest>.from(
              json['ResultObject'].map((x) => OTRequest.fromJson(x)));
          apiResponse.data = data;
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
