import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUpServerScreen extends StatefulWidget {
  @override
  _SetUpServerScreenState createState() => _SetUpServerScreenState();
}

class _SetUpServerScreenState extends State<SetUpServerScreen> {
  final myController = TextEditingController();
  SharedPreferences newShare;

  @override
  void initState() {
    super.initState();
    _setSharedPrefer();
  }

  _setSharedPrefer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      newShare = sp;
      myController.text = newShare.getString('BASE_URL');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Set-up Server'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 16, right: 16),
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Server URL'),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  final sharePre = await SharedPreferences.getInstance();
                  sharePre.setString('BASE_URL', myController.text);
                  // Services().setBaseURL();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Text(getTranslated(context, 'Save'))),
          ],
        ),
      ),
    );
  }
}
