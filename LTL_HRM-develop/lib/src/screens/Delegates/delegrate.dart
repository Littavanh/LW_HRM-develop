import 'dart:convert';
import 'dart:io';

import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/screens/Delegates/component/approve_list.dart';
import 'package:LTL_HRM/src/web_api.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:LTL_HRM/src/screens/Delegates/component/body.dart';
import 'package:http/http.dart' as http;
import 'package:LTL_HRM/src/models/Delegation.dart';

import '../../../main.dart';

class Delegate extends StatefulWidget {
  @override
  _DelegateState createState() => _DelegateState();
}

class _DelegateState extends State<Delegate> {
  List<Delegation> delegations = [];
  bool _isLoading = false;

  int _selectedIndex = 0;

  @override
  void initState() {
    if (_selectedIndex == 0) {
      _getNewsList();
    }
    super.initState();
  }

  goToAddDelegate() async {
    await Navigator.pushNamed(context, addDelegateRoute);
    if (_selectedIndex == 0) {
      _getNewsList();
    }
  }

  Future<void> _getNewsList() async {
    setState(() {
      _isLoading = true;
    });

    WebApi _webApi = WebApi();
    final uri = await _webApi.getURL(Services.DelegateList);
    if (delegations != null) {
      delegations.clear();
    }

    Map body = {
      "Tokenkey": globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN),
      "lang": globalMyLocalPrefes.getString(AppConstant.LANG),
      "empID": globalMyLocalPrefes.getInt(AppConstant.USER_ID),
    };

    print('fetchDelegationList: [POST] --> $uri; body --> $body');
    http
        .post(Uri.parse(uri),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(body))
        .then((response) {
      setState(() {
        _isLoading = false;
      });
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["StatusCode"] == 200) {
        if (jsonResponse['ResultObject'] != null) {
          final parsed = jsonResponse['ResultObject'];
          parsed.forEach((delegation) {
            delegations.add(Delegation.fromJson(delegation));
          });
        }
      } else {
        print("Error: fetch delegate data error");
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        Body(
          delegateList: delegations,
        ),
        ApproveList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _selectedIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'Delegates')),
          centerTitle: true,
          bottom: TabBar(
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (_selectedIndex == 0) {
                  _getNewsList();
                }
              },
              tabs: [
                Tab(
                  text: getTranslated(context, 'YourRequests'),
                ),
                Tab(
                  text: getTranslated(context, 'RequestsToYou'),
                ),
              ]),
        ),
        body: (_isLoading) ? LoadingView() : _buildBody(),
        floatingActionButton:
            UtilsHRM.getPermissionObject(context, 'Delegates').app_add == "1"
                ? FloatingActionButton.extended(
                    onPressed: () {
                      goToAddDelegate();
                    },
                    elevation: 4,
                    label: Text(getTranslated(context, 'Delegates')),
                    icon: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.pink,
                  )
                : null,
      ),
    );
  }
}
