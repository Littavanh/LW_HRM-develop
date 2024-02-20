import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:flutter/material.dart';

class ButtonsSection extends StatelessWidget {
  final Function onReject;
  final Function onApprove;

  ButtonsSection(this.onReject, this.onApprove);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              onReject();
            },
            child: Text(
              getTranslated(context, 'Reject'),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // color: Colors.red,
          ),
          ElevatedButton(
            onPressed: () async {
              onApprove();
            },
            child: Text(
              getTranslated(context, 'Approve'),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // color: Colors.green,
          ),
        ],
      ),
    );
  }
}
