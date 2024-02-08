import 'dart:convert';
import 'dart:io';

import 'package:LTL_HRM/utils/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/Services.dart';

class WebApi {
  Future<String> getURL(String path) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.getString('BASE_URL') != null) {
      return sharedPref.getString('BASE_URL') + path;
    }
    return UrlConstants.initURL + path;
  }

  Future<http.Response> postLogin(body) async {
    final url = await getURL(Services.LOGIN);
    print('postLogin: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postUserPermission(body) async {
    final url = await getURL(Services.GetPermissions);
    print('postUserPermission: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postRequestDocumentData(body) async {
    final url = await getURL(Services.VIEW_LEAVE_DOCUMENT);

    print('postRequestDocumentData: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postLeaveBalance(body) async {
    final url = await getURL(Services.LeaveBalance);
    print('postLeaveBalance: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }
Future<http.Response> postLeaveBalanceAllType(body) async {
    final url = await getURL(Services.LeaveBalanceAllType);
    print('postLeaveBalanceAllType: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }
  Future<http.Response> postMyLeaveRequests(body) async {
    final url = await getURL(UrlConstants.MY_LEAVE_REQUEST_LIST_URL);
    print('postMyLeaveRequests: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postMyOTRequests(body) async {
    final url = await getURL(UrlConstants.MY_OT_REQUEST_LIST_URL);
    print('postMyOTRequests: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postRequestDetails(body) async {
    final url = await getURL(Services.MyLevReqDetails);
    print('postRequestDetails: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postCancelMyRequest(body) async {
    final url = await getURL(Services.CancelMyrequest);
    print('postCancelMyRequest: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postCancelMyOTRequest(body) async {
    final url = await getURL(Services.CancelMyOTRequest);
    print('postCancelMyRequest: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postEmpRequests(body) async {
    final url = await getURL(Services.EmpRequest);
    print('postEmpRequests: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postEmpOTRequests(body) async {
    final url = await getURL(Services.EmpOTRequest);
    print('postEmpRequests: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postEmpRequestDetails(body) async {
    final url = await getURL(Services.EmpRequestDetails);
    print('postEmpRequestDetails: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postRejectEmpRequest(Map body) async {
    final url = await getURL(Services.RejectLeave);
    print('postRejectEmpRequest: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postApproveEmpRequest(Map body) async {
    final url = await getURL(Services.ApproveEmpRequest);
    print('postApproveEmpRequest: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postRequestOT(body) async {
    final url = await getURL(UrlConstants.ADD_NEW_OT_URL);
    // final reqBody = {
    //   "TokenKey": "2269b5e2-f6f8-4d2e-a2e6-7efc795c5f35",
    //   "lang": "1",
    //   "empID": 38,
    //   "otTypeID": 1,
    //   "startDate": "2021-10-07",
    //   "endDate": "2021-10-07",
    //   "otStartTime": "08:00",
    //   "otEndTime": "17:00",
    //   "noted": "Test from Mobile",
    //   "fileAttached": "",
    //   "managerID": 0
    // };

    print('postRequestOT: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postApproveEmpRequestOT(Map body) async {
    final url = await getURL(Services.ApproveOT);
    print('postApproveEmpRequestOT: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postGetTypeOfLeave(Map body) async {
    final url = await getURL(UrlConstants.LEAVE_TYPE);
    print('postGetTypeOfLeave: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postGetResponsiblePerson(Map body) async {
    final url = await getURL(Services.GetResponsiblePer);
    print('postGetResponsiblePerson: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url), body: body);
  }

  Future<http.Response> postNewLeaveRequest(Map body) async {
    final url = await getURL(UrlConstants.ADD_MY_LEAVE_REQUEST);
    print('postNewLeaveRequest: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postGetEmployeeInfo(Map body) async {
    final url = await getURL(Services.GetEmployeeInfo);
    print('postGetEmployeeInfo: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postDelegateApproverList(Map body) async {
    final url = await getURL(Services.DelegateApproverList);
    print('postDelegateApproverList: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postDelegateApprove(Map body) async {
    final url = await getURL(Services.ApproveDelegate);
    print('postDelegateApprover: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> postDelegateReject(Map body) async {
    final url = await getURL(Services.RejectDelegate);
    print('postDelegateReject: [POST] --> $url; body --> $body');
    return await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
  }
}
