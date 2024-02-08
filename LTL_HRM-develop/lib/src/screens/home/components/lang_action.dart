import 'package:LTL_HRM/classes/language.dart';
import 'package:flutter/material.dart';

class LangAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<Language>(
        underline: SizedBox(),
        icon: Icon(
          Icons.language,
          color: Colors.white,
        ),
        onChanged: (Language language) {
          // UtilsHRM.onChangeLanguage(context, language);
        },
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      e.flag,
                      height: 25,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(e.name)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
