import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/screens/MyRequest/components/leave_item.dart';
import 'package:flutter/material.dart';

class LeaveRequestList extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;
  LeaveRequestList({Key key, @required this.leaveRequests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leaveRequests.sort((LeaveRequest a, LeaveRequest b) {
      return b.leaveRequestId.compareTo(a.leaveRequestId);
    });

    return ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, position) {
          return LeaveItem(
            request: leaveRequests[position],
          );
        });
  }
}
