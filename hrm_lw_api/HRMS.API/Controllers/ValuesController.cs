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
    public class ValuesController : ApiController
    {
        public static string connectionString = ConfigurationManager.ConnectionStrings["db_hrmsEntities.Properties.Settings.db_hrmsConnectionString"].ConnectionString;
        public static Boolean SendEmailProcess = true;
        public string Set_PassKey = "7386t189-58c0-c495-8ff0-d0fnov0a29ta";


        private double? CLentitlement;
        private double? CLbalancelastmonth;
        private double? CLusedthismonth;
        private double? CLremain;
        private double? ALentitlement;
        private double? ALbalancelastmonth;
        private double? ALusedthismonth;
        private double? AEworkingthismonth;
        private double? AKremain;
        private float? DILBalance;
        private float? DILUsed;

        public static void WriteLogFile(string Message)
        {
            StreamWriter sw = null;

            try
            {
                //WriteStatusBar(Message);
                //updateStatusText(Message);
                string sLogFormat = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString() + " ==> ";
                //string sPathName = @"E:\";
                string sPathName = @"d:\logs\newhrm\";

                string sYear = DateTime.Now.Year.ToString();
                string sMonth = DateTime.Now.Month.ToString();
                string sDay = DateTime.Now.Day.ToString();

                string sErrorTime = sDay + "-" + sMonth + "-" + sYear;

                sw = new StreamWriter(sPathName + sErrorTime + ".txt", true);

                sw.WriteLine(sLogFormat + Message);
                sw.Flush();

            }
            catch (Exception)
            {
                //ErrorLog(ex.ToString());
            }
            finally
            {
                if (sw != null)
                {
                    sw.Dispose();
                    sw.Close();
                }
            }

        }
        [HttpPost]
       [Route("api/User/GetEmployeeByDepartment")]
       public rptotdetailsemployeeResult GetempGetDepart(rptotdetailsemployeeVL data)
        {
            var ret = new rptotdetailsemployeeResult();
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
                        var ds_Data =(from c in db.v_dept_unit_employee
                                       select new
                                       {
                                           c.empID,
                                           c.firstName1,
                                           c.firstName2,
                                           c.lastName1,
                                           c.lastName2
                                       }).ToList();
                        if (ds_Data != null)
                        {
                            List<GetEmployeeByDeptIDtViewModelResult> ResultObject = new List<GetEmployeeByDeptIDtViewModelResult>();
                            ResultObject = ds_Data.Select(c => new GetEmployeeByDeptIDtViewModelResult()
                            {
                                empID = c.empID.ToString(),
                                empName = data.lang == "1" || data.lang == null ? c.firstName1 + " " + c.lastName1 : c.firstName2 + " " + c.lastName2
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
                    }else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }catch(Exception ex)
            {
                //WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/User/EmployeeLeaveAllbyDate")]
        public rptleavedetailsemployeeResult empleavealldetails(rptleaveemployee data)
        {
            var ret = new rptleavedetailsemployeeResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey= (from c in db.v_user_permission
                                       //  where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_view == 1
                                   where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                   select new
                                   {
                                       c.empID
                                   }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_emp = (from c in db.v_employeeLeavedetails
                                      where c.n_startdate >= data.startdate && c.n_startdate <= data.enddate
                                      select new
                                      {
                                          c.empID,
                                          c.leaveRequestNo,
                                          c.empNo,
                                          c.firstName1,
                                          c.firstName2,
                                          c.lastName1,
                                          c.lastName2,
                                          c.dob,
                                          c.empPosition,
                                          c.deptName1,
                                          c.deptName2,
                                          c.companyName1,
                                          c.ethnicName1,
                                          c.nationalityText,
                                          c.genderText,                                         
                                          c.leavestartdate,
                                          c.leaveenddate,
                                          c.returndate,
                                          c.leaveDay,
                                          c.leaveTypeName1,
                                          c.leaveTypeName2,
                                          c.noted,
                                          c.n_startdate,
                                          c.n_enddate,
                                          c.n_returndate,
                                          c.companyID,
                                          c.deptID,
                                          c.textstatus,
                                          c.fstatusText,
                                          c.empMobile
                                      }).ToList();
                        
                        if (ds_emp != null && ds_emp.Any())
                        {
                            List<GetEmployeeLeaveViewModelResult> ResultObject = new List<GetEmployeeLeaveViewModelResult>();
                            ResultObject = ds_emp.Select(c => new GetEmployeeLeaveViewModelResult()
                            {
                                empId = c.empID.ToString(),
                                leaverequestno = c.leaveRequestNo,
                                empNo = c.empNo.ToString(),
                                firstname = data.lang == "1" ? c.firstName1 : c.firstName2,
                                lastname = data.lang == "1" ? c.lastName1 : c.lastName2,
                                empposition = c.empPosition,
                                deptname = data.lang == "1" ? c.deptName1 : c.deptName2,
                                leavestartdate = c.leavestartdate,
                                leaveeenddate = c.leaveenddate,
                                leavereturndate = c.returndate,
                               // leaveday = Convert.ToDouble(c.leaveDay),
                                leaveday = c.leaveDay.ToString(),
                                leavetype = data.lang == "1" ? c.leaveTypeName1 : c.leaveTypeName2,
                                noted = c.noted,
                                n_startdate = Convert.ToDateTime(c.n_startdate).ToString(),
                                n_enddate = Convert.ToDateTime(c.n_enddate).ToString(),
                                n_returndate = Convert.ToDateTime(c.n_returndate).ToString(),
                                companyID = c.companyID == null ? "" :  c.companyID.ToString(),
                                deptid = c.deptID == null ? "" :  c.deptID.ToString(),
                                textstatus = c.textstatus == null ? "" :  c.textstatus.ToString(),
                                dob = c.dob == null ? "" :  c.dob.ToString(),
                                ethic = c.ethnicName1 == null ? "" : c.ethnicName1.ToString(),
                                fstatus = c.fstatusText == null ? "" :  c.fstatusText.ToString(),
                                nationlity = c.nationalityText == null ? "" :  c.nationalityText.ToString(),
                                tel = c.empMobile == null ? "" :  c.empMobile.ToString(),
                                worklocation = c.companyName1 == null ? "" :  c.companyName1.ToString(),
                                gender = c.genderText == null ? "" : c.genderText.ToString()
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

            }catch (Exception ex)
            {
                WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }


        [HttpPost]
        [Route("api/User/EmployeeLeaveDetailBydate")]
        public EmployeeLeaveDetailBydateResult EmployeeLeaveDetailBydate(employeeLeaveDetailParam data)
        {
            var ret = new EmployeeLeaveDetailBydateResult();
            DateTime set_strDate;
            DateTime set_endDate;
            try
            {
                set_strDate = DateTime.Parse(data.startdate);
                set_endDate = DateTime.Parse(data.enddate);
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                        //  where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_view == 1
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_emp = (from c in db.v_employeeLeavedetails
                                      where c.n_startdate >= set_strDate && c.n_startdate <= set_endDate && c.empID == data.empId
                                      select new
                                      {
                                          c.leaveRequestNo,
                                          c.empNo,
                                          c.firstName1,
                                          c.firstName2,
                                          c.lastName1,
                                          c.lastName2,
                                          c.empPosition,
                                          c.deptName1,
                                          c.deptName2,
                                          c.leavestartdate,
                                          c.leaveenddate,
                                          c.returndate,
                                          c.leaveDay,
                                          c.leaveTypeName1,
                                          c.leaveTypeName2,
                                          c.noted,
                                          c.n_startdate,
                                          c.n_enddate,
                                          c.n_returndate,
                                          c.companyID,
                                          c.deptID,
                                          c.textstatus

                                      }).ToList();

                        if (ds_emp != null && ds_emp.Any())
                        {
                            List<EmployeeLeaveDetailBydateModelResult> ResultObject = new List<EmployeeLeaveDetailBydateModelResult>();
                            ResultObject = ds_emp.Select(c => new EmployeeLeaveDetailBydateModelResult()
                            {
                                leaverequestno = c.leaveRequestNo,                              
                                leavestartdate = c.leavestartdate,
                                leaveeenddate = c.leaveenddate,
                                leavereturndate = c.returndate,
                                leaveday = c.leaveDay.ToString(),
                                leavetype = data.lang == "1" ? c.leaveTypeName1 : c.leaveTypeName2,
                                noted = c.noted,
                                n_startdate = Convert.ToDateTime(c.n_startdate).ToString(),
                                n_enddate = Convert.ToDateTime(c.n_enddate).ToString(),
                                n_returndate = Convert.ToDateTime(c.n_returndate).ToString(),                            
                                textstatus = c.textstatus
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
                WriteLogFile(ex.Message);
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }



        [HttpPost]
        [Route("api/User/EmployeeLeaveAllbyDateManager")]
        public rptleavedetailsemployeeResult empleavealldetailsbymanager(rptleaveemployee data)
        {
            var ret = new rptleavedetailsemployeeResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                        //  where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey) && c.app_permissionId == 19 && c.app_view == 1
                                    where (c.appTokenKey == data.TokenKey || c.webTokenKey == data.TokenKey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    
                    if (ds_tokey != null)
                    {
                        var ds_emp = (from c in db.v_employeeLeavedetails
                                      where c.n_startdate >= data.startdate && c.n_startdate <= data.enddate && c.managerID == ds_tokey.empID
                                      select new
                                      {
                                          c.leaveRequestNo,
                                          c.empNo,
                                          c.firstName1,
                                          c.firstName2,
                                          c.lastName1,
                                          c.lastName2,
                                          c.empPosition,
                                          c.deptName1,
                                          c.deptName2,
                                          c.leavestartdate,
                                          c.leaveenddate,
                                          c.returndate,
                                          c.leaveDay,
                                          c.leaveTypeName1,
                                          c.leaveTypeName2,
                                          c.noted,
                                          c.n_startdate,
                                          c.n_enddate,
                                          c.n_returndate,
                                          c.companyID,
                                          c.deptID,
                                          c.textstatus
                                      }).ToList();

                        if (ds_emp != null && ds_emp.Any())
                        {
                            List<GetEmployeeLeaveViewModelResult> ResultObject = new List<GetEmployeeLeaveViewModelResult>();
                            ResultObject = ds_emp.Select(c => new GetEmployeeLeaveViewModelResult()
                            {
                                leaverequestno = c.leaveRequestNo,
                                empNo = c.empNo.ToString(),
                                firstname = data.lang == "1" ? c.firstName1 : c.firstName2,
                                lastname = data.lang == "1" ? c.lastName1 : c.lastName2,
                                empposition = c.empPosition,
                                deptname = data.lang == "1" ? c.deptName1 : c.deptName2,
                                leavestartdate = c.leavestartdate,
                                leaveeenddate = c.leaveenddate,
                                leavereturndate = c.returndate,
                                //leaveday = c.leaveDay,
                                leaveday = c.leaveDay.ToString(),
                                leavetype = data.lang == "1" ? c.leaveTypeName1 : c.leaveTypeName2,
                                noted = c.noted,
                                n_startdate = Convert.ToDateTime(c.n_startdate).ToString(),
                                n_enddate = Convert.ToDateTime(c.n_enddate).ToString(),
                                n_returndate = Convert.ToDateTime(c.n_returndate).ToString(),
                                companyID = c.companyID.ToString(),
                                deptid = c.deptID.ToString(),
                                textstatus = c.textstatus
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
                //WriteLogFile(ex.Message);
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
        [Route("api/User/EmployeeListDetailsAllCompany")]
        public rptemployeedtails Loademployee (rptemployeedetailsParam data)
        {
            var ret = new rptemployeedtails();
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
                        var ds_emp = (from c in db.v_employess
                                      where c.status_id == 3
                                      select new
                                      {
                                          c.empID,
                                          c.empNo,
                                          c.firstName1,
                                          c.lastName1,
                                          c.nickName1,
                                          c.firstName2,
                                          c.lastName2,
                                          c.nickName2,
                                          c.genderText,
                                          c.dob,
                                          c.fstatusText,
                                          c.nationalityText,
                                          c.ethnicName1,
                                          c.ethnicName2,
                                          c.empEmail,
                                          c.empMobile,
                                          c.deptName1,
                                          c.deptName2,
                                          c.assignmentLocation,
                                          c.costCenterCode,
                                          c.costCenterText,
                                          c.currentAddress,
                                          c.empPosition,
                                          c.unitID,
                                          c.companyID,
                                          c.deptID,
                                          c.empLevelID,
                                          c.empGroupID,
                                          c.mgrid,
                                          c.shiftWorkingID,
                                          c.hireDay,
                                          c.actingDate,
                                          c.positionID
                                      }).ToList();
                        if (ds_emp != null && ds_emp.Any())
                        {
                            List<GetEmployeeReportDetailsResult> ResultObject = new List<GetEmployeeReportDetailsResult>();
                            ResultObject = ds_emp.Select(c => new GetEmployeeReportDetailsResult()
                            {
                                empID = c.empID.ToString(),
                                empNo = c.empNo.ToString(),
                                emp_FullName = data.lang == "1" ? c.firstName1.ToString() + " " + c.lastName1.ToString() : c.firstName2.ToString() + " " + c.lastName2.ToString(),
                                emp_Gender = c.genderText.ToString(),
                                emp_dob = c.dob.ToString(),
                                emp_FstatusText = c.fstatusText.ToString(),
                                emp_Nationallity = c.nationalityText.ToString(),
                                emp_Ethic = c.ethnicName1.ToString(),
                                emp_email = c.empEmail.ToString(),
                                emp_tel = c.empMobile.ToString(),
                                emp_position = c.empPosition.ToString(),
                                emp_DeptText = c.deptName1.ToString(),
                                emp_AssignmemtLocation = c.assignmentLocation.ToString(),
                                emp_CurrentAddress = c.currentAddress.ToString(),
                                emp_CostCenterCode = c.costCenterCode.ToString(),
                                emp_CostCenterText = c.costCenterText.ToString(),
                                emp_unitID = c.unitID.ToString(),
                                emp_deptID = c.deptID.ToString(),
                                emp_companyID = c.companyID.ToString(),
                                emp_empGroupID = c.empGroupID.ToString(),
                                emp_empLevelID = c.empLevelID.ToString(),
                                emp_mgrid = c.mgrid.ToString(),
                                emp_shiftWorkingID = c.shiftWorkingID.ToString(),
                                emp_shiftWorkingName = db.tb_shiftWorking.Where(w => w.shiftWorkingID == c.shiftWorkingID).Select(s => s.shiftName).FirstOrDefault(),
                                emp_hireDay1 = c.hireDay == null ? "" : Convert.ToDateTime(c.hireDay).ToString("yyyy-MM-dd"),
                                emp_actingDay1 = c.actingDate == null ? "" : Convert.ToDateTime(c.actingDate).ToString("yyyy-MM-dd"),
                                emp_hireDay2 = c.hireDay == null ? "" : Convert.ToDateTime(c.hireDay).ToString("dd-MM-yyyy"),
                                emp_actingDay2 = c.actingDate == null ? "" : Convert.ToDateTime(c.actingDate).ToString("dd-MM-yyyy"),
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

            }catch (Exception ex)
            {
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/User/SummaryLeaveAll")]
        public leavedetailsmodel ReportSummaryLeave(leavedetailsparam data)
        {
            var ret = new leavedetailsmodel();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.v_empleaverequestall where c.empID == data.empid && c.yearleave == data.years
                                       select new
                                      {
                                           c.startdate,
                                           c.enddate,
                                           c.returndate,
                                          c.amountdayleave,
                                          c.leaveTypeCode                                          
                                         
                                      }).ToList();
                        if (ds_data !=null && ds_data.Any())
                        {
                            List<leavedetailresult> ResultObject = new List<leavedetailresult>();
                            ResultObject = ds_data.Select(c => new leavedetailresult()
                            {
                                leavestart = c.startdate,
                                leaveend = c.enddate,
                                leavereturn = c.returndate,
                                leavename = c.leaveTypeCode.ToString(),
                                leaveamountused = c.amountdayleave.ToString()

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

            }catch (Exception ex)
            {
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route ("api/User/SummaryLeaveAllbyMgrid")]
        public leavedetailsmodel ReportSummaryLeaveMgrid(leavedetailparammgrid data)
        {
            var ret = new leavedetailsmodel();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.v_empleaverequestall
                                       where c.mgrid == data.mgrid && c.yearleave == data.years
                                       select new
                                       {
                                           c.startdate,
                                           c.enddate,
                                           c.returndate,
                                           c.amountdayleave,
                                           c.leaveTypeCode
                                       }).ToList();
                        if (ds_data !=null && ds_data.Any())
                        {
                            List<leavedetailresult> ResultObject = new List<leavedetailresult>();
                            ResultObject = ds_data.Select(c => new leavedetailresult()
                            {
                                leaveamountused = c.amountdayleave.ToString(),
                                leavestart = c.startdate,
                                leaveend = c.enddate,
                                leavereturn = c.returndate,
                                leavename = c.leaveTypeCode.ToString()
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
            }catch (Exception ex)
            {
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route ("api/User/SummaryOTdetailAllbyMgrid")]
        public otdetailsmodel otdetailbymgrid (otdetailsparam data)
        {
            var ret = new otdetailsmodel();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.v_empleaverequestallbymgrid
                                       where c.mgrid == data.mgrid && c.yearmonths == data.yearmonths
                                       select new
                                       {
                                           c.otrate1,
                                           c.otrate2,
                                           c.otrate3,
                                           c.otrate4,
                                           c.otrate5,
                                           c.sumot,
                                           c.overtimeincome, 
                                           c.overtimeincome1,
                                           c.overtimeincome2,
                                           c.overtimeincome3,
                                           c.overtimeincome4,
                                           c.overtimeincome5
                                       }).ToList();
                        if (ds_data !=null && ds_data.Any())
                        {
                            List<otdetailsresult> ResultObject = new List<otdetailsresult>();
                            ResultObject = ds_data.Select(c => new otdetailsresult()
                            {
                                ot1 = c.otrate1.ToString(),
                                ot2 = c.otrate2.ToString(),
                                ot3 = c.otrate3.ToString(),
                                ot4 = c.otrate4.ToString(),
                                ot5 = c.otrate5.ToString(),
                                sumot = c.sumot.ToString(),
                                otincome1 = c.overtimeincome1.ToString(),
                                otincome2 = c.overtimeincome2.ToString(),
                                otincome3 = c.overtimeincome3.ToString(),
                                otincome4 = c.overtimeincome4.ToString(),
                                otincome5 = c.overtimeincome5.ToString(),
                                otincome = c.overtimeincome.ToString()

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

            }catch (Exception ex)
            {
                ret.ModelErrors = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
        }

        [HttpPost]
        [Route("api/User/checkpermissionapprovesalarybutton")]
        public checkpermissionmodel checkpermissionx (checkpermissiondParam data)
        {
            var ret = new checkpermissionmodel();
            try
            {
                using (var db = new db_hrmsEntities())
                {

                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        List<checkpermissionResult> ResultObject = new List<checkpermissionResult>();
                        var ds_sql = (from c in db.v_salary_list
                                      where c.salaryID == data.salaryid && c.mgrID == data.empid && c.status_id == 1
                                      select new
                                      {
                                          c.salaryID

                                      }).FirstOrDefault();
                        if (ds_sql == null)
                        {                            
                            ret.ModelErrors = "Not found data";
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 400;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "Don't have permission approve.";
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Found data";
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = "Have permission approve.";
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

            }catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 401;
                ret.IsSuccess = false;
                ret.CommonErrors = ex.Message;
                return ret;

            }
            
        }

        [HttpPost]
        [Route("api/User/DateSalaryMonthly")]
        public DateSalaryModel SalaryMonth(DateSalaryLastmonthParam data)
        {
            var ret = new DateSalaryModel();
            try
            {
                using (var db = new db_hrmsEntities())
                {

                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {

                        var ds_data = (from d in db.v_dateSalaryLastMonth
                                       orderby d.salaryID descending
                                       select new
                                       {
                                           d.fmstartdate,
                                           d.fmenddate
                                       }).ToList();
                        if (ds_data != null)
                        {
                            List<DateSalaryResult> ResultObject = new List<DateSalaryResult>();
                            ResultObject = ds_data.Select(d => new DateSalaryResult()
                            {
                                stdate = d.fmstartdate,
                                enddate = d.fmenddate

                            }).ToList();
                            ret.ModelError = null;
                            ret.ResultObject = ResultObject;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }
                        else
                        {
                            ret.ModelError = "Unauthorized";
                            ret.ResultObject = null;
                            ret.StatusCode = 401;
                            ret.IsSuccess = false;
                            ret.CommonErrors = "Token key not correct ...!";
                            return ret;

                        }

                    }
                    else
                    {
                        ret.ModelError = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonErrors = "Token key not correct ...!";
                        return ret;
                    }
                }
            }catch (Exception ex)
            {

            }

            return null;
        }

        [HttpPost]
        [Route("api/User/SaveEmployeeLeave")]
        public EmpLeaveModel InsertLeaveRequest(EmpLeaveParam data)
        {
            var ret = new EmpLeaveModel();
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
                        string command;
                        //int Result;
                        string result = "0";


                        /*This is check data first*//*
                        var ds_check = (from cx in db.v_employeeleave_thisyear where (cx.leavetypeid == data.leavetypeid && cx.empid == data.empid)
                                        select new
                                        {
                                            cx.leavetype,
                                            cx.empid
                                        }).FirstOrDefault();*/

                        /* if (ds_check == null)
                         {
                             command = "EXEC p_insertEmployeeLeaveDetail @leavetypeid = " + data.leavetypeid + ", " +
                             "@empid =" + data.empid + ", @amount =" + data.amountday + ", " +
                             "@useradd = " + data.useradd + "";

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

                             if (data.lang == "1")
                             {
                                 ret.ModelError = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                             }
                             else
                             {
                                 ret.ModelError = "Save complete";
                             }
                             ret.ResultObject = null;
                             ret.StatusCode = 200;
                             ret.IsSuccess = true;
                             ret.CommonErrors = null;
                             return ret;
                         }*/
                        /*else
                        {
                            if (data.lang == "1")
                            {
                                ret.ModelError = "ມີຂໍ້ມູນຂອງທ່ານແລ້ວ.";
                            }
                            else
                            {
                                ret.ModelError = "Your data have been in system.";
                            }
                            ret.ResultObject = null;
                            ret.StatusCode = 401;
                            ret.IsSuccess = true;
                            ret.CommonErrors = null;
                            return ret;
                        }*/

                        command = "EXEC p_insertEmployeeLeaveDetail @leavetypeid = " + data.leavetypeid + ", " +
                           "@empid =" + data.empid + ", @amount =" + data.amountday + ", " +
                           "@useradd = " + data.useradd + "";

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

                        if (data.lang == "1")
                        {
                            ret.ModelError = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                        }
                        else
                        {
                            ret.ModelError = "Save complete";
                        }
                        ret.ResultObject = null;
                        ret.StatusCode = 200;
                        ret.IsSuccess = true;
                        ret.CommonErrors = null;
                        return ret;


                    }
                    else
                    {
                        ret.ModelError = "Unauthorized";
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
                WriteLogFile(ex.Message);
                ret.ModelError = "Error" + ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 417;
                ret.IsSuccess = false;
                ret.CommonErrors = "Expectation Failed";
                return ret;
            }
            
        }
        
        [HttpPost]
        [Route("api/User/LoadEmpLeavethisYear")]
        public loadEmpLeaveModel loadEmpLeaveDetail(loadEmpLeaveParam data)
        {
            var ret = new loadEmpLeaveModel();
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
                    var query = (from c in db.v_employeeleave_thisyear
                                 select new
                                 {
                                     c.empID,
                                     c.empNo,
                                     c.laoname,
                                     c.engname,
                                     c.leavetype,
                                     c.amountday,
                                     c.expdate,
                                     c.leaveTypeID

                                 }).ToList();
                    if (query != null)
                    {
                        List<loadEmpLeaveReult> ResultObject = new List<loadEmpLeaveReult>();
                        ResultObject = query.Select(d => new loadEmpLeaveReult()
                        {
                            //leaverequestid = d.leaverequestid,
                            empid = d.empID.ToString(),
                            empno = d.empNo,
                            laoname = d.laoname,
                            engname = d.engname,
                            leavetype = d.leavetype,
                            amountday = d.amountday.ToString(),
                            expdate = d.expdate,
                            leavetypeid = d.leaveTypeID.ToString()
                        }).ToList();
                        ret.ResultObject = ResultObject;
                        ret.ModelErrors = "Success.";
                        ret.IsSuccess = true;
                        ret.CommonErrors = "Load Complate";
                        ret.StatusCode = 200;
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
            return null;

        }

        [HttpPost]
        [Route("api/User/updateEmployeeLeave")]
        public updateEmployeeLeaveModel updateEMp(updateEmployeeLeaveParam data)
        {
            {
                var ret = new updateEmployeeLeaveModel();
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
                            string command;
                            //int Result;
                            string result = "0";

                            command = "EXEC p_updateEmployeeLeaveDetail @leaverequestid =" + data.leaverequestid + ", @amountday = " + data.amountday + ", @useradd =" + data.useradd + "";

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

                            //This is save log
                            string logevent = "Update";
                            string logmodules = "UpdateEmployeeLeave";
                            string olddata = "";
                            string newdata = "LeaverequestID = " + data.leaverequestid + "; amountday=" + data.amountday + ".";
                            insertLog(data.token, logevent, logmodules, olddata, newdata);

                            if (data.lang == "1")
                            {
                                ret.ModelError = "ບັນທຶກຂໍ້ມູນສໍາເລັດ";
                            }
                            else
                            {
                                ret.ModelError = "Save complete";
                            }
                            ret.ResultObject = null;
                            ret.StatusCode = 200;
                            ret.IsSuccess = true;
                            ret.CommonError = null;
                            return ret;

                        }
                        else
                        {
                            ret.ModelError = "Unauthorized";
                            ret.ResultObject = null;
                            ret.StatusCode = 401;
                            ret.IsSuccess = false;
                            ret.CommonError = "Token key not correct ...!";
                            return ret;


                        }

                    }
                }
                catch (Exception ex)
                {
                    WriteLogFile(ex.Message);
                    ret.ModelError = "Error" + ex.Message;
                    ret.ResultObject = null;
                    ret.StatusCode = 417;
                    ret.IsSuccess = false;
                    ret.CommonError = "Expectation Failed";
                    return ret;
                }
            }
        }
        

        [HttpPost]
        [Route ("api/User/LeaveSummaryAllEmployee")]
        public loadLeaveSummaryAllEmployeeModel loadData (loadLeaveSummaryAllEmployeeParam data)
        {
            var ret = new loadLeaveSummaryAllEmployeeModel();

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
                        var query = (from x in db.p_reportLeaveSummaryAllEmployee_new()
                                     select new
                                     {
                                         x.empid,
                                         x.leaveforward,
                                         x.CLentitlement,
                                         x.CLbalancelastmonth,
                                         x.CLusedthismonth,
                                         x.CLremain,
                                         x.ALentitlement,
                                         x.ALbalancelastmonth,
                                         x.ALusedthismonth,
                                         x.AEworkingthismonth,
                                         x.AKremain,
                                         x.DILbalance,
                                         x.DILUsed,
                                         x.empno,
                                         x.empnameL1,
                                         x.empnameL2,
                                         x.departmentL1,
                                         x.departmentL2,
                                     }).ToList();

                        List<loadLeaveSummaryAllEmployeeResult> ResultObject = new List<loadLeaveSummaryAllEmployeeResult>();
                        if (data.lang == "1")
                        {
                            ResultObject = query.Select(d => new loadLeaveSummaryAllEmployeeResult()
                            {
                                empid = d.empid.ToString(),
                                empno = d.empno == null ? "" : d.empno.ToString(),
                                empname = d.empnameL1 == null ? "" : d.empnameL1.ToString(),
                                deptname = d.departmentL1 == null ? "": d.departmentL1.ToString(),

                                leaveforward = d.leaveforward.ToString(),
                                CLentitlement = d.CLentitlement.ToString(),
                                CLbalancelastmonth = d.CLbalancelastmonth.ToString(),
                                CLusedthismonth = d.CLusedthismonth.ToString(),
                                CLremain = d.CLremain.ToString(),
                                ALentitlement = d.ALentitlement.ToString(),
                                ALbalancelastmonth = d.ALbalancelastmonth.ToString(),
                                ALusedthismonth = d.ALusedthismonth.ToString(),
                                AEworkingthismonth = d.AEworkingthismonth.ToString(),
                                AKremain = d.AKremain.ToString(),
                                DILbalance = d.DILbalance.ToString(),
                                DILUsed = d.DILUsed.ToString()
                            }).ToList();

                        }
                        else
                        {
                            ResultObject = query.Select(d => new loadLeaveSummaryAllEmployeeResult()
                            {
                                empid = d.empid.ToString(),
                                empno = d.empno == null ? "" : d.empno.ToString(),
                                empname = d.empnameL2 == null ? "" : d.empnameL2.ToString(),
                                deptname = d.departmentL2 == null ? "" : d.departmentL2.ToString(),
                                leaveforward = d.leaveforward.ToString(),
                                CLentitlement = d.CLentitlement.ToString(),
                                CLbalancelastmonth = d.CLbalancelastmonth.ToString(),
                                CLusedthismonth = d.CLusedthismonth.ToString(),
                                CLremain = d.CLremain.ToString(),
                                ALentitlement = d.ALentitlement.ToString(),
                                ALbalancelastmonth = d.ALbalancelastmonth.ToString(),
                                ALusedthismonth = d.ALusedthismonth.ToString(),
                                AEworkingthismonth = d.AEworkingthismonth.ToString(),
                                AKremain = d.AKremain.ToString(),
                                DILbalance = d.DILbalance.ToString(),
                                DILUsed = d.DILUsed.ToString()
                            }).ToList();
                        }
                        ret.ModelError = "Display Data.";
                        ret.ResultObject = ResultObject;
                        ret.StatusCode = 200;
                        ret.IsSuccess = false;
                        ret.CommonError = "Success...";
                        return ret;
                    }
                    else
                    {
                        ret.ModelError = "Unauthorized";
                        ret.ResultObject = null;
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.CommonError = "Token key not correct ...!";
                        return ret;

                    }
                }
            }
            catch(Exception ex)
            {
                //ex.Message();
                ret.ModelError = ex.Message;
                ret.ResultObject = null;
                ret.StatusCode = 401;
                ret.IsSuccess = false;
                ret.CommonError = "Check Again.";
                return ret;
            }
            //return null;
        }


        [HttpPost]
        [Route("api/User/displayLeaveRequestAllDetails")]
        public leaverequestalldetailsResult Leavealldetail (leaverequestalldetailsParam data)
        {
            var ret = new leaverequestalldetailsResult();
            using (var db = new db_hrmsEntities())
            {
                try
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.Tokenkey || c.webTokenKey == data.Tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        if (data.status == "0" || data.status == "" || data.status == "All")
                        {
                            var dtx = (from c in db.v_leaverequestalldetails
                                       where c.empID == ds_tokey.empID 
                                       orderby c.startdate descending, c.status_ID ascending
                                       select new
                                       {
                                           c.leaveRequestID,
                                           c.leaveRequestNo,
                                           c.empID,
                                           c.firstName1,
                                           c.firstName2,
                                           c.lastName1,
                                           c.lastName2,
                                           c.leaveTypeID,
                                           c.startdate,
                                           c.enddate,
                                           c.returnDate,
                                           c.amountday,
                                           c.noted,
                                           c.delegateEmpID,
                                           c.fileAttached,
                                           c.managerID,
                                           c.transactiontypetext,
                                           c.expdate,
                                           c.referAdd,
                                           c.status_ID,
                                           c.imagePath,
                                           c.manager_fname1,
                                           c.manager_fname2,
                                           c.manager_lastname1,
                                           c.manager_lastname2,
                                           c.delegate_fname1,
                                           c.delegate_fname2,
                                           c.delegate_lname1,
                                           c.delegate_lname2,
                                           c.status_text,
                                           c.empNo,
                                           c.leaveDay,
                                           c.leaveTypeName1,
                                           c.leaveTypeName2,
                                           c.leavemorning,
                                           c.leaveafternoon
                                       }).ToList();
                            if (dtx != null)
                            {
                                List<leaverequestalldetailsModel> ResultObject = new List<leaverequestalldetailsModel>();
                                if (data.lang == "1")
                                {

                                    ResultObject = dtx.Select(d => new leaverequestalldetailsModel()
                                    {
                                        leaveRequestID = d.leaveRequestID.ToString(),
                                        leaveRequestNo = d.leaveRequestNo,
                                        empID = d.empID.ToString(),
                                        empName = d.firstName1 + " " + d.lastName1,
                                        leaveTypeID = d.leaveTypeID.ToString(),
                                        startDate = Convert.ToDateTime(d.startdate).ToString("dd/MM/yyyy"),

                                        //startDate = d.startdate.ToString(),

                                        endDate = Convert.ToDateTime(d.enddate).ToString("dd/MM/yyyy"),
                                        returnDate = Convert.ToDateTime(d.returnDate).ToString("dd/MM/yyyy"),
                                        amountDay = d.amountday.ToString(),

                                        noted = d.noted.ToString(),
                                        delegateEmpid = d.delegateEmpID.ToString(),
                                        fileAttached = d.fileAttached.ToString(),
                                        managerEmpID = d.managerID,
                                        managerName = d.manager_fname1 + " " + d.manager_lastname1,
                                        delegateEmpName = d.delegate_fname1 + " " + d.delegate_lname1.ToString(),
                                        status = d.status_text.ToString(),
                                        expDate = Convert.ToDateTime(d.expdate).ToString("dd/MM/yyyy"),
                                        filePath = d.imagePath.ToString().Trim(),
                                        transactionTypeName = d.transactiontypetext,
                                        empNo = d.empNo.ToString(),
                                        leaveDay = d.leaveDay,
                                        leaveTypeName = d.leaveTypeName1.ToString(),
                                        leavemorning = d.leavemorning.ToString(),
                                        leaveafternoon = d.leaveafternoon.ToString(),
                                        referAdd = d.referAdd == null ? "" : d.referAdd.ToString()
                                    }).ToList();
                                }
                                else
                                {
                                    ResultObject = dtx.Select(d => new leaverequestalldetailsModel()
                                    {
                                        leaveRequestID = d.leaveRequestID.ToString(),
                                        leaveRequestNo = d.leaveRequestNo,
                                        empID = d.empID.ToString(),
                                        empName = d.firstName2 + " " + d.lastName2,
                                        leaveTypeID = d.leaveTypeID.ToString(),
                                        startDate = Convert.ToDateTime(d.startdate).ToString("dd/MM/yyyy"),
                                        endDate = Convert.ToDateTime(d.enddate).ToString("dd/MM/yyyy"),
                                        returnDate = Convert.ToDateTime(d.returnDate).ToString("dd/MM/yyyy"),
                                        amountDay = d.amountday.ToString(),
                                        noted = d.noted.ToString(),
                                        delegateEmpid = d.delegateEmpID.ToString(),
                                        fileAttached = d.fileAttached.ToString(),
                                        managerEmpID = d.managerID,
                                        managerName = d.manager_fname2 + " " + d.manager_lastname2,
                                        delegateEmpName = d.delegate_fname2 + " " + d.delegate_lname2.ToString(),
                                        status = d.status_text.ToString(),
                                        expDate = d.expdate.ToString(),
                                        filePath = d.imagePath.ToString().Trim(),
                                        transactionTypeName = d.transactiontypetext,
                                        empNo = d.empNo.ToString(),
                                        leaveDay = d.leaveDay,
                                        leaveTypeName = d.leaveTypeName2.ToString(),
                                        leavemorning = d.leavemorning.ToString(),
                                        leaveafternoon = d.leaveafternoon.ToString(),
                                        referAdd = d.referAdd == null ? "" : d.referAdd.ToString()
                                    }).ToList();
                                }
                                ret.ModelErrors = "Success Data.";
                                ret.CommonErrors = "Display Data.";
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.ResultObject = ResultObject;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Not found your data.";
                                ret.ResultObject = null;
                                ret.StatusCode = 401;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "Check your data again.";
                                return ret;
                            }
                        }
                        else
                        {
                            var dtx = (from c in db.v_leaverequestalldetails
                                       where c.empID == ds_tokey.empID & c.status_text == data.status & c.startdate >= data.stdate & c.startdate <= data.enddate
                                       orderby c.startdate descending
                                       select new
                                       {
                                           c.leaveRequestID,
                                           c.leaveRequestNo,
                                           c.empID,
                                           c.firstName1,
                                           c.firstName2,
                                           c.lastName1,
                                           c.lastName2,
                                           c.leaveTypeID,
                                           c.startdate,
                                           c.enddate,
                                           c.returnDate,
                                           c.amountday,
                                           c.noted,
                                           c.delegateEmpID,
                                           c.fileAttached,
                                           c.managerID,
                                           c.transactiontypetext,
                                           c.expdate,
                                           c.referAdd,
                                           c.status_ID,
                                           c.imagePath,
                                           c.manager_fname1,
                                           c.manager_fname2,
                                           c.manager_lastname1,
                                           c.manager_lastname2,
                                           c.delegate_fname1,
                                           c.delegate_fname2,
                                           c.delegate_lname1,
                                           c.delegate_lname2,
                                           c.status_text,
                                           c.empNo,
                                           c.leaveDay,
                                           c.leaveTypeName1,
                                           c.leaveTypeName2,
                                           c.leavemorning,
                                           c.leaveafternoon
                                       }).ToList();
                            if (dtx != null)
                            {
                                List<leaverequestalldetailsModel> ResultObject = new List<leaverequestalldetailsModel>();
                                if (data.lang == "1")
                                {

                                    ResultObject = dtx.Select(d => new leaverequestalldetailsModel()
                                    {
                                        leaveRequestID = d.leaveRequestID.ToString(),
                                        leaveRequestNo = d.leaveRequestNo,
                                        empID = d.empID.ToString(),
                                        empName = d.firstName1 + " " + d.lastName1,
                                        leaveTypeID = d.leaveTypeID.ToString(),
                                        startDate = Convert.ToDateTime(d.startdate).ToString("dd/MM/yyyy"),

                                        //startDate = d.startdate.ToString(),

                                        endDate = Convert.ToDateTime(d.enddate).ToString("dd/MM/yyyy"),
                                        returnDate = Convert.ToDateTime(d.returnDate).ToString("dd/MM/yyyy"),
                                        amountDay = d.amountday.ToString(),

                                        noted = d.noted.ToString(),
                                        delegateEmpid = d.delegateEmpID.ToString(),
                                        fileAttached = d.fileAttached.ToString(),
                                        managerEmpID = d.managerID,
                                        managerName = d.manager_fname1 + " " + d.manager_lastname1,
                                        delegateEmpName = d.delegate_fname1 + " " + d.delegate_lname1.ToString(),
                                        status = d.status_text.ToString(),
                                        expDate = Convert.ToDateTime(d.expdate).ToString("dd/MM/yyyy"),
                                        filePath = d.imagePath.ToString().Trim(),
                                        transactionTypeName = d.transactiontypetext,
                                        empNo = d.empNo.ToString(),
                                        leaveDay = d.leaveDay,
                                        leaveTypeName = d.leaveTypeName1.ToString(),
                                        leavemorning = d.leavemorning.ToString(),
                                        leaveafternoon = d.leaveafternoon.ToString(),
                                        referAdd = d.referAdd == null ? "" : d.referAdd.ToString()
                                    }).ToList();
                                }
                                else
                                {
                                    ResultObject = dtx.Select(d => new leaverequestalldetailsModel()
                                    {
                                        leaveRequestID = d.leaveRequestID.ToString(),
                                        leaveRequestNo = d.leaveRequestNo,
                                        empID = d.empID.ToString(),
                                        empName = d.firstName2 + " " + d.lastName2,
                                        leaveTypeID = d.leaveTypeID.ToString(),
                                        startDate = Convert.ToDateTime(d.startdate).ToString("dd/MM/yyyy"),
                                        endDate = Convert.ToDateTime(d.enddate).ToString("dd/MM/yyyy"),
                                        returnDate = Convert.ToDateTime(d.returnDate).ToString("dd/MM/yyyy"),
                                        amountDay = d.amountday.ToString(),
                                        noted = d.noted.ToString(),
                                        delegateEmpid = d.delegateEmpID.ToString(),
                                        fileAttached = d.fileAttached.ToString(),
                                        managerEmpID = d.managerID,
                                        managerName = d.manager_fname2 + " " + d.manager_lastname2,
                                        delegateEmpName = d.delegate_fname2 + " " + d.delegate_lname2.ToString(),
                                        status = d.status_text.ToString(),
                                        expDate = d.expdate.ToString(),
                                        filePath = d.imagePath.ToString().Trim(),
                                        transactionTypeName = d.transactiontypetext,
                                        empNo = d.empNo.ToString(),
                                        leaveDay = d.leaveDay,
                                        leaveTypeName = d.leaveTypeName2.ToString(),
                                        leavemorning = d.leavemorning.ToString(),
                                        leaveafternoon = d.leaveafternoon.ToString(),
                                        referAdd = d.referAdd == null ? "" : d.referAdd.ToString()
                                    }).ToList();
                                }
                                ret.ModelErrors = "Success Data.";
                                ret.CommonErrors = "Display Data.";
                                ret.StatusCode = 200;
                                ret.IsSuccess = true;
                                ret.ResultObject = ResultObject;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Not found your data.";
                                ret.ResultObject = null;
                                ret.StatusCode = 401;
                                ret.IsSuccess = false;
                                ret.CommonErrors = "Check your data again.";
                                return ret;
                            }
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
                catch (Exception ex)
                {

                }
            }
            return null;
        }


        [HttpPost]
        [Route("api/User/displayNotiApproval")]
        public displayNotiApproveResult displaynotiapproves(displayNotiApproveParam data)
        {
            var ret = new displayNotiApproveResult();

            using (var db = new db_hrmsEntities())
            {
                try
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.token || c.webTokenKey == data.token)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();

                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.pd_displayNotiapprove1(data.managerid)
                                       select new
                                       {
                                           c.leave,
                                           c.wff,
                                           c.wfh,
                                           c.ot,
                                           c.deleagte,
                                           c.totalleave,
                                           c.total,
                                           c.countsalaryapprove
                                       }).ToList();

                        if (ds_data != null)
                        {

                            var ds_ll = (from c in db.tmp_notiMenu
                                         where c.mgrId == data.managerid
                                           select new
                                           {
                                               c.leave,
                                               c.wff,
                                               c.wfh,
                                               c.ot,
                                               c.deleagte,
                                               c.totalleave,
                                               c.total,
                                               c.countsalaryapprove,
                                               c.deleagte_rq
                                           }).ToList();

                            List<displayNotiApproveModel> ResultObject = new List<displayNotiApproveModel>();
                            ResultObject = ds_ll.Select(dx => new displayNotiApproveModel()
                            {
                                leave = dx.leave.ToString(),
                                wff = dx.wff.ToString(),
                                wfh = dx.wfh.ToString(),
                                ot = dx.ot.ToString(),
                                deleagte = dx.deleagte.ToString(),
                                totalleave = dx.totalleave.ToString(),
                                total = dx.total.ToString(),
                                countapprove = dx.countsalaryapprove.ToString(),
                                deleagte_rq = dx.deleagte_rq == null ?  "0" : dx.deleagte_rq.ToString()

                            }).ToList();
                            ret.ModelErrors = "Success.";
                            ret.CommonErrors = "Display your data.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Not Found Your Data.";
                            ret.CommonErrors = "Erros query data.";
                            ret.IsSuccess = false;
                            ret.StatusCode = 401;
                            ret.ResultObject = null;
                            return ret;
                        }

                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonErrors = "Check your Token";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                        return ret;
                    }

                }
                catch (Exception ex)
                {
                    ret.ModelErrors = ex.Message;
                    ret.CommonErrors = "";
                    ret.StatusCode = 401;
                    ret.IsSuccess = false;
                    ret.ResultObject = null;
                    return ret;
                }
            }
            //return null;
        }

        [HttpPost]
        [Route("api/User/displayLeaveBalanceAllEMPYear")]
        public displayLeaveBalanceAllResult displayLeaveBalance(displayLeaveBalanceAllParam data)
        {
            var ret = new displayLeaveBalanceAllResult();
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
                        var ds_data = (from c in db.pd_displayLeaveBalanceAll(data.empid, data.year)
                                       select new
                                       {
                                           c.balanceleaveEMP,
                                           c.balanceleaveMGID
                                       }).ToList();
                        if (ds_data != null)
                        {
                            List<displayLeaveBalanceAllModel> ResultObject = new List<displayLeaveBalanceAllModel>();
                            ResultObject = ds_data.Select(d => new displayLeaveBalanceAllModel()
                            {
                                blEMP = d.balanceleaveEMP.ToString(),
                                blMGID = d.balanceleaveMGID.ToString()
                            }).ToList();

                            ret.ModelErrors = "Success.";
                            ret.CommomErrors = "Display your data.";
                            ret.StatusCode = 200;
                            ret.IsSuccess = false;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Check your data again.";
                            ret.CommomErrors = "Can not found your data.";
                            ret.IsSuccess = false;
                            ret.StatusCode = 401;
                            ret.ResultObject = null;
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommomErrors = "Token is  errors.";
                        ret.StatusCode = 401;
                        ret.IsSuccess = false;
                        ret.ResultObject = null;
                        return ret;
                    }

                }
            }
            catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.CommomErrors = "";
                ret.StatusCode = 401;
                ret.IsSuccess = false;
                ret.ResultObject = null;
                return ret;
            }
          //return null;
        }

        [HttpPost]
        [Route("api/User/displaymbPaymentRecord")]
        public displaymbpaymentRecordResult displaymbRecordDetail(displaymbpaymentRecordParam data)
        {
            var ret = new displaymbpaymentRecordResult();
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
                        var ds_data = (from c in db.v_mobile_paymentrecord where c.empid == data.empid orderby c.strdate descending
                                       select new
                                       {
                                           c.salaryid,
                                           c.strdate,
                                           c.enddate,
                                           c.empid,
                                           c.monthcal,
                                           c.monthyear
                                       }).ToList();
                        List<displaymbpaymentRecordModel> ResultObject = new List<displaymbpaymentRecordModel>();
                        ResultObject = ds_data.Select(d => new displaymbpaymentRecordModel()
                        {
                            salaryid = d.salaryid,
                            empid = d.empid.ToString(),
                            strdate = Convert.ToDateTime(d.strdate).ToString("dd-MM-yyyy"),
                            enddate = Convert.ToDateTime(d.enddate).ToString("dd-MM-yyyy"),
                            monthly = d.monthcal.ToString(),
                            monthyear = d.monthyear.ToString()

                        }).ToList();
                        ret.ModelErrors = "Display Data...";
                        ret.CommonErrors = "Found Data.";
                        ret.IsSucess = true;
                        ret.StatusCode = 200;
                        ret.ResultObject = ResultObject;
                        return ret;
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonErrors = "Token is Errors.";
                        ret.IsSucess = false;
                        ret.StatusCode = 401;
                        return ret;
                    }
                } 

            }catch (Exception ex)
            {

            }
            return null;
        }


        [HttpPost]
        [Route("api/User/displayLog")]
        public displayLogResult displayLogDetails (displayLogParam data)
        {
            var ret = new displayLogResult();
            try
            {
                using (var db=new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.token || c.webTokenKey == data.token)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        if (data.strdate!=null && data.enddate!= null)
                        {
                          var ds_data = (from c in db.v_Log where (c.logDate >= data.strdate)
                                         where (c.logDate <= data.enddate)
                                         orderby c.logId descending
                                       select new
                                       {
                                           c.logId,
                                           c.logDate,
                                           c.logUser,
                                           c.username,
                                           c.logEven,
                                           c.logModules,
                                           c.oldData,
                                           c.newData,
                                           c.datelog
                                       }).ToList();
                            if (ds_data != null)
                            {
                                List<displayLogModel> ResultObject = new List<displayLogModel>();
                                ResultObject = ds_data.Select(d => new displayLogModel()
                                {
                                    logid = d.logId.ToString(),
                                    logdate = Convert.ToDateTime(d.logDate).ToString("dd-MM-yyyy hh:mm:ss"),
                                    loguser = d.logUser.ToString(),
                                    logeven = d.logEven.ToString(),
                                    logmodules = d.logModules.ToString(),
                                    olddata = d.oldData.ToString(),
                                    newdata = d.newData.ToString(),
                                    username = d.username.ToString(),
                                    datelog = d.datelog                                    

                                }).ToList();
                                ret.ModelErrors = "Display data.";
                                ret.CommonErrors = "Success.";
                                ret.IsSuccess = true;
                                ret.StatusCode = 200;
                                ret.ResultObject = ResultObject;
                                return ret;
                            }
                            else
                            {
                                ret.ModelErrors = "Not found your data.";
                                ret.CommonErrors = "Check your data again.";
                                ret.IsSuccess = true;
                                ret.StatusCode = 200;
                                ret.ResultObject = null;
                                return ret;
                            }
                        }
                        else
                        {
                            ret.ModelErrors = "Not found your Date.";
                            ret.CommonErrors = "Check your data again.";
                            ret.IsSuccess = false;
                            ret.StatusCode = 401;
                            ret.ResultObject = null;
                            return ret;

                        }
                        
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonErrors = "Token is fails.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                        return ret;
                    }
                }

            }catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.CommonErrors = "Errors.";
                ret.IsSuccess = false;
                ret.StatusCode = 401;
                ret.ResultObject = null;
                return ret;
            }
           // return null;
        }

        [HttpPost]
        [Route("api/User/DasboarSumOT")]
        public dasboardSumOTResult displaySumOT (dasboardSumOTParam data)
        {
            var ret = new dasboardSumOTResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.v_DashbordSumOT
                                       where c.empID == data.empid 
                                       select new
                                       {
                                           c.totalot
                                       }).ToList();
                        //var sum = ds_data.Select(c => c.totalot).Sum();

                        if (ds_data != null)
                        {
                            List<dashboardSumOTModel> ResultObject = new List<dashboardSumOTModel>();
                            ResultObject = ds_data.Select(d => new dashboardSumOTModel()
                            {
                                //sumtotal = d.totalot.ToString()
                                sumtotal = d.totalot == null ? "0" : d.totalot.ToString()

                            }).ToList();
                            ret.ModelErrors = "Display data.";
                            ret.CommonError = "Success.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonError = "Token is fails.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                        return ret;
                    }

                }

                }catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.CommonError = "Errors";
                ret.IsSuccess = false;
                ret.StatusCode = 401;
                ret.ResultObject = null;
                return ret;
            }
            return null;
        }

        [HttpPost]
        [Route("api/User/Dashboardleave")]
        public dashboardSumLeaveResult sumleaveall (dashboardSumLeaveParam data)
        {
            var ret = new dashboardSumLeaveResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.pd_displayLeaveDashboard(data.empid)

                                       select new
                                       {
                                           c.amountused,
                                           c.balanceleave
                                       }).ToList();
                        //var sum = ds_data.Select(c => c.totalot).Sum();

                        if (ds_data != null)
                        {
                            List<dashboardSumLeaveModel> ResultObject = new List<dashboardSumLeaveModel>();
                            ResultObject = ds_data.Select(d => new dashboardSumLeaveModel()
                            {
                                //sumtotal = d.totalot.ToString()
                                //sumtotal = d.totalot == null ? "0" : d.totalot.ToString()
                                amtDayleave = d.amountused.ToString(),
                                amtDayBalance = d.balanceleave.ToString()

                            }).ToList();
                            ret.ModelErrors = "Display data.";
                            ret.CommonError = "Success.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonError = "Token is fails.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                        return ret;
                    }

                }

            }
            catch (Exception ex)
            {
                ret.ModelErrors = ex.Message;
                ret.CommonError = "Errors";
                ret.IsSuccess = false;
                ret.StatusCode = 401;
                ret.ResultObject = null;
                return ret;
            }
            return null;
        }

        [HttpPost]
        [Route("api/User/displayMobileLeaveBalanceDashboard")]
        public displayMobileLeaveDashboardResult displayMobileleaveDashboard (displayMobileLeaveDashboardParam data)
        {
            var ret = new displayMobileLeaveDashboardResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.pd_displayMobileLeaveBalanceDashboard(data.year, data.empid, Convert.ToInt32(data.lang))

                                       select new
                                       {
                                           c.annualeave,
                                           c.b_annualleave,
                                           c.u_annualeave,
                                           c.sickleave,
                                           c.b_sickleave,
                                           c.u_sickleave,
                                           c.CLleave,
                                           c.b_CLleave,
                                           c.u_aCLleave,
                                           c.MLleave,
                                           c.b_MLleave,
                                           c.u_MLleave

                                       }).ToList();
                        //var sum = ds_data.Select(c => c.totalot).Sum();

                        if (ds_data != null)
                        {
                            List<displayMobileLeaveDashboardModel> ResultObject = new List<displayMobileLeaveDashboardModel>();
                            ResultObject = ds_data.Select(d => new displayMobileLeaveDashboardModel()
                            {
                               annualleave = d.annualeave, 
                               b_annualleave = d.b_annualleave.ToString(),
                               u_annualleave = d.u_annualeave.ToString(),
                               sickleave = d.sickleave,
                               b_sickleave = d.b_sickleave.ToString(),
                               u_sickleave = d.u_sickleave.ToString(),
                               clleave = d.CLleave,
                               b_clleave = d.b_CLleave.ToString(),
                               u_clleave = d.u_aCLleave.ToString(),
                               mlleave = d.MLleave,
                               b_mlleave = d.b_MLleave.ToString(),
                               u_mlleave = d.u_MLleave.ToString()

                            }).ToList();
                            ret.ModelErrors = "Display data.";
                            ret.CommonError = "Success.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonError = "Token is fails.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                        return ret;
                    }

                }

            }
            catch (Exception ex)
            {

            }
            return null;

        }
           
        [HttpPost]
        [Route("api/User/rptBonus")]
        public rptBonusResult rptBonusDetails (rptBonusParam data)
        {
            var ret = new rptBonusResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.v_advBonus
                                       where c.bonusyear + "-" + c.bonusmonth == data.monthlyyear
                                       select new
                                       {
                                           c.empid,
                                           c.firstname1, 
                                           c.firstname2,
                                           c.lastname1,
                                           c.lastname2,
                                           c.gendertext,
                                           c.basicsalary,
                                           c.ltlhiredate,
                                           c.bonusDate,
                                           c.lengthservice,
                                           c.bonusamount,
                                           c.bonusmonth,
                                           c.bonusyear,
                                           c.bonusStrdate,
                                           c.bonusEnddate,
                                           c.nummonthbonus,
                                           c.sec
                                       }).ToList();
                        if (ds_data != null)
                        {
                            List<rptBonusModel> ResultObject = new List<rptBonusModel>();
                            ResultObject = ds_data.Select(d => new rptBonusModel()
                            {
                                empid = d.empid.ToString(),
                                empname1 = d.firstname1.ToString() +' '+ d.lastname1,
                                empname2 = d.firstname2.ToString() +' '+ d.lastname2,
                                gendertext = d.gendertext.ToString(),
                                f_basicsalary = d.basicsalary.ToString(),
                                ltlthiredate = d.ltlhiredate.ToString(),
                                bonusdate = d.bonusDate.ToString(),
                                lengservice = d.lengthservice.ToString(),
                                f_bonusamount = d.bonusamount.ToString(),
                                bonusyear = d.bonusyear.ToString(),
                                bonustrdate = d.bonusStrdate.ToString(),
                                bonusenddate = d.bonusEnddate.ToString(),
                                numonthbonus = d.nummonthbonus.ToString(),
                                sec = d.sec.ToString(),
                                bonusamount = d.bonusamount.ToString()
                                
                            }).ToList();
                            ret.ModelErrors = "Display data.";
                            ret.CommonErrors = "Found your data.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                        else
                        {
                            ret.ModelErrors = "Not Found your data.";
                            ret.CommonErrors = "Check your data in your DB.";
                            ret.IsSuccess = false;
                            ret.StatusCode = 401;
                            ret.ResultObject = null;
                            return ret;
                        }

                    }
                    else
                    {
                        ret.ModelErrors = "Unauthorized";
                        ret.CommonErrors = "Check your token key.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                    }

                }

            }catch (Exception ex)
            {
                WriteLogFile(ex.Message);
                ret.ModelErrors = ex.Message;
                ret.CommonErrors = "Errors";
                ret.IsSuccess = false;
                ret.StatusCode = 401;
                ret.ResultObject = null;
            }
            return null;
        }

        [HttpPost]
        [Route("api/User/ReportSeverance")]
        public severanceResult SeveranceDetails (severanceParam data)
        {
            var ret = new severanceResult();
            try
            {
                using (var db = new db_hrmsEntities())
                {
                    var ds_tokey = (from c in db.v_user_permission
                                    where (c.appTokenKey == data.tokenkey || c.webTokenKey == data.tokenkey)
                                    select new
                                    {
                                        c.empID
                                    }).FirstOrDefault();
                    if (ds_tokey != null)
                    {
                        var ds_data = (from c in db.tb_severance
                                       where c.severanceMonth == data.month & c.severanceYear == data.year & c.status_id ==1
                                       orderby c.empID descending
                                       select new
                                       {
                                           c.severanceID,
                                           c.transactionNo,
                                           c.empID,
                                           c.empNo,
                                           c.empWorkDayID,
                                           c.deptCode,
                                           c.sec,
                                           c.gender,
                                           c.basicSalrary,
                                           c.severanceMonth,
                                           c.severanceYear,
                                           c.severanceDate,
                                           c.ltlHireDate,
                                           c.ltcHireDate,
                                           c.lengthService,
                                           c.severanceAmount,
                                           c.remark,
                                           c.typeID, 
                                           c.status_id,
                                           c.user_add
                                       }).ToList();
                        if (ds_data != null)
                        {
                            List<severanceModel> ResultObject = new List<severanceModel>();
                            ResultObject = ds_data.Select(c => new severanceModel()
                            {
                                severanceID = c.severanceID.ToString(),
                                empID = c.empID.ToString(),
                                transactionno = c.transactionNo,
                                empno = c.empNo,
                                empworkdayid = c.empWorkDayID,
                                deptcode = c.deptCode,
                                sec = c.sec,
                                gender = c.gender,
                                basicSalary = Convert.ToDouble(c.basicSalrary).ToString("#,##.0"),
                                severanceMonth = c.severanceMonth.ToString(),
                                severanceYear = c.severanceYear.ToString(),
                                severanceDate = c.severanceDate==null ? "" : Convert.ToDateTime(c.severanceDate).ToString("dd-MM-yyyy"),

                                //ltlHireDate = c.ltlHireDate==null?"": c.ltlHireDate.ToString(),

                                ltlHireDate = c.ltlHireDate==null ? "" : Convert.ToDateTime(c.ltlHireDate).ToString("dd-MM-yyyy"),

                                lengthService = Convert.ToDouble(c.lengthService).ToString("#,##.0"),
                                severanceAmount = Convert.ToDouble(c.severanceAmount).ToString("#,##.0"),
                                remark = c.remark.ToString(),
                                typeID = c.typeID.ToString(),
                                status_id = c.status_id.ToString(),
                                ltchiredate = c.ltcHireDate == null ? "" : Convert.ToDateTime(c.ltcHireDate).ToString("dd-MM-yyyy")

                            }).ToList();
                            ret.ModelError = "Display Data.";
                            ret.CommonError = "Found your data.";
                            ret.IsSuccess = true;
                            ret.StatusCode = 200;
                            ret.ResultObject = ResultObject;
                            return ret;
                        }
                        else
                        {
                            ret.ModelError = "Error, Not found your data.";
                            ret.CommonError = "Check your API or DB again.";
                            ret.IsSuccess = false;
                            ret.StatusCode = 401;
                            ret.ResultObject = null;
                            return ret;
                        }

                    }
                    else
                    {
                        ret.ModelError = "Unauthorized";
                        ret.CommonError = "Check your token key.";
                        ret.IsSuccess = false;
                        ret.StatusCode = 401;
                        ret.ResultObject = null;
                    }

                }

            }catch(Exception ex)
            {

            }

            return null;
        }

    }

}