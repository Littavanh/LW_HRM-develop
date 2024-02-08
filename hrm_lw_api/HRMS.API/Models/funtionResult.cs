using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class salaryByDeptResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<salaryByDeptModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class salaryByDeptModelResult
    {
        public string costCenterCode { get; set; }
        public string headcount { get; set; }
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
        public string grossIncome { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string netIncome { get; set; }
        public string deductLoan { get; set; }
        public string deductFHF { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string grossLastMonth { get; set; }
        public string grossVariance { get; set; }
        public string sumAll { get; set; }
    }


    public class EmpPositionTitleListtResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<EmpPositionTitleListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class EmpPositionTitleListViewModelResult
    {
        public string empPositionTitleID { get; set; }
        public string empPositionTitleName { get; set; }      
    }


    public class salaryMonthResult
    {
        public string ModelErrors { get; set; }
        public string salaryMonth { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }



    public class CheckPaymentListtResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<CheckPaymentListViewModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class CheckPaymentListViewModelResult
    {
        public string salaryID { get; set; }
      
        public string transactionNo { get; set; }
        public string costCenterCode { get; set; }
        public string oldSalary { get; set; }
        public string incrementSalary { get; set; }
        public string basicSalary { get; set; }
        public string shiftIncome { get; set; }
        public string shiftwd1 { get; set; }
        public string shiftwd2 { get; set; }
        public string shiftwd3 { get; set; }
        public string othour1 { get; set; }
        public string othour2 { get; set; }
        public string othour3 { get; set; }
        public string othour4 { get; set; }
        public string othour5 { get; set; }
        public string grossVariance { get; set; }
        public string overtimeIncome { get; set; }
        public string threshingIncom { get; set; }
        public string additionalPay { get; set; }
        public string additionalDeduct { get; set; }
        public string deductDayOff { get; set; }
        public string allowance { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string saleIncentive { get; set; }
        public string advanceBonus { get; set; }
        public string grossIncome { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string netIncome { get; set; }
        public string deductLoan { get; set; }
        public string deductFHF { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string severanceBook { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string grossLastMonth { get; set; }
        public string remark { get; set; }
        public string sumAll { get; set; }
    }


    public class ViewImageRequestResult
    {
        public string ModelErrors { get; set; }
        public string fileName { get; set; }
        public string imageFile { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class SumLeaveBalanceListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<SumLeaveBalanceListModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }
    public class SumLeaveBalanceListModelResult
    {
        public string empID { get; set; }
        public string empNo { get; set; }
        public string fullName { get; set; }
        public string empPosition { get; set; }
        public string deptName { get; set; }
        public string totalDay_SL { get; set; }
        public string totalDay_AL { get; set; }
        public string totalDay_CL { get; set; }
        public string totalDay_DIL { get; set; }

       
    }

    public class sumtranbankResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<sumtranbankModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class sumtranbankModelResult
    {
        public string bankName { get; set; }
        public string sumFee { get; set; }
        public string sumTotal { get; set; }
        public string sumTotalFee { get; set; }
    }


    public class departmentGroupListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<departmentGroupListDetailModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class departmentGroupListDetailModelResult
    {
        public string deptGroupCode { get; set; }
        public string deptGroupName { get; set; }

    }


    public class rpt1006ListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1006ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1006ModelResult
    {
        public string transactionNo { get; set; }
        public string deptGroupCode { get; set; }
        public string deptGroupName { get; set; }
        public string staffCount { get; set; }
        public string deptname { get; set; }
        public string deptCode { get; set; }
        public string grossSalaryBenefits { get; set; }
        public string advanceBonus { get; set; }
        public string deductEmpSSO { get; set; }
        public string deductTaxs { get; set; }
        public string grossIncome { get; set; }
        public string deductFHFdeductOther { get; set; }
        public string deduct_SLDRT_fun { get; set; }
        public string canteenNET { get; set; }
        public string leavingPackage { get; set; }
        public string netToPay { get; set; }
        public string employerSSO { get; set; }
        public string netToPayMaster { get; set; }
        public string variance { get; set; }
        public string remark { get; set; }
        public string topic { get; set; }
        public string sumAll { get; set; }

    }

    public class rpt1011ListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1011ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1011ModelResult
    {
        public string transactionNo { get; set; }
        public string deptGroupCode { get; set; }
        public string deptGroupName { get; set; }
        public string costCenter { get; set; }
        public string unitName { get; set; }
        public string total_active { get; set; }
        public string permanent_active { get; set; }
        public string fixed_perary_active { get; set; }
        public string permanaent_NoActive { get; set; }
        public string groupInHCR { get; set; }
       

    }


    public class rpt1012ListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1012ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1012ModelResult
    {
        public string transactionNo { get; set; }
        public string deptGroupCode { get; set; }
        public string deptGroupText { get; set; }
        public string descript { get; set; }
        public string headCount { get; set; }
        public string work_perma { get; set; }
        public string work_fixedTemp { get; set; }
        public string permaGrossincome { get; set; }
        public string fixedTempGrossincome { get; set; }
        public string grossBenefit { get; set; }
        public string bonus { get; set; }
        public string ovetime { get; set; }
        public string paidHours { get; set; }
        public string paidAbsent { get; set; }
        public string AL { get; set; }
        public string sick { get; set; }
        public string CL { get; set; }
        public string publicHoliday { get; set; }
        public string unpaidLeave { get; set; }
        public string OT150 { get; set; }
        public string OT200 { get; set; }                
        public string OT250 { get; set; }
        public string OT300 { get; set; }
        public string OT350 { get; set; }
        public string headcount_perma { get; set; }
        public string headcount_temp { get; set; }
        public string wh_paid { get; set; }
        public string wh_absent { get; set; }
 
    }



    public class rpt1013Result
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1013ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1013ModelResult
    {
       
        public string ssoNumber { get; set; }
        public string empName { get; set; }
        public string empNo { get; set; }
        public string salary { get; set; }
        public string ssoSalary { get; set; }
        public string employeeSSO { get; set; }
        public string employerSSO { get; set; }
        public string remark { get; set; }

    }




    public class rpt1007Result
    {
        public string ModelErrors { get; set; }
        public IEnumerable<rpt1007ModelResult> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class rpt1007ModelResult
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
        public string shiftIncom1 { get; set; }
        public string shiftIncom2 { get; set; }
        public string shiftIncom3 { get; set; }
        public string empLeaveDay { get; set; }
        public string empDayOff { get; set; }
        public string al { get; set; }
        public string al_use { get; set; }
        public string al_left { get; set; }
        public string sick { get; set; }
        public string cl { get; set; }
        public string ot1 { get; set; }
        public string ot2 { get; set; }
        public string ot3 { get; set; }
        public string ot4 { get; set; }
        public string ot5 { get; set; }
        public string allowance_phone { get; set; }
        public string allowance_flue { get; set; }
        public string allowance_car { get; set; }
        public string allowance_house { get; set; }
        public string hireday { get; set; }
        public string workprevious { get; set; }
        public string workingID { get; set; }

    }

}