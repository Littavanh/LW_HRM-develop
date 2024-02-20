import 'package:LTL_HRM/src/screens/Payslip/component/body.dart';
import 'package:flutter/material.dart';

class Payslip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pays lip'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
