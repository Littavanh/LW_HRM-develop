import 'dart:convert';
import 'dart:io';
import 'package:LTL_HRM/components/MyCustomFileUpload.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/constants/select_single_item_dialog.dart';
import 'package:LTL_HRM/src/screens/AddRequest/LeaveRequest/PODO/GetLeaveType.dart';
import 'package:LTL_HRM/src/screens/AddRequest/LeaveRequest/PODO/GetResponsiblePerson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:LTL_HRM/src/screens/home/home.dart';

class AddLeaveRequestForm extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<AddLeaveRequestForm>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<dynamic> animation;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _focusNode = new FocusNode();
  bool showHalf = false;
  bool isLoading = true;
  final TextEditingController leaveController = new TextEditingController();
  final TextEditingController resoneController = new TextEditingController();
  final TextEditingController responsiblePerController =
      new TextEditingController();
  final TextEditingController returnDateSelected = new TextEditingController();
  final TextEditingController leaveDateSelected = new TextEditingController();
  final TextEditingController rangeDateSelected = new TextEditingController();
  final TextEditingController leaveApplyFor = new TextEditingController();
  final TextEditingController totalDaysController = new TextEditingController();
  List<ResultObject> leaveList = [];
  List<String> leaveTypeList = [];

  List<ResResultObject> resPersonList = [];
  List<String> resPerLsit = [];

  String leaveLable = "Leave";
  String leaveId;
  double totalDays = 0;

  String respPerLable = "Leave";
  String respPerId;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  DateTime returndate;

  bool dateSelectedreturn = false;

  DateTime selecteddate;
  bool dateSelectedselect = false;

  // _focusListener() {
  //   setState(() {});
  // }

  void getStartDate() {
    selecteddate = dateFormat.parse(DateTime.now().toString());
    returndate = dateFormat.parse(DateTime.now().toString());
  }

  @override
  void initState() {
    // _focusNode.addListener(_focusListener);
    getTypeOfLeave();
    getResponsiblePerson();
    getStartDate();
    totalDaysController.text = totalDays.toString();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  DateTime strDate, endDate, endStartDate;
  void _onDateRangeSelect() {
    // strDate =dateFormat.parse(val.start.toString()) ;
    // endDate = dateFormat.parse(val.end.toString());
    // final difference = this.endDate.difference(strDate).inDays;
    // print("difference:: $difference");
    var totalDay = getDifferenceWithoutWeekends(strDate, endDate);
    print(totalDay);
    setState(() {
      totalDays = (totalDay == 0)
          ? selectedLeaveStartRadio == 2
              ? 1
              : 1
          : totalDay;
      // : difference.toDouble() + 1;
      print("total days: $totalDays");
      totalDaysController.text = totalDays.toString();
    });
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

  String selectedDateRange = 'Select Date Range';
  int selectedLeaveRadio = 1;
  int selectedLeaveStartRadio = 1;
  DateTime returnDate;
  String result1;
  PickedFile pickedFile;
  @override
  Widget build(BuildContext context) {
    print('add form');
    // String selectedDateRange = getTranslated(context, "SelectDateRange");
    Size size = MediaQuery.of(context).size;
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    if (!isLoading) {
      return ListView(children: <Widget>[
        FormBuilder(
          key: _fbKey,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            getTranslated(context, "LeaveApplyFor"),
                          ),
                          Radio(
                              value: selectedLeaveRadio,
                              groupValue: 1,
                              onChanged: (flag) {
                                setState(() {
                                  selectedLeaveRadio = 1;
                                  showHalf = false;
                                });
                              }),
                          Text(getTranslated(context, "FullDay"))
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: selectedLeaveRadio,
                              groupValue: 2,
                              onChanged: (flag) {
                                setState(() {
                                  selectedLeaveRadio = 2;
                                  showHalf = true;
                                });
                              }),
                          Text(getTranslated(context, "HalfDay"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              showHalf
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Leave Start From : '),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio(
                                        value: selectedLeaveStartRadio,
                                        groupValue: 1,
                                        onChanged: (flag) {
                                          setState(() {
                                            selectedLeaveStartRadio = 1;
                                          });
                                        }),
                                    Text('First Half')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Radio(
                                        value: selectedLeaveStartRadio,
                                        groupValue: 2,
                                        onChanged: (flag) {
                                          setState(() {
                                            selectedLeaveStartRadio = 2;
                                          });
                                        }),
                                    Text('Second Half')
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  : Container(),
              selectedLeaveRadio == 2
                  ? GestureDetector(
                      onTap: () async {
                        final DateTime pickedDate = await showDatePicker(
                            context: context,
                            // initialDate: DateTime.now().weekday ==
                            //             6 ||
                            //         DateTime.now().weekday == 7
                            //     ? DateTime(DateTime.now().year,
                            //         DateTime.now().month, 1)
                            //     : DateTime.now(),
                            // selectableDayPredicate:
                            //     (DateTime val) =>
                            //         val.weekday == 6 ||
                            //                 val.weekday == 7
                            //             ? false
                            //             : true,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 150)),
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (pickedDate != null)
                          setState(() {
                            selecteddate =
                                dateFormat.parse(pickedDate.toString());

                            dateSelectedselect = true;
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(dateSelectedselect
                              ? 'Selected Date: ${selecteddate.day}/${selecteddate.month}/${selecteddate.year}'
                              : 'Select Date')),
                    )
                  : Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  // initialDate: DateTime.now()
                                  //                 .weekday ==
                                  //             6 ||
                                  //         DateTime.now().weekday == 7
                                  //     ? DateTime(DateTime.now().year,
                                  //         DateTime.now().month, 1)
                                  //     : DateTime.now(),
                                  // selectableDayPredicate:
                                  //     (DateTime val) =>
                                  //         val.weekday == 6 ||
                                  //                 val.weekday == 7
                                  //             ? false
                                  //             : true,
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 150)),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 120)));
                              if (pickedDate != null)
                                setState(() {
                                  strDate =
                                      dateFormat.parse(pickedDate.toString());
                                  endStartDate = strDate;
                                });
                              // dateTimeRangePicker();
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: strDate == null
                                    ? Text(getTranslated(context, 'StartDate'))
                                    : Text(
                                        '${strDate.day}/${strDate.month}/${strDate.year}')),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // dateTimeRangePicker();
                              final DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  // selectableDayPredicate:
                                  //     (DateTime val) =>
                                  //         val.weekday == 6 ||
                                  //                 val.weekday == 7
                                  //             ? false
                                  //             : true,
                                  initialDate: endStartDate,
                                  firstDate: endStartDate,
                                  lastDate: DateTime(endStartDate.year + 1));
                              if (pickedDate != null)
                                setState(() {
                                  endDate =
                                      dateFormat.parse(pickedDate.toString());
                                  selectedDateRange =
                                      '${strDate.day}/${strDate.month}/${strDate.year}  To  ${endDate.day}/${endDate.month}/${endDate.year}';
                                });
                              _onDateRangeSelect();
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: endDate == null
                                    ? Text(getTranslated(context, 'EndDate'))
                                    : Text(
                                        '${endDate.day}/${endDate.month}/${endDate.year}')),
                          ),
                        ],
                      ),
                    ),
              selectedLeaveRadio == 2
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.all(9),
                      child: TextFormField(
                        maxLength: 4,
                        decoration: new InputDecoration(
                          hintText:
                              'Applying for  ${totalDays.toString()} days',
                          labelText: 'Applying for total days',
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
                        ),
                        controller: totalDaysController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        onSaved: (dynamic value) {
                          setState(() {
                            totalDays = double.parse(value);
                          });
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                      ),
                    ),
              GestureDetector(
                onTap: () async {
                  final DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedLeaveRadio == 1
                          ? endDate.add(Duration(days: 1))
                          : selecteddate,
                      firstDate: selectedLeaveRadio == 1
                          ? endDate.add(Duration(days: 1))
                          : selecteddate,
                      lastDate: dateFormat
                          .parse(DateTime(DateTime.now().year + 1).toString()));
                  if (pickedDate != null && pickedDate != returndate)
                    setState(() {
                      returndate = dateFormat.parse(pickedDate.toString());
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
                        ? 'Return Date: ${returndate.day}/${returndate.month}/${returndate.year}'
                        : getTranslated(context, "Returntoworkdate"))),
              ),
              Container(
                padding: const EdgeInsets.all(9),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
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
                    contentPadding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    labelText: getTranslated(context, "Selecttypeofleave"),
                  ),
                  controller: leaveController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Select Type of Leave';
                    } else {
                      return null;
                    }
                  },
                  onTap: () {
                    SelectItemDialog.showModal<String>(
                      context,
                      label: getTranslated(context, "Selecttypeofleave"),
                      titleStyle: TextStyle(color: Colors.black),
                      showSearchBox: false,
                      selectedValue: leaveLable,
                      items: leaveTypeList,
                      onChange: (String selected) {
                        setState(() {
                          leaveLable = (selected.isEmpty
                              ? getTranslated(context, "Selecttypeofleave")
                              : selected);
                          leaveController.text = leaveLable;
                          for (int i = 0; i < leaveList.length; i++) {
                            if (leaveList[i].typeName.contains(selected)) {
                              leaveId = leaveList[i].typeID;
                              print("id" + leaveId);
                            }
                          }
                        });
                      },
                    );
                  },
                ),
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
                    contentPadding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    labelText:
                        getTranslated(context, "SelectResponsiblePerson"),
                  ),
                  controller: responsiblePerController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTranslated(context, "SelectResponsiblePerson");
                    } else {
                      return null;
                    }
                  },
                  onTap: () {
                    SelectItemDialog.showModal<String>(
                      context,
                      label: getTranslated(context, "SelectResponsiblePerson"),
                      titleStyle: TextStyle(color: Colors.black),
                      showSearchBox: false,
                      selectedValue: respPerLable,
                      items: resPerLsit,
                      onChange: (String selected) {
                        setState(() {
                          respPerLable = (selected.isEmpty
                              ? getTranslated(
                                  context, "SelectResponsiblePerson")
                              : selected);
                          responsiblePerController.text = respPerLable;
                          for (int i = 0; i < resPersonList.length; i++) {
                            if (resPersonList[i].firstname.contains(selected)) {
                              respPerId = resPersonList[i].empid;
                              print("id" + respPerId);
                            }
                          }
                        });
                      },
                    );
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
                    contentPadding:
                        EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                    // suffixIcon: Icon(Icons.keyboard_arrow_down),
                    labelText: getTranslated(context, "Reason"),
                  ),
                  controller: resoneController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Select Reason';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                width: size.width * 0.9,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    result1 != null
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Colors.grey[700]),
                            ),
                            child: Image.file(
                              File(result1),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                    ElevatedButton(
                      child: Text(getTranslated(context, 'ChooseFile')),
                      onPressed: _showMyDialog,
                      // color: Colors.cyan,
                    ),
                  ],
                ),
              ),
              MyCustomFileUpload(),
              Container(
                width: size.width * 0.9,
                height: 50,
                margin: EdgeInsets.only(bottom: 30, top: 20),
                child: ElevatedButton(
                    // color: leaveCardcolor,
                    // textColor: kWhiteColor,
                    child: Text(
                      getTranslated(context, "Send"),
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        // print(_fbKey.currentState.value);
                        _placeRequests();
                      } else {
                        print('invalidate');
                      }
                    }),
              ),
            ],
          ),
        ),
      ]);
    } else {
      return Container(child: Center(child: CircularProgressIndicator()));
    }
  }

  Image img;
  PickedFile imageFile;
  _imgFromCamera() async {
    imageFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    if (imageFile != null) {
      setState(() {
        result1 = imageFile.path;
        pickedFile = imageFile;
        // _showSubmitBtn = true;
      });
    }
  }

  _imgFromGallery() async {
    imageFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 10);
    if (imageFile != null) {
      setState(() {
        result1 = imageFile.path;
        pickedFile = imageFile;
        // _showSubmitBtn = true;
      });
    }
  }

  Future<void> _showMyDialog() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
    // return showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (_) {
    //       return AlertDialog(
    //         title: Text(getTranslated(context, 'TakePic')),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text("Take photo of attachment!!!"),
    //             ],
    //           ),
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, false), // passing false
    //             child: Text(getTranslated(context, 'Gallery')),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, true), // passing true
    //             child: Text(getTranslated(context, 'Take Photo')),
    //           ),
    //         ],
    //       );
    //     }).then((exit1) async {
    //   if (exit1 == null) return;

    //   if (exit1) {
    //     //  await Navigator.pop(context);

    //     imageFile = await ImagePicker()
    //         .getImage(source: ImageSource.camera, imageQuality: 60);
    //     if (imageFile != null) {
    //       setState(() {
    //         result1 = imageFile.path;
    //         pickedFile = imageFile;
    //         // _showSubmitBtn = true;
    //       });
    //     }

    //     // user pressed Yes button
    //   } else {
    //     Navigator.pushNamed(context, homeRoute);
    //     // user pressed No button
    //   }
    // });
  }

  Future<void> getTypeOfLeave() async {
    setState(() {
      isLoading = true;
    });
    leaveList.clear();
    leaveTypeList.clear();

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.GetLeaveType;
    print(uri);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    print("value" + body.toString());
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      print("jsonResponse...kk.." + jsonResponse.toString());
      GetLeaveType leave = new GetLeaveType.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        setState(() {
          leaveList = leave.resultObject;
          for (int i = 0; i < leaveList.length; i++) {
            leaveTypeList.add(leaveList[i].typeName);
          }
        });
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          await GetToken().getToken().then((value) {
            getTypeOfLeave();
          });
        } else {
          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }

  Future<void> _placeRequests() async {
    setState(() {
      isLoading = true;
    });
    print("xfghx ${totalDaysController.text.runtimeType}");
    var base64Image;
    if (pickedFile != null) {
      Uint8List uint8list = await pickedFile.readAsBytes();
      base64Image = base64Encode(uint8list);
    } else {
      base64Image = "null";
    }

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.AddNewLeave;
    Map body = {
      "TokenKey": token,
      "attachFile": base64Image,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "LeaveTypeId": leaveId,
      "strDate": selectedLeaveRadio == 2
          ? '${selecteddate.year}-${selecteddate.month}-${selecteddate.day}'
          : '${strDate.year}-${strDate.month}-${strDate.day}',
      "endDate": selectedLeaveRadio == 2
          ? '${selecteddate.year}-${selecteddate.month}-${selecteddate.day}'
          : '${endDate.year}-${endDate.month}-${endDate.day}',
      "ReturnDate": '${returndate.year}-${returndate.month}-${returndate.day}',
      "TotalDays":
          selectedLeaveRadio == 2 ? '0.5' : '${totalDaysController.text}',
      "reasone": resoneController.text,
      "responsiblePersonID": respPerId,
      "LeaveFor": selectedLeaveRadio == 2 ? "half day" : "full day",
    };

    print('$body');
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Leave Request Added Successfully!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        print("j&&& $jsonResponse");

        Navigator.pop(context);
        // Navigator.pushNamed(context, myRequestRoute);
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          await GetToken().getToken().then((value) {
            _placeRequests();
          });
          // Future<String> token = getToken();
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: jsonResponse["ModelErrors"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }

  Future<void> getResponsiblePerson() async {
    setState(() {
      isLoading = true;
    });
    resPersonList.clear();
    resPerLsit.clear();
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.GetResponsiblePer;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      print("jsonResponse...resPerson.." + jsonResponse.toString());
      GetResponsiblePerson resPerson =
          new GetResponsiblePerson.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        setState(() {
          resPersonList = resPerson.resultObject;
          for (int i = 0; i < resPersonList.length; i++) {
            resPerLsit.add(resPersonList[i].firstname);
          }
        });
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          await GetToken().getToken().then((value) {
            getResponsiblePerson();
          });
        } else {
          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }
}
