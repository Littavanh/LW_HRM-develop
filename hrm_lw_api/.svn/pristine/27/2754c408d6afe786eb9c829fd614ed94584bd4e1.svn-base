using HRMS.API.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web.Http;
using HRMS.Data;
using System.Drawing;
using System.Text;
using System.Security.Cryptography;
namespace HRMS.API.Controllers
{

    public class FunctionController : ApiController
    {
        public static string connectionString = ConfigurationManager.ConnectionStrings["db_hrmsEntities.Properties.Settings.db_hrmsConnectionString"].ConnectionString;
       
        [HttpPost]
        [Route("api/Function/SalaryList")]
        public SalaryListResult salarylist(SalaryListParam data)
        {
            var ret = new SalaryListResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearView != 0)
                {
                    NewYearView = data.yearView;
                }
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.v_salary_list
                                           //  where c.salaryYear == NewYearView && (c.mgrID == ds_tokey.empID || c.user_add == ds_tokey.empID) && c.status_id != 4
                                       where c.salaryYear == NewYearView  && c.status_id != 4
                                       orderby c.salaryID descending, c.status_id descending
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.salaryMonth,
                                           c.salaryYear,
                                           c.generateDate,
                                           c.ownerID,
                                           c.firstName1,
                                           c.lastName1,
                                           c.firstName2,
                                           c.lastName2,
                                           c.mgrID,
                                           c.mgrF1,
                                           c.mgrL1,
                                           c.mgrF2,
                                           c.mgrL2,
                                           c.status_id,
                                           c.statusText,
                                           c.remark,
                                           c.ApproveDate,
                                           c.processStatus,
                                           c.workingDay,
                                           c.additionalPayment,
                                           c.saleIncentive,
                                           c.bonus,
                                           c.deductFHF,
                                           c.deductOther,
                                           c.personalLoan,
                                           c.SLDRT,
                                           c.approveFinger,
                                           c.cycleRun,
                                           c.reportPrint,
                                           c.reportGen,
                                           c.startdate,
                                           c.enddate                                           
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<SalaryListModelResult> ResultObject = new List<SalaryListModelResult>();
                            ResultObject = ds_Data.Select(c => new SalaryListModelResult()
                            {
                                salaryID = c.salaryID.ToString(),
                                transactionNo = c.transactionNo.ToString(),
                                generateDate = c.generateDate.ToString(),
                                salaryDate = c.salaryMonth.ToString() + "/" + c.salaryYear.ToString(),
                                staffName = data.lang == "1" ? c.firstName1.ToString() + " " + c.lastName1.ToString() : c.firstName2.ToString() + " " + c.lastName2.ToString(),
                                approveDate = c.ApproveDate.ToString(),
                                approveName = data.lang == "1" ? c.mgrF1.ToString() + " " + c.mgrL1.ToString() : c.mgrF2.ToString() + " " + c.mgrL2.ToString(),
                                noted = c.remark.ToString(),
                                statusText = c.statusText.ToString(),
                                monthView = c.salaryMonth.ToString(),
                                yearView = c.salaryYear.ToString(),
                                status_id = c.status_id.ToString(),
                                processStatus = c.processStatus.ToString(),
                                workingDay = c.workingDay.ToString(),
                                additionalPayment = c. additionalPayment.ToString(),
                                saleIncentive = c. saleIncentive.ToString(),
                                bonus = c. bonus.ToString(),
                                deductFHF = c.deductFHF.ToString(),
                                deductOther = c.deductOther.ToString(),
                                personalLoan = c.personalLoan.ToString(),
                                SLDRT = c.SLDRT.ToString(),
                                approveFinger = c.approveFinger.ToString(),
                                cycleRun = c.cycleRun.ToString(),
                                reportPrint = c.reportPrint.ToString(),
                                reportGen = c.reportGen.ToString(),
                                strDate = c.startdate == null ? "" : c.startdate.ToString(),
                                endDate = c.enddate == null ? "": c.enddate.ToString()
                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }
        void insertLog(string token, string logeven, string logmodules, string olddata, string newdata)
        {
            using (var db = new db_hrmsEntities())
            {
                try
                {
                    var ds_tokey = (from c in db.v_user_permission
                                        //   where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_add == 1
                                    where (c.appTokenKey == token || c.webTokenKey == token)
                                    select new
                                    {
                                        c.empID,
                                        c.userID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        //string newdata = "";
                        string command;
                        string result = "0";
                        //newdata = "name1 = " + data.ethnicName1.Trim() + "; name2 =" + data.ethnicName2.Trim() + "; status_ID = 3";

                        command = "Exec pd_insertTb_log @logdate = '" + DateTime.Now + "', @loguser = " + ds_tokey.userID + ", @logeven = '" + logeven + "', @logmodules = '" + logmodules + "', @oldData = N'" + olddata + "', @newData = N'" + newdata + "'";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(command, myConnection))
                            {
                                //Error this
                                //Result = (int)myCommand.ExecuteScalar();

                                object value = myCommand.ExecuteScalar();
                                if (value != null)
                                {
                                    result = value.ToString();
                                }
                                myConnection.Close();
                                // return result;
                            }
                        }
                    }

                }
                catch (Exception ex)
                {

                }

            }
        }

        [HttpPost]
        [Route("api/Function/salaryApprovelist")]
        public SalaryListResult salaryApprovelist(SalaryListParam data)
        {
            var ret = new SalaryListResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearView != 0)
                {
                    NewYearView = data.yearView;
                }
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.v_salary_list
                                        where c.salaryYear == NewYearView && (c.mgrID == ds_tokey.empID || c.user_add == ds_tokey.empID) && c.status_id != 4
                                       //where c.salaryYear == NewYearView && c.status_id != 4 
                                       orderby c.salaryID descending, c.status_id descending
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.salaryMonth,
                                           c.salaryYear,
                                           c.generateDate,
                                           c.ownerID,
                                           c.firstName1,
                                           c.lastName1,
                                           c.firstName2,
                                           c.lastName2,
                                           c.mgrID,
                                           c.mgrF1,
                                           c.mgrL1,
                                           c.mgrF2,
                                           c.mgrL2,
                                           c.status_id,
                                           c.statusText,
                                           c.remark,
                                           c.ApproveDate,
                                           c.processStatus,
                                           c.workingDay,
                                           c.additionalPayment,
                                           c.saleIncentive,
                                           c.bonus,
                                           c.deductFHF,
                                           c.deductOther,
                                           c.personalLoan,
                                           c.SLDRT,
                                           c.approveFinger,
                                           c.cycleRun,
                                           c.reportPrint,
                                           c.reportGen

                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<SalaryListModelResult> ResultObject = new List<SalaryListModelResult>();
                            ResultObject = ds_Data.Select(c => new SalaryListModelResult()
                            {
                                salaryID = c.salaryID.ToString(),
                                transactionNo = c.transactionNo.ToString(),
                                generateDate = c.generateDate.ToString(),
                                salaryDate = c.salaryMonth.ToString() + "/" + c.salaryYear.ToString(),
                                staffName = data.lang == "1" ? c.firstName1.ToString() + " " + c.lastName1.ToString() : c.firstName2.ToString() + " " + c.lastName2.ToString(),
                                approveDate = c.ApproveDate.ToString(),
                                approveName = data.lang == "1" ? c.mgrF1.ToString() + " " + c.mgrL1.ToString() : c.mgrF2.ToString() + " " + c.mgrL2.ToString(),
                                noted = c.remark.ToString(),
                                statusText = c.statusText.ToString(),
                                monthView = c.salaryMonth.ToString(),
                                yearView = c.salaryYear.ToString(),
                                status_id = c.status_id.ToString(),
                                processStatus = c.processStatus.ToString(),
                                workingDay = c.workingDay.ToString(),
                                additionalPayment = c.additionalPayment.ToString(),
                                saleIncentive = c.saleIncentive.ToString(),
                                bonus = c.bonus.ToString(),
                                deductFHF = c.deductFHF.ToString(),
                                deductOther = c.deductOther.ToString(),
                                personalLoan = c.personalLoan.ToString(),
                                SLDRT = c.SLDRT.ToString(),
                                approveFinger = c.approveFinger.ToString(),
                                cycleRun = c.cycleRun.ToString(),
                                reportPrint = c.reportPrint.ToString(),
                                reportGen = c.reportGen.ToString()

                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }
        

        [HttpPost]
        [Route("api/Function/salarylistDetail")]
        public SalaryListDetailResult salarylistDetail(SalaryListDetailParam data)
        {
            var ret = new SalaryListDetailResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView
                                       orderby c.deptGroupCode ascending, c.costCenterCode ascending
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.orderNo,
                                           c.monthCal,
                                           c.YearCal,
                                           c.MYCal,
                                           c.costCenterCode,
                                           c.costCenterText,
                                           c.deptCode,
                                           c.deptName1,
                                           c.deptName2,
                                           c.unitCode,
                                           c.unitName1,
                                           c.unitName2,
                                           c.empID,
                                           c.empNo,
                                           c.empDayID,
                                           c.empType,
                                           c.oldSalary,
                                           c.incrementSalary,
                                           c.basicSalary,
                                           c.shiftIncome1,
                                           c.shiftIncome2,
                                           c.shiftIncome3,
                                           c.shiftIncome,
                                           c.overtimeIncome1,
                                           c.overtimeIncome2,
                                           c.overtimeIncome3,
                                           c.overtimeIncome4,
                                           c.overtimeIncome5,
                                           c.overtimeIncome,
                                           c.threshingIncom,
                                           c.additionalPay,
                                           c.additionalDeduct,
                                           c.deductDayOff,
                                           c.allowance_phone,
                                           c.allowance_fuel,
                                           c.allowance_housing,
                                           c.allowance_car,
                                           c.allowance,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.grossIncome,
                                           c.deductEmpSSO,
                                           c.tax_b1,
                                           c.tax_b2,
                                           c.tax_b3,
                                           c.tax_b4,
                                           c.tax_b5,
                                           c.tax_b6,
                                           c.tax_extra,
                                           c.deductTaxs,
                                           c.deductLoan,
                                           c.deductFHF,
                                           c.deduct_SLDRT_fun,
                                           c.deductOther,
                                           c.canteenNET,
                                           c.OtherAllowanNET,
                                           c.severanceBook,
                                           c.NetToPay,
                                           c.employerSSO,
                                           c.grossLastMonth,
                                           c.grossVariance,
                                           c.noted,
                                           c.empName1,
                                           c.empName2,
                                           c.netIncome,
                                           c.saleIncentive,
                                           c.workdayID
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<SalaryListDetailModelResult> ResultObject = new List<SalaryListDetailModelResult>();
                            ResultObject = ds_Data.Select(c => new SalaryListDetailModelResult()
                            {
                                salaryID = c.salaryID.ToString(),
                                costCenterCode = c.costCenterCode == null ? "" : c.costCenterCode.ToString(),
                                deptCode = c.deptCode == null ? "" : c.deptCode.ToString(),
                                unitCode = c.unitCode == null ? "" : c.unitCode.ToString(),
                                empNo = c.empNo == null ? "": c.empNo.ToString(),
                                empDayID = c.empDayID == null ? "" : c.empDayID.ToString(),
                                empType = c.empType == null ? "" : c.empType.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct =c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                saleIncentive = c.saleIncentive.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductOther + c.deductLoan).ToString("#,##0"),
                                deduct_loan = c.deductLoan.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = c.noted == null ? "" : c.noted.ToString(),
                                empName = data.lang == "1" ? c.empName1.ToString() : c.empName2.ToString(),
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll="0",
                                grossincome_empsso = ((float) c.grossSalaryBenefits - (float) c.deductEmpSSO).ToString("#,##0"),
                                workingid = c.workdayID,
                                empid = c.empID.ToString()
                            }).ToList();


                            var ds_sum = (from c in db.tb_paymentRecord
                                           where c.monthCal == data.monthView && c.YearCal == data.yearView 
                                          group c by new { c.monthCal, c.YearCal } into g
                                         
                                          select new
                                           {
                                              oldSalary = g.Sum(s => s.oldSalary),
                                              incrementSalary = g.Sum(s => s.incrementSalary),
                                              basicSalary = g.Sum(s => s.basicSalary),
                                              shiftIncome = g.Sum(s => s.shiftIncome),
                                              overtimeIncome = g.Sum(s => s.overtimeIncome),
                                              threshingIncom = g.Sum(s => s.threshingIncom),
                                              additionalPay = g.Sum(s => s.additionalPay),
                                              additionalDeduct = g.Sum(s => s.additionalDeduct),
                                              deductDayOff = g.Sum(s => s.deductDayOff),
                                              allowance = g.Sum(s => s.allowance),
                                              grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                              advanceBonus = g.Sum(s => s.advanceBonus),
                                              saleIncentive = g.Sum(s => s.saleIncentive),
                                              grossIncome = g.Sum(s => s.grossIncome),
                                              deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                              deductTaxs = g.Sum(s => s.deductTaxs),
                                              deductLoan = g.Sum(s => s.deductLoan),
                                              deductFHF = g.Sum(s => s.deductFHF + s.deductLoan  + s.deductOther),
                                              deduct_SLDRT_fun = g.Sum(s => s.deduct_SLDRT_fun),
                                              deductOther = g.Sum(s => s.deductOther),
                                              canteenNET = g.Sum(s => s.canteenNET),
                                              OtherAllowanNET = g.Sum(s => s.OtherAllowanNET),
                                              severanceBook = g.Sum(s => s.severanceBook),
                                              NetToPay = g.Sum(s => s.NetToPay),
                                              employerSSO = g.Sum(s => s.employerSSO),
                                              grossLastMonth = g.Sum(s => s.grossLastMonth),
                                              grossVariance = g.Sum(s => s.grossVariance),
                                              netIncome = g.Sum(s => s.netIncome),
                                              tax_b1 = g.Sum(s => s.tax_b1),
                                              tax_b2 = g.Sum(s => s.tax_b2),
                                              tax_b3 = g.Sum(s => s.tax_b3),
                                              tax_b4 = g.Sum(s => s.tax_b4),
                                              tax_b5 = g.Sum(s => s.tax_b5),
                                              tax_b6 = g.Sum(s => s.tax_b6),
                                              tax_extra = g.Sum(s => s.tax_extra),
                                              sumAll = "1",

                                          }).ToList();

                            List<SalaryListDetailModelResult> ResultObject_sum = new List<SalaryListDetailModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new SalaryListDetailModelResult()
                            {
                                salaryID = "",
                                costCenterCode = "",
                                deptCode = "",
                                unitCode = "",
                                empNo = "",
                                empDayID = "",
                                empType = "",
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                saleIncentive = c.saleIncentive.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = c.deductFHF.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = "",
                                empName = "",
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll = "1"
                            }).ToList();



                            ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/salaryByDept")]
        public salaryByDeptResult salaryByDept(SalaryListDetailParam data)
        {
            var ret = new salaryByDeptResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView 
                                       group c by new { c.costCenterCode } into g
                                       orderby g.Key.costCenterCode ascending
                                     
                                       select new
                                       {
                                           costCenterCode = g.Key.costCenterCode,
                                           headcount = g.Count(),

                                           oldSalary = g.Sum(s => s.oldSalary),
                                           incrementSalary = g.Sum(s => s.incrementSalary),
                                           basicSalary = g.Sum(s => s.basicSalary),
                                           shiftIncome = g.Sum(s => s.shiftIncome),
                                           overtimeIncome = g.Sum(s => s.overtimeIncome),
                                           threshingIncom = g.Sum(s => s.threshingIncom),
                                           additionalPay = g.Sum(s => s.additionalPay),
                                           additionalDeduct = g.Sum(s => s.additionalDeduct),
                                           deductDayOff = g.Sum(s => s.deductDayOff),                                      
                                           allowance = g.Sum(s => s.allowance),
                                           grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                           advanceBonus = g.Sum(s => s.saleIncentive), //This is update by advanceBonus to be saleIncentive.
                                           grossIncome = g.Sum(s => s.grossIncome),
                                           deductEmpSSO = g.Sum(s => s.deductEmpSSO),                                          
                                           deductTaxs = g.Sum(s => s.deductTaxs),
                                           deductLoan = g.Sum(s => s.deductLoan),
                                           deductFHF = g.Sum(s => s.deductFHF),
                                           deduct_SLDRT_fun = g.Sum(s => s.deduct_SLDRT_fun),
                                           deductOther = g.Sum(s => s.deductOther),
                                           canteenNET = g.Sum(s => s.canteenNET),
                                           OtherAllowanNET = g.Sum(s => s.OtherAllowanNET),
                                           severanceBook = g.Sum(s => s.severanceBook),
                                           NetToPay = g.Sum(s => s.NetToPay),
                                           employerSSO = g.Sum(s => s.employerSSO),
                                           grossLastMonth = g.Sum(s => s.grossLastMonth),
                                           grossVariance = g.Sum(s => s.grossVariance),                                          
                                           netIncome = g.Sum(s => s.netIncome),
                                           sumAll = "0"
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<salaryByDeptModelResult> ResultObject = new List<salaryByDeptModelResult>();
                            ResultObject = ds_Data.Select(c => new salaryByDeptModelResult()
                            {
                                //costCenterCode = c.costCenterCode.ToString(),

                                costCenterCode = c.costCenterCode == null ? "" : c.costCenterCode.ToString(),
                                headcount = c.headcount.ToString(),    
                                
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductLoan).ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),                                        
                                deductLoan = c.deductLoan.ToString("#,##0"),
                                sumAll = "0"
                            }).ToList();

