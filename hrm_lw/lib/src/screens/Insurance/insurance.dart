import 'package:LTL_HRM/classes/language.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/screens/Insurance/component/body.dart';
import 'package:flutter/material.dart';

class Insurance extends StatefulWidget {
  // final TabController tabBar;
  Insurance();

  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Insurance')),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Body(),
    );
  }
}
