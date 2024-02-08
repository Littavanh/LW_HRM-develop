import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLeaveType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveFormVM>(builder: (BuildContext context, model, _) {
      return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  getTranslated(context, "LeaveApplyFor"),
                ),
                Radio(
                    value: 1,
                    groupValue: model.leaveType,
                    onChanged: (value) => model.onChangeLeaveType(value)),
                Text(getTranslated(context, "FullDay"))
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: model.leaveType,
                    onChanged: (value) => model.onChangeLeaveType(value)),
                Text(getTranslated(context, "HalfDay"))
              ],
            ),
          ],
        ),
      );
    });
  }
}
