import 'package:LTL_HRM/src/screens/AddRequest/components/leave_reason_input.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_delegation.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_file_view.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_type_of_leave.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_full_day.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_haft_day.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_leave_type.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/submit_button.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LeaveFormVM(),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SelectLeaveType(),
              Consumer<LeaveFormVM>(builder: (context, model, _) {
                return model.leaveType == 1
                    ? SelectFullDay(model)
                    : SelectHaftDay();
              }),
              SelectTypeOfLeave(),
              SelectDelegation(),
              LeaveReasonInput(),
              SelectFileView(),
              SubmitButton(_formKey)
            ],
          ),
        ));
  }
}
