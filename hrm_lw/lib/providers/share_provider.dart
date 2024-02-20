import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/GetEmployeesInfo.dart';
import 'package:LTL_HRM/models/permission.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ShareProvider extends ChangeNotifier {
  List<Permission> _listofPermissions;
  String _appLang;
  GetEmployeesInfo _empInfo;
  RELOAD_DATA _reloadData = RELOAD_DATA.NONE;

  List<Permission> get permissions => _listofPermissions;

  GetEmployeesInfo get empInfo => _empInfo;

  String get appLang => _appLang;

  RELOAD_DATA get reloadData => _reloadData;

  clearReloadData(RELOAD_DATA clearReloadData) {
    _reloadData = clearReloadData;
  }

  setPermissions(List<Permission> permissions) {
    _listofPermissions = permissions;
  }

  updateAppLang(String appLang) {
    _appLang = appLang;
    notifyListeners();
  }

  setLocale(Locale locale) async {
    if (locale.languageCode.trim() == 'en') {
      await globalMyLocalPrefes
          .setString(AppConstant.LANG, '2')
          .then((value) {});
    } else {
      await globalMyLocalPrefes
          .setString(AppConstant.LANG, '1')
          .then((value) {});
    }
    notifyListeners();
  }

  // Future<Locale> setLocale(String languageCode) async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setString(LAGUAGE_CODE, languageCode);
  //   return _locale(languageCode);
  // }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return Locale(ENGLISH, 'US');
      case LAO:
        return Locale(LAO, "");
      default:
        return Locale(ENGLISH, 'US');
    }
  }

  void setEmployeeInfo(GetEmployeesInfo empInfo) {
    _empInfo = empInfo;
    notifyListeners();
  }

  void setReloadData(RELOAD_DATA reloadData) {
    _reloadData = reloadData;
    notifyListeners();
  }
}
