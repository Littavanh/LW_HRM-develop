import 'package:LTL_HRM/enum.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/models/OTRequest.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';

class OtItem extends StatelessWidget {
  final OTRequest request;
  const OtItem({this.request, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> arg = {
          'requestId': request.otRequestId,
          'detailType': AddRequestType.OT,
          'request': request
        };

        Navigator.pushNamed(context, CustomRouter.requestDetailsScreen,
            arguments: arg);

        // Navigator.pushNamed(context, CustomRouter.myOtRequestRoute,
        //     arguments: arg);

        // Navigator.pushNamed(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         MyOTReqDetails(levReqDetailID: widget.leaveList[i].requestID),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(4),
        child: Stack(
          children: <Widget>[
            planetCard(context, request),
            // planetThumbnail(context, request.status),
          ],
        ),
      ),
    );
  }

  Widget planetThumbnail(BuildContext context, String statusText) {
    print('');
    return Container(
      child: new Image(
        image: new AssetImage(
            "lib/assets/images/${statusText[0].toLowerCase()}${statusText.substring(1)}.png"),
        height: 40.0,
        width: 40.0,
      ),
    );
  }

  Widget planetCard(BuildContext context, OTRequest request) {
    return Container(
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
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${request.status} ',
                          style: new TextStyle(
                              color: UtilsHRM.getStatusColor(request.status),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${request.otRequestNo}',
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  _buildInfoRow('${getTranslated(context, 'manager')}: ',
                      '${request.managerName}'),
                  _buildInfoRow('${getTranslated(context, 'DateText')}: ',
                      '${request.startDate} - ${request.endDate}'),
                  _buildInfoRow('${getTranslated(context, 'TimeText')}: ',
                      '${request.otStartTime} ໂມງ - ${request.otEndTime} ໂມງ'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
