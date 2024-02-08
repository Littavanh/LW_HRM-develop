import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../enum.dart';

class LeaveItem extends StatelessWidget {
  final LeaveRequest request;
  const LeaveItem({this.request, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> arg = {
          'requestId': request.leaveRequestId,
          'detailType': AddRequestType.LEAVE,
          'request': request
        };

        Navigator.pushNamed(context, CustomRouter.requestDetailsScreen,
            arguments: arg);
        // Navigator.pushNamed(context, CustomRouter.myLeaveReqDetails,
        // arguments: request.requestId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Stack(
          children: <Widget>[
            _infoCard(context, request),
            _statusIcon(context, request.status.toLowerCase()),
          ],
        ),
      ),
    );
  }

  Widget _statusIcon(BuildContext context, String statusText) {
    // _onDateRangeSelect(leaveList.strDate, leaveList.endDate);
    return Container(
      child: new Image(
        image: new AssetImage(
            "lib/assets/images/${statusText[0].toLowerCase()}${statusText.substring(1)}.png"),
        height: 40.0,
        width: 40.0,
      ),
    );
  }

  Widget _infoCard(BuildContext context, LeaveRequest request) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.88,
      margin: new EdgeInsets.fromLTRB(21.0, 0, 0, 0),
      decoration: new BoxDecoration(
        color: kWhiteColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: kGreyLightColor,
            blurRadius: 5.0,
            offset: new Offset(0.5, 0.5),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.leaveRequestId,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        request.status,
                        style: new TextStyle(
                          color: UtilsHRM.getStatusColor(
                              request.status.toLowerCase()),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // totalDays.toString(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        getTranslated(context, 'manager'),
                        style: new TextStyle(),
                      ),
                      Text(
                        ": " + request.managerName,
                        style: new TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTranslated(context, 'Duration')}: ',
                        style: new TextStyle(),
                      ),
                      Text(
                        '${request.startDate} - ${request.endDate}',
                        style: new TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
