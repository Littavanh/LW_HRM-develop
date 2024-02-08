import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/emp_requests/components/emp_leave_request_list.dart';
import 'package:LTL_HRM/src/screens/emp_requests/components/emp_ot_request_list.dart';
import 'package:flutter/material.dart';

class EmpRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: getTranslated(context, 'LEAVEREQUEST')),
              Tab(text: getTranslated(context, 'OTREQUEST')),
            ],
          ),
          title: Text(getTranslated(context, 'EmpRequest')),
        ),
        body: TabBarView(
          children: [EmpLeaveRequestList(), EmpOTRequestList()],
        ),
      ),
    );
  }
}
