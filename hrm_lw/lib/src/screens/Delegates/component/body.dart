import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/Delegation.dart';
import 'package:LTL_HRM/src/screens/Delegates/delegation_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final delegateList;

  Body({this.delegateList});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Delegation> delegations = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      delegations = widget.delegateList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (delegations == null || delegations.length == 0) return NoDataFound();

    delegations.sort(
        (a, b) => int.parse(b.delegateId).compareTo(int.parse(a.delegateId)));

    return ListView.builder(
        itemCount: delegations.length,
        itemBuilder: (context, index) {
          return DelegationItem(delegations[index]);
        });
  }

  Widget _buildPopupDialog(BuildContext context, data) {
    DateTime tempDate1 =
        new DateFormat('dd/MM/yyyy HH:mm:ss a', 'en_US').parse(data.entryDate);
    var entryDate1 = DateFormat("dd/MM/yy").format(tempDate1);

    DateTime tempDate2 =
        new DateFormat('dd/MM/yyyy HH:mm:ss a', 'en_US').parse(data.acceptDate);
    var accept2 = DateFormat("dd/MM/yy").format(tempDate2);

    return new AlertDialog(
      title: const Text('Delegates Details'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              "Delegates By Name : " + data.delegatesByName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          data.startDate != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("Start Date : " + data.startDate),
                )
              : Container(),
          data.endDate != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("End Date : " + data.endDate),
                )
              : Container(),
          data.noted != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("Content : " + data.noted),
                )
              : Container(),
          data.responseName != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("Response Name: " + data.responseName),
                )
              : Container(),
          data.entryDate != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("Entry Date: " + entryDate1),
                )
              : Container(),
          data.acceptDate != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text("Accept Date: " + accept2),
                )
              : Container(),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
