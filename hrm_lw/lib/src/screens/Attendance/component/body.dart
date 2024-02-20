import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:LTL_HRM/localization/localization_constants.dart';
import 'package:LTL_HRM/main.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/src/constants/Services.dart';
import 'package:LTL_HRM/src/constants/colors.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import './background.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position> _positionStreamSubscription;
  bool _isCheckinDisabled, _isCheckoutDisabled, _showSubmitBtn;
  String result1;
  PickedFile pickedFile;
  Position position;

  bool isChecking = globalMyLocalPrefes.getBool('isChecking') ?? false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _isCheckinDisabled = isChecking;
    _isCheckoutDisabled = !isChecking;
    _showSubmitBtn = false;
  }

  Image img;
  PickedFile imageFile;
  Future<void> _showMyDialog(serviceRequestText) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(getTranslated(context, 'TakePic')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(getTranslated(context, 'clickPictureTag')),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text(getTranslated(context, 'Cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text(getTranslated(context, 'Ok')),
              ),
            ],
          );
        }).then((exit1) async {
      if (exit1 == null) return;

      if (exit1) {
        //  await Navigator.pop(context);

        imageFile = await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 60);
        if (imageFile != null) {
          setState(() {
            result1 = imageFile.path;
            pickedFile = imageFile;
            _showSubmitBtn = true;
          });
        }

        // user pressed Yes button
      } else {
        Navigator.pushNamed(context, homeRoute);
        // user pressed No button
      }
    });
  }

  // getCamera(BuildContext context, serviceRequestText) async {
  //   result1 = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => TakePictureScreen()),
  //   );
  //   setState(() {});
  //   print("Result imgaeg : $result1");

  //   _showSubmitBtn = true;
  // }

  Future _determinePosition(serviceRequestText) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
        // return Future.error(
        //     'Location permissions are denied (actual value: $permission).');
      }
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      _showMyDialog(serviceRequestText);
    }
    print("position%%%%%%%%%%::: ${position.latitude}");
    //  / return print(position); // return await Geolocator.getCurrentPosition();
  }

  Future<void> submitAttendance(bool checkinout) async {
    setState(() {
      isLoading = true;
    });

    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);
    final uri = Services.MyAttendance;

    Uint8List uint8list = await pickedFile.readAsBytes();

    var base64Image = base64Encode(uint8list);
    print("Imageee::: $base64Image");

    Map body = {
      "TokenKey": token,
      "CheckDataTime": new DateTime.now().toString(),
      "longitude": position.longitude.toString(),
      "latitude": position.latitude.toString(),
      "checkInOut": checkinout ? "checkin" : "checkout",
      "picture": base64Image
    };
    http.post(Uri.parse(uri), body: body).then((response) async {
      var jsonResponse = jsonDecode(response.body);
      print("Reponse : $jsonResponse");

      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        await globalMyLocalPrefes.setBool('isChecking', !isChecking);

        Navigator.pushNamed(context, homeRoute);
      } else {
        setState(() {
          isLoading = false;
        });
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {
            submitAttendance(checkinout);
          });
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong, please try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          // currentState.showSnackBar(
          //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Container(
            child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 100.0,
            height: 100.0,
            margin: const EdgeInsets.all(20.0),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("lib/assets/images/XSgklyxE.jpg")))),
        Container(
            // color: Colors.pink,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(getTranslated(context, 'attendanceTagline'),
                style: TextStyle(color: Colors.grey[800]))),
        result1 != null
            ? Container(
                height: 170,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey[700]),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.file(
                  File(result1),
                  fit: BoxFit.cover,
                ),
              )
            : Container(),
        SizedBox(
          height: 50,
        ),
        _showSubmitBtn == true
            ? Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  // color: leaveCardcolor,
                  onPressed: () {
                    print(" $_isCheckinDisabled $_isCheckoutDisabled = true");
                    if (_isCheckinDisabled) {
                      _isCheckinDisabled = false;
                      _isCheckoutDisabled = true;
                    } else {
                      _isCheckinDisabled = true;
                      _isCheckoutDisabled = false;
                    }
                    _showSubmitBtn = false;
                    result1 = null;
                    setState(() {});
                    submitAttendance(_isCheckinDisabled);
                  },
                  // textColor: Colors.white,
                  // padding: const EdgeInsets.all(10.0),
                  child: const Text('Submit Check-In Now',
                      style: TextStyle(fontSize: 25)),
                ))
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UtilsHRM.getPermissionObject(context, 'Attendance').app_add == "1"
                ? Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      // color: leaveCardcolor,
                      onPressed: _isCheckinDisabled == false
                          ? () {
                              _determinePosition('Check-In');
                            }
                          : null,
                      // textColor: Colors.white,
                      // padding: const EdgeInsets.all(10.0),
                      child: const Text('Check-In',
                          style: TextStyle(fontSize: 25)),
                    ))
                : Container(),
            UtilsHRM.getPermissionObject(context, 'Attendance').app_add == "1"
                ? Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      // disabledColor: kGreyLightColor,
                      // color: leaveCardcolor,
                      // onPressed: _isButtonDisabled ? _determinePosition : null,
                      onPressed: _isCheckoutDisabled == false
                          ? () {
                              _determinePosition('Check-Out');
                            }
                          : null,
                      // textColor: Colors.white,
                      // padding: const EdgeInsets.all(10.0),
                      child: const Text('Check-Out',
                          style: TextStyle(fontSize: 25)),
                    ))
                : Container(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _positionItems.length,
            itemBuilder: (context, index) {
              final positionItem = _positionItems[index];

              if (positionItem.type == _PositionItemType.permission) {
                return ListTile(
                  title: Text(positionItem.displayValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                );
              } else {
                return Card(
                  child: ListTile(
                    tileColor: leaveCardcolor,
                    title: Text(
                      positionItem.displayValue,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        isLoading ? LinearProgressIndicator() : Container(),
      ],
    )));
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _positionItems.add(
          _PositionItem(_PositionItemType.position, position.toString()))));
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}