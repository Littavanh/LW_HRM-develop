import 'dart:convert';
import 'dart:io';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/models/GetEmployeesInfo.dart';
import 'package:LTL_HRM/models/emp_person.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/instant_search_page.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String title;
  final ValueChanged<String> validator;

  Body({this.title, this.validator});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _focusNode = new FocusNode();

  List<EmpPerson> delPersonList = [];
  List<String> delPerList = [];
  final TextEditingController delPerController = new TextEditingController();
  String leaveLable = "Leave";
  String leaveId;

  // String endDate;

  int totalDays = 0;

  String delPerLable = "Leave";
  String delPerId;

  bool isLoading = true;

  String selectedDateRange;
  DateTime _now = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate;
  DateTime _returndate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    super.initState();
    if (_endDate == null) {
      _endDate = DateTime(_now.year, _now.month, _now.day + 1);
      _returndate = DateTime(_endDate.year, _endDate.month, _endDate.day + 1);
    }

    getDelegatePerson();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  _buildSearchEmployee(
    BuildContext context,
    List<String> empList,
    // allEmpList,
  ) async {
    final result = await showSearch(
        context: context,
        delegate: InstantSearchPage(
            empList, getTranslated(context, 'EnterEmpName'), Icons.person));
    //update selection person
    if (result != null) {
      setState(() {
        delPerController.text = result;
        for (int i = 0; i < delPersonList.length; i++) {
          if (delPersonList[i].empName.contains(result)) {
            delPerId = delPersonList[i].empId;
          }
        }
      });
    }
    print('delPersonId:$delPerId');
  }

  Future<void> getDelegatePerson() async {
    setState(() {
      isLoading = true;
    });
    delPersonList.clear();
    delPerList.clear();
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    SharedPreferences sp = await SharedPreferences.getInstance();
    final uri = sp.getString('BASE_URL') + Services.DelegatePerson;
    final GetEmployeesInfo empInfo = context.read<ShareProvider>().empInfo;

    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "DeptID": empInfo.empDeptId,
    };
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["StatusCode"] == 200 &&
          jsonResponse['ResultObject'] != null) {
        final List<dynamic> results = jsonResponse['ResultObject'];
        List<EmpPerson> persons =
            results.map((e) => EmpPerson.fromJson(e)).toList();

        setState(() {
          isLoading = false;
          delPersonList = persons;
          for (int i = 0; i < delPersonList.length; i++) {
            delPerList.add(delPersonList[i].empName);
          }
        });
      } else {
        print("ModelError: getDelegatePerson!");
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  String _getDateRangStr(DateTime startDate, DateTime endDate) {
    return "${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}";
  }

  dateTimeRangePicker() async {
    DateTimeRange picked = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.input,
      context: context,
      firstDate: _startDate,
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: DateTimeRange(
        end: _endDate,
        start: _startDate,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _returndate = DateTime(_endDate.year, _endDate.month, _endDate.day + 1);

        final difference = _endDate.difference(_startDate).inDays;
        totalDays = difference;

        selectedDateRange = _getDateRangStr(_startDate, _endDate);
      });
    }

    // _onDateRangeSelect(picked);
  }

  // void _onDateRangeSelect(DateTimeRange val) {
  //   _startDate = val.start;
  //   _endDate = val.end;

  //   final difference = _endDate.difference(_startDate).inDays;
  //   setState(() {
  //     totalDays = difference;
  //   });
  // }

  bool dateSelectedreturn = false;
  final TextEditingController resoneController = new TextEditingController();
  final TextEditingController subject = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (selectedDateRange == null) {
      selectedDateRange =
          selectedDateRange = getTranslated(context, 'SelectDateRange');
    }
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      dateTimeRangePicker();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text('$selectedDateRange')),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                          '${getTranslated(context, 'TotalDays')} ${totalDays.toString()} ${getTranslated(context, 'Days')}')),
                  GestureDetector(
                    onTap: () async {
                      final DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().weekday == 6 ||
                                  DateTime.now().weekday == 7
                              ? DateTime(
                                  DateTime.now().year, DateTime.now().month, 1)
                              : DateTime.now(),
                          selectableDayPredicate: (DateTime val) =>
                              val.weekday == 6 || val.weekday == 7
                                  ? false
                                  : true,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1));
                      if (pickedDate != null && pickedDate != _returndate)
                        setState(() {
                          _returndate = pickedDate;
                          dateSelectedreturn = true;
                        });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(dateSelectedreturn
                            ? '${getTranslated(context, 'Returntoworkdate')} ${_returndate.toString().substring(0, 10)}'
                            : '${getTranslated(context, 'Returntoworkdate')}')),
                  ),

                  Container(
                    padding: const EdgeInsets.all(9),
                    child: TextFormField(
                      readOnly: true,
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: _focusNode.hasFocus
                            ? OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: leaveCardcolor))
                            : OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey)),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        labelText: getTranslated(context, 'ResponsePerson'),
                      ),
                      controller: delPerController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return getTranslated(context, 'PleaseEnterValue');
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        _buildSearchEmployee(context, delPerList);
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(9),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: _focusNode.hasFocus
                            ? OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: leaveCardcolor))
                            : OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey)),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        // suffixIcon: Icon(Icons.keyboard_arrow_down),
                        labelText: getTranslated(context, 'Reason'),
                      ),
                      controller: resoneController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return getTranslated(context, 'PleaseEnterValue');
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  // MyCustomFileUpload(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                      // padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        getTranslated(context, 'Send'),
                        style: Theme.of(context).textTheme.labelLarge.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      // color: Colors.green,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          String token = globalMyLocalPrefes
                              .getString(AppConstant.ACCESS_TOKEN);
                          String id =
                              globalMyLocalPrefes.getString(AppConstant.EMP_ID);
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          String uri =
                              sp.getString('BASE_URL') + Services.AddDelegate;
                          GetEmployeesInfo empInfo =
                              context.read<ShareProvider>().empInfo;

                          final startDate =
                              DateFormat('yyyy-MM-dd').format(_startDate);
                          final endDate =
                              DateFormat('yyyy-MM-dd').format(_endDate);
                          final reCallDate =
                              DateFormat('yyyy-MM-dd').format(_endDate);

                          Map body = {
                            "TokenKey": token,
                            "lang":
                                globalMyLocalPrefes.getString(AppConstant.LANG),
                            "empID": empInfo.empId,
                            "delegateEmpID": '$delPerId',
                            "noted": resoneController.text,
                            "strDate": startDate,
                            "endDate": endDate,
                            "reCallDate": reCallDate,
                          };

                          print(
                              'postGetEmployeeInfo: [POST] --> $uri; body --> $body');
                          http
                              .post(Uri.parse(uri),
                                  headers: {
                                    HttpHeaders.contentTypeHeader:
                                        'application/json'
                                  },
                                  body: jsonEncode(body))
                              .then((response) {
                            var jsonResponse = jsonDecode(response.body);
                            // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);

                            print(jsonResponse.toString());
                            if (jsonResponse["StatusCode"] == 200) {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Delegates Added Successfully!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              print("j&&& $jsonResponse");
                              print("j&&& $jsonResponse");
                              Navigator.pop(context);
                            } else {
                              print(
                                  "ModelError: ${jsonResponse["ModelErrors"]}");
                              if (jsonResponse["ModelErrors"] ==
                                  'Unauthorized') {
                                GetToken().getToken().then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Please try again!!!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                });
                                // Future<String> token = getToken();
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Something went wrong, please try again later!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          });
                        }
                      }),
                ),
              ],
            ),
            isLoading ? LinearProgressIndicator() : Container(),
          ],
        ));
  }
}
