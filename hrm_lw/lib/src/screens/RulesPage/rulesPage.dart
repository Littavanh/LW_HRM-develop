import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/screens/RulesPage/component/body.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'TKRules')),
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: leaveCardcolor,
      ),
      body: Body(),
    );
  }
}
