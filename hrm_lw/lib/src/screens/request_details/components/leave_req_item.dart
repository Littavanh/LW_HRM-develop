import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/constants/colors.dart';

class LeaveReqItem extends StatelessWidget {
  final RequestLeaveItem item;
  LeaveReqItem({this.item});
  @override
  Widget build(BuildContext context) {
    // var inputFormat = DateFormat('M/d/yyyy HH:mm:ss a');
    // var outputFormat = DateFormat('dd/MM/yy');
    // var inputDate = inputFormat.parse(item.strDate);
    // var startDate = outputFormat.format(inputDate);

    // var inputDate1 = inputFormat.parse(item.endDate);
    // var endDate = outputFormat.format(inputDate1);

    // var inputDate2 = inputFormat.parse(item.returnDate);
    // var returnDate = outputFormat.format(inputDate2);

    final startDate = item.strDate;
    final endDate = item.endDate;
    // final returnDate = item.returnDate;

    return Container(
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
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: item.itemType != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Leave Type : ",
                                        style: new TextStyle(
                                            color: kRedColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      item.itemType != null
                                          ? Text(
                                              item.itemType,
                                              style: new TextStyle(
                                                  color: kRedColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Container(),
                                      item.requestFor != null
                                          ? Text(
                                              "(" + item.itemType + ")",
                                              style: new TextStyle(
                                                  color: kRedColor,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : Container(),
                                    ],
                                  )
                                : Container(),
                          ),
                          Text(
                            item.duration + " day",
                            style: new TextStyle(
                                color: kRedColor, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      startDate != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Period : ',
                                    style: new TextStyle(),
                                  ),
                                  Text(
                                    startDate + " To " + endDate,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      // returnDate != null
                      //     ? Padding(
                      //         padding: const EdgeInsets.only(bottom: 5.0),
                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               'Return Date test:',
                      //               style: new TextStyle(),
                      //             ),
                      //             Text(
                      //               returnDate,
                      //               style: new TextStyle(
                      //                   fontWeight: FontWeight.w500),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     : Container(),
                      item.requestReason != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Reason : ',
                                    style: new TextStyle(),
                                  ),
                                  Text(
                                    item.requestReason,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      item.responseName != null
                          ? Row(
                              children: [
                                Text(
                                  'Delegation : ',
                                  style: new TextStyle(),
                                ),
                                Text(
                                  item.responseName,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                            'Requested For: ${(item != null) ? (item.requestFor) : "-"}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
