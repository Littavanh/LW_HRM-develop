import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class AddRequestVM extends ChangeNotifier {
  int _otPayType = 1;
  // DateTime _otStartDateTime = DateTime.now().add(Duration(minutes: 40));
  // DateTime _otEndDateTime = DateTime.now().add(Duration(minutes: 100));
  DateTime _otStartDateTime;
  DateTime _otEndDateTime;
  RequestService _requestService = RequestService();

  String _subject;
  String _reason;

  bool _loading = false;

  int get otPayType => _otPayType;

  DateTime get otStartDateTime => _otStartDateTime;

  DateTime get otEndDateTime => _otEndDateTime;

  bool get loading => _loading;

  onChangeOtPayType(int type) {
    _otPayType = type;
    notifyListeners();
  }

  updateOtStartDate(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = dateFormat.parse(date);
    _otStartDateTime = dateTime;
    notifyListeners();
  }

  updateOtEndDate(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = dateFormat.parse(date);
    _otEndDateTime = dateTime;
    notifyListeners();
  }

  onSubjectChanged(String value) {
    _subject = value;
  }

  onReasonChanged(String value) {
    _reason = value;
  }

  onSendRequest(GlobalKey<FormBuilderState> fbKey, BuildContext context) async {
    if (fbKey.currentState.saveAndValidate()) {
      String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
      _loading = true;
      notifyListeners();

      final reqBody = {
        "TokenKey": token,
        "lang": globalMyLocalPrefes.getString(AppConstant.LANG),
        "empID": globalMyLocalPrefes.getInt(AppConstant.USER_ID),
        "otTypeID": _otPayType,
        'otSettingID': 1,
        "startDate": DateFormat('yyyy-MM-dd').format(_otStartDateTime),
        "endDate": DateFormat('yyyy-MM-dd').format(_otEndDateTime),
        "otStartTime": DateFormat('kk:mm').format(_otStartDateTime),
        "otEndTime": DateFormat('kk:mm').format(_otEndDateTime),
        "noted": _reason,
        "fileAttached": "",
        "managerID": 0
      };

      await _requestService.requestOT(reqBody);
      _loading = false;
      notifyListeners();
      Navigator.pop(context);
    }
  }
}
