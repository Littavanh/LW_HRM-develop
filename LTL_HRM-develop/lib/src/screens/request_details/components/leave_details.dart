import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/models/enum.dart';
import 'package:LTL_HRM/src/models/leave_request.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:provider/provider.dart';

class LeaveDetails extends StatefulWidget {
  final LeaveRequest request;
  LeaveDetails({@required this.request});

  @override
  _LeaveDetailsState createState() => _LeaveDetailsState();
}

class _LeaveDetailsState extends State<LeaveDetails> {
  RequestService _requestService = RequestService();
  bool isLoading = false;

  Future<void> cancelMyRequest(reqID) async {
    setState(() {
      isLoading = true;
    });
    await _requestService.cancelMyRequest(reqID);
    context.read<ShareProvider>().setReloadData(RELOAD_DATA.WFH);
    Navigator.pop(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    LeaveRequest request = widget.request;

    if (isLoading) return LoadingView();
    return _buildDetailCard(request);
  }

  Widget _buildDetailCard(LeaveRequest request) {
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
                        color: UtilsHRM.getStatusColor(request.status),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow(
                getTranslated(context, 'NoNumber'), request.leaveRequestNo),
            _buildInfoRow(
                '${getTranslated(context, 'manager')}: ', request.managerName),
            _buildInfoRow('${getTranslated(context, 'Duration')}: ',
                '${request.startDate} - ${request.endDate}'),
            _buildInfoRow('${getTranslated(context, 'Returntoworkdate')}: ',
                request.returnDate),
            _buildInfoRow('${getTranslated(context, 'TotalLeaveDays')}: ',
                request.amountDay),
            _buildInfoRow('${getTranslated(context, 'Delegation')}: ',
                request.delegateEmpName),
            _buildInfoRow('${getTranslated(context, 'LeaveType')}: ',
                request.leaveTypeName),
            _buildInfoRow(
                '${getTranslated(context, 'Reason')}: ', request.noted),
            request.fileAttached != null && request.fileAttached != ""
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CustomRouter.documentView,
                              arguments: request.leaveRequestId);
                        },
                        child: Text(getTranslated(context, 'ViewDoc'))),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            request.status.toLowerCase() == 'pending'
                ? TextButton(
                    onPressed: () {
                      cancelMyRequest(request.leaveRequestId);
                    },
                    child: Text(
                        getTranslated(
                          context,
                          'Cancel',
                        ),
                        style: TextStyle(fontSize: 18)))
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

  Widget planetCard(BuildContext context, name, remark, date) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: new BoxDecoration(
          color: kWhiteColor,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: kGreyLightColor,
              blurRadius: 5.0,
              offset: new Offset(0.5, 0.5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: 13,
                      height: 65.0,
                      // color: Colors.pink,
                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0)),
                          color: Colors.green,
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: size.width * 0.83,
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      name,
                                      style: new TextStyle(
                                          color: kRedColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      date,
                                      textAlign: TextAlign.right,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                remark,
                                style: new TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
