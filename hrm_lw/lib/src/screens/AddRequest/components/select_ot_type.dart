import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/AddRequest/add_request_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectOTType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddRequestVM>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: model.otPayType,
          onChanged: (value) => model.onChangeOtPayType(value),
        ),
        Text(
          getTranslated(context, 'Payment'),
          style: new TextStyle(fontSize: 16.0),
        ),
        Radio(
          value: 2,
          groupValue: model.otPayType,
          onChanged: (value) => model.onChangeOtPayType(value),
        ),
        Text(
          getTranslated(context, 'CompensateLeave'),
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
