import 'dart:convert';

import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/constants/AppConstant.dart';
import 'package:LTL_HRM/utils/url_constants.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/demo_localization.dart';
import 'localization/localization_constants.dart';

SharedPreferences globalMyLocalPrefes;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //If subscribe based sent notification then use this token
  final fcmToken = await messaging.getToken();
  print(fcmToken);

  //If subscribe based on topic then use this
  await messaging.subscribeToTopic('flutter_notification');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification', // id
        'flutter_notification_title', // title
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final android =
        AndroidInitializationSettings('@mipmap/launcher_icon');
   
    final initSettings = InitializationSettings(android: android);

    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    await messaging
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ShareProvider())],
      child: MyApp()));
}

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  static void clearSharedPreference(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.clearSharePref();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  setLocale(Locale locale) async {
    if (locale.languageCode == 'en') {
      context.read<ShareProvider>().updateAppLang('2');
      await globalMyLocalPrefes.setString(AppConstant.LANG, '2');
    }
    if (locale.languageCode == 'lo') {
      context.read<ShareProvider>().updateAppLang('1');
      await globalMyLocalPrefes.setString(AppConstant.LANG, '1');
    }
    setState(() {
      _locale = locale;
    });
  }

  void clearSharePref() async {
    print('Clear SharedPreference');
    await globalMyLocalPrefes.clear();
    final sp = await SharedPreferences.getInstance();
    sp.setString('BASE_URL', '${UrlConstants.initURL}');
    setState(() {
      globalMyLocalPrefes = sp;
    });
  }

  @override
  void initState() {
    initSharePref();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    initPlatformState();
    analytics.logAppOpen();
    initSharePref();

    super.initState();

    setupInteractedMessage();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) async {
      RemoteNotification notification = message.notification;

      print(notification != null ? notification.title : '');
    });

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                largeIcon: DrawableResourceAndroidBitmap('@drawable/hrm'),
                channelShowBadge: true,
                autoCancel: true,
                icon: '@mipmap/launcher_icon',
              ),
            ),
            payload: action);
      }
      print('A new event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : Map()));
  }

  void _handleMessage(Map<String, dynamic> data) {
    // if (data['redirect'] == "product") {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ProductPage(message: data['message'])));
    // }
  }
  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
        print("supported");
      } else {
        print("not supported");
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      print("Failed to get badge support.");

      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  initSharePref() async {
    print('initSharePref: ');
    globalMyLocalPrefes = await SharedPreferences.getInstance();
  }

  void setupBaseURL() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('BASE_URL') == null) {
      print('setupBaseURL');
      sp.setString('BASE_URL', '${UrlConstants.initURL}');
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    setupBaseURL();
    getLocale().then((locale) async {
      if (locale.languageCode.trim() == 'en') {
        context.read<ShareProvider>().updateAppLang('2');
        await globalMyLocalPrefes.setString(AppConstant.LANG, '2');
        await globalMyLocalPrefes.setString(AppConstant.LANG, '2');
        setState(() {
          _locale = locale;
        });
      } else {
        context.read<ShareProvider>().updateAppLang('1');
        await globalMyLocalPrefes.setString(AppConstant.LANG, '1');
        await globalMyLocalPrefes.setString(AppConstant.LANG, '1');
        setState(() {
          _locale = locale;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('Build app: local = ' + _locale.languageCode);

    // SystemChrome.setEnabledSystemUIOverlays([]);
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HRMS',
          theme: ThemeData(
            fontFamily: 'NotoSansLao',
            // fontFamily: 'Noto Serif Lao',
            // primaryColor: HexColor('#4361ee'),
            primarySwatch: Colors.indigo,
            // accentColor: HexColor('#b5179e'),
            // accentColor: splashScreenColorTop,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
          ),
          locale: _locale,
          supportedLocales: [Locale("en", "US"), Locale("lo", "")],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorObservers: <NavigatorObserver>[observer],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          onGenerateRoute: CustomRouter.generatedRoute,
          initialRoute: landingRoute);
    }
  }
}
