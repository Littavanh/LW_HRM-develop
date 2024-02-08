import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/add_request_vm.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/leave_form.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/ot_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../enum.dart';

class AddRequest extends StatefulWidget {
  final AddRequestType addRequestType;

  AddRequest(this.addRequestType);

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'AddRequest')),
        ),
        body: ChangeNotifierProvider(
            create: (_) => AddRequestVM(),
            child: widget.addRequestType == AddRequestType.LEAVE
                ? LeaveForm()
                // ? AddLeaveRequestForm()
                : OTForm()));
  }
}
