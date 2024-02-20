import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/src/components/loading_view.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/screens/Login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int settingCount = 0;

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 100,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/logo/BG03Ai.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: ChangeNotifierProvider(
              create: (context) => LoginVM(),
              child: Consumer<LoginVM>(builder: (context, model, _) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _companyBrand(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0),
                      child: _formCard(model),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    _loginButton(model),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          // setState(() {
                          settingCount++;
                          print(settingCount);
                          // });
                          if (settingCount == 5) {
                            Navigator.pushNamed(
                                    context, CustomRouter.setUpServer)
                                .then((value) {
                              model.updateServerURL();
                              setState(() {
                                settingCount = 0;
                              });
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 90),
                          child: Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }

  Widget _showErrorMessage(LoginVM model) {
    if (model.apiResponse != null &&
        model.apiResponse.hasError == true &&
        model.apiResponse.authorized != null &&
        model.apiResponse.authorized == false) {
      return Text(
        'Login not success!',
        style: TextStyle(color: Colors.red, fontSize: 16),
      );
    }

    if (model.apiResponse != null && model.apiResponse.hasError == true) {
      return Text(
        'Login not success!',
        style: TextStyle(color: Colors.red, fontSize: 16),
      );
    }

    return Container();
  }

// lib/assets/logo/HRMS. 05.png
  Widget _companyBrand() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Image.asset(
                "lib/assets/logo/HRM07.png",
                height: 300,
                width: 500,
              ),
              // Text("HRMS",
              //     style: TextStyle(
              //         fontFamily: "Poppins-Bold",
              //         color: kPrimaryColor,
              //         fontSize: 40,
              //         letterSpacing: .6,
              //         fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginButton(LoginVM model) {
    if (model.isLoading) return LoadingView();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          minWidth: 164.0,
          height: 55.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            // color: getColor(),
            // textColor: Colors.white,
            // elevation: 2.0,
            child: Text(
              getTranslated(context, 'Login'),
              style: const TextStyle(
                fontFamily: 'NotoSansLao',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              model.handleSubmitted(context, _formKey);
            },
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(25.0),
            // ),
          ),
        ),
      ],
    );
  }

  Widget _formCard(LoginVM model) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(getTranslated(context, 'Login'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  maxLength: 50,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: getTranslated(context, 'YourEmail'),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
                  validator: (value) => value.isEmpty
                      ? getTranslated(context, 'PleaseEnterValue')
                      : null,
                  onChanged: (value) => model.onUsernameChanged(value),
                ),
              ),
              Container(
                height: 55,
                child: TextFormField(
                  obscureText: true,
                  autofocus: true,
                  maxLength: 20,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: getTranslated(context, 'Password'),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
                  validator: (value) => value.isEmpty
                      ? getTranslated(context, 'PleaseEnterValue')
                      : null,
                  onChanged: (value) => model.onPasswordChanged(value),
                ),
              ),
              _showErrorMessage(model),
            ],
          ),
        ),
      ),
    );
  }
}
