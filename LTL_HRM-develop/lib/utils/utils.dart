import 'package:LTL_HRM/classes/language.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/permission.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class UtilsHRM {
  static Permission getPermissionObject(BuildContext context, String type) {
    Permission _permission;
    context.read<ShareProvider>().permissions.forEach((element) {
      if (element.app_permissionName == type) {
        _permission = element;
      }
    });
    return _permission;
  }

  static void onChangeLanguage(BuildContext context, Language language) async {
    final _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    Navigator.of(context).pushNamedAndRemoveUntil(
      landingRoute,
      (Route<dynamic> route) => false,
    );
  }

  static Future<String> generateDeviceToken() async {
    String token = '';
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static Color getStatusColor(String statusTxt) {
    if (statusTxt.toLowerCase() == 'pending') {
      return Colors.orangeAccent;
    }
    if (statusTxt.toLowerCase() == 'reject') {
      return Colors.red;
    }
    if (statusTxt.toLowerCase() == 'approved') {
      return Colors.green;
    }
    if (statusTxt.toLowerCase() == 'delete') {
      return Colors.redAccent;
    }
    return splashScreenColorTop;
  }

  static void showSuccessToast(BuildContext context) {
    Fluttertoast.showToast(
        msg: getTranslated(context, 'Successfully'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showFailedToast(BuildContext context) {
    Fluttertoast.showToast(
        msg: getTranslated(context, 'ActionFailed'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showDetailOfRemoteMsg(RemoteMessage message) {
    print(
        '[RemoteMessage] = senderId: ${message.senderId}; category: ${message.category}; data: ${message.data.toString()}; notification: ${message.notification}; sentTime: ${message.sentTime}');
  }

  static void showRemoteNotification(RemoteNotification notification) {
    print([
      '[RemoteNotification] = {title: ${notification.title}, body: ${notification.body}}'
    ]);
  }
}
