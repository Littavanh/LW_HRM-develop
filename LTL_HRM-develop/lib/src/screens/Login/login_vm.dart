import 'package:LTL_HRM/models/AuthResponse.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class LoginVM extends ChangeNotifier {
  AuthService _authService = AuthService();
  bool _isLoading = false;
  String _username;
  String _password;
  ApiResponse _apiResponse;
  AuthResponse _authResponse;

  ApiResponse get apiResponse => _apiResponse;

  bool get isLoading => _isLoading;

  AuthResponse get authResponse => _authResponse;

  Future<void> handleSubmitted(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      _isLoading = true;
      notifyListeners();
      _apiResponse =
          await _authService.submitLogin(_username.trim(), _password.trim());
      if (_apiResponse != null &&
          !_apiResponse.hasError &&
          _apiResponse.data != null) {
        //Login Success
        _authResponse = _apiResponse.data;
        await globalMyLocalPrefes.setInt(
            AppConstant.USER_ID.toString(), int.parse(_authResponse.userId));

        await globalMyLocalPrefes.setString(
            AppConstant.ACCESS_TOKEN, _authResponse.tokenKey);
        await globalMyLocalPrefes.setString(
            AppConstant.USERNAME, _authResponse.engFullname);
        await globalMyLocalPrefes.setString(
            AppConstant.IMAGE, _authResponse.empPhoto ?? "");
        await globalMyLocalPrefes.setString(
            AppConstant.PHONENO, _authResponse.companyTel);
        await globalMyLocalPrefes.setString(
            AppConstant.EMAIL, _authResponse.userEmail);
        await globalMyLocalPrefes.setString(
            AppConstant.DEPARTMENT, _authResponse.empDep);

        await globalMyLocalPrefes.setString(
            AppConstant.COMPANY, _authResponse.empCompany);

        // await globalMyLocalPrefes.setString(
        //     AppConstant.LoginGmailID, usernameController.text.trim());
        // await globalMyLocalPrefes.setString(
        //     AppConstant.PASSWORD, passwordController.text.trim());

        await globalMyLocalPrefes.setString(
            AppConstant.EMP_ID, _authResponse.empNo);
        await globalMyLocalPrefes.setString(
            AppConstant.LANG, "1");
        Navigator.pushReplacementNamed(context, CustomRouter.landingRoute);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  onUsernameChanged(String value) {
    _username = value;
  }

  onPasswordChanged(String value) {
    _password = value;
  }

  void updateServerURL() {
    print("updateServerURL");
    _authService = AuthService();
    notifyListeners();
  }
}
