import 'package:LTL_HRM/src/screens/AddRequest/components/leave_reason_input.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_delegation.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_file_view.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/select_full_day.dart';
import 'package:LTL_HRM/src/screens/AddRequest/components/submit_button.dart';
import 'package:LTL_HRM/src/screens/AddRequest/leave_form_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WTFAddRequestScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Request'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => LeaveFormVM(),
          child: Consumer<LeaveFormVM>(
            builder: (context, model, child) {
              // model.setUpWFH();
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Consumer<LeaveFormVM>(builder: (context, model, _) {
                          return SelectFullDay(model);
                        }),
                        SelectDelegation(),
                        LeaveReasonInput(),
                        SelectFileView(),
                        SubmitButton(_formKey)
                      ],
                    ),
                  ));
            },
          ),
        ));
  }
}
