import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/enum.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/MyRequest/components/leave_request_list.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WFHRequest extends StatefulWidget {
  @override
  State<WFHRequest> createState() => _WFHRequestState();
}

class _WFHRequestState extends State<WFHRequest> {
  _reloadData() {
    context.read<ShareProvider>().clearReloadData(RELOAD_DATA.NONE);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ShareProvider>().reloadData == RELOAD_DATA.WFH) {
      _reloadData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'WorkFromHome')),
      ),
      body: FutureBuilder<ApiResponse>(
          future: RequestService().getMyLeaveRequests(),
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

            List<LeaveRequest> leaveRequests = apiResponse.data;
            List<LeaveRequest> showRequests = leaveRequests
                .where(
                    (LeaveRequest element) => element.leaveTypeId.contains('9'))
                .toList();

            if (showRequests.length == 0) return NoDataFound();
            return LeaveRequestList(leaveRequests: showRequests);
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, CustomRouter.addWFHRequest)
              .then((value) => {_reloadData()});
        },
        elevation: 4,
        label: Text(getTranslated(context, 'AddNew')),
        icon: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