                            var ds_sum = (from gc in db.tb_paymentRecord
                                           where gc.monthCal == data.monthView && gc.YearCal == data.yearView 
                                           group gc by new { gc.YearCal, gc.monthCal } into gs                                           
                                           select new
                                           {            
                                               gs.Key.monthCal,                                  
                                               headcount = gs.Count(),
                                               oldSalary = gs.Sum(sg => sg.oldSalary),
                                               incrementSalary = gs.Sum(sg => sg.incrementSalary),
                                               basicSalary = gs.Sum(sg => sg.basicSalary),
                                               shiftIncome = gs.Sum(sg => sg.shiftIncome),
                                               overtimeIncome = gs.Sum(sg => sg.overtimeIncome),
                                               threshingIncom = gs.Sum(sg => sg.threshingIncom),
                                               additionalPay = gs.Sum(sg => sg.additionalPay),
                                               additionalDeduct = gs.Sum(sg => sg.additionalDeduct),
                                               deductDayOff = gs.Sum(sg => sg.deductDayOff),
                                               allowance = gs.Sum(sg => sg.allowance),
                                               grossSalaryBenefits = gs.Sum(sg => sg.grossSalaryBenefits),
                                               advanceBonus = gs.Sum(sg => sg.saleIncentive),   //This is update by advance bonus to been saleincentive
                                               grossIncome = gs.Sum(sg => sg.grossIncome),
                                               deductEmpSSO = gs.Sum(sg => sg.deductEmpSSO),
                                               deductTaxs = gs.Sum(sg => sg.deductTaxs),
                                               deductLoan = gs.Sum(sg => sg.deductLoan),
                                               deductFHF = gs.Sum(sg => sg.deductFHF),
                                               deduct_SLDRT_fun = gs.Sum(sg => sg.deduct_SLDRT_fun),
                                               deductOther = gs.Sum(sg => sg.deductOther),
                                               canteenNET = gs.Sum(sg => sg.canteenNET),
                                               OtherAllowanNET = gs.Sum(sg => sg.OtherAllowanNET),
                                               severanceBook = gs.Sum(sg => sg.severanceBook),
                                               NetToPay = gs.Sum(sg => sg.NetToPay),
                                               employerSSO = gs.Sum(sg => sg.employerSSO),
                                               grossLastMonth = gs.Sum(sg => sg.grossLastMonth),
                                               grossVariance = gs.Sum(sg => sg.grossVariance),
                                               netIncome = gs.Sum(sg => sg.netIncome),
                                               sumAll = "1"
                                           }).ToList();                           
                            List<salaryByDeptModelResult> ResultObject_sum = new List<salaryByDeptModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new salaryByDeptModelResult()
                            {
                                costCenterCode="SUM",
                                headcount = c.headcount.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductLoan).ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                deductLoan = c.deductLoan.ToString("#,##0"),
                                sumAll ="1"
                            }).ToList();                            

                            ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/terminateList")]
        public salaryByDeptResult terminate(SalaryListDetailParam data)
        {
            var ret = new salaryByDeptResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView 
                                       group c by new { c.costCenterCode } into g
                                       orderby g.Key.costCenterCode ascending

                                       select new
                                       {
                                           costCenterCode = g.Key.costCenterCode,
                                           headcount = g.Count(),
                                           oldSalary = g.Sum(s => s.oldSalary),
                                           incrementSalary = g.Sum(s => s.incrementSalary),
                                           basicSalary = g.Sum(s => s.basicSalary),
                                           shiftIncome = g.Sum(s => s.shiftIncome),
                                           overtimeIncome = g.Sum(s => s.overtimeIncome),
                                           threshingIncom = g.Sum(s => s.threshingIncom),
                                           additionalPay = g.Sum(s => s.additionalPay),
                                           additionalDeduct = g.Sum(s => s.additionalDeduct),
                                           deductDayOff = g.Sum(s => s.deductDayOff),
                                           allowance = g.Sum(s => s.allowance),
                                           grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                           advanceBonus = g.Sum(s => s.advanceBonus),
                                           grossIncome = g.Sum(s => s.grossIncome),
                                           deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                           deductTaxs = g.Sum(s => s.deductTaxs),
                                           deductLoan = g.Sum(s => s.deductLoan),
                                           deductFHF = g.Sum(s => s.deductFHF),
                                           deduct_SLDRT_fun = g.Sum(s => s.deduct_SLDRT_fun),
                                           deductOther = g.Sum(s => s.deductOther),
                                           canteenNET = g.Sum(s => s.canteenNET),
                                           OtherAllowanNET = g.Sum(s => s.OtherAllowanNET),
                                           severanceBook = g.Sum(s => s.severanceBook),
                                           NetToPay = g.Sum(s => s.NetToPay),
                                           employerSSO = g.Sum(s => s.employerSSO),
                                           grossLastMonth = g.Sum(s => s.grossLastMonth),
                                           grossVariance = g.Sum(s => s.grossVariance),
                                           netIncome = g.Sum(s => s.netIncome),
                                           sumAll = "0"
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<salaryByDeptModelResult> ResultObject = new List<salaryByDeptModelResult>();
                            ResultObject = ds_Data.Select(c => new salaryByDeptModelResult()
                            {
                                costCenterCode = c.costCenterCode.ToString(),
                                headcount = c.headcount.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay + c.additionalDeduct).ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductLoan).ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductLoan = c.deductLoan.ToString("#,##0"),
                                sumAll = "0"
                            }).ToList();

                            var ds_sum = (from gc in db.tb_paymentRecord
                                          where gc.monthCal == data.monthView && gc.YearCal == data.yearView  
                                          group gc by new { gc.YearCal, gc.monthCal } into gs
                                          select new
                                          {
                                              gs.Key.monthCal,
                                              headcount = gs.Count(),
                                              oldSalary = gs.Sum(sg => sg.oldSalary),
                                              incrementSalary = gs.Sum(sg => sg.incrementSalary),
                                              basicSalary = gs.Sum(sg => sg.basicSalary),
                                              shiftIncome = gs.Sum(sg => sg.shiftIncome),
                                              overtimeIncome = gs.Sum(sg => sg.overtimeIncome),
                                              threshingIncom = gs.Sum(sg => sg.threshingIncom),
                                              additionalPay = gs.Sum(sg => sg.additionalPay),
                                              additionalDeduct = gs.Sum(sg => sg.additionalDeduct),
                                              deductDayOff = gs.Sum(sg => sg.deductDayOff),
                                              allowance = gs.Sum(sg => sg.allowance),
                                              grossSalaryBenefits = gs.Sum(sg => sg.grossSalaryBenefits),
                                              advanceBonus = gs.Sum(sg => sg.advanceBonus),
                                              grossIncome = gs.Sum(sg => sg.grossIncome),
                                              deductEmpSSO = gs.Sum(sg => sg.deductEmpSSO),
                                              deductTaxs = gs.Sum(sg => sg.deductTaxs),
                                              deductLoan = gs.Sum(sg => sg.deductLoan),
                                              deductFHF = gs.Sum(sg => sg.deductFHF),
                                              deduct_SLDRT_fun = gs.Sum(sg => sg.deduct_SLDRT_fun),
                                              deductOther = gs.Sum(sg => sg.deductOther),
                                              canteenNET = gs.Sum(sg => sg.canteenNET),
                                              OtherAllowanNET = gs.Sum(sg => sg.OtherAllowanNET),
                                              severanceBook = gs.Sum(sg => sg.severanceBook),
                                              NetToPay = gs.Sum(sg => sg.NetToPay),
                                              employerSSO = gs.Sum(sg => sg.employerSSO),
                                              grossLastMonth = gs.Sum(sg => sg.grossLastMonth),
                                              grossVariance = gs.Sum(sg => sg.grossVariance),
                                              netIncome = gs.Sum(sg => sg.netIncome),
                                              sumAll = "1"
                                          }).ToList();
                            List<salaryByDeptModelResult> ResultObject_sum = new List<salaryByDeptModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new salaryByDeptModelResult()
                            {
                                costCenterCode = "SUM",
                                headcount = c.headcount.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay + c.additionalDeduct).ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductLoan).ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductLoan = c.deductLoan.ToString("#,##0"),
                                sumAll = "1"
                            }).ToList();

                            ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/EMPPositionTitle")]
        public EmpPositionTitleListtResult EmpGroupList(EmpGroupListParam data)
        {
            var ret = new EmpPositionTitleListtResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_positionTitle
                                       where c.status_id == 3
                                       select new
                                       {
                                           c.positionID,
                                           c.positionTitle                                         
                                       }).ToList();

                        if (ds_Data != null)
                        {
                            List<EmpPositionTitleListViewModelResult> ResultObject = new List<EmpPositionTitleListViewModelResult>();
                            ResultObject = ds_Data.Select(c => new EmpPositionTitleListViewModelResult()
                            {
                                empPositionTitleID = c.positionID.ToString(),
                                empPositionTitleName = c.positionTitle.ToString()
                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have Emp - Group data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No Emp - Group data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/salaryMonth")]
        public salaryMonthResult salaryMonth(EmpGroupListParam data)
        {
            var ret = new salaryMonthResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                        //where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId >= 19
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_salary_list
                                       where c.status_id == 3
                                        orderby c.salaryDate descending
                                       select new
                                       {
                                        c.salaryDate

                                       }).FirstOrDefault();

                        if (ds_Data != null)
                        {
                            
                            ret.ModelErrors = null;
                            ret.salaryMonth = Convert.ToDateTime(ds_Data.salaryDate).AddMonths(1).ToString("dd/MM/yyyy");
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have Emp - Group data ...!";
                            ret.salaryMonth = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No Emp - Group data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.salaryMonth = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.salaryMonth = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/checkPaymentList")]
        public CheckPaymentListtResult checkPaymentList(SalaryListDetailParam data)
        {
            var ret = new CheckPaymentListtResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView  
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.orderNo,
                                           c.monthCal,
                                           c.YearCal,
                                           c.MYCal,
                                           c.costCenterCode,
                                           c.costCenterText,
                                           c.deptCode,
                                           c.deptName1,
                                           c.deptName2,
                                           c.unitCode,
                                           c.unitName1,
                                           c.unitName2,
                                           c.empID,
                                           c.empNo,
                                           c.empDayID,
                                           c.empType,
                                           c.oldSalary,
                                           c.incrementSalary,
                                           c.basicSalary,
                                           c.shiftIncome1,
                                           c.shiftIncome2,
                                           c.shiftIncome3,
                                           c.shiftIncome,
                                           c.overtimeIncome1,
                                           c.overtimeIncome2,
                                           c.overtimeIncome3,
                                           c.overtimeIncome4,
                                           c.overtimeIncome5,
                                           c.overtimeIncome,
                                           c.threshingIncom,
                                           c.additionalPay,
                                           c.additionalDeduct,
                                           c.deductDayOff,
                                           c.allowance_phone,
                                           c.allowance_fuel,
                                           c.allowance_housing,
                                           c.allowance_car,
                                           c.allowance,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.grossIncome,
                                           c.deductEmpSSO,
                                           c.tax_b1,
                                           c.tax_b2,
                                           c.tax_b3,
                                           c.tax_b4,
                                           c.tax_b5,
                                           c.tax_b6,
                                           c.tax_extra,
                                           c.deductTaxs,
                                           c.deductLoan,
                                           c.deductFHF,
                                           c.deduct_SLDRT_fun,
                                           c.deductOther,
                                           c.canteenNET,
                                           c.OtherAllowanNET,
                                           c.severanceBook,
                                           c.NetToPay,
                                           c.employerSSO,
                                           c.grossLastMonth,
                                           c.grossVariance,
                                           c.noted,
                                           c.empName1,
                                           c.empName2,
                                           c.netIncome
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<CheckPaymentListViewModelResult> ResultObject = new List<CheckPaymentListViewModelResult>();
                            ResultObject = ds_Data.Select(c => new CheckPaymentListViewModelResult()
                            {
                                //salaryID = c.salaryID.ToString(),
                                //costCenterCode = c.costCenterCode.ToString(),
                              
                                //oldSalary = c.oldSalary.ToString("#,##0"),
                                //incrementSalary = c.incrementSalary.ToString("#,##0"),
                                //basicSalary = c.basicSalary.ToString("#,##0"),
                                //shiftIncome = c.shiftIncome.ToString("#,##0"),
                                //overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                //threshingIncom = c.threshingIncom.ToString("#,##0"),
                                //additionalPay = c.additionalPay.ToString("#,##0"),
                                //deductDayOff = c.deductDayOff.ToString("#,##0"),
                                //allowance = c.allowance.ToString("#,##0"),
                                //grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                //advanceBonus = c.advanceBonus.ToString("#,##0"),
                                //grossIncome = c.grossIncome.ToString("#,##0"),
                                //deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                //deductTaxs = c.deductTaxs.ToString("#,##0"),
                                //netIncome = c.netIncome.ToString("#,##0"),
                                //deductFHF = (c.deductFHF + c.deductLoan + c.deductOther).ToString("#,##0"),
                                //deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                //canteenNET = c.canteenNET.ToString("#,##0"),
                                //severanceBook = c.severanceBook.ToString("#,##0"),
                                //netToPay = c.NetToPay.ToString("#,##0"),
                                //employerSSO = c.employerSSO.ToString("#,##0"),
                                //grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                //grossVariance = c.grossVariance.ToString("#,##0"),
                                //remark = c.noted.ToString(),
                                //empName = data.lang == "1" ? c.empName1.ToString() : c.empName2.ToString(),
                                //tax_b1 = c.tax_b1.ToString("#,##0"),
                                //tax_b2 = c.tax_b2.ToString("#,##0"),
                                //tax_b3 = c.tax_b3.ToString("#,##0"),
                                //tax_b4 = c.tax_b4.ToString("#,##0"),
                                //tax_b5 = c.tax_b5.ToString("#,##0"),
                                //tax_b6 = c.tax_b6.ToString("#,##0"),
                                //tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll = "0"
                            }).ToList();


                            var ds_sum = (from c in db.tb_paymentRecord
                                          where c.monthCal == data.monthView && c.YearCal == data.yearView  
                                          group c by new { c.monthCal, c.YearCal } into g

                                          select new
                                          {
                                              oldSalary = g.Sum(s => s.oldSalary),
                                              incrementSalary = g.Sum(s => s.incrementSalary),
                                              basicSalary = g.Sum(s => s.basicSalary),
                                              shiftIncome = g.Sum(s => s.shiftIncome),
                                              overtimeIncome = g.Sum(s => s.overtimeIncome),
                                              threshingIncom = g.Sum(s => s.threshingIncom),
                                              additionalPay = g.Sum(s => s.additionalPay),
                                              additionalDeduct = g.Sum(s => s.additionalDeduct),
                                              deductDayOff = g.Sum(s => s.deductDayOff),
                                              allowance = g.Sum(s => s.allowance),
                                              grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                              advanceBonus = g.Sum(s => s.advanceBonus),
                                              grossIncome = g.Sum(s => s.grossIncome),
                                              deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                              deductTaxs = g.Sum(s => s.deductTaxs),
                                              deductLoan = g.Sum(s => s.deductLoan),
                                              deductFHF = g.Sum(s => s.deductFHF),
                                              deduct_SLDRT_fun = g.Sum(s => s.deduct_SLDRT_fun),
                                              deductOther = g.Sum(s => s.deductOther),
                                              canteenNET = g.Sum(s => s.canteenNET),
                                              OtherAllowanNET = g.Sum(s => s.OtherAllowanNET),
                                              severanceBook = g.Sum(s => s.severanceBook),
                                              NetToPay = g.Sum(s => s.NetToPay),
                                              employerSSO = g.Sum(s => s.employerSSO),
                                              grossLastMonth = g.Sum(s => s.grossLastMonth),
                                              grossVariance = g.Sum(s => s.grossVariance),
                                              netIncome = g.Sum(s => s.netIncome),
                                              tax_b1 = g.Sum(s => s.tax_b1),
                                              tax_b2 = g.Sum(s => s.tax_b2),
                                              tax_b3 = g.Sum(s => s.tax_b3),
                                              tax_b4 = g.Sum(s => s.tax_b4),
                                              tax_b5 = g.Sum(s => s.tax_b5),
                                              tax_b6 = g.Sum(s => s.tax_b6),
                                              tax_extra = g.Sum(s => s.tax_extra),
                                              sumAll = "1"
                                          }).ToList();

                            List<SalaryListDetailModelResult> ResultObject_sum = new List<SalaryListDetailModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new SalaryListDetailModelResult()
                            {
                                salaryID = "",
                                costCenterCode = "",
                                deptCode = "",
                                unitCode = "",
                                empNo = "",
                                empDayID = "",
                                empType = "",
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = c.additionalPay.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = c.deductFHF.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = "",
                                empName = "",
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll = "1"
                            }).ToList();



                            //ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/User/updatePayment")]
        public GetEmpByMgrResult EmpMgrList(EmpEducationListParam data)
        {
            var ret = new GetEmpByMgrResult();
            // WriteLogFile("deptList " + data.TokenKey);
            string Result;
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        string Command = " DECLARE	@return_value int " +
                             " EXEC @return_value = p_s_emp_mgr " +
                             " @userID = '" + ds_tokey.empID.ToString() + "', " +
                             " @lang = '" + data.lang.ToString() + "'  " +
                             " SELECT	'ReturnValue' = @return_value";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = myCommand.ExecuteScalar().ToString();
                            }
                        }

                        var ds_Data = (from c in db.tmp_empMgr
                                       where c.user_add == ds_tokey.empID
                                       select new
                                       {
                                           c.empID,
                                           c.empFullName
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<GetEmpByMgrViewModelResult> ResultObject = new List<GetEmpByMgrViewModelResult>();
                            ResultObject = ds_Data.Select(c => new GetEmpByMgrViewModelResult()
                            {
                                empID = c.empID.ToString(),
                                empFullName = c.empFullName.ToString()
                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have Emp data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No Emp data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/NewSalaryList")]
        public NewSalaryListResult NewSalarylist(NewSalaryListParam data)
        {
            var ret = new NewSalaryListResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearCal != 0)
                {
                    NewYearView = data.yearCal;
                }
                int NewMonthView = int.Parse(DateTime.Now.ToString("MM"));
                if (data.monthCal != 0)
                {
                    NewMonthView = data.monthCal;
                }
                string salaryDateString = NewYearView.ToString() + "-" + NewMonthView.ToString() + "-01";
                DateTime salaryDate = DateTime.Parse(salaryDateString);
                int Result;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        /* string Command = " EXEC   p_salary_Cal_TA " +
                             " @userID = '" + ds_tokey.empID.ToString() + "', " +
                             " @monthCal = '" + data.monthCal.ToString() + "',  " +
                             " @YearCal = '" + data.yearCal.ToString() + "'  ";*/

                        DateTime std = DateTime.Parse(data.startdate);
                        DateTime end = DateTime.Parse(data.enddate);
                        string xstd = std.ToString("yyyy-MM-dd");
                        string xend = end.ToString("yyyy-MM-dd");

                        string Command = "EXEC p_salary_cal_TA @userID = '"+ ds_tokey.empID.ToString() +"', @monthCal = '"+ data.monthCal.ToString() +"', @YearCal = '"+ data.yearCal.ToString() +"', " +
                            "@startdate = '"+ xstd + "', @enddate = '"+ xend + "'";

                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();                
                            }
                        }
                        if (Result > 0)
                        {
                            //This is save log
                            string logevent = "New";
                            string logmodules = "NewSalaryList";
                            string olddata = "";
                            string newdata = "monthlCal = " + data.monthCal + "; YearCal=" + data.yearCal + "; startdate = "+ xstd +"; enddate = "+ xend +".";
                            insertLog(data.tokenKey, logevent, logmodules, olddata, newdata);

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                            }
                            else
                            {
                                ret.ModelErrors = "Save complete";
                            }
                            ret.StatusCode = 200;
                            ret.salaryID = Result;

                            var ds_tranNo = (from c in db.tb_salary_list                                                
                                            where (c.salaryID == Result)
                                            select new
                                            {
                                                c.transactionNo 
                                            }).FirstOrDefault();
                            if (ds_tranNo != null)
                            {
                                ret.transactionNo = ds_tranNo.transactionNo == null ? "" : ds_tranNo.transactionNo.ToString();
                            } else
                            {
                                ret.transactionNo = "";
                            }


                                
                        } else
                        {

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                            ret.StatusCode = 417;
                            ret.salaryID = Result;
                            ret.transactionNo = "";
                        }                        
                      
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.salaryID = 0;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.salaryID = 0;
                ret.transactionNo = "";
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/DelSalarylist")]
        public SalaryListResult DelSalarylist(DelSalaryListParam data)
        {
            var ret = new SalaryListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {         
                int Result;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        string Command = " EXEC p_del_salary_TA " +
                            " @userID = '" + ds_tokey.empID.ToString() + "', " +
                            " @salaryID = '" + data.salaryID.ToString() + "' ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result == 1)
                        {

                            //This is save log
                            string logevent = "Delete";
                            string logmodules = "DelSalaryList";
                            string olddata = "";
                            string newdata = "SalaryID = " + data.salaryID + ".";
                            insertLog(data.tokenKey, logevent, logmodules, olddata, newdata);

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ລຶບລາຍການເງິນເດືອນ ສໍາເລັດ";
                            }
                            else
                            {
                                ret.ModelErrors = "Delete salary list complete";
                            }
                        }
                        else
                        {

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                        }


                        ret.ResultObject = null;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/CalculateSalary")]
        public CalculateSalaryResult CalculateSalary(CalculateSalaryParam data)
        {
            var ret = new CalculateSalaryResult();
            string set_strDate = "";
            string set_endDate = "";
            string set_salaryMonth = "";
            string set_salaryYear = "";
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {                              
                int Result;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {

                        var ds_salary = (from c in db.tb_salary_list
                                        where (c.transactionNo == data.transactionNo)
                                        select new
                                        {
                                            c.salaryMonth,
                                            c.salaryYear,
                                            c.startdate,
                                            c.enddate
                                        }).FirstOrDefault();
                        if (ds_salary != null)
                        {
                            set_salaryYear = ds_salary.salaryYear.ToString();
                            set_salaryMonth = ds_salary.salaryMonth.ToString();
                            set_strDate = DateTime.Parse(ds_salary.startdate.ToString()).ToString("yyyy-MM-dd");
                            set_endDate = DateTime.Parse(ds_salary.enddate.ToString()).ToString("yyyy-MM-dd");
                        } 





                            string Command = "DECLARE @return_value int; " + 
                            " EXEC	@return_value = p_payment_Cal_TA " +
                            " @userID = '"+ ds_tokey.empID + "', " + 
                            " @ipaddress = N'127.0.0.1', " + 
                            " @monthCal = '"+ set_salaryMonth + "', " +
                            " @YearCal = '" + set_salaryYear + "', " + 
                            " @salary_transactionNo = N'"+ data.transactionNo +"', " +
                            " @cal_strDate = '"+ set_strDate + "', " +
                            " @cal_endDate = '" + set_endDate + "' " +
                            " SELECT  'Return Value' = @return_value";

                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result == 0)
                        {
                            //This is save log
                            string logevent = "New";
                            string logmodules = "CalculateSalaryResult";
                            string olddata = "";
                            string newdata = "monthlCal = " + set_salaryMonth + "; YearCal=" + set_salaryYear + "; salary_transactionNo = " + data.transactionNo +"; startdate = " + set_strDate + "; enddate = " + set_endDate + ".";
                            insertLog(data.tokenKey, logevent, logmodules, olddata, newdata);

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                            }
                            else
                            {
                                ret.ModelErrors = "Save complete";
                            }
                            ret.StatusCode = 200;
                        }
                        else
                        {

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                            ret.StatusCode = 417;
                        }

                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/approveSalary")]
        public SalaryListResult approveSalary(approveSalaryParam data)
        {
            var ret = new SalaryListResult();
           UserController. WriteLogFile("approveSalary => tokenKey:" + data.tokenKey + ";lang:" + data.lang +";salaryID:"+ data.salaryID +";isAoorove:"+ data.isAoorove +";remark:"+data.remark);
            try
            {
                int Result;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        string Command = " DECLARE	@return_value int " +
                            " EXEC @return_value = p_approve_salary " +
                            " @salaryID = '" + data.salaryID.ToString() + "', " +
                            " @isapprove = '" + data.isAoorove.ToString() + "', " +
                            " @remark = N'" + data.remark.ToString() + "', " +
                            " @userID = '" + ds_tokey.empID.ToString() + "', " +
                            " @approveSalary = '" + data.approveSalary + "' " +
                            " SELECT	'ReturnValue' = @return_value ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result >= 0)
                        {
                            string logevent = "";
                            string logmodules = "";
                            //This is save log
                            if (data.approveSalary == 1)
                            {
                                logevent = "Approve";
                                logmodules = "ApproveSalary";
                            }
                            else
                            {
                                logevent = "Reject";
                                logmodules = "Reject Salary";

                            }
                            logevent = "Approve";
                            logmodules = "ApproveSalary";
                            string olddata = "";
                            string newdata = "SalaryID = " + data.salaryID.ToString() + "; isapprove=" + data.isAoorove.ToString() + "; " +
                                "remark = "+ data.remark.ToString() +"; userID = "+ ds_tokey.empID +";.";
                            insertLog(data.tokenKey, logevent, logmodules, olddata, newdata);

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ສໍາເລັດ.";
                            }
                            else
                            {
                                ret.ModelErrors = "Success.";
                            }                          
                            if (data.isAoorove == 8)
                            {

                                var db_salaryList = db.tb_salary_list.Where(w => w.salaryID == data.salaryID).FirstOrDefault();
                                var db_emp = db.tb_employees.Where(w => w.empID == db_salaryList.mgrID).FirstOrDefault();
                                var db_tokenNextApprove = db.tb_users.Where(w => w.empID == db_emp.empID).FirstOrDefault();
                                if (db_emp != null && db_emp.empEmail != null)
                                {
                                    if (data.approveSalary == 1) //This is approve salary
                                    {
                                        string approvermail = db_emp.empEmail == null ? "" : db_emp.empEmail;
                                        string subject = "HRM - Request Approve Salary (" + db_salaryList.salaryMonth.ToString() + "/" + db_salaryList.salaryYear.ToString();
                                        string content = "Hi, " + db_emp.firstName2 + " " + db_emp.lastName2 + Environment.NewLine +
                                        "Please Approve Salary  (" + db_salaryList.salaryMonth.ToString() + "/" + db_salaryList.salaryYear.ToString();
                                        if (approvermail != "" && approvermail != null)
                                        {
                                            Boolean isSendMail = UserController.SendMeail(approvermail, subject, content, "--- FROM Wep App---", db_salaryList.mgrID.ToString(), ds_tokey.empID.ToString(), true, "6");

                                        }

                                        if (db_tokenNextApprove.Device_token != "" && db_tokenNextApprove.Device_token != null)
                                        {
                                            Boolean isNoti = UserController.SingleNotification(db_tokenNextApprove.Device_token.ToString(), subject, content, db_salaryList.mgrID.ToString(), "--- FROM Wep App---", ds_tokey.empID.ToString(), true);
                                        }
                                    }
                                    
                                }
                            }


                        }
                        else
                        {

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                        }


                        ret.ResultObject = null;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/StaffLeaveList")]
        public SumLeaveBalanceListResult StaffLeaveList(SumLeaveBalanceListParam data)
        {
            var ret = new SumLeaveBalanceListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {
                int Result;
                string transactionView;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        transactionView = DateTime.Now.ToString("yyyyMMddHHmmss") + ds_tokey.empID;
                        string Command = " DECLARE	@return_value int " +
                            " EXEC @return_value = p_viewLeaveBalance " +
                            " @viewYear = '" + data.viewYear.ToString() + "', " +
                            " @user_view = '" + ds_tokey.empID.ToString() + "', " +
                            " @ip_view = '', " +
                            " @transactionView = '" + transactionView + "' " +
                            " SELECT	'Return Value' = @return_value ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result == 0)
                        {

                            var ds_Data = (from c in db.tmp_viewSumLeave
                                           where c.user_view == ds_tokey.empID && c.transactionView == transactionView
                                           select new
                                           {
                                               c.empID,
                                               c.empNo,
                                               c.fullName1,
                                               c.fullName2,
                                               c.empPosition,
                                               c.deptName1,
                                               c.deptName2,
                                               c.totalDay1,
                                               c.totalDay2,
                                               c.totalDay3,
                                               c.totalDay4
                                           }).ToList();

                            if (ds_Data != null)
                            {
                                List<SumLeaveBalanceListModelResult> ResultObject = new List<SumLeaveBalanceListModelResult>();
                                ResultObject = ds_Data.Select(c => new SumLeaveBalanceListModelResult()
                                {
                                    empID = c.empID.ToString(),
                                    empNo = c.empNo.ToString(),
                                    fullName = data.lang == "1" ?  c.fullName1.ToString() : c.fullName2.ToString(),
                                    empPosition = c.empPosition == null ? "" : c.empPosition.ToString(),
                                    deptName = data.lang == "1" ? c.deptName1 == null ? "" : c.deptName1.ToString() : c.deptName2 == null ? "" : c.deptName2.ToString(),
                                    totalDay_SL = c.totalDay1.ToString(),
                                    totalDay_AL = c.totalDay2.ToString(),
                                    totalDay_CL = c.totalDay3.ToString(),
                                    totalDay_DIL = c.totalDay4.ToString(),
                                }).ToList();
                                ret.ModelErrors = null;
                                ret.ResultObject = ResultObject;
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.CommonErrors = null;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Don't have Employee list ...!";
                                ret.ResultObject = null;
                                ret.StatusCode = 405;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "No Employee list";
                                return ret;
                            }                            
                        }
                        else
                        {
                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                        }

                        ret.ResultObject = null;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/adjustLeave")]
        public SumLeaveBalanceListResult adjustLeave(AdjustLeaveBalanceParam data)
        {
            var ret = new SumLeaveBalanceListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {
                int Result;
                string transactionView;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        transactionView = DateTime.Now.ToString("yyyyMMddHHmmss") + ds_tokey.empID;

                        string Command = " DECLARE	@return_value int " +
                            " EXEC @return_value = p_adjustLeave " +
                            " @empid = '" + data.empID.ToString() + "', " +
                            " @adjust_sl = '" + data.adjust_sl + "', " +
                            " @adjust_al = '" + data.adjust_al + "', " +
                            " @adjust_cl = '" + data.adjust_cl + "', " +
                            " @adjust_dil = '" + data.adjust_dil + "', " +
                            " @noted = N'" + data.remark.ToString() + "', " +
                            " @leaveRequestNo = N'"+ transactionView  + "', " +
                            " @userAdd = '" + ds_tokey.empID.ToString() + "' " +
                            " SELECT	'Return Value' = @return_value ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result == 0)
                        {

                            //This is save log
                            string logevent = "Adjust";
                            string logmodules = "AdjustLeave";
                            string olddata = "";
                            string newdata = "empid = " + data.empID.ToString() + "; adjust_sl=" + data.adjust_sl + " adjust_al=" + data.adjust_al + "; " +
                                "adjust_cl=" + data.adjust_cl + "; adjust_dil=" + data.adjust_dil + "; noted=" + data.remark.ToString() + "; LeaveRequestNo=" + transactionView + " .";
                            insertLog(data.tokenKey, logevent, logmodules, olddata, newdata);


                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                            }
                            else
                            {
                                ret.ModelErrors = "Save complete";
                            }
                            ret.StatusCode = 200;                           
                        }
                        else
                        {
                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                            ret.StatusCode = 417;
                        }

                        ret.ResultObject = null;                      
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/SetLanguages")]
        public SumLeaveBalanceListResult SetLanguages(SumLeaveBalanceListParam data)
        {
            var ret = new SumLeaveBalanceListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            try
            {
                int Result;
                string transactionView;
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID,
                                        c.userID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        transactionView = DateTime.Now.ToString("yyyyMMddHHmmss") + ds_tokey.empID;
                        string Command = " DECLARE	@return_value int " +
                            " EXEC @return_value = p_set_lang " +
                            " @userID = '" + ds_tokey.userID.ToString() + "', " +
                            " @langID = '" + data.lang.ToString() + "' " +                          
                            " SELECT	'Return Value' = @return_value ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (int)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result == 0)
                        {

                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "";
                            }
                            else
                            {
                                ret.ModelErrors = "";
                            }

                        }
                        else
                        {
                            if (data.lang == "1")
                            {
                                ret.ModelErrors = "ເກີດຂໍ້ຜິດພາດ, ກະລຸນາລອງໃໝ່ອີກຄັ້ງ ...!";
                            }
                            else
                            {
                                ret.ModelErrors = "Fail, Please try again ...!";
                            }
                        }

                        ret.ResultObject = null;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
             //   UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }



        [HttpPost]
        [Route("api/Function/viewImageRequestList")]
        public ViewImageRequestResult viewImageRequestList(ViewImageRequestParam data)
        {
            var ret = new ViewImageRequestResult();
         //   List<ViewImageRequestListViewModel> ResultObject = new List<ViewImageRequestListViewModel>();
            try
            {
                int GET_UserID;
                int Set_ReqID = int.Parse(data.requestID.ToString());
                // WriteLogFile("View Image " + data.tokenKey);
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID,
                                        c.userID,
                                        c.Device_token
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        GET_UserID = int.Parse(ds_tokey.empID.ToString());
                        var ds_EmpInfo = (from c in db.tb_request_upload
                                          where c.leaveRequestID == Set_ReqID
                                          select new
                                          {                                             
                                              c.leaveRequestID,                                          
                                              c.img,
                                              c.tb_leaveRequest.imagePath,
                                              c.tb_leaveRequest.fileAttached
                                          }).FirstOrDefault();
                        if (ds_EmpInfo != null)
                        {
                            //ResultObject = ds_EmpInfo.Select(c => new ViewImageRequestListViewModel()
                            //{
                            //    fileName = c.imagePath.Substring(c.imagePath.LastIndexOf("/") + 1),
                            //    imageFile = viewImageRequestFile(c.imagePath.ToString())

                            //}).ToList();

                            //ret.fileName = ds_EmpInfo.imagePath.Substring(ds_EmpInfo.imagePath.LastIndexOf("/") + 1);
                            ret.fileName = ds_EmpInfo.fileAttached.ToString();
                            ret.imageFile = viewImageRequestFile(ds_EmpInfo.imagePath.ToString() + ds_EmpInfo.fileAttached.ToString());

                        }
                        ret.ModelErrors = "View image file successful";
                        // ret.ResultObject = ResultObject;
                       
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;

                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        //  ret.ResultObject = null;
                        ret.fileName = null;
                        ret.imageFile = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
               UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error: request Image :" + ex.Message;
                // ret.ResultObject = null;
                ret.fileName = null;
                ret.imageFile = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/sumtranbank")]
        public sumtranbankResult sumtranbank(sumtranbankParam data)
        {
            var ret = new sumtranbankResult();
            // WriteLogFile("IncomeTypeListResult " + data.TokenKey);
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                        // where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_view == 1
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_emp = (from c in db.tb_paymentRecord   
                                      where c.monthCal == data.monthCal && c.YearCal == data.yearCal                               
                                      group c by c.bankName  into g
                                      select  new 
                                      {
                                        bankName =  g.Key,  
                                        countFee = g.Count() * 500,
                                        sumTotal = g.Sum(x => x.NetToPay),
                                        sumTotalFee = (g.Count() * 500) + g.Sum(x => x.NetToPay)
                                      }).ToList();

                        if (ds_emp != null && ds_emp.Any())
                        {
                            List<sumtranbankModelResult> ResultObject = new List<sumtranbankModelResult>();
                            ResultObject = ds_emp.Select(c => new sumtranbankModelResult()
                            {
                                bankName = c.bankName,            
                                sumFee = c.countFee.ToString("#,##0"),                    
                                sumTotal = c.sumTotal.ToString("#,##0"),
                                sumTotalFee = c.sumTotalFee.ToString("#,##0")
                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
               UserController. WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        //[HttpPost]
        //[Route("api/Function/groupDepartment")]
        //public departmentGroupListResult groupDepartment(SalaryListDetailParam data)
        //{
        //    var ret = new departmentGroupListResult();
        //    // WriteLogFile("deptList " + data.TokenKey);

        //    try
        //    {
        //        int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
        //        if (data.yearView != 0)
        //        {
        //            NewYearView = data.yearView;
        //        }
        //        using (var db = new db_hrmsEntities())
        //        {
        //            var ds_tokey = (from c in db.v_user_permission
        //                            where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
        //                            select new
        //                            {
        //                                c.empID
        //                            }).FirstOrDefault();
        //            if (ds_tokey != null)
        //            {
        //                var ds_Data = (from c in db.tb_deptGroup
        //                               where c.status_id == 1 
        //                               orderby c.deptGroupID ascending
        //                               select new
        //                               {
        //                                   c.deptGroupID,
        //                                   c.deptCode,
        //                                   c.depgroupName 
        //                               }).ToList();
        //                if (ds_Data != null)
        //                {
        //                    List<departmentGroupListDetailModelResult> ResultObject = new List<departmentGroupListDetailModelResult>();
        //                    ResultObject = ds_Data.Select(c => new departmentGroupListDetailModelResult()
        //                    {
        //                        deptGroupCode = c.deptCode.ToString(),
        //                        deptGroupName = c.depgroupName.ToString() 
        //                    }).ToList();
        //                    ret.ModelErrors = null;
        //                    ret.ResultObject = ResultObject;
        //                    ret.StatusCode = 200;
        //                    ret.IsSuccess = true;
        //                    ret.CommonErrors = null;
        //                    return ret;
        //                }
        //                else
        //                {
        //                    ret.ModelErrors = "Don't have data ...!";
        //                    ret.ResultObject = null;
        //                    ret.StatusCode = 405;
        //                    ret.IsSuccess = false;
        //                    ret.CommonErrors = "No data";
        //                    return ret;
        //                }
        //            }
        //            else
        //            {
        //                ret.ModelErrors = "Unauthorized";
        //                ret.ResultObject = null;
        //                ret.StatusCode = 401;
        //                ret.IsSuccess = false;
        //                ret.CommonErrors = "Token key not correct ...!";
        //                return ret;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        UserController.WriteLogFile(ex.Message);
        //        ret.ModelErrors = "Error" + ex.Message;
        //        ret.ResultObject = null;
        //        ret.StatusCode = 417;
        //        ret.IsSuccess = false;
        //        ret.CommonErrors = "Expectation Failed";
        //        return ret;
        //    }
        //}



        [HttpPost]
        [Route("api/Function/rpt1005")]
        public SalaryListDetailResult rpt1005(SalaryListDetailParam data)
        {
            var ret = new SalaryListDetailResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView && c.deductTaxs > 0
                                       orderby c.deptGroupCode ascending, c.costCenterCode ascending
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.orderNo,
                                           c.monthCal,
                                           c.YearCal,
                                           c.MYCal,
                                           c.costCenterCode,
                                           c.costCenterText,
                                           c.deptCode,
                                           c.deptName1,
                                           c.deptName2,
                                           c.unitCode,
                                           c.unitName1,
                                           c.unitName2,
                                           c.empID,
                                           c.empNo,
                                           c.empDayID,
                                           c.empType,
                                           c.oldSalary,
                                           c.incrementSalary,
                                           c.basicSalary,
                                           c.shiftIncome1,
                                           c.shiftIncome2,
                                           c.shiftIncome3,
                                           c.shiftIncome,
                                           c.overtimeIncome1,
                                           c.overtimeIncome2,
                                           c.overtimeIncome3,
                                           c.overtimeIncome4,
                                           c.overtimeIncome5,
                                           c.overtimeIncome,
                                           c.threshingIncom,
                                           c.additionalPay,
                                           c.additionalDeduct,
                                           c.deductDayOff,
                                           c.allowance_phone,
                                           c.allowance_fuel,
                                           c.allowance_housing,
                                           c.allowance_car,
                                           c.allowance,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.grossIncome,
                                           c.deductEmpSSO,
                                           c.tax_b1,
                                           c.tax_b2,
                                           c.tax_b3,
                                           c.tax_b4,
                                           c.tax_b5,
                                           c.tax_b6,
                                           c.tax_extra,
                                           c.deductTaxs,
                                           c.deductLoan,
                                           c.deductFHF,
                                           c.deduct_SLDRT_fun,
                                           c.deductOther,
                                           c.canteenNET,
                                           c.OtherAllowanNET,
                                           c.severanceBook,
                                           c.NetToPay,
                                           c.employerSSO,
                                           c.grossLastMonth,
                                           c.grossVariance,
                                           c.noted,
                                           c.empName1,
                                           c.empName2,
                                           c.netIncome,
                                           c.saleIncentive,
                                           c.workdayID
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<SalaryListDetailModelResult> ResultObject = new List<SalaryListDetailModelResult>();
                            ResultObject = ds_Data.Select(c => new SalaryListDetailModelResult()
                            {
                                salaryID = c.salaryID.ToString(),
                                //costCenterCode = c.costCenterCode.ToString(),

                                costCenterCode = c.costCenterCode== null ? "" : c.costCenterCode.ToString(),

                                deptCode = c.deptCode.ToString(),
                                unitCode = c.unitCode.ToString(),
                                empNo = c.empNo.ToString(),
                                empDayID = c.empDayID.ToString(),
                                empType = c.empType == null ? "" : c.empType.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                saleIncentive = c.saleIncentive.ToString("#,##0"),
                                grossIncome = (c.grossIncome - c.deductEmpSSO).ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductOther + c.deductLoan).ToString("#,##0"),
                                deduct_loan = c.deductLoan.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = c.noted.ToString(),
                                empName = data.lang == "1" ? c.empName1.ToString() : c.empName2.ToString(),
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll = "0",
                                sumgrossincome_empsso = (float)c.grossIncome - (float)c.deductEmpSSO,
                                grossincome_empsso = ((float)c.grossIncome - (float)c.deductEmpSSO).ToString("#,##0"),
                                workingid = c.workdayID == null ? "" : c.workdayID.ToString()
                            }).ToList();


                            var ds_sum = (from c in db.tb_paymentRecord
                                          where c.monthCal == data.monthView && c.YearCal == data.yearView && c.deductTaxs > 0
                                          group c by new { c.monthCal, c.YearCal } into g

                                          select new
                                          {
                                              oldSalary = g.Sum(s => s.oldSalary),
                                              incrementSalary = g.Sum(s => s.incrementSalary),
                                              basicSalary = g.Sum(s => s.basicSalary),
                                              shiftIncome = g.Sum(s => s.shiftIncome),
                                              overtimeIncome = g.Sum(s => s.overtimeIncome),
                                              threshingIncom = g.Sum(s => s.threshingIncom),
                                              additionalPay = g.Sum(s => s.additionalPay),
                                              additionalDeduct = g.Sum(s => s.additionalDeduct),
                                              deductDayOff = g.Sum(s => s.deductDayOff),
                                              allowance = g.Sum(s => s.allowance),
                                              grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                              advanceBonus = g.Sum(s => s.advanceBonus),
                                              saleIncentive = g.Sum(s => s.saleIncentive),
                                              grossIncome = g.Sum(s => s.grossIncome - s.deductEmpSSO),
                                              deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                              deductTaxs = g.Sum(s => s.deductTaxs),
                                              deductLoan = g.Sum(s => s.deductLoan),
                                              deductFHF = g.Sum(s => s.deductFHF + s.deductLoan + s.deductOther),
                                              deduct_SLDRT_fun = g.Sum(s => s.deduct_SLDRT_fun),
                                              deductOther = g.Sum(s => s.deductOther),
                                              canteenNET = g.Sum(s => s.canteenNET),
                                              OtherAllowanNET = g.Sum(s => s.OtherAllowanNET),
                                              severanceBook = g.Sum(s => s.severanceBook),
                                              NetToPay = g.Sum(s => s.NetToPay),
                                              employerSSO = g.Sum(s => s.employerSSO),
                                              grossLastMonth = g.Sum(s => s.grossLastMonth),
                                              grossVariance = g.Sum(s => s.grossVariance),
                                              netIncome = g.Sum(s => s.netIncome),
                                              tax_b1 = g.Sum(s => s.tax_b1),
                                              tax_b2 = g.Sum(s => s.tax_b2),
                                              tax_b3 = g.Sum(s => s.tax_b3),
                                              tax_b4 = g.Sum(s => s.tax_b4),
                                              tax_b5 = g.Sum(s => s.tax_b5),
                                              tax_b6 = g.Sum(s => s.tax_b6),
                                              tax_extra = g.Sum(s => s.tax_extra),
                                              sumAll = "1",

                                          }).ToList();

                            List<SalaryListDetailModelResult> ResultObject_sum = new List<SalaryListDetailModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new SalaryListDetailModelResult()
                            {
                                salaryID = "",
                                costCenterCode = "",
                                deptCode = "",
                                unitCode = "",
                                empNo = "",
                                empDayID = "",
                                empType = "",
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                advanceBonus = c.advanceBonus.ToString("#,##0"),
                                saleIncentive = c.saleIncentive.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = c.deductFHF.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = "",
                                empName = "",
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                sumAll = "1"
                            }).ToList();



                            ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }



        [HttpPost]
        [Route("api/Function/rpt1006_1")]
        public rpt1006ListResult rpt1006(rpt1006ListParam data)
        {
            var ret = new rpt1006ListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            string Result;
            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearCal != 0)
                {
                    NewYearView = data.yearCal;
                }
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {

                        string Command = " EXEC   p_rpt1006 " +
                          " @monthCal = '" + data.monthCal.ToString() + "',  " +
                          " @YearCal = '" + data.yearCal.ToString() + "',  " +
                          " @userID = '" + ds_tokey.empID.ToString() + "'  "; 
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (string) myCommand.ExecuteScalar();
                            }
                        }
                        if (Result != "")
                        {
                            var ds_Data = (from c in db.tmp_rpt1006
                                           where c.transactionNo == Result.ToString().Trim() && c.viewsheet == 1 
                                           orderby c.deptGroupCode ascending, c.deptName ascending
                                           select new
                                           {
                                               c.deptGroupCode,
                                               c.deptGroupName,
                                               c.staffCount,
                                               c.deptName,
                                               c.grossSalaryBenefits,
                                               c.advanceBonus,
                                               c.deductEmpSSO,
                                               c.deductTaxs,
                                               c.netIncome,
                                               c.loan_phone_FHF,
                                               c.sldrtFund,
                                               c.canteenOther,
                                               c.leaveingPackage,
                                               c.netToPay,
                                               c.employerSSO,
                                               c.netToPayfromMasterData,
                                               c.variance,
                                               c.remark,
                                               c.viewsheet,
                                               c.topic,
                                               c.deptCode,
                                               c.transactionNo
                                           }).ToList();
                            if (ds_Data != null)
                            {
                                List<rpt1006ModelResult> ResultObject = new List<rpt1006ModelResult>();
                                ResultObject = ds_Data.Select(c => new rpt1006ModelResult()
                                {
                                    transactionNo = c.transactionNo.ToString(),
                                    deptGroupCode = c.deptGroupCode == null ? "": c.deptGroupCode.ToString().Trim(),
                                    deptGroupName = c.deptGroupName == null ? "": c.deptGroupName.ToString().Trim(),
                                    staffCount = c.staffCount == null ?"": Convert.ToDouble(c.staffCount).ToString("#,##0"),
                                    deptname = c.deptName == null ? "": c.deptName.ToString().Trim(),
                                    deptCode = c.deptCode==null ? "" : c.deptCode.ToString().Trim(),
                                    grossSalaryBenefits = Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0"),
                                    advanceBonus = Convert.ToDouble(c.advanceBonus).ToString("#,##0"),
                                    deductEmpSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                    deductTaxs = Convert.ToDouble(c.deductTaxs).ToString("#,##0"),
                                    grossIncome = Convert.ToDouble(c.netIncome).ToString("#,##0"),
                                    deductFHFdeductOther = Convert.ToDouble(c.loan_phone_FHF).ToString("#,##0"),
                                    deduct_SLDRT_fun = Convert.ToDouble(c.sldrtFund).ToString("#,##0"),
                                    canteenNET = Convert.ToDouble(c.canteenOther).ToString("#,##0"),
                                    netToPay = Convert.ToDouble(c.netToPay).ToString("#,##0"),
                                    employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                    netToPayMaster = Convert.ToDouble(c.netToPayfromMasterData).ToString("#,##0"),
                                    variance = Convert.ToDouble(c.variance).ToString("#,##0"),
                                    leavingPackage = Convert.ToDouble(c.leaveingPackage).ToString("#,##0"),
                                    remark = "",
                                    topic = c.topic.ToString(),
                                    sumAll = "0"

                                }).ToList();



                                var ds_sum = (from c in db.tmp_rpt1006
                                              where c.transactionNo == Result.ToString().Trim() && c.viewsheet == 1 && c.topic == 1
                                              group c by new { c.transactionNo } into g

                                              select new
                                              {
                                                  transactionNo = "",
                                                  deptGroupCode = "",
                                                  deptGroupName = "",
                                                  staffCount = g.Sum(s => s.staffCount),                                                
                                                  deptname = "",
                                                  deptCode = "",
                                                  grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                                  advanceBonus = g.Sum(s => s.advanceBonus),
                                                  deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                                  deductTaxs = g.Sum(s => s.deductTaxs),
                                                  grossIncome = g.Sum(s => s.netIncome),
                                                  deductFHFdeductOther = g.Sum(s => s.loan_phone_FHF),
                                                  deduct_SLDRT_fun = g.Sum(s => s.sldrtFund),
                                                  canteenNET = g.Sum(s => s.canteenOther),
                                                  netToPay = g.Sum(s => s.netToPay),
                                                  employerSSO = g.Sum(s => s.employerSSO),
                                                  netToPayMaster = g.Sum(s => s.netToPayfromMasterData),
                                                  variance = g.Sum(s => s.variance),
                                                  leavingPackage = g.Sum(s => s.leaveingPackage),
                                                  remark = "",
                                                  topic = "0",                                                
                                                  sumAll = "1",

                                              }).ToList();

                                List<rpt1006ModelResult> ResultObject_sum = new List<rpt1006ModelResult>();
                                ResultObject_sum = ds_sum.Select(c => new rpt1006ModelResult()
                                {
                                    transactionNo = c.transactionNo != null ? c.transactionNo.ToString() : "",
                                    deptGroupCode = "",
                                    deptGroupName = "",
                                    staffCount =   Convert.ToDouble(c.staffCount -2).ToString("#,##0"),
                                    deptname = "",
                                    deptCode = "",
                                    grossSalaryBenefits = c.grossSalaryBenefits !=null ? Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0")  : "0",
                                    advanceBonus = c.advanceBonus != null ? Convert.ToDouble(c.advanceBonus).ToString("#,##0")  : "0",
                                    deductEmpSSO = c.deductEmpSSO != null ? Convert.ToDouble(c.deductEmpSSO).ToString("#,##0") : "0",
                                    deductTaxs = c.deductTaxs != null ? Convert.ToDouble(c.deductTaxs).ToString("#,##0") : "0",
                                    grossIncome = c.grossIncome != null ? Convert.ToDouble(c.grossIncome).ToString("#,##0") : "0",
                                    deductFHFdeductOther = c.deductFHFdeductOther != null ? Convert.ToDouble(c.deductFHFdeductOther).ToString("#,##0") : "0",
                                    deduct_SLDRT_fun = c.deduct_SLDRT_fun != null ? Convert.ToDouble(c.deduct_SLDRT_fun).ToString("#,##0") : "0",
                                    canteenNET = c.canteenNET != null ? Convert.ToDouble(c.canteenNET).ToString("#,##0") : "0",
                                    netToPay = c.netToPay != null ? Convert.ToDouble(c.netToPay).ToString("#,##0") : "0",
                                    employerSSO = c.employerSSO != null ? Convert.ToDouble(c.employerSSO).ToString("#,##0") : "0",
                                    netToPayMaster = c.netToPayMaster != null ? Convert.ToDouble(c.netToPayMaster).ToString("#,##0") : "0",
                                    variance = c.variance != null ? Convert.ToDouble(c.variance).ToString("#,##0") : "0",
                                    leavingPackage = c.leavingPackage != null ? Convert.ToDouble(c.leavingPackage).ToString("#,##0") : "0",
                                    remark = "",
                                    topic = "0",
                                    sumAll = "1",
                                }).ToList();



                                ResultObject.AddRange(ResultObject_sum);


                                ret.ModelErrors = null;
                                ret.ResultObject = ResultObject;
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.CommonErrors = null;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Don't have data ...!";
                                ret.ResultObject = null;
                                ret.StatusCode = 405;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "No data";
                                return ret;
                            }
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                           
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/rpt1006_2")]
        public rpt1006ListResult rpt1006_2(rpt1006_2ListParam data)
        {
            var ret = new rpt1006ListResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {       
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tmp_rpt1006
                                       where c.transactionNo == data.transactionNo.ToString().Trim() && c.viewsheet == 2
                                       orderby c.deptGroupCode ascending, c.deptName ascending
                                       select new
                                       {
                                           c.deptGroupCode,
                                           c.deptGroupName,
                                           c.deptName,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.deductEmpSSO,
                                           c.deductTaxs,
                                           c.netIncome,
                                           c.loan_phone_FHF,
                                           c.sldrtFund,
                                           c.canteenOther,
                                           c.leaveingPackage,
                                           c.netToPay,
                                           c.employerSSO,
                                           c.netToPayfromMasterData,
                                           c.variance,
                                           c.remark,
                                           c.viewsheet,
                                           c.staffCount,
                                           c.topic,
                                           c.deptCode,
                                           c.transactionNo
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1006ModelResult> ResultObject = new List<rpt1006ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1006ModelResult()
                            {
                                transactionNo = c.transactionNo.ToString(),
                                deptGroupCode = c.deptGroupCode == null ? "" : c.deptGroupCode.ToString().Trim(),
                                deptGroupName = c.deptGroupName == null ? "" : c.deptGroupName.ToString().Trim(),
                                staffCount = Convert.ToDouble(c.staffCount).ToString("#,##0"),
                                deptname = c.deptName == null ? "" : c.deptName.ToString().Trim(),
                                deptCode = c.deptCode == null ? "" : c.deptCode.ToString().Trim(),
                                grossSalaryBenefits = Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0"),
                                advanceBonus = Convert.ToDouble(c.advanceBonus).ToString("#,##0"),
                                deductEmpSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                deductTaxs = Convert.ToDouble(c.deductTaxs).ToString("#,##0"),
                                grossIncome = Convert.ToDouble(c.netIncome).ToString("#,##0"),
                                deductFHFdeductOther = Convert.ToDouble(c.loan_phone_FHF).ToString("#,##0"),
                                deduct_SLDRT_fun = Convert.ToDouble(c.sldrtFund).ToString("#,##0"),
                                canteenNET = Convert.ToDouble(c.canteenOther).ToString("#,##0"),
                                netToPay = Convert.ToDouble(c.netToPay).ToString("#,##0"),
                                employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                netToPayMaster = Convert.ToDouble(c.netToPayfromMasterData).ToString("#,##0"),
                                variance = Convert.ToDouble(c.variance).ToString("#,##0"),
                                leavingPackage = Convert.ToDouble(c.leaveingPackage).ToString("#,##0"),
                                remark = "",
                                topic = c.topic.ToString(),
                                 sumAll = "0"
                            }).ToList();



                            var ds_sum = (from c in db.tmp_rpt1006
                                          where c.transactionNo == data.transactionNo.ToString().Trim() && c.viewsheet == 2 && c.topic == 1
                                          group c by new { c.transactionNo } into g

                                          select new
                                          {
                                              transactionNo = "",
                                              deptGroupCode = "",
                                              deptGroupName = "",
                                              staffCount = g.Sum(s => s.staffCount),
                                              deptname = "",
                                              deptCode = "",
                                              grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                              advanceBonus = g.Sum(s => s.advanceBonus),
                                              deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                              deductTaxs = g.Sum(s => s.deductTaxs),
                                              grossIncome = g.Sum(s => s.netIncome),
                                              deductFHFdeductOther = g.Sum(s => s.loan_phone_FHF),
                                              deduct_SLDRT_fun = g.Sum(s => s.sldrtFund),
                                              canteenNET = g.Sum(s => s.canteenOther),
                                              netToPay = g.Sum(s => s.netToPay),
                                              employerSSO = g.Sum(s => s.employerSSO),
                                              netToPayMaster = g.Sum(s => s.netToPayfromMasterData),
                                              variance = g.Sum(s => s.variance),
                                              leavingPackage = g.Sum(s => s.leaveingPackage),
                                              remark = "",
                                              topic = "0",
                                              sumAll = "1",

                                          }).ToList();

                            List<rpt1006ModelResult> ResultObject_sum = new List<rpt1006ModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new rpt1006ModelResult()
                            {
                                transactionNo = c.transactionNo.ToString(),
                                deptGroupCode = "",
                                deptGroupName = "",
                                staffCount = Convert.ToDouble(c.staffCount -2).ToString("#,##0"),
                                deptname = "",
                                deptCode = "",
                                grossSalaryBenefits = Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0"),
                                advanceBonus = Convert.ToDouble(c.advanceBonus).ToString("#,##0"),
                                deductEmpSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                deductTaxs = Convert.ToDouble(c.deductTaxs).ToString("#,##0"),
                                grossIncome = Convert.ToDouble(c.grossIncome).ToString("#,##0"),
                                deductFHFdeductOther = Convert.ToDouble(c.deductFHFdeductOther).ToString("#,##0"),
                                deduct_SLDRT_fun = Convert.ToDouble(c.deduct_SLDRT_fun).ToString("#,##0"),
                                canteenNET = Convert.ToDouble(c.canteenNET).ToString("#,##0"),
                                netToPay = Convert.ToDouble(c.netToPay).ToString("#,##0"),
                                employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                netToPayMaster = Convert.ToDouble(c.netToPayMaster).ToString("#,##0"),
                                variance = Convert.ToDouble(c.variance).ToString("#,##0"),
                                leavingPackage = Convert.ToDouble(c.leavingPackage).ToString("#,##0"),
                                remark = "",
                                topic = "0",
                                sumAll = "1",
                            }).ToList();

                            ResultObject.AddRange(ResultObject_sum);
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/rpt1006_3")]
        public rpt1006ListResult rpt1006_3(rpt1006_2ListParam data)
        {
            var ret = new rpt1006ListResult();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {                              
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tmp_rpt1006
                                       where c.transactionNo ==data.transactionNo.ToString().Trim() && c.viewsheet == 3
                                       orderby c.deptGroupCode ascending, c.deptName ascending
                                       select new
                                       {
                                           c.deptGroupCode,
                                           c.deptGroupName,
                                           c.deptName,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.deductEmpSSO,
                                           c.deductTaxs,
                                           c.netIncome,
                                           c.loan_phone_FHF,
                                           c.sldrtFund,
                                           c.canteenOther,
                                           c.leaveingPackage,
                                           c.netToPay,
                                           c.employerSSO,
                                           c.netToPayfromMasterData,
                                           c.variance,
                                           c.remark,
                                           c.viewsheet,
                                           c.staffCount,
                                           c.topic,
                                           c.deptCode,
                                           c.transactionNo
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1006ModelResult> ResultObject = new List<rpt1006ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1006ModelResult()
                            {
                                transactionNo = c.transactionNo.ToString(),
                                deptGroupCode = c.deptGroupCode == null ? "" : c.deptGroupCode.ToString().Trim(),
                                deptGroupName = c.deptGroupName == null ? "" : c.deptGroupName.ToString().Trim(),
                                staffCount = Convert.ToDouble(c.staffCount).ToString("#,##0"),
                                deptname = c.deptName == null ? "" : c.deptName.ToString().Trim(),
                                deptCode = c.deptCode == null ? "" : c.deptCode.ToString().Trim(),
                                grossSalaryBenefits = Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0"),
                                advanceBonus = Convert.ToDouble(c.advanceBonus).ToString("#,##0"),
                                deductEmpSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                deductTaxs = Convert.ToDouble(c.deductTaxs).ToString("#,##0"),
                                grossIncome = Convert.ToDouble(c.netIncome).ToString("#,##0"),
                                deductFHFdeductOther = Convert.ToDouble(c.loan_phone_FHF).ToString("#,##0"),
                                deduct_SLDRT_fun = Convert.ToDouble(c.sldrtFund).ToString("#,##0"),
                                canteenNET = Convert.ToDouble(c.canteenOther).ToString("#,##0"),
                                netToPay = Convert.ToDouble(c.netToPay).ToString("#,##0"),
                                employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                netToPayMaster = Convert.ToDouble(c.netToPayfromMasterData).ToString("#,##0"),
                                variance = Convert.ToDouble(c.variance).ToString("#,##0"),
                                leavingPackage = Convert.ToDouble(c.leaveingPackage).ToString("#,##0"),
                                remark = "",
                                topic = c.topic.ToString(),
                                 sumAll = "0"
                            }).ToList();

                            var ds_sum = (from c in db.tmp_rpt1006
                                          where c.transactionNo == data.transactionNo.ToString().Trim() && c.viewsheet == 3 && c.topic == 1
                                          group c by new { c.transactionNo } into g

                                          select new
                                          {
                                              transactionNo = "",
                                              deptGroupCode = "",
                                              deptGroupName = "",
                                              staffCount = g.Sum(s => s.staffCount),
                                              deptname = "",
                                              deptCode = "",
                                              grossSalaryBenefits = g.Sum(s => s.grossSalaryBenefits),
                                              advanceBonus = g.Sum(s => s.advanceBonus),
                                              deductEmpSSO = g.Sum(s => s.deductEmpSSO),
                                              deductTaxs = g.Sum(s => s.deductTaxs),
                                              grossIncome = g.Sum(s => s.netIncome),
                                              deductFHFdeductOther = g.Sum(s => s.loan_phone_FHF),
                                              deduct_SLDRT_fun = g.Sum(s => s.sldrtFund),
                                              canteenNET = g.Sum(s => s.canteenOther),
                                              netToPay = g.Sum(s => s.netToPay),
                                              employerSSO = g.Sum(s => s.employerSSO),
                                              netToPayMaster = g.Sum(s => s.netToPayfromMasterData),
                                              variance = g.Sum(s => s.variance),
                                              leavingPackage = g.Sum(s => s.leaveingPackage),
                                              remark = "",
                                              topic = "0",
                                              sumAll = "1",

                                          }).ToList();

                            List<rpt1006ModelResult> ResultObject_sum = new List<rpt1006ModelResult>();
                            ResultObject_sum = ds_sum.Select(c => new rpt1006ModelResult()
                            {
                                transactionNo = c.transactionNo.ToString(),
                                deptGroupCode = "",
                                deptGroupName = "",
                                staffCount = Convert.ToDouble(c.staffCount - 2).ToString("#,##0"),
                                deptname = "",
                                deptCode = "",
                                grossSalaryBenefits = Convert.ToDouble(c.grossSalaryBenefits).ToString("#,##0"),
                                advanceBonus = Convert.ToDouble(c.advanceBonus).ToString("#,##0"),
                                deductEmpSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                deductTaxs = Convert.ToDouble(c.deductTaxs).ToString("#,##0"),
                                grossIncome = Convert.ToDouble(c.grossIncome).ToString("#,##0"),
                                deductFHFdeductOther = Convert.ToDouble(c.deductFHFdeductOther).ToString("#,##0"),
                                deduct_SLDRT_fun = Convert.ToDouble(c.deduct_SLDRT_fun).ToString("#,##0"),
                                canteenNET = Convert.ToDouble(c.canteenNET).ToString("#,##0"),
                                netToPay = Convert.ToDouble(c.netToPay).ToString("#,##0"),
                                employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                netToPayMaster = Convert.ToDouble(c.netToPayMaster).ToString("#,##0"),
                                variance = Convert.ToDouble(c.variance).ToString("#,##0"),
                                leavingPackage = Convert.ToDouble(c.leavingPackage).ToString("#,##0"),
                                remark = "",
                                topic = "0",
                                sumAll = "1",
                            }).ToList();



                            ResultObject.AddRange(ResultObject_sum);


                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/rpt1008")]
        public rpt1008Result rpt1008(SalaryListDetailParam data)
        {
            var ret = new rpt1008Result();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView 
                                       group c by new { c.monthCal, c.YearCal } into g                                       
                                       select new
                                       {
                                           employeeSSO = g.Sum(s => s.deductEmpSSO),
                                           employerSSO = g.Sum(s => s.employerSSO),
                                           sumAll = g.Sum(s => s.employerSSO) + g.Sum(s => s.deductEmpSSO)
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1008ModelResult> ResultObject = new List<rpt1008ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1008ModelResult()
                            {
                                employeeSSO = (c.employeeSSO + 495000).ToString("#,##0"),
                                employerSSO = (c.employerSSO + 540000).ToString("#,##0") ,
                                sumAll =  (c.sumAll + 1035000).ToString("#,##0")
                            }).ToList(); 
                            
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }



        [HttpPost]
        [Route("api/Function/rpt1011")]
        public rpt1011ListResult rpt1011(rpt1006ListParam data)
        {
            var ret = new rpt1011ListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            string Result;
            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearCal != 0)
                {
                    NewYearView = data.yearCal;
                }
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {

                        string Command = " EXEC   p_rpt1011 " +
                          " @monthCal = '" + data.monthCal.ToString() + "',  " +
                          " @YearCal = '" + data.yearCal.ToString() + "',  " +
                          " @userID = '" + ds_tokey.empID.ToString() + "'  ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (string)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result != "")
                        {
                            var ds_Data = (from c in db.tmp_rpt1011
                                           where c.transactionNo == Result.ToString().Trim() 
                                           orderby c.deptGroupCode ascending, c.unitName ascending
                                           select new
                                           {
                                               c.deptGroupCode,
                                               c.deptGroupName,
                                               c.costCenter,
                                               c.unitName,
                                               c.total_active,
                                               c.permanent_active,
                                               c.fixed_perary_active,
                                               c.permanaent_NoActive,
                                               c.groupInHCR,
                                               c.transactionNo
                                           }).ToList();
                            if (ds_Data != null)
                            {
                                List<rpt1011ModelResult> ResultObject = new List<rpt1011ModelResult>();
                                ResultObject = ds_Data.Select(c => new rpt1011ModelResult()
                                {
                                    transactionNo = c.transactionNo.ToString(),
                                    deptGroupCode = c.deptGroupCode.ToString().Trim(),
                                    deptGroupName = c.deptGroupName.ToString().Trim(),
                                    costCenter =c.costCenter.ToString(),
                                    unitName = c.unitName.ToString().Trim(),
                                    total_active = Convert.ToDouble(c.total_active).ToString("N"),
                                    permanent_active = Convert.ToDouble(c.permanent_active).ToString("N"),
                                    fixed_perary_active = Convert.ToDouble(c.fixed_perary_active).ToString("N"),
                                    permanaent_NoActive = Convert.ToDouble(c.permanaent_NoActive).ToString("N"),
                                    groupInHCR = c.groupInHCR.ToString()

                                }).ToList();
                                ret.ModelErrors = null;
                                ret.ResultObject = ResultObject;
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.CommonErrors = null;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Don't have data ...!";
                                ret.ResultObject = null;
                                ret.StatusCode = 405;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "No data";
                                return ret;
                            }
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }

                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/rpt1012")]
        public rpt1012ListResult rpt1012(rpt1006ListParam data)
        {
            var ret = new rpt1012ListResult();
            // WriteLogFile("deptList " + data.TokenKey);
            string Result;
            try
            {
                int NewYearView = int.Parse(DateTime.Now.ToString("yyyy"));
                if (data.yearCal != 0)
                {
                    NewYearView = data.yearCal;
                }
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenKey || c.webTokenKey == data.tokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {

                        string Command = " EXEC   p_rpt1012 " +
                          " @monthCal = '" + data.monthCal.ToString() + "',  " +
                          " @YearCal = '" + data.yearCal.ToString() + "',  " +
                          " @userID = '" + ds_tokey.empID.ToString() + "'  ";
                        using (SqlConnection myConnection = new SqlConnection(connectionString))
                        {
                            myConnection.Open();
                            using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
                            {
                                Result = (string)myCommand.ExecuteScalar();
                            }
                        }
                        if (Result != "")
                        {
                            var ds_Data = (from c in db.tmp_rpt1012
                                           where c.transactionNo == Result.ToString().Trim()
                                           orderby c.deptGroupCode ascending, c.descript ascending
                                           select new
                                           {
                                               c.transactionNo,
                                               c.deptGroupCode,
                                               c.deptGroupName,
                                               c.descript,
                                               c.headCount,
                                               c.work_perma,
                                               c.work_fixedTemp,
                                               c.permaGrossincome,
                                               c.fixedTempGrossincome,
                                               c.grossBenefit,
                                               c.bonus,
                                               c.ovetime,
                                               c.paidHours,
                                               c.paidAbsent,
                                               c.AL,
                                               c.sick,
                                               c.CL,
                                               c.publicHoliday,
                                               c.unpaidLeave,
                                               c.OT150,
                                               c.OT200,
                                               c.OT250,
                                               c.OT300,
                                               c.OT350,
                                               c.headcount_perma,
                                               c.headcount_temp,
                                               c.wh_paid,
                                               c.wh_absent
                                           }).ToList();
                            if (ds_Data != null)
                            {
                                List<rpt1012ModelResult> ResultObject = new List<rpt1012ModelResult>();
                                ResultObject = ds_Data.Select(c => new rpt1012ModelResult()
                                {
                                    transactionNo = c.transactionNo.ToString(),
                                    deptGroupCode = c.deptGroupCode.ToString().Trim(),
                                    deptGroupText = c.deptGroupName.ToString().Trim(),
                                    descript = c.descript.ToString().Trim(),
                                    headCount = Convert.ToDouble(c.headCount).ToString("N"),
                                    work_perma = Convert.ToDouble(c.work_perma).ToString("N"),
                                    work_fixedTemp = Convert.ToDouble(c.work_fixedTemp).ToString("N"),
                                    permaGrossincome = Convert.ToDouble(c.permaGrossincome).ToString("N"),
                                    fixedTempGrossincome = Convert.ToDouble(c.fixedTempGrossincome).ToString("N"),
                                    grossBenefit = Convert.ToDouble(c.grossBenefit).ToString("N"),
                                    bonus = Convert.ToDouble(c.bonus).ToString("N"),
                                    ovetime = Convert.ToDouble(c.ovetime).ToString("N"),
                                    paidHours = Convert.ToDouble(c.paidHours).ToString("N"),
                                    paidAbsent = Convert.ToDouble(c.paidAbsent).ToString("N"),
                                    AL = Convert.ToDouble(c.AL).ToString("N"),
                                    sick = Convert.ToDouble(c.sick).ToString("N"),
                                    CL = Convert.ToDouble(c.CL).ToString("N"),
                                    publicHoliday = Convert.ToDouble(c.publicHoliday).ToString("N"),
                                    unpaidLeave = Convert.ToDouble(c.unpaidLeave).ToString("N"),
                                    OT150 = Convert.ToDouble(c.OT150).ToString("N"),
                                    OT200 = Convert.ToDouble(c.OT200).ToString("N"),
                                    OT250 = Convert.ToDouble(c.OT250).ToString("N"),
                                    OT300 = Convert.ToDouble(c.OT300).ToString("N"),
                                    OT350 = Convert.ToDouble(c.OT350).ToString("N"),
                                    headcount_perma = Convert.ToDouble(c.headcount_perma).ToString("N"),
                                    headcount_temp = Convert.ToDouble(c.headcount_temp).ToString("N"),
                                    wh_paid = Convert.ToDouble(c.wh_paid).ToString("N"),
                                    wh_absent = Convert.ToDouble(c.wh_absent).ToString("N") 

                                }).ToList();
                                ret.ModelErrors = null;
                                ret.ResultObject = ResultObject;
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.CommonErrors = null;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Don't have data ...!";
                                ret.ResultObject = null;
                                ret.StatusCode = 405;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "No data";
                                return ret;
                            }
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }

                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }




        [HttpPost]
        [Route("api/Function/rpt1013")]
        public rpt1013Result rpt1013(SalaryListDetailParam data)
        {
            var ret = new rpt1013Result();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView  
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.orderNo,
                                           c.monthCal,
                                           c.YearCal,
                                           c.MYCal,
                                           c.costCenterCode,
                                           c.costCenterText,
                                           c.deptCode,
                                           c.deptName1,
                                           c.deptName2,
                                           c.unitCode,
                                           c.unitName1,
                                           c.unitName2,
                                           c.empID,
                                           c.empNo,
                                           c.empDayID,
                                           c.empType,
                                           c.oldSalary,
                                           c.incrementSalary,
                                           c.basicSalary,
                                           c.shiftIncome1,
                                           c.shiftIncome2,
                                           c.shiftIncome3,
                                           c.shiftIncome,
                                           c.overtimeIncome1,
                                           c.overtimeIncome2,
                                           c.overtimeIncome3,
                                           c.overtimeIncome4,
                                           c.overtimeIncome5,
                                           c.overtimeIncome,
                                           c.threshingIncom,
                                           c.additionalPay,
                                           c.additionalDeduct,
                                           c.deductDayOff,
                                           c.allowance_phone,
                                           c.allowance_fuel,
                                           c.allowance_housing,
                                           c.allowance_car,
                                           c.allowance,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.grossIncome,
                                           c.deductEmpSSO,
                                           c.tax_b1,
                                           c.tax_b2,
                                           c.tax_b3,
                                           c.tax_b4,
                                           c.tax_b5,
                                           c.tax_b6,
                                           c.tax_extra,
                                           c.deductTaxs,
                                           c.deductLoan,
                                           c.deductFHF,
                                           c.deduct_SLDRT_fun,
                                           c.deductOther,
                                           c.canteenNET,
                                           c.OtherAllowanNET,
                                           c.severanceBook,
                                           c.NetToPay,
                                           c.employerSSO,
                                           c.grossLastMonth,
                                           c.grossVariance,
                                           c.noted,
                                           c.empName1,
                                           c.empName2,
                                           c.netIncome,
                                           c.saleIncentive,
                                           c.ssoNumber
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1013ModelResult> ResultObject = new List<rpt1013ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1013ModelResult()
                            {
                                ssoNumber = c.ssoNumber==null ? "" : c.ssoNumber.ToString(),
                                empName  = c.empName2.ToString(),
                                empNo = c.empNo.ToString(),
                                salary =  c.basicSalary >= 4500000 ? Convert.ToDouble("4500000").ToString("#,##0") : Convert.ToDouble(c.basicSalary).ToString("#,##0"),
                                ssoSalary = c.basicSalary >= 4500000 ? Convert.ToDouble("4500000").ToString("#,##0") : Convert.ToDouble(c.basicSalary).ToString("#,##0"),
                                employeeSSO = Convert.ToDouble(c.deductEmpSSO).ToString("#,##0"),
                                employerSSO = Convert.ToDouble(c.employerSSO).ToString("#,##0"),
                                remark = ""
                            }).ToList();


                            //Update new code add Ezan and caren such as: salary = 4500000, ssosalary = 4500000, employeesso = 247500, employersso = 270000
                            var ds_Data1 = (from d in db.v_rpt1013_only2person
                                            select new
                                            {
                                                d.ssonumber,
                                                d.empno,
                                                d.empName,
                                                d.salary,
                                                d.ssosalary,
                                                d.employeesso,
                                                d.employersso
                                            }).ToList();

                            
                                List<rpt1013ModelResult> ResultObjectx = new List<rpt1013ModelResult>();
                                ResultObjectx = ds_Data1.Select(d => new rpt1013ModelResult()
                                {
                                    ssoNumber = d.ssonumber,
                                    empNo = d.empno,
                                    empName = d.empName,
                                    salary = Convert.ToDouble(d.salary).ToString("#,##0"),
                                    ssoSalary = Convert.ToDouble(d.ssosalary).ToString("#,##0"),
                                    employeeSSO = Convert.ToDouble(d.employeesso).ToString("#,##0"),
                                    employerSSO = Convert.ToDouble(d.employersso).ToString("#,##0"),
                                    remark = ""
                                }).ToList();
                            

                            ResultObject.AddRange(ResultObjectx);
 
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/rpt1007Detail")]
        public rpt1007Result rpt1007Detail(rpt1007Param data)
        {
            var ret = new rpt1007Result();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_paymentRecord
                                       where c.monthCal == data.monthView && c.YearCal == data.yearView && c.monthCal == data.monthView && c.empID==data.empID
                                       select new
                                       {
                                           c.salaryID,
                                           c.transactionNo,
                                           c.orderNo,
                                           c.monthCal,
                                           c.YearCal,
                                           c.MYCal,
                                           c.costCenterCode,
                                           c.costCenterText,
                                           c.deptCode,
                                           c.deptName1,
                                           c.deptName2,
                                           c.unitCode,
                                           c.unitName1,
                                           c.unitName2,
                                           c.empID,
                                           c.empNo,
                                           c.empDayID,
                                           c.empType,
                                           c.oldSalary,
                                           c.incrementSalary,
                                           c.basicSalary,
                                           c.shiftIncome1,
                                           c.shiftIncome2,
                                           c.shiftIncome3,
                                           c.shiftIncome,
                                           c.overtimeIncome1,
                                           c.overtimeIncome2,
                                           c.overtimeIncome3,
                                           c.overtimeIncome4,
                                           c.overtimeIncome5,
                                           c.overtimeIncome,
                                           c.threshingIncom,
                                           c.additionalPay,
                                           c.additionalDeduct,
                                           c.deductDayOff,
                                           c.allowance_phone,
                                           c.allowance_fuel,
                                           c.allowance_housing,
                                           c.allowance_car,
                                           c.allowance,
                                           c.grossSalaryBenefits,
                                           c.advanceBonus,
                                           c.grossIncome,
                                           c.deductEmpSSO,
                                           c.tax_b1,
                                           c.tax_b2,
                                           c.tax_b3,
                                           c.tax_b4,
                                           c.tax_b5,
                                           c.tax_b6,
                                           c.tax_extra,
                                           c.deductTaxs,
                                           c.deductLoan,
                                           c.deductFHF,
                                           c.deduct_SLDRT_fun,
                                           c.deductOther,
                                           c.canteenNET,
                                           c.OtherAllowanNET,
                                           c.severanceBook,
                                           c.NetToPay,
                                           c.employerSSO,
                                           c.grossLastMonth,
                                           c.grossVariance,
                                           c.noted,
                                           c.empName1,
                                           c.empName2,
                                           c.netIncome,
                                           c.saleIncentive,
                                           c.al,
                                           c.al_use,
                                           c.al_left,
                                           c.sick,
                                           c.cl,
                                           c.OTRate1,
                                           c.OTRate2,
                                           c.OTRate3,
                                           c.OTRate4,
                                           c.OTRate5 ,
                                           c.EmpDayOff,
                                           c.leaveDay,
                                           c.hireDay,
                                           c.workprevious,
                                           c.workdayID
                                           
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1007ModelResult> ResultObject = new List<rpt1007ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1007ModelResult()
                            {
                                salaryID = c.salaryID.ToString(),
                                costCenterCode = c.costCenterCode.ToString(),
                                deptCode = c.deptCode.ToString(),
                                unitCode = c.unitCode.ToString(),
                                empNo = c.empNo.ToString(),
                                empDayID = c.empDayID.ToString(),
                                empType = c.empType.ToString(),
                                oldSalary = c.oldSalary.ToString("#,##0"),
                                incrementSalary = c.incrementSalary.ToString("#,##0"),
                                basicSalary = c.basicSalary.ToString("#,##0"),
                                shiftIncome = c.shiftIncome.ToString("#,##0"),
                                overtimeIncome = c.overtimeIncome.ToString("#,##0"),
                                threshingIncom = c.threshingIncom.ToString("#,##0"),
                                additionalPay = (c.additionalPay - c.additionalDeduct).ToString("#,##0"),
                                additionalDeduct = c.additionalDeduct.ToString("#,##0"),
                                deductDayOff = c.deductDayOff.ToString("#,##0"),
                                allowance = c.allowance.ToString("#,##0"),
                                grossSalaryBenefits = c.grossSalaryBenefits.ToString("#,##0"),
                                 advanceBonus = c.advanceBonus.ToString("#,##0"),
                               // advanceBonus = c.saleIncentive.ToString("#,##0"),
                                saleIncentive = c.saleIncentive.ToString("#,##0"),
                                grossIncome = c.grossIncome.ToString("#,##0"),
                                deductEmpSSO = c.deductEmpSSO.ToString("#,##0"),
                                deductTaxs = c.deductTaxs.ToString("#,##0"),
                                netIncome = c.netIncome.ToString("#,##0"),
                                deductFHF = (c.deductFHF + c.deductOther + c.deductLoan).ToString("#,##0"),
                                deduct_loan = c.deductLoan.ToString("#,##0"),
                                deduct_SLDRT_fun = c.deduct_SLDRT_fun.ToString("#,##0"),
                                canteenNET = c.canteenNET.ToString("#,##0"),
                                severanceBook = c.severanceBook.ToString("#,##0"),
                                netToPay = c.NetToPay.ToString("#,##0"),
                                employerSSO = c.employerSSO.ToString("#,##0"),
                                grossLastMonth = c.grossLastMonth.ToString("#,##0"),
                                grossVariance = c.grossVariance.ToString("#,##0"),
                                remark = c.noted.ToString(),
                                empName = data.lang == "1" ? c.empName1.ToString() : c.empName2.ToString(),
                                tax_b1 = c.tax_b1.ToString("#,##0"),
                                tax_b2 = c.tax_b2.ToString("#,##0"),
                                tax_b3 = c.tax_b3.ToString("#,##0"),
                                tax_b4 = c.tax_b4.ToString("#,##0"),
                                tax_b5 = c.tax_b5.ToString("#,##0"),
                                tax_b6 = c.tax_b6.ToString("#,##0"),
                                tax_extra = c.tax_extra.ToString("#,##0"),
                                shiftIncom1 = c.shiftIncome1.ToString("#,##0"),
                                shiftIncom2 = c.shiftIncome2.ToString("#,##0"),
                                shiftIncom3 = c.shiftIncome3.ToString("#,##0"),
                                al = c.al.ToString(),
                                al_use = c.al_use.ToString(),
                                al_left = c.al_left.ToString(),
                                sick = c.sick.ToString(),
                                cl = c.cl.ToString(),
                                ot1 = c.OTRate1.ToString(),
                                ot2 = c.OTRate2.ToString(),
                                ot3 = c.OTRate3.ToString(),
                                ot4 = c.OTRate4.ToString(),
                                ot5 = c.OTRate5.ToString(),
                                allowance_phone =c.allowance_phone.ToString("#,##0"),
                                allowance_flue = c.allowance_fuel.ToString("#,##0"),
                                allowance_car = c.allowance_car.ToString("#,##0"),
                                allowance_house = c.allowance_housing.ToString("#,##0"),
                                empDayOff = c.EmpDayOff.ToString(),
                                empLeaveDay=c.leaveDay.ToString(),
                                hireday=c.hireDay.ToString(),
                                workprevious=c.workprevious.ToString(),
                                workingID = c.workdayID==null ? "" : c.workdayID.ToString()

                            }).ToList();
                              

                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/Function/rpt1014")]
        public rpt1014Result rpt1014(rpt1014Param data)
        {
            var ret = new rpt1014Result();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_summary_pension                                     
                                       orderby c.deptCode ascending
                                       select new
                                       {
                                           c.deptCode,
                                           c.sec,
                                           c.pensionAmount_00,
                                           c.pensionAmount_01,
                                           c.pensionAmount_02,
                                           c.pensionAmount_03,
                                           c.pensionAmount_04,
                                           c.pensionAmount_05,
                                           c.pensionAmount_06,
                                           c.pensionAmount_07,
                                           c.pensionAmount_08,
                                           c.pensionAmount_09,
                                           c.pensionAmount_10,
                                           c.pensionAmount_11,
                                           c.pensionAmount_12 
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1014ModelResult> ResultObject = new List<rpt1014ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1014ModelResult()
                            {                       
                                deptCode = c.deptCode == null ? "" : c.deptCode.ToString(),
                                costCenterCode = c.deptCode == null ? "" : c.deptCode.ToString(),
                                pension_00 = c.pensionAmount_00.ToString("#,##0"),
                                pension_01 = c.pensionAmount_01.ToString("#,##0"),
                                pension_02 = c.pensionAmount_02.ToString("#,##0"),
                                pension_03 = c.pensionAmount_03.ToString("#,##0"),
                                pension_04 = c.pensionAmount_04.ToString("#,##0"),
                                pension_05 = c.pensionAmount_05.ToString("#,##0"),
                                pension_06 = c.pensionAmount_06.ToString("#,##0"),
                                pension_07 = c.pensionAmount_07.ToString("#,##0"),
                                pension_08 = c.pensionAmount_08.ToString("#,##0"),
                                pension_09 = c.pensionAmount_09.ToString("#,##0"),
                                pension_10 = c.pensionAmount_10.ToString("#,##0"),
                                pension_11 = c.pensionAmount_11.ToString("#,##0"),
                                pension_12 = c.pensionAmount_12.ToString("#,##0")
                                 
                            }).ToList();                                                          
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/rpt1015")]
        public rpt1015Result rpt1015(rpt1014Param data)
        {
            var ret = new rpt1015Result();
            // WriteLogFile("deptList " + data.TokenKey);

            try
            {

                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_Data = (from c in db.tb_summary_bonus
                                       orderby c.deptCode ascending
                                       select new
                                       {
                                           c.deptCode,
                                           c.sec,
                                           c.bonusAmount_00,
                                           c.bonusAmount_01,
                                           c.bonusAmount_02,
                                           c.bonusAmount_03,
                                           c.bonusAmount_04,
                                           c.bonusAmount_05,
                                           c.bonusAmount_06,
                                           c.bonusAmount_07,
                                           c.bonusAmount_08,
                                           c.bonusAmount_09,
                                           c.bonusAmount_10,
                                           c.bonusAmount_11,
                                           c.bonusAmount_12
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<rpt1015ModelResult> ResultObject = new List<rpt1015ModelResult>();
                            ResultObject = ds_Data.Select(c => new rpt1015ModelResult()
                            {
                                deptCode = c.deptCode == null ? "" : c.deptCode.ToString(),
                                costCenterCode = c.deptCode == null ? "" : c.deptCode.ToString(),
                                bonus_00 = c.bonusAmount_00.ToString("#,##0"),
                                bonus_01 = c.bonusAmount_01.ToString("#,##0"),
                                bonus_02 = c.bonusAmount_02.ToString("#,##0"),
                                bonus_03 = c.bonusAmount_03.ToString("#,##0"),
                                bonus_04 = c.bonusAmount_04.ToString("#,##0"),
                                bonus_05 = c.bonusAmount_05.ToString("#,##0"),
                                bonus_06 = c.bonusAmount_06.ToString("#,##0"),
                                bonus_07 = c.bonusAmount_07.ToString("#,##0"),
                                bonus_08 = c.bonusAmount_08.ToString("#,##0"),
                                bonus_09 = c.bonusAmount_09.ToString("#,##0"),
                                bonus_10 = c.bonusAmount_10.ToString("#,##0"),
                                bonus_11 = c.bonusAmount_11.ToString("#,##0"),
                                bonus_12 = c.bonusAmount_12.ToString("#,##0")

                            }).ToList();
                            ret.ModelErrors = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Don't have data ...!";
                            ret.ResultObject = null;
                            ret.StatusCode = 405;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "No data";
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }
            catch (Exception ex)
            {
                UserController.WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }




        protected static string viewImageRequestFile(string filePath)
        {
            try
            {
                string base64Image = "";
                Byte[] imageArray;
                if (System.IO.File.Exists(filePath))
                {
                    imageArray = System.IO.File.ReadAllBytes(filePath);
                    base64Image = Convert.ToBase64String(imageArray);

                }
                return base64Image;
            }
            catch (Exception)
            {
                return null;
            }

        }



        //[HttpPost]
        //[Route("api/Function/ResetUserALL")]
        //public UserListResult ResetUserPwd(ResetUserPwdParam data)
        //{
        //    var ret = new UserListResult();
        //    string userpwd = "";
        //    int password_length = 16;
        //    int pass_complex = 1;
        //    int pass_hit = 24;
        //    int pass_expDay = 120;
        //    DateTime today = DateTime.Now;
        //    DateTime dateExp = today.AddDays(pass_expDay);
        //    int Result = 0;
        //    // WriteLogFile("deptList " + data.TokenKey);
        //    try
        //    {
        //        using (var db = new db_hrmsEntities())
        //        {
        //            var ds_tokey = (from c in db.v_user_permission
        //                            where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_add == 1
        //                            select new
        //                            {
        //                                c.empID,
        //                                c.userID
        //                            }).FirstOrDefault();
        //            if (ds_tokey != null)
        //            {

        //                var ds = (from c in db.tb_secure_setting
        //                          where c.status_id == 3
        //                          select new
        //                          {
        //                              c.password_length,
        //                              c.pass_complex,
        //                              c.pass_hit,
        //                              c.pass_expDay
        //                          }).FirstOrDefault();
        //                if (ds != null)
        //                {
        //                    password_length = ds.password_length;
        //                    pass_complex = ds.pass_complex;
        //                    pass_hit = ds.pass_hit;
        //                    pass_expDay = ds.pass_expDay;
        //                    dateExp = today.AddDays(pass_expDay);
        //                }
        //                int CountUser = 0;



        //                var ds_userList = (from c in db.tb_users
        //                                 where c.username != "admin" && c.username != "ta"
        //                                 select c).ToList();
        //                if (ds_userList.Count >0 )
        //                {
        //                    int nloop = 0;
        //                    string userencode = "";
        //                    string Command;

        //                    while (CountUser <= ds_userList.Count)
        //                    {

        //                        var ds_update = (from c in db.tb_users
        //                                         where c.username != "admin" && c.username != "ta" && c.sendNoti == 0
        //                                         select c).First();
        //                        if (ds_update != null)
        //                        {


        //                            Command = " DECLARE	@return_value int EXEC	@return_value = p_tmp_pass @username = N'" + ds_update.username + "', @pass_hit='" + pass_hit + "' SELECT	'Return Value' = @return_value ";

        //                            using (SqlConnection myConnection = new SqlConnection(connectionString))
        //                            {
        //                                myConnection.Open();
        //                                using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
        //                                {
        //                                    Result = (int)myCommand.ExecuteScalar();
        //                                }
        //                            }

        //                            while (nloop < 1)
        //                            {
        //                                userpwd = UserController.RandomString(password_length);
        //                                userencode = UserController.Base64Encode(userpwd + ds_update.username);

        //                                //check pwd history
        //                                var ds_pass = (from c in db.tmp_pass
        //                                               where ( c.pwd == userpwd)
        //                                               select new
        //                                               {
        //                                                   c.username
        //                                               }).FirstOrDefault();

        //                                if (ds_pass != null)
        //                                {
        //                                    userpwd = UserController.RandomString(password_length);
        //                                    userencode = userpwd + ds_update.username;
        //                                    userencode = UserController.Base64Encode(userencode);
        //                                    nloop = 0;
        //                                }
        //                                else
        //                                {
        //                                    nloop = 1;
        //                                }
        //                            }

        //                            nloop = 0;

        //                            Command = " DECLARE	@return_value int EXEC	@return_value =  p_tmp_pass1 @username = N'" + ds_update.username + "', @pass=N'" + userpwd + "' SELECT	'Return Value' = @return_value ";

        //                            using (SqlConnection myConnection = new SqlConnection(connectionString))
        //                            {

        //                                myConnection.Open();
        //                                using (SqlCommand myCommand = new SqlCommand(Command, myConnection))
        //                                {
        //                                       Result = (int)myCommand.ExecuteScalar();
        //                                }
        //                            }

        //                            ds_update.pwd = userencode;
        //                            ds_update.user_add = ds_tokey.userID;
        //                            ds_update.date_add = DateTime.Now;
        //                            ds_update.expDate = dateExp;
        //                            db.SaveChanges();






        //                            CountUser = CountUser + 1;


        //                    }




        //                    }

        //                }
        //                else
        //                {
        //                    ret.ModelErrors = "User data is not found...!";
        //                    ret.ResultObject = null;
        //                    ret.StatusCode = 401;
        //                    ret.IsSuccess = false;
        //                    ret.CommonErrors = "User data is not found...!";
        //                    return ret;
        //                }



        //                if (data.lang == "1")
        //                {
        //                    ret.ModelErrors = "Reset ລະຫັດສໍາເລັດ";
        //                }
        //                else
        //                {
        //                    ret.ModelErrors = "Reset password complete";
        //                }
        //                ret.ResultObject = null;
        //                ret.StatusCode = 200;
        //                ret.IsSuccess = true;
        //                ret.CommonErrors = null;
        //                return ret;
        //            }
        //            else
        //            {
        //                ret.ModelErrors = "Unauthorized";
        //                ret.ResultObject = null;
        //                ret.StatusCode = 401;
        //                ret.IsSuccess = false;
        //                ret.CommonErrors = "Token key not correct ...!";
        //                return ret;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //      UserController.  WriteLogFile(ex.Message);
        //        ret.ModelErrors = "Error" + ex.Message;
        //        ret.ResultObject = null;
        //        ret.StatusCode = 417;
        //        ret.IsSuccess = false;
        //        ret.CommonErrors = "Expectation Failed";
        //        return ret;
        //    }
        //}





        [HttpPost]
        [Route("api/Function/checkToken")]
        public LoginResult Login(checkTokenParam data)
        {
            int GET_UserID;
            int GET_StaffID;
            int GET_UserIDUpdate;
            string SET_Token;
            var ret = new LoginResult();
            
            try
            {
                using (var db = new db_hrmsEntities())
                {                    
                    var ds = (from c in db.v_users
                              where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                              select new
                              {
                                  c.userID,
                                  c.empID,
                                  c.empNo,
                                  c.firstName1,
                                  c.lastName1,
                                  c.firstName2,
                                  c.lastName2,
                                  c.empMobile,
                                  c.empEmail,
                                  c.empTitleName,
                                  c.unitName1,
                                  c.unitName2,
                                  c.deptName1,
                                  c.deptName2,
                                  c.companyName1,
                                  c.companyName2,
                                  c.companyPhone,
                                  c.empPhoto,
                                  c.roleID,
                                  c.langID,
                                  c.webTokenKey
                              }).FirstOrDefault();

                    if (ds != null)
                    {                                           
                        GET_UserID = int.Parse(ds.empID.ToString());
                        GET_StaffID = int.Parse(ds.empID.ToString());
                        GET_UserIDUpdate = int.Parse(ds.userID.ToString());
                        SET_Token = ds.webTokenKey == null ? "" : ds.webTokenKey.ToString();

                        List<LoginResultUserInfoViewModel> ResultObject = new List<LoginResultUserInfoViewModel>();
                        ResultObject.Add(new LoginResultUserInfoViewModel
                        {
                            UserId = GET_UserID.ToString(),
                            userEmail = ds.empEmail,
                            emp_no = ds.empNo,
                            lao_fullname = ds.firstName1 + " " + ds.lastName1,
                            eng_fullname = ds.firstName2 + " " + ds.lastName2,
                            emp_mobile = ds.empMobile,
                            emp_title = ds.empTitleName,
                            emp_dep = ds.deptName1,
                            emp_company = ds.companyName1,
                            companyTel = ds.companyPhone,
                            emp_photo = UserController.fileTobase64("D:/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/hrms/psImages", ds.empPhoto.ToString()),
                            TokenKey = SET_Token,
                            roleID = ds.roleID.ToString(),
                            langID = ds.langID.ToString()
                        });

                        ret.ModelErrors = null;
                        ret.ResultObject = ResultObject;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;                         

                        return ret;
                    }
                    else
                    {
                        UserController.WriteLogFile("not found user ");
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Error";
                        return ret;
                    }
                }

            }
            catch (Exception ex)
            {              
                ret.ModelErrors =  "Error details: " + ex.Message.ToString();
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/Function/DisplayDashboardLeaveBalance")]
        public dasboardLeaveResult displayleavebalance(dashboardLeavebalanceparam data)
        {
            var ret = new dasboardLeaveResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.token || c.webTokenKey == data.token)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.pd_leavebalanceyear(data.emp_id)
                                       select new
                                       {
                                           c.used_annualleave,
                                           c.used_sickleave,
                                           c.used_specialleave,
                                           c.totalannualleave,
                                           c.totalsickleave,
                                           c.totalspecialleave
                                       }).ToList();
                        List<dashboardLeavebalancemodel> ResultObject = new List<dashboardLeavebalancemodel>();
                        ResultObject = ds_data.Select(d => new dashboardLeavebalancemodel()
                        {
                            used_annualleave = d.used_annualleave.ToString(),
                            used_sickleave = d.used_sickleave.ToString(),
                            used_specialleave = d.used_specialleave.ToString(),
                            totalannualleave = d.totalannualleave.ToString(),
                            totalsiclleave = d.totalsickleave.ToString(),
                            totalspecialleave = d.totalspecialleave.ToString()
                        }).ToList();
                        ret.ModelErrors = "Display";
                        ret.CommonError = "SUCCESS";
                        ret.ResultObject = ResultObject;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Token key is failse";
                        ret.CommonError = "ERROR";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        return ret;
                    }
                }

            }catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.CommonError = "ERROR";
                ret.ResultObject = null;
                ret.StatusCode = 401;
                ret.IsSuccess = false;
                return ret;
            }
            //return null;
        }

    }
}

