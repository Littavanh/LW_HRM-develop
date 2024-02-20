import 'package:LTL_HRM/enum.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/request_details/components/leave_details.dart';
import 'package:LTL_HRM/src/screens/request_details/components/ot_details.dart';
import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arg;

  RequestDetailsScreen({@required this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Details')),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return arg['detailType'] == AddRequestType.OT
        ? OTDetails(request: arg['request'])
        : LeaveDetails(
            request: arg['request'],
          );
    // return FutureBuilder<ApiResponse>(
    //     future: RequestService().getRequestDetails(arg['requestId']),
    //     builder: (context, AsyncSnapshot<ApiResponse> response) {
    //       if (response.connectionState == ConnectionState.waiting)
    //         return LoadingView();
    //       if (response.hasError)
    //         return FetchingDataError(message: 'Fetching  request data!');
    //       final apiResponse = response.data;
    //       if (apiResponse.hasError)
    //         return FetchingDataError(message: 'Fetching  request data!');
    //       if (apiResponse.data == null) {
    //         return NoDataFound();
    //       }
    //       return arg['detailType'] == AddRequestType.OT
    //           ? OTDetails(request: apiResponse.data)
    //           : LeaveDetails(
    //               request: apiResponse.data,
    //             );
    //     });
  }
}
