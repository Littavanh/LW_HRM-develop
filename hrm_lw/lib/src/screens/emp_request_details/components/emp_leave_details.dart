import 'package:LTL_HRM/enum.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/models/messages/leave_item.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:LTL_HRM/src/screens/emp_request_details/components/buttons_section.dart';
import 'package:LTL_HRM/src/screens/emp_request_details/components/emp_info_sec.dart';
import 'package:LTL_HRM/src/screens/emp_request_details/components/emp_req_detail_list.dart';
import 'package:LTL_HRM/src/services/emp_request_service.dart';
import 'package:flutter/material.dart';

class EmpLeaveDetails extends StatefulWidget {
  final LeaveRequest request;
  EmpLeaveDetails({this.request});

  @override
  _EmpLeaveDetailsState createState() => _EmpLeaveDetailsState();
}

class _EmpLeaveDetailsState extends State<EmpLeaveDetails> {
  TextEditingController _commentController = TextEditingController();
  DateTime tempDate;
  bool isLoading = false;
  String errortext;
  EmpRequestService _empRequestService = EmpRequestService();
  RequestTitle requestTitle;
  RequestLeaveItem requestLeaveItem;

  @override
  void initState() {
    super.initState();
    // requestTitle = widget.requestDetails.requestTitle[0];
    // requestLeaveItem = widget.requestDetails.requestLeaveItem[0];
  }

  _onReject() async {
    if (_commentController.text != "") {
      print('comment: ${_commentController.text}');
      setState(() {
        isLoading = true;
      });

      //  Set approveType = 3 (Approve Leave Request)
      await _empRequestService.rejectEmpRequestLeave(
          3, widget.request.leaveRequestId, _commentController.text);
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
      setState(() {
        isLoading = true;
      });

      await _empRequestService.approveEmpRequestLeave(
          1, requestTitle.requestId, _commentController.text);
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) return LoadingView();
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EmpInfoSec(requestTitle.empName, requestTitle.empPosition,
                    requestTitle.empContact),
                Divider(),
                EmpReqDetailList(
                    requestTitle: requestTitle,
                    requestLeaveItem: requestLeaveItem,
                    reqType: AddRequestType.LEAVE),
                _commentSection(),
                ButtonsSection(_onReject, _onApprove)
              ],
            ),
          ),
        )
      ],
    );
  }

  _commentSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          filled: true,
          contentPadding:
              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          // suffixIcon: Icon(Icons.keyboard_arrow_down),
          labelText: 'Comment',
          errorText: errortext,
        ),
        controller: _commentController,
        // onChanged: (str) {
        //   // setState(() {
        //   // errortext = null;
        //   // });
        // },
      ),
    );
  }
}
