import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/emp_requests/components/emp_leave_req_item.dart';
import 'package:LTL_HRM/src/services/emp_request_service.dart';
import 'package:flutter/material.dart';

class EmpLeaveRequestList extends StatefulWidget {
  @override
  _EmpLeaveRequestListState createState() => _EmpLeaveRequestListState();
}

class _EmpLeaveRequestListState extends State<EmpLeaveRequestList> {
  _reLoadData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
        future: EmpRequestService().getEmpRequests(),
        builder: (context, AsyncSnapshot<ApiResponse> response) {
          if (response.connectionState == ConnectionState.waiting)
            return LoadingView();
          if (response.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          final apiResponse = response.data;
          if (apiResponse.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          if (apiResponse.data == null || apiResponse.data.length == 0) {
            return NoDataFound();
          }

          final List<LeaveRequest> requests = apiResponse.data;
          requests.sort((a, b) => b.leaveRequestId.compareTo(a.leaveRequestId));

          return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                // return Text('${requests.length}');
                return EmpLeaveReqItem(requests[index], _reLoadData);
              });
        });
  }
}
