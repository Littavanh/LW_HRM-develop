import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Icon(Icons.arrow_back_ios),
          Container(
              child: new CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 35,
            child: ClipOval(
              child: Image.asset(
                "lib/assets/images/profile.png",
                height: 75,
                // width: 90,
              ),
            ),
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(globalMyLocalPrefes.getString(AppConstant.USERNAME),
                      style: TextStyle(
                          fontSize: 19.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        globalMyLocalPrefes.getString(AppConstant.DEPARTMENT),
                        style: TextStyle(fontSize: 14.0)),
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
            onTap: () => launch(
                "tel://" + globalMyLocalPrefes.getString(AppConstant.PHONENO)),
          ),
        ],
      ),
    );
  }
}
