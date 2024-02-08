import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/services/emp_request_service.dart';
import 'package:flutter/material.dart';
import 'components/buttons_section.dart';

class EmpRequestDetailsScreen extends StatefulWidget {
  final Map arg;

  EmpRequestDetailsScreen({@required this.arg});

  @override
  _EmpRequestDetailsScreenState createState() =>
      _EmpRequestDetailsScreenState();
}

class _EmpRequestDetailsScreenState extends State<EmpRequestDetailsScreen> {
  dynamic request;
  String requestType;
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _commentController.text = '';
    });
    requestType = widget.arg['requestType'];
    if (requestType == 'LEAVE') {
      request = widget.arg['data'] as LeaveRequest;
    } else {
      request = widget.arg['data'] as OTRequest;
    }
  }



  String errortext;
  bool isLoading = false;
  EmpRequestService _empRequestService = EmpRequestService();

  Color _getStatusColor(String statusTxt) {
    if (statusTxt.toLowerCase() == 'pending') {
      return Colors.orangeAccent;
    }
    if (statusTxt.toLowerCase() == 'rejected') {
      return Colors.red;
    }
    if (statusTxt.toLowerCase() == 'approved') {
      return Colors.green;
    }
    return splashScreenColorTop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'Details')),
        ),
        body: ListView(shrinkWrap: true,
          children: [_buildDetailCard(context, request)],
        ));
  }

  _onReject() async {
    if (_commentController.text != "") {
      print('Post rejected');
    setState(() {
      isLoading = true;
    });

    //  Set approveType = 3 (Approve Leave Request)
    if (requestType == 'LEAVE') {
      // Request Leave
      await _empRequestService.rejectEmpRequestLeave(
          3, request.leaveRequestId, _commentController.text);
    } else {
      // Request OT
      await _empRequestService.rejectEmpRequestLeave(
          2, request.otRequestId, _commentController.text);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
    } else {
      setState(() {
        errortext = "Please Enter Comment";
      });
    }
  }

  _onApprove() async {
    if (_commentController.text != "") {
      print('Post to server');
    setState(() {
      isLoading = true;
    });

    // Set approveType = 3 (Approve Leave Request)
    if (requestType == 'LEAVE') {
      // Request Leave
      await _empRequestService.approveEmpRequestLeave(
          3, request.leaveRequestId, _commentController.text);
    } else {
      // Request OT
      await _empRequestService.approveEmpRequestLeave(
          2, request.otRequestId, _commentController.text);
    }
    setState(() {

      isLoading = false;
      print("ok");
    });
    Navigator.pop(context);
    } else {
      setState(() {
        errortext = "Please Enter Comment";
      });
    }
  }

  Widget _buildDetailCard(BuildContext context, dynamic request) {
    String paymentType = '';
    if (requestType == 'OT') {
      paymentType = request.otTypeName.replaceAll(' ', '');
    }
    return Container(
      child: Card(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${request.status} ',
                    style: new TextStyle(
                        color: _getStatusColor(request.status),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            requestType == 'LEAVE'
                ? _buildInfoRow(
                    getTranslated(context, 'NoNumber'), request.leaveRequestNo)
                : _buildInfoRow(
                    getTranslated(context, 'NoNumber'), request.otRequestNo),
            requestType == 'LEAVE'
                ? _buildInfoRow('ID', request.leaveRequestId)
                : _buildInfoRow('ID', request.otRequestId),
            _buildInfoRow(
                '${getTranslated(context, 'Name')}: ', request.empName),
            _buildInfoRow('${getTranslated(context, 'DateText')}: ',
                '${request.startDate} - ${request.endDate}'),
            requestType == 'LEAVE'
                ? _buildInfoRow(
                    '${getTranslated(context, 'Returntoworkdate')}: ',
                    request.returnDate)
                : Container(),
            requestType == 'LEAVE'
                ? _buildInfoRow('${getTranslated(context, 'TotalLeaveDays')}: ',
                    request.amountDay)
                : Container(),
            requestType == 'LEAVE'
                ? _buildInfoRow('${getTranslated(context, 'Delegation')}: ',
                    request.delegateEmpName)
                : Container(),
            requestType == 'LEAVE'
                ? _buildInfoRow('${getTranslated(context, 'LeaveType')}: ',
                    request.leaveTypeName)
                : Container(),
            requestType == 'OT'
                ? _buildInfoRow('${getTranslated(context, 'TimeText')}: ',
                    '${request.otStartTime} - ${request.otEndTime}')
                : Container(),
            requestType == 'OT'
                ? _buildInfoRow('${getTranslated(context, 'Hours')}: ',
                    '${request.qtyHour}')
                : Container(),
            requestType == 'OT'
                ? _buildInfoRow('${getTranslated(context, 'PayAs')}: ',
                    '${getTranslated(context, '$paymentType')}')
                : Container(),
            _buildInfoRow('${getTranslated(context, 'Details')}: ', ''),
            Container(
                padding: EdgeInsets.only(left: 16),
                child: _buildInfoRow('${request.noted}', '')),
            request.status.toLowerCase() == 'pending'
                ? _commentSection()
                : Container(),
            SizedBox(
              height: 30,
            ),
            request.status.toLowerCase() == 'pending'
                ? ButtonsSection(_onReject, _onApprove)
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _commentSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        validator: (_) => null,
        decoration: new InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          filled: true,
          contentPadding:
              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          // suffixIcon: Icon(Icons.keyboard_arrow_down),
          labelText: getTranslated(context, 'Comment'),
          errorText: errortext,
        ),
        controller: _commentController,
      ),
    );
  }
}
