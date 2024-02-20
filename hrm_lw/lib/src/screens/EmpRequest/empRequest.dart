import 'dart:async';
import 'dart:convert';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/EmpLeaveRequest/empLeaveRequest.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/EmpOTRequest/empOtRequest.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/empRequestPODO.dart';
import 'package:flutter/material.dart';

class EmpRequest extends StatefulWidget {
  // final TabController tabBar;
  EmpRequest();

  @override
  _EmpRequestState createState() => _EmpRequestState();
}

class _EmpRequestState extends State<EmpRequest> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ResultObject> empRequestList = [];
  List<ResultObject> empLeaveReqList = [];
  List<ResultObject> empOtReqList = [];
  AnimationController animationController;
  Animation<dynamic> animation;
  bool isLoading = false;
  @override
  void initState() {
    _getEmpRequests();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Employees Requests'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            isLoading
                ? LoadingView()
                : empLeaveReqList.isNotEmpty
                    ? EmpLeaveRequest(data: empLeaveReqList)
                    : NoDataFound(),
            isLoading
                ? LoadingView()
                : empOtReqList.isNotEmpty
                    ? EmpOTRequest(data: empOtReqList)
                    : NoDataFound(),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              text: 'LEAVE REQUEST',
              // icon: new Icon(Icons.home),
            ),
            Tab(
              text: 'OT REQUEST',
              // icon: new Icon(Icons.rss_feed),
            ),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(1.0),
          indicatorColor: Colors.red,
          indicator: BoxDecoration(
            color: Colors.white,

            // borderRadius: BorderRadius.circular(15.0),
            boxShadow: [BoxShadow(color: Colors.red, blurRadius: 3.0)],
          ),
        ),
        // backgroundColor: Colors.black,
      ),
    );
  }

  Future<void> _getEmpRequests() async {
    empRequestList.clear();

    setState(() {
      isLoading = true;
    });
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.EmpRequest;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      EmpRequestList myRequest = new EmpRequestList.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        empRequestList = myRequest.resultObject;
        for (int i = 0; i < empRequestList.length; i++) {
          if (empRequestList[i].requestType == 'Leave') {
            empLeaveReqList.add(empRequestList[i]);
          } else {
            empOtReqList.add(empRequestList[i]);
          }
        }
        setState(() {
          isLoading = false;
        });
      } else {
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          print("ModelError: ${jsonResponse["ModelErrors"]}");
          GetToken().getToken().then((value) {
            _getEmpRequests();
          });

          // Future<String> token = getToken();
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

          print("ModelError: ${jsonResponse["ModelErrors"]}");
          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }
}