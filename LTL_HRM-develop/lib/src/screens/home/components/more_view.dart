import 'package:LTL_HRM/components/LogoutOverlay.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'card_list.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardList("MyProfile", "lib/assets/images/viewProfile.png",
              "Viewyourprofiledetails", Icons.arrow_forward_ios, accountRoute),
          // CardList(
          //     "Holidays",
          //     "lib/assets/images/vector-holiday.jpg",
          //     "GetHolidayslistofthisfinancialyear",
          //     Icons.arrow_forward_ios,
          //     calendarViewRoute),
          Card(
            child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(getTranslated(context, '_logout')),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => LogoutOverlay(),
                  );
                }),
          ),
          // CardList(
          //     "NOTES / RULES",
          //     "lib/assets/images/rules.png",
          //     "Get list of all notes/rule of company",
          //     Icons.arrow_forward_ios,
          //     'rulesRoute'),
        ],
      ),
    );
  }
}
