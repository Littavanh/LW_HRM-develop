import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';

class OTDetails extends StatefulWidget {
  final OTRequest request;

  OTDetails({@required this.request});

  @override
  _OTDetailsState createState() => _OTDetailsState();
}

class _OTDetailsState extends State<OTDetails> {
  bool isLoading = false;
  RequestService _requestService = RequestService();

  Future<void> cancelMyRequest(reqID) async {
    setState(() {
      isLoading = true;
    });
    await _requestService.cancelMyOTRequest(reqID);
    Navigator.pop(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    OTRequest request = widget.request;
    if (isLoading) return LoadingView();

    print('Request = ${request.toJson().toString()}');
    return _buildDetailCard(request);
  }

  Widget _buildDetailCard(OTRequest request) {
    final paymentType = request.otTypeName.replaceAll(' ', '');

    return Container(
      margin: EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 16),
            _buildInfoRow(
                getTranslated(context, 'NoNumber'), '${request.otRequestNo}'),
            _buildInfoRow('${getTranslated(context, 'manager')}: ',
                '${request.managerName}'),
            _buildInfoRow('${getTranslated(context, 'DateText')}: ',
                '${request.startDate} - ${request.endDate}'),
            _buildInfoRow('${getTranslated(context, 'TimeText')}: ',
                '${request.otStartTime} ໂມງ - ${request.otEndTime} ໂມງ'),
            _buildInfoRow('${getTranslated(context, 'Hours')}: ',
                '${request.qtyHour} ຊົ່ວໂມງ'),
            _buildInfoRow('${getTranslated(context, 'PayAs')}:',
                '${getTranslated(context, '$paymentType')}'),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${getTranslated(context, 'Description')}:',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32, right: 16, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${request.noted}', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),

            // Text('${getTranslated(context, 'Description')}: '),
            // Text('${request.noted}'),
            SizedBox(
              height: 30,
            ),
            request.status.toLowerCase() == 'create' ||
                    request.status.toLowerCase() == 'pending'
                ? TextButton(
                    onPressed: () {
                      cancelMyRequest(request.otRequestId);
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
}
