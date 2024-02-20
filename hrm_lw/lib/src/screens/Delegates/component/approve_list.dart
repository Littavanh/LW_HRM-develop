import 'package:LTL_HRM/src/components/fetching_data_error.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/components/no_data_found.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/Delegates/delegation_item.dart';
import 'package:LTL_HRM/src/screens/Delegates/detail_dialog.dart';
import 'package:LTL_HRM/src/services/delegation_service.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/models/Delegation.dart';

class ApproveList extends StatefulWidget {
  @override
  _ApproveListState createState() => _ApproveListState();
}

class _ApproveListState extends State<ApproveList> {
  final DelegationService _delService = DelegationService();

  _onApprove(Delegation delegation) {
    setState(() {});
    _delService.approveDelegation(delegation).then((ApiResponse response) {
      if (response.hasError) {
        UtilsHRM.showFailedToast(context);
        setState(() {});
      } else {
        UtilsHRM.showSuccessToast(context);
        setState(() {});
      }
    });
  }

  _onReject(Delegation delegation) {
    setState(() {});
    _delService.rejectDelegation(delegation).then((ApiResponse response) {
      if (response.hasError) {
        UtilsHRM.showFailedToast(context);
        setState(() {});
      } else {
        UtilsHRM.showSuccessToast(context);
        setState(() {});
      }
    });
  }

  _showDetailDialog(BuildContext context, Delegation delegation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailDialog(
            delegation: delegation, onApprove: _onApprove, onReject: _onReject);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
        future: _delService.getDelegateApproverList(context),
        builder: (context, AsyncSnapshot<ApiResponse> response) {
          if (response.connectionState == ConnectionState.waiting)
            return LoadingView();
          if (response.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          final apiResponse = response.data;
          if (apiResponse.hasError)
            return FetchingDataError(message: 'Fetching leave request data!');
          if (apiResponse.data == null) {
            return NoDataFound();
          }

          final List<Delegation> requests = apiResponse.data;
          requests.sort((a, b) =>
              int.parse(b.delegateId).compareTo(int.parse(a.delegateId)));

          return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return InkWell(
                    onTap: () {
                      _showDetailDialog(context, request);
                    },
                    child: DelegationItem(request));
              });
        });
  }
}
