import 'dart:convert';

import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/Loans/component/loanDetailsPODO.dart';
import 'package:LTL_HRM/src/screens/Loans/component/loanPODO.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './background.dart';
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

  _focusListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ResultObject> loanHeader = new List();
  List<ResultDetailsObject> loanDetails = new List();
  AnimationController animationController;
  Animation<dynamic> animation;
  bool isLoading = true;

  @override
  void initState() {
    _focusNode.addListener(_focusListener);
    _getLoanHeader();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<void> _getLoanHeader() async {
    loanHeader.clear();
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.LoanHeader;
    Map body = {
      "Tokenkey": token,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      LoanHeader insuranceHeaderLst = new LoanHeader.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        loanHeader = insuranceHeaderLst.resultObject;
        print("DDDDDDD--->>>${loanHeader.toString()}");
      } else {
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          print("ModelError: ${jsonResponse["ModelErrors"]}");
          GetToken().getToken().then((value) {
            _getLoanHeader();
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

  Future<void> _getLoanDetails(String id) async {
    setState(() {
      isLoading = true;
    });
    loanDetails.clear();

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    Map body = {
      "Tokenkey": token,
      "loanID": id,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    final uri1 = Services.LoanDetail;
    http.post(Uri.parse(uri1), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      LoanDetails loanDetailsLst = new LoanDetails.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        loanDetails = loanDetailsLst.resultObject;
        print("DD--->>>${loanDetails.toString()}");
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildPopupDialog(context, loanDetails),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          print("ModelError: ${jsonResponse["ModelErrors"]}");
          GetToken().getToken().then((value) {
            _getLoanDetails(id);
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

  Widget _buildPopupDialog(BuildContext context, data) {
    Size size = MediaQuery.of(context).size;
    return new AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(10),
      scrollable: true,
      title: const Text('Loans Details'),
      content: Container(
        height: size.height * 0.99,
        width: size.width,
        padding: const EdgeInsets.only(bottom: 160),
        child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.grey[200]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Interest : " + data[i].loanInterest.toString()),
                      Text(data[i].paymentDate),
                      Text(
                        "Total Pay : " + data[i].loanTotalPay.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Balance : " + data[i].loanBalance.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ));
            }),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Background(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                loanHeader.length > 0
                    ? Container(child: loanList(context))
                    : Container(
                        child: Text(
                        "No Loans",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(child: Center(child: CircularProgressIndicator()));
    }
  }

  Widget loanList(BuildContext context) {
    final children = <Widget>[];
    if (loanHeader != null) {
      for (var i = 0; i < loanHeader.length; i++) {
        children.add(new GestureDetector(
            onTap: () {
              print("id ${loanHeader[i].loanID}");

              _getLoanDetails(loanHeader[i].loanID.toString());
            },
            child: new Container(
              // padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[350],
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Laon amount : ' +
                                  loanHeader[i].loanAmount.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Months : " +
                                  loanHeader[i].loanAmuntMonth.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monthly Fee : ' +
                                  loanHeader[i].loanMonthlyFee.toString(),
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Interest : ' +
                                  loanHeader[i].loanInterest.toString(),
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Balance : ' +
                                  loanHeader[i].loanTotalBalance.toString(),
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
      }
    } else {
      children.add(Container(
          child: Text(
        "No Loans",
        style: TextStyle(fontWeight: FontWeight.normal),
      )));
    }

    return Expanded(
        child:
            SizedBox(height: 200.0, child: new ListView(children: children)));
  }

  Widget loanDetailsList(BuildContext context) {
    final children = <Widget>[];
    if (loanDetails != null) {
      for (var i = 0; i < loanDetails.length; i++) {
        children.add(new Container(
          // width: size.width,
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[350],
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text('Pay Date :' + loanDetails[i].paymentDate),
                        Text('Interest: ' +
                            loanDetails[i].loanInterest.toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        'Total Pay :' + loanDetails[i].loanTotalPay.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        'Balance :' + loanDetails[i].loanBalance.toString()),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    } else {
      children.add(Container(
          child: Text(
        "No Loans",
        style: TextStyle(fontWeight: FontWeight.normal),
      )));
    }

    return Expanded(
        child:
            SizedBox(height: 200.0, child: new ListView(children: children)));
  }
}
