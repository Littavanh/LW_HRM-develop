import 'dart:convert';
import 'dart:typed_data';
import 'package:LTL_HRM/models/emp_person.dart';
import 'package:LTL_HRM/models/leave_type.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../main.dart';

class LeaveFormVM extends ChangeNotifier {
  int _leaveType = 1;
  DateTime _strDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime _returnDate = DateTime.now();
  double _totalDays = 1;
  String _typeOfLeave;
  String _typeOfLeaveId;
  List<String> _empOptionList;
  String _responsiblePerson;
  String _responsiblePersonId;
  String _leaveReason;
  RequestService _requestService = RequestService();
  PickedFile _pickedFile;
  bool _isLoading = false;
  int _leaveHalfDay = 1;
  DateTime _halfDayDate = DateTime.now();

  int get leaveType => _leaveType;

  DateTime get strDate => _strDate;

  DateTime get endDate => _endDate;

  double get totalDays => _totalDays;

  DateTime get returnDate => _returnDate;

  String get typeOfLeave => _typeOfLeave;

  String get typeOfLeaveId => _typeOfLeaveId;

  List<String> get empOptionList => _empOptionList;

  String get responsiblePerson => _responsiblePerson;

  String get leaveReason => _leaveReason;

  String get responsiblePersonId => _responsiblePersonId;

  PickedFile get pickedFile => _pickedFile;

  int get leaveHalfDay => _leaveHalfDay;

  DateTime get halfDayDate => _halfDayDate;

  bool get isLoading => _isLoading;

  onChangeLeaveType(int type) {
    _leaveType = type;
    notifyListeners();
  }

  void updateStrDate(DateTime date) {
    _strDate = date;
    _endDate = date;
    _returnDate = _endDate;
    notifyListeners();
  }

  void updateEndDate(DateTime date) {
    _endDate = date;
    _returnDate = _endDate;
    _onDateRangeSelect();
    notifyListeners();
  }

  void updateTotalDays(double days) {
    _totalDays = days;
  }

  void updateReturnDate(DateTime date) {
    _returnDate = date;
    notifyListeners();
  }

  void updateTypeOfLeave(String type, List<LeaveType> leaveList) {
    _typeOfLeave = type;
    print('_typeOfLeave: $_typeOfLeave');
    for (int i = 0; i < leaveList.length; i++) {
      if (leaveList[i].typeName == type) {
        _typeOfLeaveId = leaveList[i].typeId;
        print('_typeOfLeaveId: $_typeOfLeaveId');
      }
    }
    notifyListeners();
  }

  void _onDateRangeSelect() {
    final totalDay = getDifferenceWithoutWeekends(_strDate, _endDate);
    _totalDays = (totalDay == 0)
        ? leaveType == 2
            ? 1
            : 1
        : totalDay;
  }

  void updateLeaveHalfDay(int halfDay) {
    _leaveHalfDay = halfDay;
    _strDate = DateTime.now();
    _endDate = DateTime.now();
    _returnDate = DateTime.now();
    _onDateRangeSelect();
    notifyListeners();
  }

  double getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    double nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.saturday &&
          currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays + 1;
  }

  double calculateDifferenceDays() {
    double nbDays = 0;
    DateTime currentDay = _strDate;
    while (currentDay.isBefore(_endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.saturday &&
          currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays + 1;
  }

  void updateResponsiblePerson(person, List<EmpPerson> empList) {
    _responsiblePerson = person;
    for (int i = 0; i < empList.length; i++) {
      if (empList[i].empName.contains(person)) {
        _responsiblePersonId = empList[i].empId;
      }
    }
    notifyListeners();
  }

  void updateEmpOptionList(List<String> empList) {
    _empOptionList = empList;
  }

  onLeaveReasonChanged(String value) {
    _leaveReason = value;
  }

  void updateHalfDayDate(DateTime date) {
    _halfDayDate = date;
    notifyListeners();
  }

  onSubmitRequest() async {
    notifyListeners();

    String fileType;
    _isLoading = true;

    var base64Image;
    if (pickedFile != null) {
      Uint8List uint8list = await pickedFile.readAsBytes();
      base64Image = base64Encode(uint8list);
    } else {
      base64Image = "null";
    }
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    if (pickedFile != null) {
      final paths = pickedFile.path.split("/");
      String fileName = paths[paths.length - 1];
      fileType = fileName.split(".")[1];
    }

    Map body = {
      'tokenKey': token,
      'lang': globalMyLocalPrefes.getString(AppConstant.LANG),
      'empID': globalMyLocalPrefes.getInt(AppConstant.USER_ID),
      'leaveTypeID': _typeOfLeaveId,
      "leaveRequestNo": "",
      'leaveDay': _leaveType,
      'startDate': _strDate.toString(),
      'endDate': _endDate.toString(),
      'returnDate': _returnDate.toString(),
      'amountDay': _leaveType == 1 ? _totalDays : 0.5,
      'noted': _leaveReason,
      'delegateEmpID': _responsiblePersonId ?? 0,
      "fileType": fileType ?? "",
      'fileAttached': base64Image ?? "null",
      'transactionTypeId': 3,
      "expDate": "",
      "referAdd": "",
      "from_device": "2"
    };

    await _requestService.addNewLeaveRequest(body);
    _isLoading = false;
    notifyListeners();
  }

  void onChooseFile(PickedFile imageFile) {
    _pickedFile = imageFile;
    notifyListeners();
  }

  setUpWFH() {
    _typeOfLeaveId = "9";
  }
}
