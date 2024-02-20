import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/screens/MyRequest/components/ot_item.dart';
import 'package:flutter/material.dart';

class OTRequestList extends StatelessWidget {
  final List<OTRequest> otRequests;
  OTRequestList({Key key, @required this.otRequests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: otRequests.length,
        itemBuilder: (context, position) {
          return OtItem(
            request: otRequests[position],
          );
        });
  }
}
