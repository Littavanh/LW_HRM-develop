import 'dart:convert';
import 'package:LTL_HRM/classes/language.dart';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/models/permission.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Network.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/models/messages/api_response.dart';
import 'package:LTL_HRM/src/screens/Login/PODO/loginResponse.dart';
import 'package:LTL_HRM/src/screens/home/components/home_body.dart';
import 'package:LTL_HRM/src/screens/home/components/more_view.dart';
import 'package:LTL_HRM/src/services/UtilsService.dart';
import 'package:LTL_HRM/src/services/request_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Permission> listOfPermission = [];

Permission getPermissionObject(String type) {
  Permission _permission;
  listOfPermission.forEach((element) {
    if (element.app_permissionName == type) {
      _permission = element;
    }
  });
  return _permission;
}

class MyHomePage extends StatefulWidget {
  final List<Permission> listOfPermission;

  MyHomePage({this.listOfPermission});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _initFabHeight = 120.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UtilsService _utilsService = UtilsService();
  RequestService _leaveService = RequestService();

  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;
  String _username, firstName, lastName, username, department, image;

  bool isLoading = true;
  var _color = [
    Colors.pink[200],
    Colors.green[100],
    Colors.orange[100],
    Colors.purple[100],
    Colors.blue[100],
    Colors.pink[200],
    Colors.green[100],
    Colors.orange[100],
    Colors.purple[100],
  ];
  List<Widget> _viewList;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.listOfPermission == null) {
      listOfPermission = widget.listOfPermission;
      _getPermissionData();
    }
    _getInitiateData();
    _fabHeight = _initFabHeight;
  }

  _getPermissionData() async {
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    ApiResponse permissionRes = await _utilsService.fetchUserPermission(token);

    if (!permissionRes.hasError) {
      listOfPermission = permissionRes.data;
      _getInitiateData();
    }
  }

  Future _getInitiateData() async {
    // ApiResponse leaveRes = await _leaveService.fetchLeaveBalance();

    // if (!leaveRes.hasError) {
    setState(() {
      // _leaveBalances = leaveRes.data;
      username = globalMyLocalPrefes.getString(AppConstant.USERNAME);
      department = globalMyLocalPrefes.getString(AppConstant.DEPARTMENT);
      image = globalMyLocalPrefes.getString(AppConstant.IMAGE);
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    _viewList = [HomeBody(), MoreView()];
    _panelHeightOpen = MediaQuery.of(context).size.height * .70;
    if (!isLoading) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            primary: true,
            automaticallyImplyLeading: false,
            title: Text(
              'HRMS',
              style: TextStyle(
                  fontFamily: "sf-ui-text", fontWeight: FontWeight.bold),
            ),
            // backgroundColor: leaveCardcolor1,
            shadowColor: Colors.transparent,
            centerTitle: true,

            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Language>(
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onChanged: (Language language) {
                    _changeLanguage(language);
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
              ),
            ],
          ),
          body: _viewList[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: getTranslated(context, 'Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_vert),
                label: getTranslated(context, 'More'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: kPrimaryColor,
            onTap: _onItemTapped,
          ));
    } else {
      return Container(child: Center(child: CircularProgressIndicator()));
    }
  }
}

class GetToken {
  // SharedPreferences sharedPreferences;
  Future<void> getToken() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        // sharedPreferences = await SharedPreferences.getInstance();
        String username =
            globalMyLocalPrefes.getString(AppConstant.LoginGmailID);
        String password = globalMyLocalPrefes.getString(AppConstant.PASSWORD);
        String urname = globalMyLocalPrefes.getString(AppConstant.USERNAME);

        try {
          final uri = Services.LOGIN;
          Map body = {
            "PassKey": "a486f489-76c0-4c49-8ff0-d0fdec0a162b",
            "UserName": username,
            "UserPassword": password
          };

          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              if (jsonResponse["StatusCode"] == 200) {
                LoginResponse login =
                    new LoginResponse.fromJson(jsonResponse["ResultObject"][0]);

                await globalMyLocalPrefes.setInt(
                    AppConstant.USER_ID.toString(), login.userId);
                await globalMyLocalPrefes.setString(
                    AppConstant.EMP_ID, login.emp_no);
                await globalMyLocalPrefes.setString(
                    AppConstant.ACCESS_TOKEN, login.tokenKey);

                await globalMyLocalPrefes.setString(
                    AppConstant.USERNAME, login.lao_fullname);
                await globalMyLocalPrefes.setString(
                    AppConstant.IMAGE, login.emp_photo);
                await globalMyLocalPrefes.setString(
                    AppConstant.PHONENO, login.emp_mobile);
                await globalMyLocalPrefes.setString(
                    AppConstant.EMAIL, login.userEmail);
                await globalMyLocalPrefes.setString(
                    AppConstant.DEPARTMENT, login.emp_dep);
                await globalMyLocalPrefes.setString(
                    AppConstant.COMPANY, login.emp_company);
                return login.tokenKey;
              } else {
                return "Something wnet wrong.. Please try again later.";
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());
              return "Something wnet wrong.. Please try again later.";
            }
          });
        } catch (e) {
          print("Error: $e");
          return (e);
        }
      } else {
        return "Please check internet connection";
      }
    });
  }
}

retryFuture(future, delay) {
  Future.delayed(Duration(milliseconds: delay), () {
    print(delay);
    future();
  });
}
