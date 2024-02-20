import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/emp_requests/components/emp_ot_req_item.dart';
import 'package:LTL_HRM/src/services/emp_request_service.dart';
import 'package:flutter/material.dart';

class EmpOTRequestList extends StatefulWidget {
  @override
  _EmpOTRequestListState createState() => _EmpOTRequestListState();
}

class _EmpOTRequestListState extends State<EmpOTRequestList> {
  _reLoadData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
        future: EmpRequestService().getEmpOTRequestList(),
        builder: (context, AsyncSnapshot<ApiResponse> response) {
          if (response.connectionState == ConnectionState.waiting)
            return LoadingView();
          if (response.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          final apiResponse = response.data;
          if (apiResponse.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          if (apiResponse.data.length == 0) {
            return NoDataFound();
          }

          final List<OTRequest> requests = apiResponse.data;

          requests.sort((a, b) => b.otRequestId.compareTo(a.otRequestId));

          return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return EmpOTReqItem(
                    request: requests[index], reloadData: _reLoadData);
              });
        });
  }
}
