import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/models/messages/ot_item.dart';
import 'package:LTL_HRM/src/models/messages/request_approve.dart';
import 'package:LTL_HRM/src/models/messages/request_title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';

class OTDetailsCard extends StatelessWidget {
  final List<RequestTitle> requestTitle;
  final List<RequestApproved> approveds;
  final List<RequestOtItem> requestOtItem;

  const OTDetailsCard(
      {Key key, this.requestTitle, this.approveds, this.requestOtItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final reqTitle = requestTitle[0];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _profileSection(),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   Row(
              //     children: [
              //       Text(
              //         'Status: ',
              //       ),
              //       Text(reqTitle.statusText,
              //           style: TextStyle(
              //               fontSize: 16, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              // ]),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: Text(reqTitle.statusText,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary)),
              ),
              _detailItem('${getTranslated(context, 'NoNumber')}: ',
                  '${reqTitle.requestNo}'),
              // _detailItem('Request ID: ', '${reqTitle.requestId}'),
              // _detailItem('Request For: ', '${reqTitle.requestType}'),
              _detailItem('${getTranslated(context, 'Manager')}: ',
                  '${reqTitle.managerName}'),
              _detailItem('${getTranslated(context, 'SubmitDate')}: ',
                  '${reqTitle.submitDate}'),
              _detailItem('${getTranslated(context, 'DateOT')}: ',
                  '${reqTitle.otdate}'),
              _detailItem('${getTranslated(context, 'Period')}: ',
                  '${requestOtItem[0].strTime} -  ${requestOtItem[0].endTime}'),
              _detailItem('${getTranslated(context, 'Title')}: ',
                  '${requestOtItem[0].otTitle}'),
              _detailItem('${getTranslated(context, 'Description')}: ',
                  '${requestOtItem[0].otDesript}'),
              (approveds != null && approveds.isNotEmpty)
                  ? SizedBox(
                      width: size.width,
                      height: 1.0,
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  _detailItem(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$title'),
            Text('$detail'),
          ],
        ),
        Divider()
      ],
    );
  }

  _profileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Icon(Icons.arrow_back_ios),
        Container(
            child: new CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35,
          child: ClipOval(
            child: Image.asset(
              "lib/assets/images/profile.png",
              height: 75,
              // width: 90,
            ),
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(globalMyLocalPrefes.getString(AppConstant.USERNAME),
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      globalMyLocalPrefes.getString(AppConstant.DEPARTMENT),
                      style: TextStyle(fontSize: 14.0)),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.phone),
          ),
          onTap: () => launch(
              "tel://" + globalMyLocalPrefes.getString(AppConstant.PHONENO)),
        ),
      ],
    );
  }
}
