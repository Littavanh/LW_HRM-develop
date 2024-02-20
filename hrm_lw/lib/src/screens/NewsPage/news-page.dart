import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/src/screens/NewsPage/component/body.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'News')),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
