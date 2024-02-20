import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final String title;
  final String img;
  final String subtitle;
  final IconData icon;
  final String pagNav;

  const CardList(this.title, this.img, this.subtitle, this.icon, this.pagNav);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, pagNav);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: Icon(
                  icon,
                ),
                title: Text(
                  getTranslated(context, title),
                ),
                subtitle: Text(
                  getTranslated(context, subtitle),
                  // style: TextStyle(color: Color(0xFF797777), fontSize: 12.0)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
