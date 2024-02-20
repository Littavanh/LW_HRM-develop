import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/models/GetEmployeesInfo.dart';
import 'package:LTL_HRM/models/permission.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/services/UtilsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'Login/login.dart';
import 'home/home.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  UtilsService _utilsService = UtilsService();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      _loadUserInfo();
    });
  }

  _loadUserInfo() async {
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    print('_loadUserInfo: token = $token');

    if (token == null) {
      // Navigator.pushReplacementNamed(context, '/login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Login(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    } else {
      ApiResponse response = await _utilsService.fetchUserPermission(token);
      ApiResponse empInfoResponse =
          await _utilsService.fetchEmployeeInfo(token);

      //If API response unauthorized error redirect to Login
      if (response.hasError || empInfoResponse.hasError) {
        if (!response.authorized || empInfoResponse.hasError) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Login(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        }
      } else {
        List<Permission> permissions = response.data;
        GetEmployeesInfo empInfo = empInfoResponse.data[0];
        print('permision: ${empInfoResponse.data.toString()}');
        context.read<ShareProvider>().setPermissions(permissions);
        context.read<ShareProvider>().setEmployeeInfo(empInfo);

        setState(() {
          listOfPermission = permissions;

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) =>
                  MyHomePage(listOfPermission: listOfPermission),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "lib/assets/logo/HRM loading.png",
              height: 250,
              width: 250,
            ),
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: SpinKitThreeBounce(
                color: Colors.purple,
                size: 30.0,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}







