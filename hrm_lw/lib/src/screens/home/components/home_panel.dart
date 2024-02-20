import 'dart:convert';
import 'dart:typed_data';

import 'package:LTL_HRM/components/LogoutOverlay.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/screens/home/components/card_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePanel extends StatefulWidget {
  final ScrollController sc;
  final String image;
  final String username;
  final String department;

  HomePanel(this.sc, this.image, this.username, this.department);

  @override
  _HomePanelState createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('E, dd MMM yyyy');
    String formattedDate = formatter.format(now);
    if (widget.image != null && widget.image != "") {
      bytes = Base64Codec().decode(widget.image);
    }

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: widget.sc,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
              ],
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35,
                        child: bytes != null
                            ? ClipOval(
                                child: new Image.memory(
                                bytes,
                                height: 75,
                              ))
                            : ClipOval(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.username ?? "",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(top: 6)),
                          Text(widget.department,
                              style: TextStyle(fontSize: 14.0)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.logout),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => LogoutOverlay(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 7.0,
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CardList(
                    "MyProfile",
                    "lib/assets/images/viewProfile.png",
                    "Viewyourprofiledetails",
                    Icons.arrow_forward_ios,
                    accountRoute),
                CardList(
                    "Holidays",
                    "lib/assets/images/vector-holiday.jpg",
                    "GetHolidayslistofthisfinancialyear",
                    Icons.arrow_forward_ios,
                    calendarViewRoute),
                // _cardList(
                //     "NOTES / RULES",
                //     "lib/assets/images/rules.png",
                //     "Get list of all notes/rule of company",
                //     Icons.arrow_forward_ios,
                //     rulesRoute),
              ],
            ),
          )
        ],
      ),
    );
  }
}
