import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/constants/colors.dart';

class EmpLeaveReqItem extends StatelessWidget {
  final LeaveRequest request;
  final Function reloadData;

  EmpLeaveReqItem(this.request, this.reloadData);

  Color _getStatusColor(String statusTxt) {
    if (statusTxt.toLowerCase() == 'pending') {
      return Colors.orangeAccent;
    }
    if (statusTxt.toLowerCase() == 'rejected') {
      return Colors.red;
    }
    if (statusTxt.toLowerCase() == 'approved') {
      return Colors.green;
    }
    return splashScreenColorTop;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: InkWell(
        child: Container(
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: ClipOval(
                                child: Image.asset(
                              "lib/assets/images/profile.png",
                              height: 50,
                              width: 50,
                              // width: 90,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: size.width * 0.70,
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        request.empName,
                                        style: new TextStyle(
                                            // color: kRedColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${request.status}',
                                        style: new TextStyle(
                                            color:
                                                _getStatusColor(request.status),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${request.startDate} - ${request.endDate}',
                                  style: new TextStyle(),
                                ),
                                Text(
                                  'NO: ${request.leaveRequestNo}',
                                  style: new TextStyle(),
                                ),
                                Text(
                                  'ID: ${request.leaveRequestId}',
                                  style: new TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          _toToDetailsScreen(context);
        },
      ),
    );
  }

  void _toToDetailsScreen(context) async {
    Map<String, dynamic> arg = {'requestType': "LEAVE", 'data': request};
    await Navigator.pushNamed(context, CustomRouter.empRequestsDetailsScreen,
        arguments: arg);
    reloadData();
  }
}
