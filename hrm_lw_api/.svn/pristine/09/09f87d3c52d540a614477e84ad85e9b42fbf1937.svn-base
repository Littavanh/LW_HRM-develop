using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    #region App_Type ENUM
    public enum AppType
    {
        Attendant = 1,
        Overtime = 2,
        Leave = 3,
        Bonus = 4,
        Allowance = 5,
        SaleIncentive = 6,
        Loan = 7,
        SalaryApprover = 8,
        BudgetAccrues = 9
    }
    #endregion

    public class NewEmpLeaveResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<MyRequestResultViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class MyRequestResultViewModel
    {
        public string RequestID { get; set; }
        public string RequestNo { get; set; }
        public string RequestType { get; set; }
        public string managerName { get; set; }
        public string SubmitDate { get; set; }                       
        public string statusText { get; set; }           
        public string fileName { get; set; }
        public Byte[] attachedFile { get; set; }
    }
     

    public class RequestDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<MyRequestResultViewModel> RequestTitleObject { get; set; }
        public IEnumerable<ApprovedCommentResult> ApprovedObject { get; set; }
        public IEnumerable<RequestItemDetailResultViewModel> RequestItemObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ApprovedCommentResult
    {
        public string approvedName { get; set; }
        public string comment { get; set; }
        public string approvedDate { get; set; }
    }

    public class RequestItemDetailResultViewModel
    {
        public string itemID { get; set; }
        public string itemType { get; set; }      
        public string duration { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string returnDate { get; set; }         
        public string RequestFor { get; set; }            
        public string requestReason { get; set; }
        public string responseName { get; set; }       
    }

    public class MyRequestResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<MyRequestResultViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpRequestResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpRequestResultViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpRequestResultViewModel
    {
        public string requestID { get; set; }
        public string requestNo { get; set; }
        public string requestType { get; set; }
        public string empName { get; set; }
        public string empPosition { get; set; }
        public string dateRequest { get; set; }      
        public string fileName { get; set; }
        public Byte[] attachedFile { get; set; }
        public string statusText { get; set; }
        public string empContact { get; set; }
        public byte[] empPhoto { get; set; }

    }

    public class EmployeeRequestDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpRequestResultViewModel> RequestTitleObject { get; set; }
        public IEnumerable<ApprovedCommentResult> ApprovedObject { get; set; }
        public IEnumerable<EmpRequestResultDetailViewModel> RequestItemObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpRequestResultDetailViewModel
    {
        public string itemID { get; set; }
        public string itemType { get; set; }
        public string duration { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string returnDate { get; set; }
        public string RequestFor { get; set; }
        public string requestReason { get; set; }
        public string responseName { get; set; }
        public string managerName { get; set; }
        public string entryDate { get; set; }
       
    }

    public class DelegatesResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DelegatesResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class DelegatesResultObject
    {
        public string delegatesId { get; set; }
        public string delegatesByName { get; set; }
        public string noted { get; set; }             
        public string startDate { get; set; }
        public string endDate { get; set; }
        public string responseName { get; set; }
        public string entryDate { get; set; }
        public string acceptDate { get; set; }
    }

    public class MyLoansHeaderResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LoanHeaderViewModelResult> ResultObject { get; set; }       
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LoanHeaderViewModelResult
    {
        public int? loanID { get; set; }
        public double? loanAmount { get; set; }
        public double? loanMonthlyFee { get; set; }
        public double? loanAmuntMonth { get; set; }
        public double? loanInterest { get; set; }
        public double? loanPayment { get; set; }
        public double? loanTotalBalance { get; set; }
    }

    public class MyLoansDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LoanDetailViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LoanDetailViewModelResult
    {
        public string paymentDate { get; set; }
        public double? loanInterest { get; set; }
        public double? loanTotalPay { get; set; }
        public double? loanBalance { get; set; }        
    }

    public class InsuranceHeaderResult
    {
        public string ModelErrors { get; set; }
       
        public IEnumerable<InsuranceHeaderViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class InsuranceDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<InsuranceDetailViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class InsuranceHeaderViewModelResult
    {
        public double ?insuranceBalance { get; set; }
        public double ?insuranceLimit { get; set; }
        public double ?insuranceUsed { get; set; }
    }

    public class InsuranceDetailViewModelResult
    {
        public string dateUsing { get; set; }
        public string hotspital { get; set; }
        public string contact { get; set; }
        public double ?amountPay { get; set; }
        public string sentDate { get; set; }
        public string receivedDate { get; set; }
        public string descript { get; set; }
    }

    public class PublicHolidayResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PublicHolidayViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PublicHolidayListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PublicHolidayListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class CompanyListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<CompanyListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class DeptListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DeptListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class UnitParentListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UnitParentListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class UnitListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UnitListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EMPGroupListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EMPGroupListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class CompanyListViewModelResult
    {
        public string companyID { get; set; }
        public string companyCode { get; set; }
        public string companyName1 { get; set; }
        public string companyName2 { get; set; }
        public string companyPhone { get; set; }
        public string companyFax { get; set; }
        public string companyWebsite { get; set; }
        public string companyFaebook { get; set; }
        public string companyLogo { get; set; }

    }

    public class DeptListViewModelResult
    {
        public string deptID { get; set; }
        public string companyCode { get; set; }
        public string deptCode { get; set; }
        public string deptName1 { get; set; }
        public string deptName2 { get; set; }      
    }

    public class EMPGroupListViewModelResult
    {
        public string empGroupID { get; set; }
        public string empGroupCode { get; set; }       
        public string empGroupName1 { get; set; }
        public string empGroupName2 { get; set; }
    }

    public class UnitParentListViewModelResult
    {
        public string unitID { get; set; }
        public string deptID { get; set; }
        public string unitCode { get; set; }     
        public string unitName1 { get; set; }
        public string unitName2 { get; set; }
    }

    public class UnitListViewModelResult
    {
        public string unitID { get; set; }
        public string unitCode { get; set; }
        public string deptCode { get; set; }
        public string parentCode { get; set; }
        public string unitName1 { get; set; }
        public string unitName2 { get; set; }
    }

    public class PublicHolidayViewModelResult
    {
        public string month { get; set; }
        public IEnumerable<EventHolidayViewModelResult> Events { get; set; }        
    }

    public class PublicHolidayListViewModelResult
    {
        public string publicHolidayID { get; set; }
        public string publicHoliday { get; set; }
        public string publicHolidayName1 { get; set; }
        public string publicHolidayName2 { get; set; }

    }

    public class EventHolidayViewModelResult
    {
        public string eventDate { get; set; }
        public string eventNoted { get; set; }
    }


    public class PayslipHeaderResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PayslipHeaderViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PayslipHeaderViewModelResult
    {

        public string slipID { get; set; }
        public string slipNo { get; set; }
        public string slipDate { get; set; }
        public string slipMonthYr { get; set; }
        
    }


    public class PayslipDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PayslipViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PayslipViewModelResult
    {
        public IEnumerable<EarningViewModelResult> earningObject { get; set; }
        public double totalEarning { get; set; }
        public IEnumerable<DeductionViewModelResult> deductionObject { get; set; }
        public double totalDeduction { get; set; }
        public double netSalary  { get; set; }
    }

    public class EarningViewModelResult
    {
        public string earningDescrip { get; set; }
        public Double? earningValues { get; set; }
    }

    public class DeductionViewModelResult
    {
        public string deductionDescrip { get; set; }
        public Double? deductionValues { get; set; }
    }

    public class SendNotiResult
    {
        public string ModelErrors { get; set; }
        // public IEnumerable<TaskListViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class EMPLevelListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EMPEMPLevelListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EMPEMPLevelListViewModelResult
    {
        public string empLevelID { get; set; }
        public string empLevelCode { get; set; }
        public string empLevelName1 { get; set; }
        public string empLevelName2 { get; set; }
    }


    public class EthnicListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EthnicListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EthnicListViewModelResult
    {
        public string ethnicID { get; set; }
        public string ethnicName1 { get; set; }
        public string ethnicName2 { get; set; }
    }



    public class GenderListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<GenderListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class GenderListViewModelResult
    {
        public string genderID { get; set; }
        public string genderText { get; set; }
    }


    public class fstatusListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<fstatusListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class fstatusListViewModelResult
    {
        public string fstatusID { get; set; }
        public string fstatusText { get; set; }
    }



    public class NationalListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<NationalListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class NationalListViewModelResult
    {
        public string nationalityID { get; set; }
        public string nationalityCode { get; set; }
        public string nationalityText { get; set; }
    }


    public class ReligionListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ReligionListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ReligionListViewModelResult
    {
        public string religionID { get; set; }
        public string religionText { get; set; }
    }


    public class BankListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<BankListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class BankListViewModelResult
    {
        public string bankID { get; set; }
        public string BankShortName { get; set; }
        public string BankLongName { get; set; }
    }


    public class LeaveSettingListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LeaveSettingListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LeaveSettingListViewModelResult
    {
        public string leaveSettingID { get; set; }
        public string leaveTypeID { get; set; }
        public string leaveTypeText { get; set; }
        public string amountDay { get; set; }
        public string remark { get; set; }
    }

    public class ApprovalTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ApprovalTypeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ApprovalTypeListViewModelResult
    {
        public string appTypeID { get; set; }
        public string appTypeName { get; set; }
    }

    public class ApprovalSettingListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ApprovalSettingListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<getEmployeeListResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeListByCompanyIdResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<getEmployeeListByCompanyIdResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeDobLis
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeDobListResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeLeaveDetails
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeLeaveDetailResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeOTDetails
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeOTDetailResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeOTDetailsByEmpId
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeOTDetailByEmpIdResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpPaymentRecord
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpPaymentRecordResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PaymentRecordYearmonth
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PaymentRecordYearmonthResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PaymentRecordBank
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PaymentRecordBankResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ReportLeaveSummary
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ReportLeaveSummaryResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpPaySlip
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpPaySlipResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeInfoResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<getEmployeeInfoResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class getEmployeeInfoResult
    {
        public string empID { get; set; }
        public string empNo { get; set; }
        public string empTitleName { get; set; }
        public string firstName1 { get; set; }
        public string lastName1 { get; set; }
        public string nickName1 { get; set; }
        public string firstName2 { get; set; }
        public string lastName2 { get; set; }
        public string nickName2 { get; set; }
        public string genderID { get; set; }
        public string dob { get; set; }
        public string fstatusID { get; set; }
        public string nationalityID { get; set; }
        public string ethnicID { get; set; }
        public string religionID { get; set; }
        public string IDCrad { get; set; }
        public string passport { get; set; }
        public string address1 { get; set; }
        public string district_id1 { get; set; }
        public string ProvID1 { get; set; }
      //  public string address2 { get; set; }
      //  public string district_id2 { get; set; }
        public string empMobile { get; set; }
        public string empEmail { get; set; }
        public string empPhoto { get; set; }
        public string paymentPercent { get; set; }
        public string mgrid { get; set; }
        public string spName { get; set; }
        public string spMobile { get; set; }
        public string spEmail { get; set; }
        public string spAddress { get; set; }
        public string spJob { get; set; }
        public string spJobAddress { get; set; }
        public string workingStatus { get; set; }

        public string emp_position { get; set; }
        public string emp_unitID { get; set; }
        public string emp_companyID { get; set; }
        public string emp_deptID { get; set; }
        public string emp_empLevelID { get; set; }
        public string emp_empGroupID { get; set; }
        public string emp_mgrid { get; set; }
        public string emp_shiftWorkingID { get; set; }
        public string emp_costCenterID { get; set; }
        public string emp_hireDay { get; set; }
        public string emp_AssignmemtLocation { get; set; }
        public string emp_CurrentAddress { get; set; }
        public string emp_empTypeID { get; set; }
        public string emp_TaxTypeID { get; set; }
        public string emp_positionID { get; set; }
        public string empDayID { get; set; }
        public string approveby { get; set; }
    }


    public class getEmployeeListResult
    {
        public string empID { get; set; }
        public string empNo { get; set; }
        public string emp_FullName1 { get; set; }
        public string emp_FullName2 { get; set; }
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
        public string emp_CurrentAddress  { get; set; }
        public string emp_CostCenterCode { get; set; }
        public string emp_CostCenterText { get; set; }
        public string emp_unitID { get; set; }
        public string emp_companyID { get; set; }
        public string emp_deptID { get; set; }
        public string emp_empLevelID { get; set; }
        public string emp_empGroupID { get; set; }
        public string emp_mgrid { get; set; }
        public string emp_shiftWorkingID { get; set; }
        public string emp_costCenterID { get; set; }
        public string emp_workingStatusID { get; set; }
        public string emp_hireDay { get; set; }
        public string approveby { get; set; }
    }

    public class getEmployeeListByCompanyIdResult
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

    public class EmployeeDobListResult
    {
        public string empID { get; set; }
        public string empNo { get; set; }
        public string empEmail { get; set; }
        public string empTitleName { get; set; }
        public string firstname { get; set; }
        public string lastName { get; set; }
        public string genderText { get; set; }
        public string unitName { get; set; }
        public string deptName { get; set; }
        public string empPosition { get; set; }
        public string companyname { get; set; }
        public string dob { get; set; }
        public string ages { get; set; }
    }

    public class EmployeeLeaveDetailResult
    {
        public string leaverequestNo { get; set; }
        public string empNo { get; set; }
        public string firstname { get; set; }
        public string lastName { get; set; }
        public string empPosition { get; set; }
        public string deptName { get; set; }
        public string leavestartdate { get; set; }
        public string leaveenddate { get; set; }
        public string returndate { get; set; }
        public string leaveday { get; set; }
        public string leavetypename { get; set; }
        public string noted { get; set; }
        public string n_startdate { get; set; }
        public string n_enddate { get; set; }
        public string n_returndate { get; set; }
        public string companyID { get; set; }
        public string deptid { get; set; }
        public string textstatus { get; set; }
    }

    public class EmployeeOTDetailResult
    {
        public string empid { get; set; }
        public string empNo { get; set; }
        public string emptitlename { get; set; }
        public string firstname { get; set; }
        public string lastName { get; set; }
        public string unitname { get; set; }
        public string deptName { get; set; }
        public string companyname { get; set; }
        public string normal150 { get; set; }
        public string normal200 { get; set; }
        public string p250 { get; set; }
        public string p300 { get; set; }
        public string p350 { get; set; }
        public string ot150 { get; set; }
        public string ot200 { get; set; }
        public string ot250 { get; set; }
        public string ot300 { get; set; }
        public string ot350 { get; set; }
        public string Total { get; set; }
    }

    public class EmployeeOTDetailByEmpIdResult
    {
        public string empid { get; set; }
        public string otRequestID { get; set; }
        public string otRequestNo { get; set; }
        public string otSettingType { get; set; }
        public string startdate { get; set; }
        public string stdatenoformat { get; set; }
        public string starttime { get; set; }
        public string endtime { get; set; }
        public string qtyHour { get; set; }
        public string otSettingValues { get; set; }
        public string rateCode { get; set; }
        public string noted { get; set; }
        public string otTypeText { get; set; }
        public string createdatetime { get; set; }
    }

    public class EmpPaymentRecordResult
    {
        public string SalaryID { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string empTitleName { get; set; }
        public string empEmail { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string deptCode { get; set; }
        public string deptName { get; set; }
        public string unitName { get; set; }
        public string monthCal { get; set; }
        public string yearCal { get; set; }
        public string empworkingDay { get; set; }
        public string empPosition { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string nStrDate { get; set; }
        public string nEnddate { get; set; }
        public string deductTaxs { get; set; }
        public string deptID { get; set; }
        public string empDayID { get; set; }
        public string empType { get; set; }
        public string grossSalaryBenefits { get; set; }
    }

    public class PaymentRecordYearmonthResult
    {
        public string startate { get; set; }
        public string enddate { get; set; }
        public string yearmonth { get; set; }
    }

    public class PaymentRecordBankResult
    {
        public string bankName { get; set; }
        public string bankAccountName { get; set; }
        public string bankAccountNo { get; set; }
        public string nettopay { get; set; }
        public string sumbcel { get; set; }
        public string sumjdb { get; set; }
        public string sumstbank { get; set; }
        public string sumbfl { get; set; }
        public string sumindochina { get; set; }
        public string SumTotal { get; set; }
        public string remark { get; set; }
    }

    public class ReportLeaveSummaryResult
    {
        public int empid { get; set; }
        public string empno { get; set; }
        public string empname { get; set; }
        public string deptname { get; set; }
        public string leavecarriedforward { get; set; }
        public string CLentitlement { get; set; }
        public string CLbalancelastmonth { get; set; }
        public string CLusedthismonth { get; set; }
        public string CLremain { get; set; }
        public string ALentitlement { get; set; }
        public string ALbalancelastmonth { get; set; }
        public string ALusedthismonth { get; set; }
        public string AEworkingthismonth { get; set; }
        public string AKremain { get; set; }
        public string DILBalance { get; set; }
        public string DILUsed { get; set; }
    }

    public class EmpPaySlipResult
    {
        public string SalaryID{ get; set; }
    public string empID { get; set; }
        public string empNo { get; set; }
        public string empTitleName { get; set; }
        public string empEmail { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string deptCode { get; set; }
        public string deptName { get; set; }
        public string unitName { get; set; }
        public string monthCal { get; set; }
        public string yearCal { get; set; }
        public string empworkingDay { get; set; }
        public string empPosition { get; set; }
        public string empTypeText { get; set; }
        public string basicSalary { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string nStrDate { get; set; }
        public string nEnddate { get; set; }
        public string workingmonth { get; set; }
        public string costCenterCode { get; set; }
        public string costcentertext { get; set; }
        public string shiftincomeA { get; set; }
        public string shiftincomeB { get; set; }
        public string shiftincomeC { get; set; }
        public string OT1 { get; set; }
        public string OT2 { get; set; }
        public string OT3 { get; set; }
        public string OT4 { get; set; }
        public string OT5 { get; set; }
        public string SumOT { get; set; }
        public string leavedays { get; set; }
        public string qyears { get; set; }
        public string sickleavedays { get; set; }
        public string allowance_phone { get; set; }
        public string allowance_fuel { get; set; }
        public string allowance_housing { get; set; }
        public string allowance_car { get; set; }
        public string totalAllowance { get; set; }
        public string TotalTaxpaid { get; set; }
        public string EmployeeSSO { get; set; }
        public string deductFHF { get; set; }
        public string SLDRTFund { get; set; }
        public string severanceBook { get; set; }
        public string grossVariance { get; set; }
        public string Advancebonus { get; set; }
        public string OtherAllowance { get; set; }
        public string NetToPay { get; set; }
        public string annualeavetotal { get; set; }
        public string annualeaveused { get; set; }
        public string annualeavebalance { get; set; }
        public string empDayID { get; set; }
        public string empType { get; set; }
        public string overtimeincome1 { get; set; }
        public string overtimeincome2 { get; set; }
        public string overtimeincome3 { get; set; }
        public string overtimeincome4 { get; set; }
        public string overtimeincome5 { get; set; }
        public string Totalovertimeincome { get; set; }
        public string NetIncome { get; set; }
        public string TotalShiftIncome { get; set; }
        public string ComposulyLeave { get; set; }


    }

    public class ApprovalSettingListViewModelResult
    {
        public string approveID { get; set; }
        public string appLevel { get; set; }
        public string approveTypeID { get; set; }
        public string approveTypeText { get; set; }
        public string deptID { get; set; }
        public string deptName { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
    }

    public class ApprovalSettingParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class NewApprovalSettingParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int approveTypeID { get; set; }
        public int deptID { get; set; }
        public int appLevel { get; set; }
        public int empID { get; set; }
    }

    public class UpdateApprovalSettingParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int approveID { get; set; }
        public int deptID { get; set; }
        public int appLevel { get; set; }
        public int empID { get; set; }
    }

    public class DelApprovalSettingParam
    {
        public int approveID { get; set; }
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class ApprovalTypeListParam
    {
        public string TokenKey { get; set; }
    }

    public class NewApprovalTypeParam
    {
        public string TokenKey { get; set; }
        public string appTypeName { get; set; }
        public string lang { get; set; }
    }

    public class UpdateApprovalTypeParam
    {
        public string TokenKey { get; set; }
        public int appTypeID { get; set; }
        public string appTypeName { get; set; }
        public string lang { get; set; }
    }

    public class DelApprovalTypeParam
    {
        public string TokenKey { get; set; }
        public int appTypeID { get; set; }
        public string lang { get; set; }
    }

    public class EmployeeByDeptParam
    {
        public int DeptID { get; set; }
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class IncomeTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<IncomeTypeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class IncomeTypeListViewModelResult
    {
        public string incomTypeID { get; set; }
        public string incomTypeCode { get; set; }
        public string incomTypeName1 { get; set; }
        public string incomTypeName2 { get; set; }
    }




    public class DeductionTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DeductionTypeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class DeductionTypeListViewModelResult
    {
        public string deductionTypeID { get; set; }
        public string deductionTypeCode { get; set; }
        public string deductionTypeName1 { get; set; }
        public string deductionTypeName2 { get; set; }
    }

    public class AllowanceTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<AllowanceTypeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class AllowanceTypeListViewModelResult
    {
        public string allowanceTypeID { get; set; }
        public string allowanceTypeCode { get; set; }
        public string allowanceTypeName1 { get; set; }
        public string allowanceTypeName2 { get; set; }
    }



    public class TaxsListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<TaxsListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class TaxsListViewModelResult
    {
        public string taxsID { get; set; }
        public string minBase { get; set; }
        public string maxBase { get; set; }
        public string taxsRate { get; set; }        
    }


    public class SSOTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SSOTypeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class SSOTypeListViewModelResult
    {
        public string ssoTypeID { get; set; }
        public string ssoName { get; set; }
    }

    public class SSOListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SSOListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class SSOListViewModelResult
    {
        public string ssoID { get; set; }
        public string ssoTypeID { get; set; }
        public string ssoname { get; set; }
        public string minBase { get; set; }
        public string maxBase { get; set; }
        public string employeeRate { get; set; }
        public string employerRate { get; set; }
    }





    public class ApproveSettingListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ApproveSettingListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class ApproveSettingListViewModelResult
    {
        public string approveID { get; set; }
        public string appLevel { get; set; }
        public string approveDept { get; set; }
        public string deptName { get; set; }
        public string empID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
    }



    public class EmployeeSelListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmployeeSelListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmployeeSelListViewModelResult
    {
        public string empID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
    }

    public class ProvinceListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ProvinceListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ProvinceListViewModelResult
    {
        public string ProID { get; set; }
        public string ProName { get; set; }
    }

    public class DistrictListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DistrictListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpployeeUnderListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpployeeUnderListModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpployeeUnderListModelResult
    {
        public string empID { get; set; }
        public string empName { get; set; }
    }

    public class DistrictListViewModelResult
    {
        public string ProID { get; set; }
        public string ProName { get; set; }
        public string DisID { get; set; }
        public string DisName { get; set; }
    }

    public class EmpAllowanceListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpAllowanceListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpAllowanceListViewModelResult
    {
        public string empAllowanceID { get; set; }
        public string EmpID { get; set; }
        public string EmpName { get; set; }
        public string allowanceTypeID { get; set; }
        public string allowanceTypeName { get; set; }
        public string amount { get; set; }
        public string amount1 { get; set; }
        public string remark { get; set; }
    }

    public class leaveRequestListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<leaveRequestListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class checkleaveRequestListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<checkleaveRequestListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LeaveAdjustListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<listAdjustListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LoanListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LoanListResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PaymentRecordResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LoanListResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LoanListResultObject
    {
        public string loanID { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string empname { get; set; }
        public string amountLoan { get; set; }
        public string loanMonth { get; set; }
        public string requestDate { get; set; }
        public string requestDate2 { get; set; }
        public string loanPercent { get; set; }
        public string totalLoan { get; set; }
        public string loan_incen { get; set; }
        public string monthlyamount { get; set; }
        public string loanStart { get; set; }
        public string loanStart2 { get; set; }
        public string loanEnd { get; set; }
        public string loanEnd2 { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public string payMonth { get; set; }
        public int approverEmpId { get; set; }
        public string payStatus { get; set; }
        public string totalBL { get; set; }
    }


    public class DBOTListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DBOTListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class DBOTListViewModelResult
    {
        public string otdate { get; set; }
        public string starttime { get; set; }
        public string endtime { get; set; }
        public string hourqty { get; set; }
    }

    public class SLDRTLoanListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SLDRTLoanListResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class SLDRTLoanListResultObject
    {
        public string SLDRT_loanID { get; set; }
        public string empID { get; set; }
        public string empno { get; set; }
        public string empname { get; set; }
        public string amountLoan { get; set; }
        public string loanMonth { get; set; }
        public string requestDate { get; set; }
        public string requestDate2 { get; set; }
        public string loanPercent { get; set; }
        public string totalLoan { get; set; }
        public string loan_incen { get; set; }
        public string monthlyamount { get; set; }
        public string loanStart { get; set; }
        public string loanStart2 { get; set; }
        public string loanEnd { get; set; }
        public string loanEnd2 { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public string payMonth { get; set; }
        public int approverEmpId { get; set; }
        public string payStatus { get; set; }
        public string totalBL { get; set; }
    }

    public class LoanDetailListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LoanDetailListResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LoanDetailListResultObject
    {
        public string loanDetailID { get; set; }
        public string empno { get; set; }
        public string empname { get; set; }
        public string section { get; set; }
        public string monthBL { get; set; }
        public string acc_balance { get; set; }
        public string acc_balance2 { get; set; }
        public string monthlyPay { get; set; }
        public string monthlyPay2 { get; set; }
        public string loan_incen { get; set; }
        public string loan_incen2 { get; set; }
        public string pay_amount { get; set; }
        public string pay_amount2 { get; set; }
        public string totalBL { get; set; }
        public string totalBL2 { get; set; }
        public string paidStatus { get; set; }
        public string payMonth { get; set; }
        public string payDate { get; set; }
    }

    public class SLDRTLoanDetailListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SLDRTLoanDetailListResultObject> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class SLDRTLoanDetailListResultObject
    {
        public string loanDetailID { get; set; }
        public string empno { get; set; }
        public string empname { get; set; }
        public string section { get; set; }
        public string monthBL { get; set; }
        public string acc_balance { get; set; }
        public string acc_balance2 { get; set; }
        public string monthlyPay { get; set; }
        public string monthlyPay2 { get; set; }
        public string loan_incen { get; set; }
        public string loan_incen2 { get; set; }
        public string pay_amount { get; set; }
        public string pay_amount2 { get; set; }
        public string totalBL { get; set; }
        public string totalBL2 { get; set; }
        public string paidStatus { get; set; }
        public string payDate { get; set; }
        public string payMonth { get; set; }
    }

    public class NewLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public float amountLoan { get; set; }
        public int loanMonth { get; set; }
        public DateTime requestDate { get; set; }
        public float loanPercent { get; set; }
        public float totalLoan { get; set; }
        public DateTime loanStart { get; set; }
        public DateTime loanEnd { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public float payMonth { get; set; }
        public float loan_incen { get; set; }
    }

    public class NewSLDRTLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public float amountLoan { get; set; }
        public int loanMonth { get; set; }
        public DateTime requestDate { get; set; }
        public float loanPercent { get; set; }
        public float totalLoan { get; set; }
        public DateTime loanStart { get; set; }
        public DateTime loanEnd { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public float payMonth { get; set; }
        public float loan_incen { get; set; }
    }

    public class UpdateLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public float amountLoan { get; set; }
        public int loanMonth { get; set; }
        public DateTime requestDate { get; set; }
        public float loanPercent { get; set; }
        public float totalLoan { get; set; }
        public DateTime loanStart { get; set; }
        public DateTime loanEnd { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public float payMonth { get; set; }
        public float loan_incen { get; set; }
        public int loanID { get; set; }
    }

    public class DelLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int loanID { get; set; }
        public string noted { get; set; }
    }

    public class DelSLDRTLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int sldrtloanid { get; set; }
    }

    public class RejectSLDRTLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int sldrtloanid { get; set; }
        public string noted { get; set; }
    }
    public class UpdateSLDRTLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int SLDRT_loanID { get; set; }
        public float amountLoan { get; set; }
        public int loanMonth { get; set; }
        public float loanPercent { get; set; }
        public float totalLoan { get; set; }
        public DateTime loanStart { get; set; }
        public DateTime loanEnd { get; set; }
        public string LoanReason { get; set; }
        public string loanFile { get; set; }
        public float payMonth { get; set; }
        public float loan_incen { get; set; }
    }

    public class ApproveLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int loanID { get; set; }
        public string noted { get; set; }
    }

    public class ApprovePaymentRecordParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string transactionNo { get; set; }
        public string noted { get; set; }
    }

    public class ApproveSLDRTLoanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int SLDRT_loanID { get; set; }
        public string noted { get; set; }
    }

    public class checkleaveRequestListViewModelResult
    {
        public string leavetypeid { get; set; }
        public string leavetypename { get; set; }
        public string leaveadd { get; set; }
        public string leaveuse { get; set; }
        public string leavebalance { get; set; }
    }

    public class listAdjustListViewModelResult
    {
        public string empid { get; set; }
        public string empno { get; set; }
        public string empname { get; set; }
        public string empposition { get; set; }
        public string empdept { get; set; }
        public string empcom { get; set; }
        public string leaveSL { get; set; }
        public string leaveSLAdd { get; set; }
        public string leaveSLUsed { get; set; }
        public string leaveSLBalance { get; set; }
        public string leaveAL { get; set; }
        public string leaveALAdd { get; set; }
        public string leaveALUsed { get; set; }
        public string leaveALBalance { get; set; }
        public string leaveCL { get; set; }
        public string leaveCLAdd { get; set; }
        public string leaveCLUsed { get; set; }
        public string leaveCLBalance { get; set; }
    }

    public class leaveRequestListViewModelResult
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
        public string approveDate { get; set; }
    }

    public class NewleaveRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string leaveRequestNo { get; set; }
        public int empID { get; set; }
        public int leaveTypeID { get; set; }
        public string leaveDay { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public string returnDate { get; set; }
        public float amountDay { get; set; }
        public string noted { get; set; }
        public int delegateEmpID { get; set; }
        public string fileAttached { get; set; }
        //public int? managerID { get; set; }
        public int transactionTypeID { get; set; }
        public string expDate { get; set; }
        public string referAdd { get; set; }
        public string fileType { get; set; }
        public int from_device { get; set; }
        public Boolean leavemorning { get; set; }
        public Boolean leaveafternoon { get; set; }
    }

    public class UpdateleaveRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int? leaveRequestID { get; set; }
        public string leaveRequestNo { get; set; }
        public int? empID { get; set; }
        public int? leaveTypeID { get; set; }
        public string leaveDay { get; set; }
        public DateTime? startDate { get; set; }
        public DateTime? endDate { get; set; }
        public DateTime? returnDate { get; set; }
        public int? amountDay { get; set; }
        public string noted { get; set; }
        public int? delegateEmpID { get; set; }
        public string fileAttached { get; set; }
        public int? managerID { get; set; }
        public int? transactionTypeID { get; set; }
        public DateTime? expDate { get; set; }
        public string referAdd { get; set; }
    }

    public class DelleaveRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int leaveRequestID { get; set; }
    }

    public class ApproveRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int RequestID { get; set; }
        public string noted { get; set; }
        public int deptID { get; set; }
        public int approveTypeID { get; set; }
        public int isApprove { get; set; }
       

    }

    public class ApproveOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int otRequestID { get; set; }
        public string noted { get; set; }
        public int deptID { get; set; }
    }

    public class ApprovalSettinResult
    {
        public int finalLevelID { get; set; }
        public int empID { get; set; }
    }

    public class EmpBankAccountListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpBankAccountListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpBankAccountListViewModelResult
    {
        public string empBankAccountID { get; set; }
        public string bankName { get; set; }
        public string empName { get; set; }
        public string bankAccountName { get; set; }
        public string bankAccountNo { get; set; }
    }

    public class EmpBankAccountListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }

    public class NewEmpBankAccountParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int bankID { get; set; }
        public int empID { get; set; }
        public string bankAccountName { get; set; }
        public string bankAccountNo { get; set; }
    }

    public class UpdateEmpBankAccountParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empBankAccountID { get; set; }
        public int bankID { get; set; }
        public int empID { get; set; }
        public string bankAccountName { get; set; }
        public string bankAccountNo { get; set; }
    }

    public class DelEmpBankAccountParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empBankAccountID { get; set; }
    }

    public class EmpDeductionListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }

    public class NewEmpDeductionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int deductionTypeID { get; set; }
        public double amount { get; set; }
        public bool taxsCal { get; set; }
        public string remark { get; set; }
    }
    public class UpdateEmpDeductionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int empDeductionID { get; set; }
        public int deductionTypeID { get; set; }
        public double amount { get; set; }
        public bool taxsCal { get; set; }
        public string remark { get; set; }
    }

    public class DelEmpDeductionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }      
        public int empDeductionID { get; set; }       
    }

    public class EmpDeductionListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpDeductionListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpDeductionListViewModelResult
    {
        public string empDeduction { get; set; }
        public string empName { get; set; }
        public string deductionTypeID { get; set; }
        public string deductionTypeName { get; set; }
        public string amount { get; set; }
        public string amount1 { get; set; }
        public string taxsCal { get; set; }
        public string remark { get; set; }
    }

    public class EmpEducationListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpEducationListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpEducationListViewModelResult
    {
        public string empEducationID { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
        public string educationTypeName { get; set; }
        public string educationLeveText { get; set; }
        public string schoolName { get; set; }
        public string levelReceive { get; set; }
        public string acdamyYear { get; set; }
        public string remark { get; set; }
    }
    public class EmpEducationListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }

    public class NewEmpEducationParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int educationTypeID { get; set; }
        public string educationLeveText { get; set; }
        public string schoolName { get; set; }
        public string levelReceive { get; set; }
        public string acdamyYear { get; set; }
        public string remark { get; set; }
    }

    public class UpdateEmpEducationParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empEducationID { get; set; }
        public string educationLeveText { get; set; }
        public int empID { get; set; }
        public int educationTypeID { get; set; }
        public string schoolName { get; set; }
        public string levelReceive { get; set; }
        public string acdamyYear { get; set; }
        public string remark { get; set; }
    }
    public class DelEmpEducationParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empEducationID { get; set; }
    }

    public class EmpFamilyListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpFamilyListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class EmpFamilyListViewModelResult
    {
        public string empFamilyID { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
        public string empFamilyRelationships { get; set; }
        public string empFamilyFullName { get; set; }
        public string empFamilyJob { get; set; }
        public string empFamilyJobAddr { get; set; }
        public string empFamilyAddr { get; set; }
        public string empFamilyTel { get; set; }
        public string empFamilyEmail { get; set; }
    }

 
    public class NewEmpFamilyParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }      
        public string empFamilyRelationships { get; set; }
        public string empFamilyFullName { get; set; }
        public string empFamilyJob { get; set; }
        public string empFamilyJobAddr { get; set; }
        public string empFamilyAddr { get; set; }
        public string empFamilyTel { get; set; }
        public string empFamilyEmail { get; set; }
    }
    public class UpdateEmpFamilyParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empFamilyID { get; set; }
        public int empID { get; set; }
        public string empName { get; set; }
        public string empFamilyRelationships { get; set; }
        public string empFamilyFullName { get; set; }
        public string empFamilyJob { get; set; }
        public string empFamilyJobAddr { get; set; }
        public string empFamilyAddr { get; set; }
        public string empFamilyTel { get; set; }
        public string empFamilyEmail { get; set; }
    }
    public class DelEmpFamilyParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empFamilyID { get; set; }
    }



    public class EmpSSOListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpSSOListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class EmpSSOListViewModelResult
    {
        public string empSSOID { get; set; }
        public string empID { get; set; }
        public string ssoID { get; set; }
        public string ssoTypeName { get; set; }
        public string SSOValue { get; set; }
        public string SSOValue1 { get; set; }
        public string startDate { get; set; }
        public string startDate1 { get; set; }
        public string remark { get; set; }
        public string ssonnumber { get; set; }
    }


    public class NewEmpSSOParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int ssoID { get; set; }
        public float? SSOValue { get; set; }
        public string startDate { get; set; }
        public string remark { get; set; }       
        public string ssonumber { get; set; }
    }
    public class UpdateEmpSSOParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empSSOID { get; set; }
        public int empID { get; set; }
        public int ssoID { get; set; }
        public float SSOValue { get; set; }
        public DateTime startDate { get; set; }
        public string remark { get; set; }
        public string ssonumber { get; set; }
    }
    public class DelEmpSSOParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empSSOID { get; set; }
    }




    public class EmpGroupListtResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpGroupListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpGroupListViewModelResult
    {
        public string empGroupID { get; set; }
        public string empGroupCode { get; set; }
        public string empGroupName1 { get; set; }
        public string empGroupName2 { get; set; }
    }



    public class NewEmpGroupParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string empGroupCode { get; set; }
        public string empGroupName1 { get; set; }
        public string empGroupName2 { get; set; }
    }
    public class UpdateEmpGroupParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empGroupID { get; set; }
        public string empGroupCode { get; set; }
        public string empGroupName1 { get; set; }
        public string empGroupName2 { get; set; }
    }
    public class DelEmpGroupParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empGroupID { get; set; }
    }

    public class EmpIncomeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpIncomeListResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpIncomeListResultViewModelResult
    {
        public string empIncomeID { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
        public string incomTypeID { get; set; }
        public string incomTypeName { get; set; }
        public string amount { get; set; }
        public string amount1 { get; set; }
        public string remark { get; set; }
    }
    public class EmpIncomeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }

    public class NewEmpIncomeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int incomTypeID { get; set; }
        public double amount { get; set; }
        public string remark { get; set; }
    }
    public class UpdateEmpIncomeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empIncomeID { get; set; }
        public int empID { get; set; }
        public int incomTypeID { get; set; }
        public double amount { get; set; }
        public string remark { get; set; }
    }

    public class DelEmpIncomeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empIncomeID { get; set; }
    }

    public class EmpInfoListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpInfoListResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpInfoListResultViewModelResult
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string empInfoID { get; set; }
        public string empPosition { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
        public string UnitName { get; set; }
        public string empLevelName { get; set; }
        public string hireDay { get; set; }
        public string empGroupName { get; set; }
        public string shiftWorking { get; set; }
        public string costCenter { get; set; }
        public string assignmentLocation { get; set; }
        public string currentAddress { get; set; }
        public string mgrid { get; set; }
    }
    //

    public class UploadFingerResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UploadFingerResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class UploadFingerSUMResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UploadFingerSUMResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class UploadFingerResultViewModelResult
    {
        public string workingDayID { get; set; }
        public string transactionNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string fullName { get; set; }
        public string statusText { get; set; }
        public string workDay { get; set; }
        public string workdayName { get; set; }
        public string shift1_timeIn { get; set; }
        public string shift1_timeOut { get; set; }
        public string shift1_wd { get; set; }
        public string shift2_timeIn { get; set; }
        public string shift2_timeOut { get; set; }
        public string shift2_wd { get; set; }
        public string shift3_timeIn { get; set; }
        public string shift3_timeOut { get; set; }
        public string shift3_wd { get; set; }
        public string total_wd { get; set; }
        public string total_h{ get; set; }
        public string total_oth { get; set; }
    }


    public class UploadFingerSUMResultViewModelResult
    {
        public string workingDayID { get; set; }
        public string transactionNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string fullName { get; set; }        
        public string workDay { get; set; }      
        public string shift1_wd { get; set; }
        public string shift2_wd { get; set; }
        public string shift3_wd { get; set; }
        public string actual_wd { get; set; }
        public string wd_in_month { get; set; }
        public string remark { get; set; }
        public string cost_center { get; set; }
        public string al { get; set; }
        public string sl { get; set; }
        public string cl { get; set; }
        public string dil { get; set; }
        public string ml { get; set; }
        public string pl { get; set; }
        public string otherl { get; set; }
        public string lwp { get; set; }
        public string publicHoliday { get; set; }
        public string wh { get; set; }
        public string wf { get; set; }
        public string dayOff { get; set; }
    }








    public class ProcessStatusResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ProcessStatusResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class ProcessStatusResultViewModelResult
    {
        public string ProcessStatus { get; set; }
        public string ProcessStatusText { get; set; }
    }


 
    public class EmpInfoListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }
    public class NewEmpInfoParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string empPosition { get; set; }
        public int empID { get; set; }
        public int UnitID { get; set; }
        public int empLevelID { get; set; }
        public DateTime hireDay { get; set; }
        public int empGroupID { get; set; }
        public int shiftWorkingID { get; set; }
        public int costCenterID { get; set; }
        public string assignmentLocation { get; set; }
        public string currentAddress { get; set; }
        public int mgrid { get; set; }
        public int workingStatusID { get; set; }
        public int empTypeID { get; set; }     
        public int empTaxTypeID { get; set; }
        public int empPositionTitleID { get; set; }
        public int approveby { get; set; }
    }

    public class UpdateEmpInfoParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empInfoID { get; set; }
        public string empPosition { get; set; }
        public int empID { get; set; }
        public int UnitID { get; set; }
        public int empLevelID { get; set; }
        public DateTime hireDay { get; set; }
        public int empGroupID { get; set; }
        public int shiftWorkingID { get; set; }
        public int costCenterID { get; set; }
        public string assignmentLocation { get; set; }
        public string currentAddress { get; set; }
        public int mgrid { get; set; }
        public int workingStatusID { get; set; }
        public int empTypeID { get; set; }
        public int empTaxTypeID { get; set; }
        public int empPositionTitleID { get; set; }
        public int approveby { get; set; }
    }

    public class DelEmpInfoParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empInfoID { get; set; }
    }


    public class UploadFingerScanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string transactionNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string workday { get; set; }
        public string fullName { get; set; }
        public string wdName { get; set; }
        public string statusText { get; set; }
        public string shift1_timeIn { get; set; }
        public string shift1_timOut { get; set; }
        public string shift1_wd { get; set; }
        public string shift2_timeIn { get; set; }
        public string shift2_timOut { get; set; }
        public string shift2_wd { get; set; }
        public string total_wd { get; set; }
        public string total_wh { get; set; }
        public string total_oth { get; set; }
        public string noted { get; set; }
    }

    public class UploadFingerScanSUMParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string transactionNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string workday { get; set; }
        public string fullName { get; set; }
        public string cost_center { get; set; }            
        public string shift1_wd { get; set; }       
        public string shift2_wd { get; set; }
        public string shift3_wd { get; set; }
        public string actual_wd { get; set; }
        public string wd_in_month { get; set; }
        public string noted { get; set; }
    }

    public class SaveUploadFingerScanParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int UserID { get; set; }

    }


    public class EmpLevelListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpLevelListResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class EmpLevelListResultViewModelResult
    {
        public string empLevelID { get; set; }
        public string empLevelCode { get; set; }
        public string empLevelName1 { get; set; }
        public string empLevelName2 { get; set; }
        public string levelsigndays { get; set; }
    }

    public class EmpLevelListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class NewEmpLevelParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string empLevelCode { get; set; }
        public string empLevelName1 { get; set; }
        public string empLevelName2 { get; set; }
        public int levelsignsday { get; set; }
    }

    public class UpdateEmpLevelParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empLevelID { get; set; }
        public string empLevelCode { get; set; }
        public string empLevelName1 { get; set; }
        public string empLevelName2 { get; set; }
        public int Levelsigndays { get; set; }
    }

    public class DelEmpLevelParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empLevelID { get; set; }
    }


    public class EmpSalaryListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpSalaryListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpSalaryListResulttViewModelResult
    {
        public string salaryID { get; set; }
        public string empName { get; set; }
        public string paymentPercent { get; set; }
        public string empBankAccountName { get; set; }
    }
    public class EmpSalaryListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
    }

    public class NewEmpSalaryParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public double paymentPercent { get; set; }
        public int empBankAccountID { get; set; }
    }
    public class UpdateEmpSalaryParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int salaryID { get; set; }
        public int empID { get; set; }
        public double paymentPercent { get; set; }
        public int empBankAccountID { get; set; }
    }

    public class DelEmpSalaryParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int salaryID { get; set; }
    }


    public class OTRequestListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<OTRequestListResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class OTRequestListResultViewModelResult
    {
        public string otRequestID { get; set; }
        public string otRequestNo { get; set; }
        public string empName { get; set; }
        public string otTypeName { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public string otStartTime { get; set; }
        public string otEndTime { get; set; }
        public string noted { get; set; }
        public string managerNoted { get; set; }
        public string fileAttached { get; set; }
        public string managerName { get; set; }
        public string qtyHour { get; set; }
        public string status { get; set; }
        public string historyCount { get; set; }
        public int? managerEmpID { get; set; }
        public int? delegateID { get; set; }
        public int? approveUserID { get; set; }

        //public List<OTTimeDetails> OTTimeDetail { get; set; }
    }

    public class OTTimeDetails
    {
        public string otStartTime { get; set; }
        public string otEndTime { get; set; }
        public string qtyHour { get; set; }
    }

    public class OTRequestListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
        public int status { get; set; }

    }

    public class OTRequestApproveListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int managerID { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
        public int status { get; set; }

    }

    public class ConfirmDataOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }

    }

    public class NewOTRequestMobileParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int otTypeID { get; set; }
        public DateTime startDate { get; set; }
        public string endDate { get; set; }
        public string otStartTime { get; set; }
        public string otEndTime { get; set; }
        public string noted { get; set; }
        public string fileAttached { get; set; }
        public int managerID { get; set; }
    }

    public class NewOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int otTypeID { get; set; }
        public DateTime startDate { get; set; }
        public DateTime endDate { get; set; }
        public DateTime otStartTime { get; set; }
        public DateTime otEndTime { get; set; }
        public string noted { get; set; }
        public string fileAttached { get; set; }
        public int managerID { get; set; }
    }

    public class ConfirmOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        //test
    }

    public class UpdateOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int otRequestID { get; set; }
        public int empID { get; set; }
        public int startDate { get; set; }
        public int endDate { get; set; }
        public int otStartTime { get; set; }
        public int otEndTime { get; set; }
        public int noted { get; set; }
        public int fileAttached { get; set; }
    }

    public class DelOTRequestParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int otRequestID { get; set; }
    }


    public class EducationTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EducationTypeListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EducationTypeListResulttViewModelResult
    {
        public string educationTypeID { get; set; }
        public string educationTypeCode { get; set; }
        public string educationTypeName1 { get; set; }
        public string educationTypeName2 { get; set; }
    }

    public class RoleListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<RoletViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class RoletViewModelResult
    {
        public string roleID { get; set; }
        public string roleName { get; set; }
    }

    public class PermissionListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PermissiontViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PermissiontViewModelResult
    {
        public string permissionID { get; set; }
        public string permissionName { get; set; }
        public string langName { get; set; }
    }


    public class UserListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UserViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class UserViewModelResult
    {
        public string userID { get; set; }
        public string username { get; set; }
        public string empid { get; set; }
        public string empname { get; set; }        
        public string roleid { get; set; }
        public string rolename { get; set; }
        public string expiredate { get; set; }
        public string expiredate2 { get; set; }
        public string empNo { get; set; }
        public string empPosition { get; set; }
    }

    public class PRMonthListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PRMonthModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PRMonthModelResult
    {
        public string monthid { get; set; }
        public string monthname { get; set; }
    }

    public class PRYearListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PRYearModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PRYearModelResult
    {
        public string yearid { get; set; }
        public string yearname { get; set; }
    }

    public class PRBankListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PRBankModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PRBankModelResult
    {
        public string bankid { get; set; }
        public string bankname { get; set; }
    }

    public class PRCostCenterListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PRCostCenterModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PRCostCenterModelResult
    {
        public string costcentercode { get; set; }
        public string costcentername { get; set; }
    }

    public class PaymentRecordListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PaymentRecordModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PaymentRecordModelResult
    {
        public string deptname { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string advanceBonus { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string grossIncome { get; set; }
        public string deductFHFdeductOther { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string netToPayMaster { get; set; }
        public string variance { get; set; }
        public string remark { get; set; }
        public string costCenterCode { get; set; }
        public IEnumerable<PaymentRecordDetailModelResult> prdetail { get; set; }
    }

    public class PaymentRecordDetailsResult
    {
        public string empno { get; set; }
        public string deptname { get; set; }
        public string unitname { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string advanceBonus { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string grossIncome { get; set; }
        public string deductFHFdeductOther { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string netToPayMaster { get; set; }
        public string variance { get; set; }
        public string remark { get; set; }
        public string costCenterCode { get; set; }
        public string costcentername { get; set; }
    }

    public class SalaryListModelResult
    {
        public string salaryID { get; set; }
        public string transactionNo { get; set; }
        public string generateDate { get; set; }
        public string salaryDate { get; set; }     
        public string staffName { get; set; }
        public string approveDate { get; set; }
        public string approveName { get; set; }
        public string noted { get; set; }
        public string statusText { get; set; }
        public string yearView { get; set; }
        public string monthView { get; set; }
        public string status_id { get; set; }
        public string processStatus { get; set; }
        public string workingDay { get; set; }
        public string additionalPayment { get; set; }
        public string saleIncentive { get; set; }
        public string bonus { get; set; }
        public string deductFHF { get; set; }
        public string deductOther { get; set; }
        public string personalLoan { get; set; }
        public string SLDRT { get; set; }
        public string approveFinger { get; set; }
        public string cycleRun { get; set; }
        public string reportPrint { get; set; }
        public string reportGen { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }

    }

    public class PaymentRecordDetailModelResult
    {
        public string costcentercode { get; set; }
        public string costcentername { get; set; }
        public string deptcode { get; set; }
        public string deptname { get; set; }
        public string unitname { get; set; }
        public string empno { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string advanceBonus { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string grossIncome { get; set; }
        public string deductFHFdeductOther { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string netToPayMaster { get; set; }
        public string variance { get; set; }
        public string remark { get; set; }
    }
    public class PaymentRecordDetailListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PaymentRecordModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class PaymentRecordDetailsListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<PaymentRecordDetailsResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class SalaryListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SalaryListModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }



    public class UserEmployeeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<UserEmployeeListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class UserEmployeeListViewModelResult
    {
        public string empid { get; set; }
        public string empname { get; set; }
    }
 

    public class RolPermissionListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<RolPermissionListModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class RolPermissionListModelResult
    {
        public string roleId { get; set; }
        public string app_permissionId { get; set; }
        public string app_permissionName { get; set; }
        public string app_view { get; set; }
        public string app_add { get; set; }
        public string app_edit { get; set; }
        public string app_del { get; set; }
        public string app_action { get; set; }
    }

    public class GetRolPermissionListResult
    {
        public string ModelErrors { get; set; }
        public GetRolPermissionListModelResult ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class GetRolPermissionListModelResult
    {
        public string app_view { get; set; }
        public string app_add { get; set; }
        public string app_edit { get; set; }
        public string app_del { get; set; }
        public string app_action { get; set; }
    }

    public class NewRolePermissionListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int? roleId { get; set; }
        public int? app_permissionId { get; set; }
        public string appname { get; set; } //view, add, edit, del & action
        public int? appvalue { get; set; } // 0 or 1
    }

    public class NewRolePermissionListModelResult
    {
        public int? roleId { get; set; }
        public int? app_permissionId { get; set; }
        public int? app_view { get; set; }
        public int? app_add { get; set; }
        public int? app_edit { get; set; }
        public int? app_del { get; set; }
        public int? app_action { get; set; }
    }

    public class EducationTypeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class NewEducationTypeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string educationTypeCode { get; set; }
        public string educationTypeName1 { get; set; }
        public string educationTypeName2 { get; set; }
    }

    public class RoleListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class LoanListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int empid { get; set; }
    }

    public class SLDRTLoanListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class LoanDetailListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int loanID { get; set; }
    }

    public class LoanPaymentParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int loandetailid { get; set; }
        public double? pay_amount { get; set; }
    }

    public class SLDRTLoanPaymentParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int sldrtloandetailid { get; set; }
        public double? pay_amount { get; set; }
    }

    public class SLDRTLoanDetailListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int SLDRT_loanID { get; set; }
    }

    public class PermissionListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class UserListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        //public int roleid { get; set; }
    }

    public class PRMonthListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class PRYearListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class PRBankListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class PRCostCenterListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class PaymentRecordListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int month { get; set; }
        public int year { get; set; }
        public string bankname { get; set; }
        public string costcentercode { get; set; }
    }

    public class PaymentRecordDetailListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string costcentercode { get; set; }
        public int monthView { get; set; }
        public int yearView { get; set; }
    }




    public class UserEmployeeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        //public int roleid { get; set; }
    }

    public class RolePermissionListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int roleID { get; set; }
    }

    public class GetRolePermissionListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int app_permissionId { get; set; }
    }

    public class NewRoleParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string roleName { get; set; }
    }

    public class UpdateRoleParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int roleID { get; set; }
        public string roleName { get; set; }
    }

    public class DelRoleParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int roleID { get; set; }
    }

    public class DelPermissionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int permissionID { get; set; }
    }

    public class NewPermissionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string permissionName { get; set; }
    }

    public class NewUserParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string username { get; set; }
        public int empID { get; set; }
        public int roleID { get; set; }
        public DateTime expDate { get; set; }

    }

    public class UpdateUserParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int userID { get; set; }
        public string username { get; set; }
        public int roleID { get; set; }
        public DateTime expDate { get; set; }
    }

    public class ResetUserPwdParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int userID { get; set; }
    }


    public class ChangePwdParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }      
        public string currentPWD { get; set; }
        public string newPass { get; set; }
    }



    public class DelUserParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int userID { get; set; }
    }

    public class UpdatePermissionParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int permissionID { get; set; }
        public string PermissionName { get; set; }
    }

    public class UpdateEducationTypeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int educationTypeID { get; set; }
        public string educationTypeCode { get; set; }
        public string educationTypeName1 { get; set; }
        public string educationTypeName2 { get; set; }
    }

    public class DelEducationTypeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int educationTypeID { get; set; }
    }

    public class LeaveTranTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LeaveTranTypeListResultViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class LeaveTranTypeListResultViewModelResult
    {
        public string transactionTypeID { get; set; }
        public string transactionTypeText { get; set; }
    }
    public class LeaveTranTypeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }

    public class NewLeaveTranTypeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string transactionTypeText { get; set; }
    }

    public class UpdateLeaveTranTypeListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int transactionTypeID { get; set; }
        public string transactionTypeText { get; set; }
    }

    public class DelLeaveTranTypeParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int transactionTypeID { get; set; }
    }

    public class CostCenterListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<CostCenterListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class CostCenterListResulttViewModelResult
    {
        public string costCenterID { get; set; }
        public string costCenterCode { get; set; }
        public string costCenterText { get; set; }
    }

    public class WorkStatusListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<WorkStatusListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class WorkStatusListResulttViewModelResult
    {
        public string workingStatusID { get; set; }
        public string workingStatusText { get; set; }
    }


    public class ShiftWorkListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ShiftWorkListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ShiftWorkListResulttViewModelResult
    {
        public string shiftWorkingID { get; set; }
        public string shiftName { get; set; }
        public string mo { get; set; }
        public string mo_timeIn { get; set; }
        public string mo_timeOut { get; set; }
        public string tu { get; set; }
        public string tu_timeIn { get; set; }
        public string tu_timeOut { get; set; }
        public string we { get; set; }
        public string we_timeIn { get; set; }
        public string we_timeOut { get; set; }
        public string th { get; set; }
        public string th_timeIn { get; set; }
        public string th_timeOut { get; set; }
        public string fr { get; set; }
        public string fr_timeIn { get; set; }
        public string fr_timeOut { get; set; }
        public string sa { get; set; }
        public string sa_timeIn { get; set; }
        public string sa_timeOut { get; set; }
        public string su { get; set; }
        public string su_timeIn { get; set; }
        public string su_timeOut { get; set; }
        public string dayAverage { get; set; }
    }



    public class EMPTypeListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EMPTypeListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EMPTypeListResulttViewModelResult
    {
        public string empTypeID { get; set; }
        public string empTypeText { get; set; }       
    }


    public class DelagateListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<DelagateListResulttViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class DelagateListResulttViewModelResult
    {
        public string delegateID { get; set; }
        public string empID { get; set; }
        public string empName { get; set; }
        public string delegateEmpID { get; set; }
        public string delegateEmpName { get; set; }
        public string noted { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string reCallDate { get; set; }
        public string strDate2 { get; set; }
        public string endDate2 { get; set; }
        public string reCallDate2 { get; set; }
        public string status { get; set; }
        public string delegateNoted { get; set; }
    }

    public class MonthsListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<MonthsViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class MonthsViewModelResult
    {
        public string monthid { get; set; }
        public string monthname { get; set; }
    }


    public class DelagateListParam
    {
        public string tokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
        public int status { get; set; }
    }

    public class MonthsListParam
    {
        public string tokenKey { get; set; }
        public string lang { get; set; }
    }

    public class DelagateApproverListParam
    {
        public string tokenKey { get; set; }
        public string lang { get; set; }
        public int delegateEmpID { get; set; }
        public DateTime stdate { get; set; }
        public DateTime enddate { get; set; }
        public int status { get; set; }
    }

    public class NewDelagateParam
    {
        public string tokenKey { get; set; }
        public string lang { get; set; }
        public int empID { get; set; }
        public int delegateEmpID { get; set; }
        public string noted { get; set; }
        public string strDate { get; set; }
        public string endDate { get; set; }
        public string reCallDate { get; set; }
    }

    public class UpdateDelegateParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int delegateID { get; set; }
        public int empID { get; set; }
        public int delegateEmpID { get; set; }
        public string noted { get; set; }
        public DateTime strDate { get; set; }
        public DateTime endDate { get; set; }
        public DateTime reCallDate { get; set; }
    }

    public class ReCallDelegateParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int delegateID { get; set; }
        public string noted { get; set; }
    }

    public class ReCallDelegate_rq_Param
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }      
    }

    public class DelDelegateParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int delegateID { get; set; }
    }

    public class UnApproveDelegateParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int delegateID { get; set; }
        public string delegateNoted { get; set; }
    }

    public class ApproveDelegateParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int delegateID { get; set; }
        public string delegateNoted { get; set; }
    }


    public class GetEmpByDeptIDResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<GetEmpByDeptIDtViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class GetEmpByDeptIDtViewModelResult
    {
        public string empID { get; set; }
        public string empName { get; set; }
        public string delegatetype { get; set; } // 1 never delegate, 2 ever delegate
    }
    public class EmpByDeptIDParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int DeptID { get; set; }
    }

    public class GetEmpByMgrResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<GetEmpByMgrViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class GetEmpByMgrViewModelResult
    {
        public string empID { get; set; }
        public string empFullName { get; set; }
    }



    public class CheckWorkingDayListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<CheckWorkingDayViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }



    public class ApproveRequestHistoryResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ApproveRequestHistoryViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class ApproveRequestHistoryViewModelResult
    {
        public string approverName { get; set; }
        public string noted { get; set; }
        public string approveDateTime { get; set; }
    }

    public class ApproveLaonHistoryResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ApproveLoanHistoryViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class ApproveLoanHistoryViewModelResult
    {
        public string approverName { get; set; }
        public string noted { get; set; }
        public string approveDateTime { get; set; }
    }

    public class ApproveRequestHistoryParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int RequestID { get; set; }
    }

    public class ApproveLoanHistoryParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public int loanID { get; set; }
    }

    public class CheckWorkingDayViewModelResult
    {
        public string tmp_id { get; set; }
        public string transactionNo { get; set; }
        public string empID { get; set; }
        public string empNo { get; set; }
        public string fullNameLA { get; set; }
        public string fullNameEN { get; set; }
        public string workDay { get; set; }
        public string workMonth { get; set; }
        public string workYear { get; set; }
        public string shift1_n { get; set; }
        public string shift1_ot { get; set; }
        public string shift1_wd_total { get; set; }
        public string shift1_ot_total { get; set; }
        public string shift2_n { get; set; }
        public string shift2_ot { get; set; }
        public string shift2_wd_sun { get; set; }
        public string shift2_ot_sun { get; set; }
        public string shift2_wd_total { get; set; }
        public string shift2_ot_total { get; set; }
        public string total_wd { get; set; }
        public string total_ot { get; set; }
        public string leave1 { get; set; }
        public string leave2 { get; set; }
        public string leave3 { get; set; }
        public string leave4 { get; set; }
        public string sys_leave { get; set; }
        public string sys_OTh { get; set; }
        public string statusText { get; set; }
        public string statusID { get; set; }
        public string dayoff { get; set; }
    }

 
     

    public class ReadFileResult
    {
        public string ModelErrors { get; set; }        
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class CheckWorkingDayParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
        public string monthView { get; set; }
        public string yearView { get; set; }
        public int empID { get; set; }

    }



    public class SalaryListDetailResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SalaryListDetailModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class SalaryListDetailModelResult
    {
        public string salaryID { get; set; }
        public string costCenterCode { get; set; }
        public string deptCode { get; set; }
        public string unitCode { get; set; }
        public string empNo { get; set; }
        public string empDayID { get; set; }
        public string empType { get; set; }
        public string empName { get; set; }
        public string oldSalary { get; set; }
        public string incrementSalary { get; set; }
        public string basicSalary { get; set; }
        public string shiftIncome { get; set; }
        public string overtimeIncome { get; set; }
        public string threshingIncom { get; set; }
        public string additionalPay { get; set; }
        public string additionalDeduct { get; set; }
        public string deductDayOff { get; set; }
        public string allowance { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string advanceBonus { get; set; }
        public string saleIncentive { get; set; }
        public string grossIncome { get; set; }
        public string deductEmpSSO { get; set; }
        public string tax_b1 { get; set; }
        public string tax_b2 { get; set; }
        public string tax_b3 { get; set; }
        public string tax_b4 { get; set; }
        public string tax_b5 { get; set; }
        public string tax_b6 { get; set; }
        public string tax_extra { get; set; }
        public string deductTaxs { get; set; }
        public string netIncome { get; set; }
        public string deductFHF { get; set; }
        public string deduct_loan { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string grossLastMonth { get; set; }
        public string grossVariance { get; set; }
        public string remark { get; set; }
        public string sumAll { get; set; }
        public float sumgrossincome_empsso { get; set; }
        public string grossincome_empsso { get; set; }
        public string workingid { get; set; }
        public string empid { get; set; }

    }




    public class rpt1008Result
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1008ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }



    public class rpt1008ModelResult
    {
        public string employeeSSO { get; set; }
        public string employerSSO { get; set; }
        public string sumAll { get; set; }
    }



    public class rpt1014Result
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1014ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1014ModelResult
    {
        public string deptCode { get; set; }
        public string costCenterCode { get; set; }
        public string pension_00 { get; set; }
        public string pension_01 { get; set; }
        public string pension_02 { get; set; }
        public string pension_03 { get; set; }
        public string pension_04 { get; set; }
        public string pension_05 { get; set; }
        public string pension_06 { get; set; }
        public string pension_07 { get; set; }
        public string pension_08 { get; set; }
        public string pension_09 { get; set; }
        public string pension_10 { get; set; }
        public string pension_11 { get; set; }
        public string pension_12 { get; set; }         
    }




    public class rpt1015Result
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1015ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1015ModelResult
    {
        public string deptCode { get; set; }
        public string costCenterCode { get; set; }
        public string bonus_00 { get; set; }
        public string bonus_01 { get; set; }
        public string bonus_02 { get; set; }
        public string bonus_03 { get; set; }
        public string bonus_04 { get; set; }
        public string bonus_05 { get; set; }
        public string bonus_06 { get; set; }
        public string bonus_07 { get; set; }
        public string bonus_08 { get; set; }
        public string bonus_09 { get; set; }
        public string bonus_10 { get; set; }
        public string bonus_11 { get; set; }
        public string bonus_12 { get; set; }
    }

}