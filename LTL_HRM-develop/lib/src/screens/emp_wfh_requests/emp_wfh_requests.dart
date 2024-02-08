import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/emp_requests/components/emp_leave_req_item.dart';
import 'package:LTL_HRM/src/services/emp_request_service.dart';
import 'package:flutter/material.dart';

class EmpWfhRequests extends StatefulWidget {
  @override
  _EmpWfhRequestsState createState() => _EmpWfhRequestsState();
}

class _EmpWfhRequestsState extends State<EmpWfhRequests> {
  _reLoadData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'EmpWfhRequests')),
        ),
        body: FutureBuilder<ApiResponse>(
            future: EmpRequestService().getEmpRequests(),
            builder: (context, AsyncSnapshot<ApiResponse> response) {
              if (response.connectionState == ConnectionState.waiting)
                return LoadingView();
              if (response.hasError)
                return FetchingDataError(
                    message: 'Fetching leave request data!');
              final apiResponse = response.data;
              if (apiResponse.hasError)
                return FetchingDataError(
                    message: 'Fetching leave request data!');
              if (apiResponse.data == null || apiResponse.data.length == 0) {
                return NoDataFound();
              }

              List<LeaveRequest> leaveRequests = apiResponse.data;
              List<LeaveRequest> showRequests = leaveRequests
                  .where((LeaveRequest element) =>
                      element.leaveTypeId.contains('9'))
                  .toList();

              return ListView.builder(
                  itemCount: showRequests.length,
                  itemBuilder: (context, index) {
                    // return Text('${requests.length}');
                    return EmpLeaveReqItem(showRequests[index], _reLoadData);
                  });
            }));
  }
}
