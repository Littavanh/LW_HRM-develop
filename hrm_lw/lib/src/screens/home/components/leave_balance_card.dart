import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/models/leave_balance.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';

class LeaveBalanceCard extends StatelessWidget {
  final RequestService _leaveService = RequestService();

  Widget _buildLeaveCard(context, name, used, total, cardWidth) {
  

    return Container(
      width: cardWidth,
      padding: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
          // color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
          SizedBox(
            height: 4,
          ),
          Text('$used/$total',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: _leaveService.fetchLeaveBalance(),
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        });
  }
}
