import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../localization/localization_constants.dart';
import '../../components/loading_view.dart';
import '../../models/leave_balance.dart';
import '../../models/messages/api_response.dart';
import '../../services/request_service.dart';

class LeaveAll extends StatelessWidget {
  // const LeaveAll({Key key}) : super(key: key);
  final RequestService _leaveService = RequestService();

  Widget _buildLeaveCard(context, name, used, total, cardWidth) {
    return Container(
      width: cardWidth,
      padding: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
          // color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        tileColor: Color.fromARGB(255, 176, 246, 212),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(
                text: getTranslated(context, 'Days left'),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' $used',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  )
                ])),
                  Text.rich(TextSpan(
                text: getTranslated(context, 'Total'),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' $total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  )
                ])),
          ],
        ),
//  Text(
//               'ທັງໝົດ: $total',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.redAccent),
//             ),
        // trailing: Text('Metadata'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'Leave Balance')),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _leaveService.fetchLeaveBalanceAllType(),
            builder: (context, AsyncSnapshot<ApiResponse> response) {
              print('Build Leave Balance List');
              if (response.connectionState == ConnectionState.waiting) {
                return LoadingView();
              }
              if (response.hasError) {
                return Text('Error fetching leave balance');
              }
              List<LeaveBalance> leaveBalances = response.data.data;

              if (leaveBalances.isEmpty || leaveBalances == null) {
                return Center(child: Text('No data to show!'));
              }

              print('LeaveBalance: ${leaveBalances[0].toJson().toString()}');

              final cardWidth = (sizeWidth - 16) / 4;
              return Container(
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: ListView(
                    children: leaveBalances
                        .map(
                          (leaveBalance) => _buildLeaveCard(
                              context,
                              leaveBalance.leaveName,
                              double.parse(leaveBalance.leaveDayCanUse),
                              double.parse(leaveBalance.leaveTotal),
                              cardWidth),
                        )
                        .toList()),
              );
            }));
  }
}
