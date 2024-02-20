import 'package:LTL_HRM/src/models/messages/request_approve.dart';
import 'package:flutter/material.dart';


class ApproveSection extends StatelessWidget {
  final List<RequestApproved> approved;

  const ApproveSection(this.approved);

  @override
  Widget build(BuildContext context) {
    if (approved == null) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Aproved Date: ${approved.isNotEmpty ? approved[0].approvedDate : "-"}'),
        Divider(),
        Text(
            'ApprovedName Name: ${approved.isNotEmpty ? approved[0].approvedName : "-"}'),
        Divider(),
        Text('Comment: ${approved.isNotEmpty ? approved[0].comment : "-"}'),
        Divider()
      ],
    );
  }
}
