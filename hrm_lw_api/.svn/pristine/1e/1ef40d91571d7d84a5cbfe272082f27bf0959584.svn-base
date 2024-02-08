using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class ValuesModels
    {
    }

    public class rptotdetailsemployeeResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<GetEmployeeByDeptIDtViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class rptotdetailsemployeeVL
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class GetEmployeeByDeptIDtViewModelResult
    {
        public string empID { get; set; }
        public string empName { get; set; }
        public string delegatetype { get; set; } // 1 never delegate, 2 ever delegate
    }

    public class rptleavedetailsemployeeResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<GetEmployeeLeaveViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }

    public class EmployeeLeaveDetailBydateResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeLeaveDetailBydateModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }


    public class rptleaveemployee
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public DateTime startdate { get; set; }
        public DateTime enddate { get; set; }
    }

    public class employeeLeaveDetailParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empId { get; set; }
        public string startdate { get; set; }
        public string enddate { get; set; }
    }

    public class GetEmployeeLeaveViewModelResult
    {
        public string leaverequestno { get; set; }
        public string empId { get; set; }
        public string empNo { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string dob { get; set; }
        public string ethic { get; set; }
        public string nationlity { get; set; }
        public string tel { get; set; }
        public string fstatus { get; set; }
        public string worklocation { get; set; }
        public string empposition { get; set; }
        public string deptname { get; set; }
        public string leavestartdate { get; set; }
        public string leaveeenddate { get; set; }
        public string leavereturndate { get; set; }
        public string leaveday { get; set; }
        public string leavetype { get; set; }
        public string n_startdate { get; set; }
        public string n_enddate { get; set; }
        public string n_returndate { get; set; }
        public string textstatus { get; set; }
        public string companyID { get; set; }
        public string deptid { get; set; }
        public string noted { get; set; }
        public string gender { get; set; }
    }

    public class EmployeeLeaveDetailBydateModelResult
    {
        public string leaverequestno { get; set; }              
        public string leavestartdate { get; set; }
        public string leaveeenddate { get; set; }
        public string leavereturndate { get; set; }
        public string leaveday { get; set; }
        public string leavetype { get; set; }
        public string n_startdate { get; set; }
        public string n_enddate { get; set; }
        public string n_returndate { get; set; }
        public string textstatus { get; set; }       
        public string noted { get; set; }
    }

    public class GetEmployeeReportDetailsResult
    {
        public string empID { get; set; }
        public string empNo { get; set; }
        public string emp_FullName { get; set; }
        public string emp_Gender { get; set; }
        public string emp_dob { get; set; }
        public string emp_FstatusText { get; set; }
        public string emp_Nationallity { get; set; }
        public string emp_Ethic { get; set; }
        public string emp_email { get; set; }
        public string emp_tel { get; set; }
        public string emp_position { get; set; }
        public string emp_DeptText { get; set; }
        public string emp_AssignmemtLocation { get; set; }
        public string emp_CurrentAddress { get; set; }
        public string emp_CostCenterCode { get; set; }
        public string emp_CostCenterText { get; set; }
        public string emp_unitID { get; set; }
        public string emp_companyID { get; set; }
        public string emp_deptID { get; set; }
        public string emp_empLevelID { get; set; }
        public string emp_empGroupID { get; set; }
        public string emp_mgrid { get; set; }
        public string emp_shiftWorkingID { get; set; }
        public string emp_shiftWorkingName { get; set; }
        public string emp_costCenterID { get; set; }
        public string emp_workingStatusID { get; set; }
        public string emp_hireDay1 { get; set; }
        public string emp_actingDay1 { get; set; }
        public string emp_hireDay2 { get; set; }
        public string emp_actingDay2 { get; set; }
    }
    public class rptemployeedetailsParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class rptemployeedtails
    {        
        public string ModelErrors { get; set; }
        public IEnumerable<GetEmployeeReportDetailsResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }
    public class leavedetailsparam
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
        public string years { get; set; }
        public int empid { get; set; }
    }
    public class leavedetailresult
    {
        public string leaveamountused { get; set; }
        public string leavename { get; set; }
        public string leavestart { get; set; }
        public string leaveend { get; set; }
        public string leavereturn { get; set; }
    }
    public class leavedetailsmodel
    {
        public string ModelErrors { get; set; }
        public IEnumerable<leavedetailresult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }
    public class leavedetailparammgrid
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
        public string years { get; set; }
        public int mgrid { get; set; }
    }
    public class leavedetailmgridresult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<leavedetailresult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }
    public class otdetailsparam
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
        public string yearmonths { get; set; }
        public int mgrid { get; set; }
    }
    public class otdetailsresult
    {
        public string ot1 { get; set; }
        public string ot2 { get; set; }
        public string ot3 { get; set; }
        public string ot4 { get; set; }
        public string ot5 { get; set; }
        public string sumot { get; set; }
        public string otincome1 { get; set; }
        public string otincome2 { get; set; }
        public string otincome3 { get; set; }
        public string otincome4 { get; set; }
        public string otincome5 { get; set; }
        public string otincome { get; set; }

    }
    public class otdetailsmodel
    {
        public string ModelErrors { get; set; }
        public IEnumerable<otdetailsresult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class checkpermissionmodel
    {
        public string ModelErrors { get; set; }
        public IEnumerable<checkpermissionResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public String CommonErrors { get; set; }
    }
    public class checkpermissiondParam
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
        public int salaryid { get; set; }
    }
    public class checkpermissionResult
    {
        public int checkdata { get; set; }
    }
    public class DateSalaryLastmonthParam
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
    }
    public class DateSalaryResult
    {
        public string stdate { get; set; }
        public string enddate { get; set; }
    }
    public class DateSalaryModel
    {
        public string ModelError { get; set; }
        public string CommonErrors { get; set; }
        public Boolean IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<DateSalaryResult> ResultObject { get; set; }
    }

    public class EmpLeaveParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public int leavetypeid { get; set; }
        public int useradd { get; set; }
        public float amountday { get; set; }
        public int empid { get; set; }

    }
    public class EmpLeaveResult
    {
        public string leaverequestno { get; set; }
        public string empid { get; set; }
        public string startdate { get; set; }
        public string enddate { get; set; }
        public string returndate { get; set; }
        public string amountday { get; set; }
        public string noted { get; set; }
        public string expdate { get; set; }
        public string leaverequestid { get; set; }
        public string leavetypeid { get; set; }
        public string leavetypename { get; set; }
    }
    public class EmpLeaveModel
    {
        public string ModelError { get; set; }
        public string CommonErrors { get; set; }
        public Boolean IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<EmpLeaveResult> ResultObject { get; set; }
    }

    public class loadEmpLeaveParam
    {
        public string token { get; set; }
        public string lang { get; set; }
    }
    public class loadEmpLeaveReult
    {
        public int leaverequestid { get; set; }
        public string empid { get; set; }
        public string empno { get; set; }
        public string laoname { get; set; }
        public string engname { get; set; }
        public string leavetype { get; set; }
        public string amountday { get; set; }
        public string expdate { get; set; }
        public string leavetypeid { get; set; }
    }
    public class loadEmpLeaveModel
    {
        public string ModelErrors { get; set; }
        public string CommonErrors { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public IEnumerable<loadEmpLeaveReult> ResultObject { get; set; }
    }

    public class updateEmployeeLeaveParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public int leaverequestid { get; set; }
        public float amountday { get; set; }
        public int useradd { get; set; }

    }
    public class updateEmployeeLeaveResult
    {
        public string leaverequestno { get; set; }
    }
    
    public class updateEmployeeLeaveModel
    {
        public string ModelError { get; set;}
        public string CommonError { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public IEnumerable<updateEmployeeLeaveResult> ResultObject { get; set; }
    }

    public class loadLeaveSummaryAllEmployeeParam
    {
        public string token { get; set; }
        public string lang { get; set; }

    }
    public class loadLeaveSummaryAllEmployeeResult
    {
        public string empid { get; set; }
        public string leaveforward { get; set; }
        public string CLentitlement { get; set; }
        public string CLbalancelastmonth { get; set; }
        public string CLusedthismonth { get; set; }
        public string CLremain { get; set; }
        public string ALentitlement { get; set; }
        public string ALbalancelastmonth { get; set; }
        public string ALusedthismonth { get; set; }
        public string AEworkingthismonth { get; set; }
        public string AKremain { get; set; }
        public string DILbalance { get; set; }
        public string DILUsed { get; set; }
        public string empno { get; set; }
        public string empnameL1 { get; set; }
        public string empnameL2 { get; set; }
        public string departmentL1 { get; set; }
        public string departmentL2 { get; set; }
        public string deptname { get; set; }
        public string empname { get; set; }

    }
    public class loadLeaveSummaryAllEmployeeModel
    {
        public string ModelError { get; set; }
        public string CommonError { get; set; }
        public Boolean IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<loadLeaveSummaryAllEmployeeResult> ResultObject { get; set; }
    }
    public class leaverequestalldetailsParam
    {
        public string Tokenkey { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
        public string status { get; set; }
    }
    public class leaverequestalldetailsResult
    {
        public string ModelErrors { get; set; }
        public string CommonErrors { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public IEnumerable<leaverequestalldetailsModel> ResultObject { get; set; }
    }
    public class leaverequestalldetailsModel
    {
        public string leaveRequestID { get; set; }
        public string leaveRequestNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string empName { get; set; }
        public string leaveTypeID { get; set; }
        public string leaveTypeName { get; set; }
        public string leaveDay { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public string returnDate { get; set; }
        public string amountDay { get; set; }
        public string noted { get; set; }
        public string delegateEmpid { get; set; }
        public string delegateEmpName { get; set; }
        public string filePath { get; set; }
        public string fileAttached { get; set; }
        public string managerName { get; set; }
        public string transactionTypeName { get; set; }
        public string expDate { get; set; }
        public string referAdd { get; set; }
        public string status { get; set; }
        public int historyCount { get; set; }
        public int? managerEmpID { get; set; }
        public int approveUserID { get; set; }
        public string leavemorning { get; set; }
        public string leaveafternoon { get; set; }
    }

    public class displayNotiApproveParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public int managerid { get; set; }
    }
    public class displayNotiApproveModel
    {
        public string leave { get; set; }
        public string wff { get; set; }
        public string wfh { get; set; }
        public string ot { get; set; }
        public string deleagte { get; set; }
        public string totalleave { get; set; }
        public string total { get; set; }
        public string countapprove { get; set; }
        public string deleagte_rq { get; set; }
    }
    public class displayNotiApproveResult
    {
        public string ModelErrors { get; set; }
        public string CommonErrors { get; set; }
        public bool IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<displayNotiApproveModel> ResultObject { get; set; }
    }

    public class displayLeaveBalanceAllParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
        public int year { get; set; }
    }
    public class displayLeaveBalanceAllModel
    {
        public string blEMP { get; set; }
        public string blMGID { get; set; }
    }
    public class displayLeaveBalanceAllResult
    {
        public string ModelErrors { get; set; }
        public string CommomErrors { get; set; }
        public int StatusCode { get; set; }
        public bool IsSuccess { get; set; }
        public IEnumerable<displayLeaveBalanceAllModel> ResultObject { get; set; }
    }

    public class displaymbpaymentRecordParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
    }
    public class displaymbpaymentRecordModel
    {
        public int salaryid { get; set; }
        public string strdate { get; set; }
        public string enddate { get; set; }
        public string empid { get; set; }
        public string monthly { get; set; }
        public string monthyear { get; set; }
    }
    public class displaymbpaymentRecordResult
    {
        public string ModelErrors { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSucess { get; set; }
        public string CommonErrors { get; set; }
        public IEnumerable<displaymbpaymentRecordModel> ResultObject { get; set; }
    }
    public class displayLogModel
    {
        public string logid { get; set; }
        public string logdate { get; set; }
        public string loguser { get; set; }
        public string username { get; set; }
        public string logeven { get; set; }
        public string logmodules { get; set; }
        public string olddata { get; set; }
        public string newdata { get; set; }
        public string datelog { get; set; }

    }
    public class displayLogParam
    {
        public string token { get; set; }
        public string lang { get; set; }
        public DateTime strdate { get; set; }
        public DateTime enddate { get; set; }

    }
    public class displayLogResult
    {
        public string ModelErrors { get; set; }
        public string CommonErrors { get; set; }
        public Boolean IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<displayLogModel> ResultObject { get; set; }
    }
    public class dashboardSumOTModel
    {
        public string sumtotal { get; set; }
    }
    public class dasboardSumOTParam
    {
        public string tokenkey { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
      
    }
    public class dasboardSumOTResult
    {
        public string ModelErrors { get; set; }
        public string CommonError { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public IEnumerable<dashboardSumOTModel> ResultObject { get; set; }

    }
    public class dashboardSumLeaveModel
    {
        public string empid { get; set; }
        public string amtDayleave { get; set; }
        public string amtDayBalance { get; set; }
        public string leavetypeid { get; set; }
    }
    public class dashboardSumLeaveResult
    {
        public string ModelErrors { get; set; }
        public string CommonError { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public IEnumerable<dashboardSumLeaveModel> ResultObject { get; set; }
    }
    public class dashboardSumLeaveParam
    {
        public string tokenkey { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
    }

    public class displayMobileLeaveDashboardModel
    {
        public string annualleave { get; set; }
        public string u_annualleave { get; set; }
        public string b_annualleave { get; set; }
        public string sickleave { get; set; }
        public string u_sickleave { get; set; }
        public string b_sickleave { get; set; }
        public string clleave { get; set; }
        public string u_clleave { get; set; }
        public string b_clleave { get; set; }
        public string mlleave { get; set; }
        public string u_mlleave { get; set; }
        public string b_mlleave { get; set; }
    }
    public class displayMobileLeaveDashboardResult
    {
        public string ModelErrors { get; set; }
        public string CommonError { get; set; }
        public bool IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<displayMobileLeaveDashboardModel> ResultObject { get; set; }
    }
    public class displayMobileLeaveDashboardParam
    {
        public string tokenkey { get; set; }
        public string lang { get; set; }
        public string year { get; set; }
        public int empid { get; set; }
        
    }
    public class rptBonusModel
    {
        public string empid { get; set; }
        public string empno { get; set; }
        public string empname1 { get; set; }
        public string empname2 { get; set; }
        public string gendertext { get; set; }
        public string f_basicsalary { get; set; }
        public string ltlthiredate { get; set; }
        public string bonusdate { get; set; }
        public string lengservice { get; set; }
        public string f_bonusamount { get; set; }
        public string bonuspercent { get; set; }
        public string bonusyear { get; set; }
        public string bonustrdate { get; set; }
        public string numonthbonus { get; set; }
        public string bonusenddate { get; set; }
        public string sec { get; set; }
        public string bonusamount { get; set; }

    }
    public class rptBonusResult
    {
        public string ModelErrors { get; set; }
        public string CommonErrors { get; set; }
        public bool IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<rptBonusModel> ResultObject { get; set; }

    }
    public class rptBonusParam
    {
        public string tokenkey { get; set; }
        public string lang { get; set; }
        public string monthlyyear { get; set; }
    }
    public class severanceParam
    {
        public string tokenkey { get; set; }
        public string lang { get; set; }
        public int month { get; set; }
        public int year { get; set; }
    }
    public class severanceResult
    {
        public string ModelError { get; set; }
        public string CommonError { get; set; }
        public int StatusCode { get; set; }
        public bool IsSuccess { get; set; }
        public IEnumerable<severanceModel>ResultObject { get; set; }

    }
    public class severanceModel
    {
        public string severanceID { get; set; }
        public string empID { get; set; }
        public string basicSalary { get; set; }
        public string severanceMonth { get; set; }
        public string severanceYear { get; set; }
        public string severanceDate { get; set; }
        public string ltlHireDate { get; set; }
        public string lengthService { get; set; }
        public string severanceAmount { get; set; }
        public string remark { get; set; }
        public string typeID { get; set; }
        public string status_id { get; set; }
        public string empno { get; set; }
        public string empworkdayid { get; set; }
        public string deptcode { get; set; }
        public string sec { get; set; }
        public string gender { get; set; }
        public string transactionno { get; set; }
        public string ltchiredate { get; set; }
    }

}