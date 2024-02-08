import 'dart:convert';
import 'package:LTL_HRM/components/MyCustomFileUpload.dart';
import 'package:LTL_HRM/components/MyCustomTextField.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/constants/select_single_item_dialog.dart';
import 'package:LTL_HRM/src/screens/AddRequest/LeaveRequest/PODO/GetResponsiblePerson.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './background.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  final String title;
  final ValueChanged<String> validator;

  Body({this.title, this.validator});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  var _focusNode = new FocusNode();
  List<ResResultObject> resPersonList = new List();
  List<String> resPerLsit = new List();
  final TextEditingController responsiblePerController =
      new TextEditingController();
  bool isLoading = false;
  String respPerLable = "Leave";
  String respPerId;
  AnimationController animationController;
  Animation<dynamic> animation;

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    getResponsiblePerson();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  Future<void> getResponsiblePerson() async {
    setState(() {
      isLoading = true;
    });
    resPersonList.clear();
    resPerLsit.clear();
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.GetResponsiblePer;
    print(uri);
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      print("...resPerson.." + jsonResponse.toString());
      if (jsonResponse["StatusCode"] == 200) {
        GetResponsiblePerson resPerson =
            new GetResponsiblePerson.fromJson(jsonResponse);
        setState(() {
          isLoading = false;
          resPersonList = resPerson.resultObject;
          for (int i = 0; i < resPersonList.length; i++) {
            resPerLsit.add(resPersonList[i].firstname);
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          print("jsonResponse ${jsonResponse["ModelErrors"]}");
          GetToken().getToken().then((value) {
            getResponsiblePerson();
          });
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong, please try again later.",
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

  Future<void> _addTask(data) async {
    print(data["subject"]);
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    setState(() {
      isLoading = true;
    });

    final uri = Services.AddTaskList;

    Map body = {
      "TokenKey": token,
      "taskName": data["subject"],
      "taskDetail": data["reason"],
      "emp_id": respPerId,
      "Task_attachec_file": "sample string 5",
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    print("j&&& $body");
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      print("jsonResponse:: $jsonResponse");
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, taskRoute);
        print("j& $jsonResponse");
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            _addTask(data);
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Something went wrong, please try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }).catchError((onError) => {print("onError:: $onError")});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    return Background(
        child: !isLoading
            ? FormBuilder(
                key: _fbKey,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(9),
                              child: TextFormField(
                                readOnly: true,
                                decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: _focusNode.hasFocus
                                      ? OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: leaveCardcolor))
                                      : OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 10.0, left: 10.0, right: 10.0),
                                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                                  labelText: getTranslated(
                                      context, 'SelectResponsiblePerson'),
                                ),
                                controller: responsiblePerController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return getTranslated(
                                        context, 'SelectResponsiblePerson');
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  SelectItemDialog.showModal<String>(
                                    context,
                                    label: getTranslated(
                                        context, 'SelectResponsiblePerson'),
                                    titleStyle: TextStyle(color: Colors.black),
                                    showSearchBox: false,
                                    selectedValue: respPerLable,
                                    items: resPerLsit,
                                    onChange: (String selected) {
                                      setState(() {
                                        respPerLable = (selected.isEmpty
                                            ? getTranslated(context,
                                                'SelectResponsiblePerson')
                                            : selected);
                                        responsiblePerController.text =
                                            respPerLable;
                                        for (int i = 0;
                                            i < resPersonList.length;
                                            i++) {
                                          if (resPersonList[i]
                                              .firstname
                                              .contains(selected)) {
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
                            MyCustomTextField(
                                title: getTranslated(context, 'Subject'),
                                attrName: 'subject'),
                            MyCustomTextField(
                                title: getTranslated(context, 'Reason'),
                                attrName: 'reason'),
                            MyCustomFileUpload(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            child: Text(getTranslated(context, 'Send')),
                            onPressed: () {
                              if (_fbKey.currentState.saveAndValidate()) {
                                print(_fbKey.currentState.value);
                                _addTask(_fbKey.currentState.value);
                              }
                            }),
                        ElevatedButton(
                            child: Text(getTranslated(context, 'Clear')),
                            onPressed: () {
                              _fbKey.currentState.reset();
                            })
                      ],
                    )
                  ],
                ))
            : Container(child: Center(child: CircularProgressIndicator())));
  }
}