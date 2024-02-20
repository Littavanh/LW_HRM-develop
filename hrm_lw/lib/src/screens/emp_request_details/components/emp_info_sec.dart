import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpInfoSec extends StatelessWidget {
  final String empName;
  final String empPosition;
  final String empContact;

  EmpInfoSec(this.empName, this.empPosition, this.empContact);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 4),
            child: ClipOval(
                child: Image.asset(
              "lib/assets/images/profile.png",
              height: 50,
              width: 50,
              // width: 90,
            )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(empName,
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(empPosition, style: TextStyle(fontSize: 14.0)),
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
              if (empContact != null) {
                launch("tel://" + empContact);
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
    );
  }
}
