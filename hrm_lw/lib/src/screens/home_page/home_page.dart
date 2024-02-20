import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
          )
        ],
      ),
    );
  }
}
