import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveReasonInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      child: TextFormField(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          contentPadding:
              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          // suffixIcon: Icon(Icons.keyboard_arrow_down),
          labelText: getTranslated(context, "Reason"),
        ),
        onChanged: (value) =>
            context.read<LeaveFormVM>().onLeaveReasonChanged(value),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Select Reason';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
