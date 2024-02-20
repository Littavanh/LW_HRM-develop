import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/Loans/component/body.dart';
import 'package:flutter/material.dart';

class LoansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Loans')),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
