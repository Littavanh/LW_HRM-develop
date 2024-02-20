import 'package:LTL_HRM/enum.dart';
import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:LTL_HRM/src/models/messages/ot_item.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:flutter/material.dart';

class EmpReqDetailList extends StatelessWidget {
  final RequestTitle requestTitle;
  final RequestLeaveItem requestLeaveItem;
  final RequestOtItem requestOT;
  final AddRequestType reqType;

  EmpReqDetailList(
      {this.requestTitle, this.requestLeaveItem, this.requestOT, this.reqType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        _itemContainer('No: ', requestTitle.requestNo),
        _itemContainer('Type: ', requestTitle.requestType),
        _itemContainer('Request date: ', requestTitle.dateRequest),
        // _itemContainer('Title: ', requestTitle.requestTitle),
        _itemContainer('Status: ', requestTitle.statusText),
        SizedBox(height: 16),
        reqType == AddRequestType.OT ? _showOTDetails() : _showLeaveDetails(),
        //       ),
        //         child: Text(
        //             'Request Reason: ${requestLeaveItem.requestReason ?? ""}'),
        // requestTitle.requestType == 'OT'
        //     ? Container()
        //     : Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 8),
        //         child: Text('Requested For: ${requestLeaveItem.requestFor}'),
        //       ),
      ],
    );
  }

  _showOTDetails() {
    return Column(
      children: [
        _smallContainer('Title: ', requestOT.otTitle),
        _smallContainer('Description:', requestOT.otDesript),
        _smallContainer('OT type:', requestTitle.otTypeText),
        _smallContainer('OT date: ', requestTitle.dateRequest),
        _smallContainer(
            'OT duration: ', '${requestOT.strTime} - ${requestOT.endTime}'),
      ],
    );
  }

  _showLeaveDetails() {
    return Column(
      children: [
        _smallContainer('Reason: ', requestLeaveItem.requestReason),
        _smallContainer('Type: ', requestLeaveItem.itemType),
        _smallContainer('Return date: ', requestLeaveItem.returnDate),
        _smallContainer('Duration: ',
            '${requestLeaveItem.strDate} - ${requestLeaveItem.endDate} (${requestLeaveItem.duration} days)'),
        _smallContainer('Response person: ', requestLeaveItem.responseName),
        _smallContainer('Manager: ', requestLeaveItem.managerName),
        // _itemContainer('Submit date: ', requestLeaveItem.entryDate),
      ],
    );
  }
  // _itemContainer(Text(
  //     'Return Date: ${requestLeaveItem.returnDate.split(" ")[0] ?? ""}'))

  _itemContainer(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(text),
          ],
        ),
        Divider(),
      ],
    );
  }

  _smallContainer(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(text),
          ],
        ),
        SizedBox(height: 4)
        // Divider(),
      ],
    );
  }
}
