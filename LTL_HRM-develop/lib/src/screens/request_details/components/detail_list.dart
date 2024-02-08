import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:LTL_HRM/src/models/messages/request_approve.dart';
import 'package:flutter/material.dart';

class DetailList extends StatelessWidget {
  final List<RequestTitle> myReqTitleObj;
  final List<RequestApproved> approvedObject;
  final List<RequestLeaveItem> requestItemObject;

  const DetailList(
      this.myReqTitleObj, this.approvedObject, this.requestItemObject);

  @override
  Widget build(BuildContext context) {
    final reqTitle = myReqTitleObj[0];
    final reqItem = requestItemObject[0];
    String statusTxt;
    switch (myReqTitleObj[0].statusText) {
      case 'Pending':
        statusTxt = getTranslated(context, 'Pending');
        break;
      case 'Cancel':
        statusTxt = getTranslated(context, 'Cancel');
        break;
      case 'Approve':
        statusTxt = getTranslated(context, 'Approve');
        break;
      case 'Cancel':
        statusTxt = getTranslated(context, 'Cancel');
        break;
      case 'Reject':
        statusTxt = getTranslated(context, 'Reject');
        break;
      default:
        statusTxt = myReqTitleObj[0].statusText;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          child: Text(statusTxt,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${getTranslated(context, 'NoNumber')}: ${reqTitle.requestNo} ',
            ),
            Text('${reqItem.itemType} - ${reqItem.requestFor}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        _detailItem('${getTranslated(context, 'LeaveDate')}: ',
            '${reqItem.strDate} - ${reqItem.endDate} (${reqItem.duration} days)'),
        // _detailItem('Return: ', '${reqItem.returnDate}'),
        _detailItem('${getTranslated(context, 'Reason')}: ',
            '${reqItem.requestReason}'),
        _detailItem('${getTranslated(context, 'Manager')}: ',
            '${reqTitle.managerName}'),
        _detailItem('${getTranslated(context, 'Delegation')}: ',
            '${reqItem.responseName}'),
        Container(
          margin: EdgeInsets.only(top: 5),
          alignment: Alignment.topRight,
          child: Text(
              '${getTranslated(context, 'SubmitDate')}: ${reqTitle.submitDate}'),
        )
      ],
    );
  }

  _detailItem(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$title'),
            Text('$detail'),
          ],
        ),
        Divider()
      ],
    );
  }
}
