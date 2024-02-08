import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:LTL_HRM/src/models/messages/request_approve.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:LTL_HRM/src/screens/request_details/components/detail_list.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/constants/colors.dart';

class LeaveDetailsCard extends StatelessWidget {
  final List<RequestTitle> requestTitle;
  final List<RequestApproved> requestApproveds;
  final List<RequestLeaveItem> requestLeaveItem;

  LeaveDetailsCard(
      this.requestTitle, this.requestApproveds, this.requestLeaveItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.88,
      margin: new EdgeInsets.all(10),
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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EmployeeInfo(),
            DetailList(
              requestTitle,
              requestApproveds,
              requestLeaveItem,
            ),
            // requestApproveds.length > 1
            //     ? ApproveSection(requestApproveds)
            //     : Container(),
            Container(
              alignment: Alignment.topLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CustomRouter.documentView,
                        arguments: requestTitle[0].requestId);
                  },
                  child: Text(getTranslated(context, 'ViewDoc'))),
            )
          ],
        ),
      ),
    );
  }
}
