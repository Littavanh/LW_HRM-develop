import 'package:LTL_HRM/src/screens/Account/account.dart';
import 'package:LTL_HRM/src/screens/Attendance/attendance.dart';
import 'package:LTL_HRM/src/screens/Delegates/AddDelegates/addDelegates.dart';
import 'package:LTL_HRM/src/screens/Delegates/delegrate.dart';

import 'package:LTL_HRM/src/screens/Loans/loans.dart';
import 'package:LTL_HRM/src/screens/Insurance/insurance.dart';

import 'package:LTL_HRM/src/screens/AddRequest/addRequest.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/RequestDetails/requestDetails.dart';
import 'package:LTL_HRM/src/screens/MyRequest/MyLeaveRequest/myLeaveReqDetails/myLeaveReqDetails.dart';
import 'package:LTL_HRM/src/screens/MyRequest/MyOTRequest/component/myOtRequest.dart';
import 'package:LTL_HRM/src/screens/MyRequest/myRequest.dart';

import 'package:LTL_HRM/src/screens/EmpRequest/EmpRequest.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/EmpLeaveRequest/EmpLeaveRequest.dart';
import 'package:LTL_HRM/src/screens/EmpRequest/EmpOtRequest/EmpOtRequest.dart';

// import 'package:LTL_HRM/src/screens/Dashboard/approveHome/approve-home.dart';
// import 'package:LTL_HRM/src/screens/Dashboard/pendingHome/pending-home.dart';
// import 'package:LTL_HRM/src/screens/Dashboard/rejectHome/component/reject-home.dart';
import 'package:LTL_HRM/src/screens/NewsPage/AddNews/addNews.dart';
import 'package:LTL_HRM/src/screens/NewsPage/news-page.dart';
import 'package:LTL_HRM/src/screens/Payslip/payslip.dart';
import 'package:LTL_HRM/src/screens/RulesPage/rulesPage.dart';
import 'package:LTL_HRM/src/screens/SetUpServer/SetUpScreen.dart';
import 'package:LTL_HRM/src/screens/Task/TaskAdd/taskAdd.dart';
import 'package:LTL_HRM/src/screens/Task/task.dart';
import 'package:LTL_HRM/src/screens/doc_view/doc_view_screen.dart';
import 'package:LTL_HRM/src/screens/emp_request_details/emp_request_details.dart';
import 'package:LTL_HRM/src/screens/emp_requests/emp_requests_sreen.dart';
import 'package:LTL_HRM/src/screens/emp_wfh_requests/emp_wfh_requests.dart';
import 'package:LTL_HRM/src/screens/holidays/holidays.dart';
import 'package:LTL_HRM/src/screens/home/home.dart';
import 'package:LTL_HRM/src/screens/landing.dart';
import 'package:LTL_HRM/src/screens/Login/login.dart';
import 'package:LTL_HRM/src/screens/request_details/request_details.dart';
import 'package:LTL_HRM/src/screens/wfh_add_request/wfh_add_request.dart';
import 'package:LTL_HRM/src/screens/wfh_request/wfh_requests.dart';
import 'package:flutter/cupertino.dart';

import '../src/screens/LeaveAll/leaveAll.dart';

class CustomRouter {
  static const String homeRoute = '/home';
  static const String accountRoute = '/account';
  static const String dashboardRoute = '/dashboard';
  static const String loginRoute = '/login';
  static const String landingRoute = '/landing';
  static const String pendingHomeRoute = '/pendingHome';
  static const String approveHomeRoute = '/approveHome';
  static const String rejectHomeRoute = '/rejectHome';
  static const String addRequestRoute = '/addRequest';

  static const String addDelegatesRoute = '/addDelegates';
  static const String myOtRequestRoute = '/myOtRequest';
  static const String myLeaveRequestRoute = '/myLeaveRequest';
  static const String myRequestRoute = '/myRequestRoute';

  static const String empOtRequestRoute = '/empOtRequest';
  static const String empLeaveRequestRoute = '/empLeaveRequest';
  static const String empRequestRoute = '/empRequestRoute';
  static const String requestDetailsRoute = '/requestDetailsRoute';
  static const String calendarViewRoute = '/calendarViewRoute';
  static const String loansRoute = '/loansRoute';
  static const String insuranceRoute = '/insuranceRoute';

  static const String taskRoute = '/taskRoute';

  static const String addTaskRoute = '/addTaskRoute';

  static const String rulesRoute = '/rulesRoute';
  static const String attendanceRoute = '/attendanceRoute';
  static const String payslipRoute = '/payslipRoute';
  static const String leaveAllRoute = '/leaveAllRoute';
 

