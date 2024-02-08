using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class LeaveBalanceParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class LeaveBalanceAllParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }
    public class dashboardLeavebalanceparam
    {
        public string token { get; set; }
        public int emp_id { get; set; }
    }
    public class dashboardLeavebalancemodel
    {
        public string used_annualleave { get; set; }
        public string used_sickleave { get; set; }
        public string used_specialleave { get; set; }
        public string totalannualleave { get; set; }
        public string totalsiclleave { get; set; }
        public string totalspecialleave { get; set; }
    }
    public class dasboardLeaveResult
    {
        public string ModelErrors { get; set; }
        public string CommonError { get; set; }
        public Boolean IsSuccess { get; set; }
        public int StatusCode { get; set; }
        public IEnumerable<dashboardLeavebalancemodel> ResultObject { get; set; }
    }


}