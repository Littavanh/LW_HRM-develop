import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:flutter/material.dart';

class OTRequestDetail extends StatelessWidget {
  final OTRequest request;

  OTRequestDetail({this.request});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('OT Request Detail'),
    );
  }
}
