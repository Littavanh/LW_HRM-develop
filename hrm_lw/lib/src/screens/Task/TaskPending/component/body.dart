import 'dart:convert';

import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/Task/TaskPending/component/PODO.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './background.dart';

class Body extends StatefulWidget {
  final List<ResultObject> taskPenList;
  Body({Key key, @required this.taskPenList}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(taskPenList);
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  List<ResultObject> taskPenList;
  AnimationController animationController;
  Animation<dynamic> animation;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _BodyState(this.taskPenList);
  List<bool> valuefirst = new List<bool>();

  @override
  void initState() {}

  void _itemChange(bool val, int index) {
    setState(() {
      valuefirst[index] = val;
    });
  }

  Future<void> _markcompleted() async {
    setState(() {
      isLoading = true;
    });
    // var x = valuefirst.map((val, index) {
    List map = new List();

    valuefirst.asMap().entries.map((entry) {
      int idx = entry.key;
      bool val = entry.value;
      if (val && map.indexOf(val) == -1) {
        apiCallMark(idx);
      }
      // return map;
    }).toList();
  }

  apiCallMark(index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstant.ACCESS_TOKEN);
    print("Here.. $index");

    final uri = Services.MarkCompTaskList;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2",
      "taskID": taskPenList[index].taskID,
      "CompleteStatus": "true"
    };
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, taskRoute);
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            apiCallMark(index);
          });
        } else {
          setState(() {
            isLoading = false;
          });
          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (taskPenList.length != 0) {
      if (taskPenList.length > valuefirst.length &&
          taskPenList.length != valuefirst.length) {
        setState(() {
          for (int i = 0; i < taskPenList.length; i++) {
            valuefirst.add(false);
          }
        });
      }

      return Background(
        child: Column(
          children: [
            valuefirst.indexOf(true) > -1
                ? Container(
                    margin: EdgeInsets.all(5),
                    child: TextButton(
                      child: Text(
                        'Marked Task Completed',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      // color: Colors.blueAccent,
                      // textColor: Colors.white,
                      onPressed: () {
                        _markcompleted();
                      },
                    ),
                  )
                : Container(),
            Expanded(
              child: ListView.builder(
                  itemCount: taskPenList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        background: stackBehindDismiss(),
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          //To delete
                          deleteItem(taskPenList[index].taskID);
                          //To show a snackbar with the UNDO button
                          // Scaffold.of(context).showSnackBar(SnackBar(
                          //     content: Text("Item deleted"),
                          //     action: SnackBarAction(
                          //         label: "UNDO",
                          //         onPressed: () {
                          //           //To undo deletion
                          //           undoDeletion(index, item);
                          //         }))
                          // );
                        },
                        child: Container(
                          padding: new EdgeInsets.all(0.0),
                          child: new Column(
                            children: <Widget>[
                              new CheckboxListTile(
                                  activeColor: Colors.green,
                                  value: valuefirst[index],
                                  title: new Text(taskPenList[index].taskName),
                                  subtitle: Text(taskPenList[index].taskDetail),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool val) {
                                    _itemChange(val, index);
                                  })
                            ],
                          ),
                        ));
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container(
          child: Center(
        child: Text(
          'No Pending Task.',
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }

  Future<void> deleteItem(index) async {
    print("reqID66:::$index");
    setState(() {
      isLoading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.DeleteTask;
    Map body = {
      "Tokenkey": token,
      "taskID": index,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      print("Reponse---44432222 : $jsonResponse");

      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, taskRoute);
      } else {
        setState(() {
          isLoading = false;
        });
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            deleteItem(index);
          });
        } else {
          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }

  void undoDeletion(index, item) {
    setState(() {
      taskPenList.insert(index, item);
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}