  static const String takePictureScreenRoute = '/takePictureScreenRoute';
  static const String addNewsRoute = '/addNewsRoute';
  static const String delegateRoute = '/delegateRoute';
  static const String addDelegateRoute = '/addDelegateRoute';
  static const String myLeaveReqDetails = '/myLeaveReqDetails';
  static const String newsList = '/newsList';
  static const String documentView = '/documentView';
  static const String requestOtDetailScreen = 'ADD_REQUEST_OT_SREEN';
  static const String requestDetailsScreen = 'REQUEST_DETAILS_SREEN';
  static const String empRequestsScreen = 'EMP_REQUESTS_SREEN';
  static const String empRequestsDetailsScreen = 'EMP_REQUEST_DETAILS_SREEN';
  static const String setUpServer = 'SetUpServer';
  static const String workFromHome = 'WorkFromHome';
  static const String empWorkFromHome = 'EmpWorkFromHome';
  static const String addWFHRequest = "addWFHRequest";

  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => MyHomePage());
      case accountRoute:
        return CupertinoPageRoute(builder: (_) => Account());
      case landingRoute:
        return CupertinoPageRoute(builder: (_) => Landing());
      // case pendingHomeRoute:
      //   return CupertinoPageRoute(builder: (_) => PendingHome());
      // case approveHomeRoute:
      //   return CupertinoPageRoute(builder: (_) => ApproveHome());
      // case rejectHomeRoute:
      //   return CupertinoPageRoute(builder: (_) => RejectHome());
      case addRequestRoute:
        return CupertinoPageRoute(
            builder: (_) => AddRequest(settings.arguments));
      case loginRoute:
        return CupertinoPageRoute(builder: (_) => Login());
      case newsList:
        return CupertinoPageRoute(builder: (_) => NewsPage());
      case delegateRoute:
        return CupertinoPageRoute(builder: (_) => Delegate());
      case addDelegateRoute:
        return CupertinoPageRoute(builder: (_) => AddDelegates());
      case myRequestRoute:
        return CupertinoPageRoute(builder: (_) => MyRequest());
      // case myOtRequestRoute:
      //   return CupertinoPageRoute(builder: (_) => MyLeaveRequest());
      // case myLeaveRequestRoute:
      //   return CupertinoPageRoute(builder: (_) => MyOTRequest());
      case empRequestRoute:
        return CupertinoPageRoute(builder: (_) => EmpRequest());
      case empOtRequestRoute:
        return CupertinoPageRoute(builder: (_) => EmpLeaveRequest());
      case empLeaveRequestRoute:
        return CupertinoPageRoute(builder: (_) => EmpOTRequest());
      case requestDetailsRoute:
        return CupertinoPageRoute(builder: (_) => RequestDetails());
      case calendarViewRoute:
        return CupertinoPageRoute(builder: (_) => HolidaysScreen());

      case rulesRoute:
        return CupertinoPageRoute(builder: (_) => RulesPage());
      case loansRoute:
        return CupertinoPageRoute(builder: (_) => LoansScreen());
      case insuranceRoute:
        return CupertinoPageRoute(builder: (_) => Insurance());
      case taskRoute:
        return CupertinoPageRoute(builder: (_) => Task());

      case addTaskRoute:
        return CupertinoPageRoute(builder: (_) => TaskAdd());
      case attendanceRoute:
        return CupertinoPageRoute(builder: (_) => Attendance());
      case payslipRoute:
        return CupertinoPageRoute(builder: (_) => Payslip());
      case leaveAllRoute:
        return CupertinoPageRoute(builder: (_) => LeaveAll());
      // case takePictureScreenRoute:
      //   return CupertinoPageRoute(builder: (_) => TakePictureScreen());

      case addNewsRoute:
        return CupertinoPageRoute(builder: (_) => AddNews());
      case myLeaveReqDetails:
        return CupertinoPageRoute(
            builder: (_) => MyLeaveReqDetails(
                  levReqDetailID: settings.arguments,
                ));
      case requestOtDetailScreen:
        return CupertinoPageRoute(
            builder: (_) => MyOTReqDetails(
                  levReqDetailID: settings.arguments,
                ));
      case requestDetailsScreen:
        return CupertinoPageRoute(
            builder: (_) => RequestDetailsScreen(
                  arg: settings.arguments,
                  // levReqDetailID: settings.arguments,
                ));
      case documentView:
        return CupertinoPageRoute(
            builder: (_) => DocViewScreen(settings.arguments as String));
      case empRequestsScreen:
        return CupertinoPageRoute(builder: (_) => EmpRequestsScreen());
      case empRequestsDetailsScreen:
        return CupertinoPageRoute(
            builder: (_) => EmpRequestDetailsScreen(arg: settings.arguments));
      case setUpServer:
        return CupertinoPageRoute(builder: (_) => SetUpServerScreen());
      case workFromHome:
        return CupertinoPageRoute(builder: (_) => WFHRequest());
      case empWorkFromHome:
        return CupertinoPageRoute(builder: (_) => EmpWfhRequests());
      case addWFHRequest:
        return CupertinoPageRoute(builder: (_) => WTFAddRequestScreen());
    }
    return CupertinoPageRoute(builder: (_) => Landing());
  }
}
