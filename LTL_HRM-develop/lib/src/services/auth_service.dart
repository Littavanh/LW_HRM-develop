import 'dart:convert';

import 'package:LTL_HRM/models/AuthResponse.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/web_api.dart';
import 'package:LTL_HRM/utils/utils.dart';

class AuthService {
  WebApi _webApi = WebApi();

  Future<ApiResponse> submitLogin(username, password) async {
    ApiResponse apiResponse = ApiResponse(hasError: false);
    final deviceToken = await UtilsHRM.generateDeviceToken();
    Map body = {
      "PassKey": "7386t189-58c0-c495-8ff0-d0fnov0a29ta",
      "UserName": username,
      "UserPassword": password,
      "Device_token": deviceToken,
    };

    try {
      final response = await _webApi.postLogin(body);
      print('LoginResponse: ${response.statusCode}');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['StatusCode'] == 200) {
          final authResponse = AuthResponse.fromJson(json['ResultObject'][0]);
          print('responseData: ${authResponse.toJson().toString()}');
          apiResponse.data = authResponse;
        } else {
          apiResponse.hasError = true;
        }
        if (json['ModelErrors'] != null &&
            json['ModelErrors'] == 'Unauthorized') {
          apiResponse.authorized = false;
        }
        return apiResponse;
      } else {
        apiResponse.hasError = true;
      }
    } catch (e) {
      apiResponse.hasError = true;
      print(e);
    }

    // Network().check().then((intenet) async {
    //   if (intenet != null && intenet) {
    //     // sharedPreferences = await SharedPreferences.getInstance();
    //     // setState(() {
    //     //   _state = 1;
    //     //   buttonText = 'LOADING..';
    //     // });

    //     try {
    //       final uri = Services.LOGIN;
    //       Map body = {
    //         "PassKey": "7386t189-58c0-c495-8ff0-d0fnov0a29ta",
    //         "UserName": usernameController.text.trim(),
    //         "UserPassword": passwordController.text.trim(),
    //         "Device_token": token,
    //       };

    //       http.post(Uri.parse(uri), body: body).then((response) async {
    //         print(response.body);
    //         if (response.statusCode == 200) {
    //           var jsonResponse = jsonDecode(response.body);
    //           print("Reponse---2 : $jsonResponse");
    //           if (jsonResponse["StatusCode"] == 200) {
    //             LoginResponse login =
    //                 LoginResponse.fromJson(jsonResponse["ResultObject"][0]);
    //             // print(login.toString());
    //             print("login.tokenKey: ${login.tokenKey}");
    //             print("userId---3 : ${login.userId}");

    //             await globalMyLocalPrefes.setInt(
    //                 AppConstant.USER_ID.toString(), login.userId);

    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.ACCESS_TOKEN, login.tokenKey);
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.USERNAME, login.eng_fullname);
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.IMAGE, login.emp_photo ?? "");
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.PHONENO, login.emp_mobile);
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.EMAIL, login.userEmail);
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.DEPARTMENT, login.emp_dep);

    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.COMPANY, login.emp_company);

    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.LoginGmailID, usernameController.text.trim());
    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.PASSWORD, passwordController.text.trim());

    //             await globalMyLocalPrefes.setString(
    //                 AppConstant.EMP_ID, login.emp_no);
    //             print(
    //                 "Ge ${globalMyLocalPrefes.getInt(AppConstant.USER_ID.toString())}");
    //             print(
    //                 "EMP_ID ${globalMyLocalPrefes.getString(AppConstant.EMP_ID.toString())}");

    //             setState(() {
    //               _state = 2;
    //               buttonText = 'Success';
    //               animateButton();
    //             });

    //             //Get permission data
    //             ApiResponse permissionRes =
    //                 await _utilsService.fetchUserPermission(login.tokenKey);

    //             if (!permissionRes.hasError) {
    //               context
    //                   .read<ShareProvider>()
    //                   .setPermissions(permissionRes.data);
    //               Navigator.pushNamedAndRemoveUntil(
    //                   context, homeRoute, ModalRoute.withName(homeRoute));
    //             }
    //           } else {
    //             setState(() {
    //               _state = 3;
    //               buttonText = 'RETRY';
    //             });
    //             _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
    //                 "Something went wrong.. Please try again later."));
    //           }
    //         } else {
    //           print("response.statusCode.." + response.statusCode.toString());
    //           setState(() {
    //             _state = 3;
    //             buttonText = 'RETRY';
    //           });
    //           _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
    //               "Something wnet wrong.. Please try again later."));
    //         }
    //       });
    //     } catch (e) {
    //       print("Error: $e");
    //       return (e);
    //     }
    //   } else {
    //     Navigator.pop(context);
    //     Fluttertoast.showToast(
    //         msg: "Please check internet connection.",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.red,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    // });
  }
}
