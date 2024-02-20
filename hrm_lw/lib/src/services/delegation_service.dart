import 'dart:convert';

import 'package:LTL_HRM/models/GetEmployeesInfo.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../web_api.dart';
import 'package:LTL_HRM/src/models/Delegation.dart';

class DelegationService {
  WebApi _webApi = WebApi();

  Future<ApiResponse> getDelegateApproverList(BuildContext context) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    GetEmployeesInfo empInfo = context.read<ShareProvider>().empInfo;
    print(
        "DelegationService: getDelegateApproverList: empInfo: ${empInfo.toJson()}");
    Map body = {
      "Tokenkey": token,
      "empID": empInfo.empId,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    try {
      final response = await _webApi.postDelegateApproverList(body);
      final json = jsonDecode(response.body);
      if (json["StatusCode"] == 200 && json['ResultObject'] != null) {
        final List<dynamic> results = json['ResultObject'];
        List<Delegation> delegations =
            results.map((e) => Delegation.fromJson(e)).toList();
        apiResponse.data = delegations;
      } else {
        print("ModelError: getDelegatePerson!");
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> approveDelegation(Delegation delegation) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "delegateID": delegation.delegateId,
      "delegateNoted": ''
    };

    try {
      final response = await _webApi.postDelegateApprove(body);
      final json = jsonDecode(response.body);
      print('Response => ${json.toString()}');
      if (json["StatusCode"] == 200 && json['IsSuccess']) {
      } else {
        print("ModelError: getDelegatePerson!");
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> rejectDelegation(Delegation delegation) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "delegateID": delegation.delegateId,
      "delegateNoted": ''
    };

    try {
      final response = await _webApi.postDelegateReject(body);
      final json = jsonDecode(response.body);
      print('Response => ${json.toString()}');
      if (json["StatusCode"] == 200 && json['IsSuccess']) {
      } else {
        print("ModelError: getDelegatePerson!");
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }
}
