import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';

class MiniProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username = globalMyLocalPrefes.getString(AppConstant.USERNAME);
    final department = globalMyLocalPrefes.getString(AppConstant.DEPARTMENT);

    return Row(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: new CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 35,
              child: ClipOval(
                child: Image.asset(
                  "lib/assets/images/profile.png",
                  height: 50,
                  width: 50,
                  // width: 90,
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username.toUpperCase() ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(top: 6)),
                Text(department,
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
