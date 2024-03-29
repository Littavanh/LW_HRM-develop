import 'package:LTL_HRM/components/approvalAction.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/RequestDetails/empReqDetailPODO.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import './background.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  final String data;
  Body({Key key, @required this.data}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(data);
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  String data;
  final _formKey = GlobalKey<FormState>();

  List<RequestTitleObject> myReqTitleObj = [];
  List<ApprovedObject> approvedObject = [];
  List<RequestItemObject> requestItemObject = [];
  bool isLoading = true;

  int totalDays;

  String errortext;
  _BodyState(this.data);

  @override
  void initState() {
    super.initState();
    String empLevId = widget.data;
    _getEmpReqDetails(empLevId);
  }

  void takeAction(text) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApprovalAction(text)),
    );
  }

  int totalDayss;
  DateTime strDate, endDate;

  Future<void> _getEmpReqDetails(reqID) async {
    print("reqID:::$reqID");
    setState(() {
      isLoading = true;
    });
    myReqTitleObj.clear();
    approvedObject.clear();
    requestItemObject.clear();

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    final uri = Services.EmpRequestDetails;
    Map body = {
      "Tokenkey": token,
      "requestID": reqID,
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG) ?? "2"
    };

    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      EmpReqDetails getLevReqDetails = new EmpReqDetails.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        myReqTitleObj = getLevReqDetails.requestTitleObject ?? [];
        approvedObject = getLevReqDetails.approvedObject ?? [];
        requestItemObject = getLevReqDetails.requestItemObject ?? [];

        print("R2 : ${myReqTitleObj.first.toJson()}");
        print(
            "R2 : ${approvedObject.isNotEmpty ? approvedObject.first.toJson() : ""}");
        print(
            "R2 : ${requestItemObject.isNotEmpty ? requestItemObject.first.toJson() : ""}");

        setState(() {
          isLoading = false;
        });
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            _getEmpReqDetails(reqID);
          });
          // Future<String> token = getToken();
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
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  DateTime tempDate;
  TextEditingController resoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.pushNamed(context, addRequestRoute);
      //     // Add your onPressed code here!
      //   },
      //   elevation: 4,
      //   child: Icon(
      //     Icons.calendar_today,
      //   ),
      //   backgroundColor: Colors.pink,
      // ),
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: (myReqTitleObj.isEmpty && (isLoading))
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()))
          : Background(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .15),
                              blurRadius: 16.0)
                        ],
                      ),
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // Icon(Icons.arrow_back_ios),
                                  myReqTitleObj[0].empPhoto != null
                                      ? Container(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: ClipOval(
                                            child: Image.memory(
                                              base64Decode(
                                                  myReqTitleObj[0].empPhoto),
                                              height: 47,
                                              width: 47,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(myReqTitleObj[0].empName,
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  fontWeight: FontWeight.bold)),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                myReqTitleObj[0].empPosition,
                                                style:
                                                    TextStyle(fontSize: 14.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.phone),
                                    ),
                                    onTap: () {
                                      if (myReqTitleObj[0].empContact != null) {
                                        launch("tel://" +
                                            myReqTitleObj[0].empContact);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please try again later.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  'Request No: ${myReqTitleObj.isNotEmpty ? myReqTitleObj[0].requestNo : "-"}'),
                            ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  'Request Type: ${myReqTitleObj.isNotEmpty ? myReqTitleObj[0].requestType : "-"}'),
                            ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  'Request Date: ${myReqTitleObj.isNotEmpty ? myReqTitleObj[0].dateRequest.split(" ")[0] : "-"}'),
                            ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            myReqTitleObj[0].requestType != 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'OT Date: ${myReqTitleObj.isNotEmpty ? myReqTitleObj[0].otdate.split(" ")[0] : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType != 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Start Date:  ${requestItemObject.isNotEmpty ? requestItemObject[0].strDate.split(" ")[0] : "-"}  To  ${requestItemObject.isNotEmpty ? requestItemObject[0].endDate.split(" ")[0] ?? "" : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Return Date: ${requestItemObject.isNotEmpty ? requestItemObject[0].returnDate.split(" ")[0] ?? "" : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Duration: ${requestItemObject.isNotEmpty ? requestItemObject[0].duration : "-"} days'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  'Request Status: ${myReqTitleObj.isNotEmpty ? myReqTitleObj[0].statusText : "-"}'),
                            ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8),
                            //   child: Text(
                            //       'Reason: ${requestItemObject.isNotEmpty ? requestItemObject[0].requestReason : "-"}'),
                            // ),
                            SizedBox(
                              width: size.width,
                              height: 1.0,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Manager: ${requestItemObject.isNotEmpty ? requestItemObject[0].managerName : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Request Reason: ${requestItemObject.isNotEmpty ? requestItemObject[0].requestReason ?? "" : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            requestItemObject.isEmpty
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Response Name: ${requestItemObject.isNotEmpty ? requestItemObject[0].responseName ?? "" : "-"}'),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : SizedBox(
                                    width: size.width,
                                    height: 1.0,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                            myReqTitleObj[0].requestType == 'OT'
                                ? Container()
                                : Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                        'Requested For: ${requestItemObject.isNotEmpty ? requestItemObject[0].requestFor : "-"}'),
                                  ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 10.0, left: 10.0, right: 10.0),
                                  // suffixIcon: Icon(Icons.keyboard_arrow_down),
                                  labelText: 'Comment',
                                  errorText: errortext,
                                ),
                                controller: resoneController,
                                onChanged: (str) {
                                  setState(() {
                                    errortext = null;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (resoneController.text != "") {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        String token =
                                            globalMyLocalPrefes.getString(
                                                AppConstant.ACCESS_TOKEN);
                                        // final uri = Services.RejectOT;
                                        final uri =
                                            myReqTitleObj[0].requestType == 'OT'
                                                ? Services.RejectOT
                                                : Services.RejectLeave;
                                        Map body = {
                                          "TokenKey": token,
                                          "lang": globalMyLocalPrefes.getString(
                                                  AppConstant.LANG) ??
                                              "2",
                                          "requestID":
                                              myReqTitleObj[0].requestID,
                                          "rejectDescription":
                                              resoneController.text ?? " ",
                                        };

                                        print('$body');
                                        http
                                            .post(Uri.parse(uri), body: body)
                                            .then((response) {
                                          var jsonResponse =
                                              jsonDecode(response.body);
                                          // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);
                                          if (jsonResponse["StatusCode"] ==
                                              200) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg:
                                                    jsonResponse['ModelErrors'],
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            print("j&&& $jsonResponse");
                                            Navigator.pushNamed(
                                                context, empRequestRoute);
                                          } else {
                                            print(
                                                "ModelError: ${jsonResponse["ModelErrors"]}");
                                            if (jsonResponse["ModelErrors"] ==
                                                'Unauthorized') {
                                              GetToken()
                                                  .getToken()
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: "Please try again!!!",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Something went wrong, please try again later.",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          errortext = "Please Enter Comment";
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Reject',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    // color: Colors.red,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (resoneController.text != "") {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        String token =
                                            globalMyLocalPrefes.getString(
                                                AppConstant.ACCESS_TOKEN);
                                        final uri =
                                            myReqTitleObj[0].requestType == 'OT'
                                                ? Services.ApproveOT
                                                : Services.ApproveLeave;
                                        Map body = {
                                          "TokenKey": token,
                                          "lang": globalMyLocalPrefes.getString(
                                                  AppConstant.LANG) ??
                                              "2",
                                          "requestID":
                                              myReqTitleObj[0].requestID,
                                          "approvedescription":
                                              resoneController.text ?? " ",
                                          "approveby": globalMyLocalPrefes
                                              .getString(AppConstant.EMP_ID)
                                              .toString(),
                                        };

                                        print('$body');
                                        http
                                            .post(Uri.parse(uri), body: body)
                                            .then((response) {
                                          var jsonResponse =
                                              jsonDecode(response.body);
                                          print('APPROVE_RESPONSE: ' +
                                              jsonResponse.toString());
                                          // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);
                                          if (jsonResponse["StatusCode"] ==
                                              200) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg:
                                                    jsonResponse['ModelErrors'],
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            print("j&&& $jsonResponse");
                                            Navigator.pushNamed(
                                                context, empRequestRoute);
                                          } else {
                                            print(
                                                "ModelError: ${jsonResponse["ModelErrors"]}");
                                            if (jsonResponse["ModelErrors"] ==
                                                'Unauthorized') {
                                              GetToken()
                                                  .getToken()
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: "Please try again!!!",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Something went wrong, please try again later.",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          errortext = "Please Enter Comment";
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Approve',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    // color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            isLoading ? LinearProgressIndicator() : Container(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .9,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Previous Manager's Notes",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 70),
                        child: Column(
                          children: getApproveObjects(),
                        )),
                  ],
                ),
              ),
            ),
    );
  }

  List<Widget> getApproveObjects() {
    List<Widget> list = [];

    if (approvedObject.isNotEmpty) {
      approvedObject.forEach((element) {
        list.add(planetCard(context, element.approvedName, element.comment,
            element.approvedDate));
      });
    }
    return list;
  }
}

Widget planetCard(BuildContext context, name, remark, date) {
  Size size = MediaQuery.of(context).size;

  DateTime tempDate = new DateFormat("MM/dd/yyyy HH:mm").parse(date);
  var inputDate = DateTime.parse(tempDate.toString());
  var outputFormat = DateFormat('MMM d HH:mm');
  var outputDate = outputFormat.format(inputDate);
  print("inputDate $outputDate");
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: new BoxDecoration(
        color: kWhiteColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: kGreyLightColor,
            blurRadius: 5.0,
            offset: new Offset(0.5, 0.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 13,
                    height: 65.0,
                    // color: Colors.pink,
                    child: new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0)),
                        color: Colors.green,
                      ),
                    )),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: ClipOval(
                          child: Image.asset(
                            "lib/assets/images/profile.jpg",
                            height: 47,
                            // width: 90,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: size.width * 0.7,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    name,
                                    style: new TextStyle(
                                        color: kRedColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    outputDate,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              remark,
                              style: new TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget _itemBuilder(label, textValue) {
//   return Container(
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 15.0, bottom: 15),
//           child: Row(
//             children: [
//               Text(
//                 label,
//                 style: new TextStyle(fontWeight: FontWeight.w400),
//               ),
//               Text(
//                 textValue,
//                 style: new TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
