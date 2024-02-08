import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/models/Delegation.dart';

class DetailDialog extends StatelessWidget {
  final Delegation delegation;
  final Function onApprove;
  final Function onReject;

  DetailDialog(
      {@required this.delegation,
      @required this.onApprove,
      @required this.onReject});

  _buildActionBtn(BuildContext context, Delegation delegation) {
    return [
      TextButton(
        child: Text(getTranslated(context, 'Approve')),
        onPressed: () {
          onApprove(delegation);
          Navigator.of(context).pop();
        },
      ),
      SizedBox(
        width: 30,
      ),
      TextButton(
        child: Text(getTranslated(context, 'Reject')),
        onPressed: () {
          onReject(delegation);
          Navigator.of(context).pop();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getTranslated(context, 'Details')),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("ID: ${delegation.delegateId}"),
            Divider(),
            Text("${delegation.empName}"),
            Divider(),
            Text("${delegation.noted}"),
            Divider(),
            Text("${delegation.strDate} - ${delegation.endDate}"),
            Divider(),
            Text("${delegation.status}",
                style: TextStyle(
                    color: UtilsHRM.getStatusColor(delegation.status))),
          ]),
      actions: delegation.status.toLowerCase() == 'pending'
          ? _buildActionBtn(context, delegation)
          : [],
    );
  }
}
