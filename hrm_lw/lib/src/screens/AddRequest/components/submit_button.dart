import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../enum.dart';
import '../../../../routes/route_names.dart';
import '../../../services/request_service.dart';
import '../leave_form_vm.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formStateKey;
  SubmitButton(this.formStateKey);
  RequestService _leaveService = RequestService();

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveFormVM>(builder: (context, model, _) {
      if (model.isLoading) return LoadingView();

      return Container(
        height: 40,
        margin: EdgeInsets.only(left: 32, right: 16, top: 32, bottom: 50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            minimumSize: Size(88, 36),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          onPressed: () async {
            if (formStateKey.currentState.validate()) {
              await model.onSubmitRequest();

              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, myRequestRoute);
            }
          },
          child: Text(getTranslated(context, 'SendRequest')),
        ),
      );
    });
  }
}
