import 'dart:convert';

import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/Payslip/PayslipDesc/payslipDesc.dart';
import 'package:LTL_HRM/src/screens/Payslip/component/paySlipListPODO.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import './background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  var _focusNode = new FocusNode();

  _focusListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ResultObject> payslipList = new List();
  AnimationController animationController;
  Animation<dynamic> animation;
  bool isLoading = true;

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    _getInsurHeader();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<void> _getInsurHeader() async {
    payslipList.clear();
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.PayslipList;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      PayslipList payslipLists = new PayslipList.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        payslipList = payslipLists.resultObject;
        print("DDDDDDD--->>>${payslipList.toString()}");
      } else {
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          print("ModelError: ${jsonResponse["ModelErrors"]}");
          GetToken().getToken().then((value) {
            _getInsurHeader();
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

  void takeAction(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PayslipDesc(payslipDetailID: id, payslipList: payslipList)),
    );
  }

  Widget notiDetailCard(PayslipList) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new InkWell(
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                PayslipList.slipMonthYr,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          // color: Colors.yellow,
                        ),
                      ),
                    ),

                    // new Placeholder(),
                  ],
                ),
              ),
              Container(
                // color: Colors.pink,
                width: size.width * 0.76,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "SlipNo." + PayslipList.slipNo,
                            style: new TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        children: <Widget>[
                          Text(
                            PayslipList.slipDate,
                            style: new TextStyle(fontSize: 14.0),
                          ),
                          // new Placeholder(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => takeAction(PayslipList.slipID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Background(
        child: (payslipList != null && payslipList.length > 0)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: payslipList.map((p) {
                  return notiDetailCard(p);
                }).toList()
                // SizedBox(height: size.height * 0.03),

                )
            : Column(
                children: [
                  Container(
                    child: Text(
                      "No payslip",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}