import 'package:shared_preferences/shared_preferences.dart';

class Services {
  SharedPreferences sharedPref;

  // void setBaseURL() async {
  //   sharedPref = await SharedPreferences.getInstance();
  // }
  //
  // getBaseURL() {
  //   if (sharedPref != null) {
  //     final url = sharedPref.getString('BASE_URL');
  //     return url == null ? '' : url;
  //   }
  //   return '';
  // }

  static final String LOGIN = 'User/Login';
  static final String GetLeaveType = 'User/LeaveType';
  static final String GetResponsiblePer = 'User/EmployeeUnderResponse';
  static final String GetUserProfiles = 'profile';
  static final String LeaveBalance = 'User/LeaveBalanceAll';
  static final String LeaveBalanceAllType = 'User/LeaveBalanceAllType';
  static final String GetPermissions = 'User/permission';
  static final String GetNewsList = 'New/Newlist';
  static final String AddNews = 'New/AddNews';
  static final String DelNews = 'New/DeleteNews';
  static final String NewsDetail = 'NewsItem';
  static final String PublicHolidays = 'User/publicholidays';
  static final String MyRequest = 'User/MyRequest';
  static final String AddNewLeave = 'User/AddNewLeave';
  static final String AddDelegate = 'User/NewDelegate';
  static final String RejectLeave = 'User/RejectLeave';
  static final String ApproveLeave = 'User/ApproveLeave';
  static final String ApproveOT = 'User/ApproveOT';
  static final String AddNewOT = 'User/AddNewOT';
  static final String RejectOT = 'User/RejectOT';
  static final String EmpRequest = 'User/LeaveRequestApproveList';
  static final String EmpOTRequest = 'User/OTRequestApproveList';
  static final String EmpRequestDetails = 'User/EmployeeRequestDetail';
  static final String DelegateList = 'User/DelegateList';

  static final String DelegatePerson = 'User/GetEmpByDeptID';
  static final String MyLevReqDetails = 'User/MyRequestDetail';
  static final String CancelMyrequest = 'User/DelleaveRequest';
  static final String CancelMyOTRequest = 'User/DelOTRequest';
  static final String VIEW_LEAVE_DOCUMENT = 'Function/viewImageRequestList';

  static final String TaskList = 'Task/Tasklist';
  static final String AddTaskList = 'Task/AddTask';
  static final String DeleteTask = 'Task/DeleteTask';

  static final String MarkCompTaskList = 'Task/UpdateTaskStatus';
  static final String MyAttendance = 'MyAttendance/CheckIn-Out';
  static final String InsuranceHeader = 'User/InsuranceHeader';
  static final String InsuranceDetail = 'User/InsuranceDetail';
  static final String LoanHeader = 'User/LoanHeader';

  static final String LoanDetail = 'User/LoanDetail';

  static final String PayslipList = 'User/paymentSlipHeader';
  static final String PayslipDetails = 'User/paymentSlipDetail';

  //InsuranceHeader

  static final String ApproveEmpRequest = 'User/ApproveRequest';
  static final String GetEmployeeInfo = 'User/GetEmployeesInfo';
  static final String DelegateApproverList = 'User/DelegateApproverList';
  static final String ApproveDelegate = 'User/ApproveDelegate';
  static final String RejectDelegate = 'User/UnApproveDelegate';
}
