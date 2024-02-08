import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/models/Delegation.dart';

class DelegationItem extends StatelessWidget {
  final Delegation delegation;

  DelegationItem(this.delegation);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(delegation.empName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${delegation.strDate} - ${delegation.endDate}'),
        ],
      ),
      subtitle: Text(delegation.noted),
      trailing: Text(delegation.status,
          style: TextStyle(color: UtilsHRM.getStatusColor(delegation.status))),
    ));
  }
}
