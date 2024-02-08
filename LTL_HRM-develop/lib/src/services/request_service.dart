import 'dart:convert';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/leave_balance.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/models/messages/my_request_details.dart';
import 'package:LTL_HRM/src/web_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

class RequestService {
  WebApi _webApi = WebApi();

  Future<ApiResponse> getMyLeaveRequests() async {
    ApiResponse apiResponse = ApiResponse(hasError: false);
    final token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final lang = globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2";

    try {
      final response =
          await _webApi.postMyLeaveRequests({'Tokenkey': token, 'lang': lang});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['StatusCode'] == 200 && json['ResultObject'] != null) {
          List<LeaveRequest> data = List<LeaveRequest>.from(
              json['ResultObject'].map((x) => LeaveRequest.fromJson(x)));
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

  Future<ApiResponse> getMyOTRequests() async {
    ApiResponse apiResponse = ApiResponse(hasError: false);
    final token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final lang = globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2";

    try {
      final response =
          await _webApi.postMyOTRequests({'Tokenkey': token, 'lang': lang});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['StatusCode'] == 200 && json['ResultObject'] != null) {
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

  Future<ApiResponse> getRequestDetails(reqID) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "requestID": reqID,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    try {
      final response = await _webApi.postRequestDetails(body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('RequestData: $json');
        final requestDetails = MyRequestDetails.fromJson(json);
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

  Future<ApiResponse> fetchRequestDocument(String requestId) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final body = {'token': token, 'requestID': requestId};

    http.Response response = await _webApi.postRequestDocumentData(body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Map<String, dynamic> parsed = jsonResponse;
      apiResponse.data = parsed;
    } else {
      apiResponse.hasError = true;
    }

    return apiResponse;
  }

  Future<ApiResponse> fetchLeaveBalance() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    String lang = globalMyLocalPrefes.getString(AppConstant.LANG);
    final body = {'Tokenkey': token, 'lang': lang};

    http.Response response = await _webApi.postLeaveBalance(body);
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonResponse["StatusCode"] == 200) {
        final List parsed = jsonResponse['ResultObject'];
        print(parsed.length);
        List<LeaveBalance> dataList =
            parsed.map((item) => LeaveBalance.fromJson(item)).toList();
        apiResponse.data = dataList;
      } else {
        apiResponse.hasError = true;
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
      }
    } else {
      print("fetchRequestDocument Error: ${jsonResponse["ModelErrors"]}");
      apiResponse.hasError = true;
    }

    return apiResponse;
  }
 Future<ApiResponse> fetchLeaveBalanceAllType() async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    String lang = globalMyLocalPrefes.getString(AppConstant.LANG);
    final body = {'Tokenkey': token, 'lang': lang};

    http.Response response = await _webApi.postLeaveBalanceAllType(body);
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonResponse["StatusCode"] == 200) {
        final List parsed = jsonResponse['ResultObject'];
        print(parsed.length);
        List<LeaveBalance> dataList =
            parsed.map((item) => LeaveBalance.fromJson(item)).toList();
        apiResponse.data = dataList;
      } else {
        apiResponse.hasError = true;
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
      }
    } else {
      print("fetchRequestDocument Error: ${jsonResponse["ModelErrors"]}");
      apiResponse.hasError = true;
    }

    return apiResponse;
  }
  Future<ApiResponse> cancelMyRequest(String requestId) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "leaveRequestID": requestId
    };

    try {
      http.Response response = await _webApi.postCancelMyRequest(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('response = ${json.toString()}');
        // final requestDetails = MyRequestDetails.fromJson(json);
        // apiResponse.data = requestDetails;
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> cancelMyOTRequest(String requestId) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "otRequestID": requestId
    };

    try {
      http.Response response = await _webApi.postCancelMyOTRequest(body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('response = ${json.toString()}');
        // final requestDetails = MyRequestDetails.fromJson(json);
        // apiResponse.data = requestDetails;
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;
  }

  Future<ApiResponse> requestOT(body) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);

    try {
      http.Response response = await _webApi.postRequestOT(body);
      print(response);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('response = ${json.toString()}');
        // final requestDetails = MyRequestDetails.fromJson(json);
        // apiResponse.data = requestDetails;
         if (json["StatusCode"] == 200) {
          print('Response: ${json["ModelErrors"]}');
           Fluttertoast.showToast(
              msg: json["ModelErrors"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
              
      } else {
        apiResponse.hasError = true;
        if (json["ModelErrors"] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
        print(json["ModelErrors"]);
       
        //  currentState.showSnackBar(
        //       UIhelper.showSnackbars(json["ModelErrors"]));
        Fluttertoast.showToast(
              msg: json["ModelErrors"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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

  Future<void> addNewLeaveRequest(Map body) async {
    ApiResponse apiResponse = ApiResponse(hasError: false, authorized: true);
    try {
      http.Response response = await _webApi.postNewLeaveRequest(body);
      final json = jsonDecode(response.body);
      print('AddLeave Response: ${json.toString()}');
      if (json["StatusCode"] == 200) {
          print('Response: ${json["ModelErrors"]}');
           Fluttertoast.showToast(
              msg: json["ModelErrors"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
              
      } else {
        apiResponse.hasError = true;
        if (json["ModelErrors"] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
        print(json["ModelErrors"]);
       
        //  currentState.showSnackBar(
        //       UIhelper.showSnackbars(json["ModelErrors"]));
        Fluttertoast.showToast(
              msg: json["ModelErrors"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    return apiResponse;

    // http.post(Uri.parse(uri), body: body).then((response) async {
    //   var jsonResponse = jsonDecode(response.body);
    //   // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);
    //   if (jsonResponse["StatusCode"] == 200) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     Fluttertoast.showToast(
    //         msg: "Leave Request Added Successfully!!!",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.green,
    //         textColor: Colors.white,
    //         fontSize: 16.0);

    //     print("j&&& $jsonResponse");

    //     Navigator.pop(context);
    //     // Navigator.pushNamed(context, myRequestRoute);
    //   } else {
    //     print("ModelError: ${jsonResponse["ModelErrors"]}");
    //     if (jsonResponse["ModelErrors"] == 'Unauthorized') {
    //       await GetToken().getToken().then((value) {
    //         _placeRequests();
    //       });
    //       // Future<String> token = getToken();
    //     } else {
    //       setState(() {
    //         isLoading = false;
    //       });
    //       Fluttertoast.showToast(
    //           msg: jsonResponse["ModelErrors"],
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);

    //       // currentState.showSnackBar(
    //       //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
    //     }
    //   }
    // });
  }
}
