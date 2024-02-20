import 'package:LTL_HRM/enum.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/MyRequest/components/leave_request_list.dart';
import 'package:LTL_HRM/src/screens/MyRequest/components/ot_request_list.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';

class MyRequest extends StatefulWidget {
  MyRequest();

  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> with TickerProviderStateMixin {
  RequestService _leaveService = RequestService();
  AddRequestType _requestType = AddRequestType.LEAVE;
  AnimationController animationController;

  onGetRequestData() {
    if (_requestType == AddRequestType.OT) {
      return _leaveService.getMyOTRequests();
    }
    return _leaveService.getMyLeaveRequests();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'MyRequest')),
        ),
        body: FutureBuilder<ApiResponse>(
            future: onGetRequestData(),
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
              if (apiResponse.data.length == 0) {
                return NoDataFound();
              }

              List<LeaveRequest> leaveRequests = [];
              List<OTRequest> otRequests = [];

              if (_requestType == AddRequestType.OT) {
                otRequests = apiResponse.data;
              } else {
                leaveRequests = apiResponse.data;
              }

              return TabBarView(
                children: [
                  LeaveRequestList(leaveRequests: leaveRequests),
                  // LeaveRequestList(leaveRequests: apiResponse.data ?? []),
                  OTRequestList(otRequests: otRequests)
                ],
              );
            }),
        floatingActionButton:
            UtilsHRM.getPermissionObject(context, 'My Request').app_add == "1"
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, CustomRouter.addRequestRoute,
                          arguments: _requestType);
                    },
                    elevation: 4,
                    label: Text(getTranslated(context, 'Request')),
                    icon: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.pink,
                  )
                : Container(),
        bottomNavigationBar: new TabBar(
          onTap: (value) {
            if (value == 0) {
              setState(() {
                _requestType = AddRequestType.LEAVE;
              });
            } else if (value == 1) {
              setState(() {
                _requestType = AddRequestType.OT;
              });
            }
          },
          tabs: [
            Tab(
              text: getTranslated(context, 'LEAVEREQUEST'),
            ),
            Tab(
              text: getTranslated(context, 'OTREQUEST'),
            ),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(1.0),
          indicatorColor: Colors.red,
          indicator: BoxDecoration(
            color: Colors.white,

            // borderRadius: BorderRadius.circular(15.0),
            boxShadow: [BoxShadow(color: Colors.red, blurRadius: 3.0)],
          ),
        ),
      ),
    );
  }
}
