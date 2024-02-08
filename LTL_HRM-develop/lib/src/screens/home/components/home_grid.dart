import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  final String title;
  final String img;
  final String pagNav;
  final String countTxt;

  const HomeGrid(this.title, this.img, this.pagNav, this.countTxt);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pagNav);
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        new Stack(children: <Widget>[
          Container(
            child: Image.asset(
              img,
              fit: BoxFit.contain,
              height: 75,
            ),
          ),
          Positioned(
            // draw a red marble
            top: 0.0,
            right: 0.0,
            child: (countTxt == null || countTxt == '0')
                ? Container()
                : Container(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Center(
                            child: Text(countTxt,
                                style: TextStyle(color: Colors.white))),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(color: Colors.red[400], spreadRadius: 1),
                          ],
                        ),
                      ),
                    ),
                  ),
          )
        ]),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            getTranslated(context, title),
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ]),
    );
  }
}
