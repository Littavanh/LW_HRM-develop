import 'package:LTL_HRM/classes/language.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/src/screens/Account/component/body.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  // final TabController tabBar;
  Account();

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'MyAccount')),
        centerTitle: true,
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: DropdownButton<Language>(
        //       underline: SizedBox(),
        //       icon: Icon(
        //         Icons.language,
        //         color: Colors.white,
        //       ),
        //       onChanged: (Language language) {
        //         _changeLanguage(language);
        //       },
        //       items: Language.languageList()
        //           .map<DropdownMenuItem<Language>>(
        //             (e) => DropdownMenuItem<Language>(
        //               value: e,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: <Widget>[
        //                   Image.asset(
        //                     e.flag,
        //                     height: 25,
        //                   ),
        //                   Container(
        //                       padding: EdgeInsets.only(left: 10),
        //                       child: Text(e.name)),
        //                 ],
        //               ),
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   ),
        // ],
      ),
      body: Body(),
    );
  }
}
