import 'dart:async';
import 'dart:convert';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/Task/TaskAll/taskAll.dart';
import 'package:LTL_HRM/src/screens/Task/TaskCompleted/taskCompleted.dart';
import 'package:LTL_HRM/src/screens/Task/TaskPending/component/PODO.dart';
import 'package:LTL_HRM/src/screens/Task/TaskPending/taskPending.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import './background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ResultObject> myTaskAllList = new List();
  List<ResultObject> myTaskPenList = new List();

  List<ResultObject> myTaskCompList = new List();

  AnimationController animationController;
  Animation<dynamic> animation;
  bool isLoading = false;

  @override
  void initState() {
    _getTaskList();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<void> _getTaskList() async {
    setState(() {
      isLoading = true;
    });
    myTaskAllList.clear();

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.TaskList;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      TaskList myRequest = new TaskList.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });

        print("j&&& $myRequest");
        myTaskAllList = myRequest.resultObject ?? [];
        for (int i = 0; i < myTaskAllList.length; i++) {
          if (myTaskAllList[i].taskStatus) {
            myTaskCompList.add(myTaskAllList[i]);
          } else {
            myTaskPenList.add(myTaskAllList[i]);
          }
        }
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            _getTaskList();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.pending_actions),
                    text: "Pending",
                  ),
                  Tab(icon: Icon(Icons.done), text: "Complete"),
                  Tab(icon: Icon(Icons.all_inbox), text: "All"),
                ],
              ),
              title: Text(getTranslated(context, 'MyTask'))),
          body: TabBarView(
            children: [
              TaskPending(data: myTaskPenList),
              TaskCompleted(data: myTaskCompList),
              TaskAll(data: myTaskAllList)
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, addTaskRoute);
              // Add your onPressed code here!
            },
            elevation: 4,
            label: Text(getTranslated(context, 'AddTask')),
            icon: Icon(
              Icons.add,
            ),
            backgroundColor: Colors.pink,
          )),
    ));
  }
}