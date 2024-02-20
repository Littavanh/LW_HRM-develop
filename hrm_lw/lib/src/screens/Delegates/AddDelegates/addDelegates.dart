import 'package:LTL_HRM/classes/language.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/screens/Delegates/AddDelegates/component/body.dart';
import 'package:flutter/material.dart';

class AddDelegates extends StatefulWidget {
  // final TabController tabBar;
  AddDelegates();

  @override
  _AddDelegatesState createState() => _AddDelegatesState();
}

class _AddDelegatesState extends State<AddDelegates> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'AddDelegates')),
      ),
      body: Body(),
    );
  }
}
