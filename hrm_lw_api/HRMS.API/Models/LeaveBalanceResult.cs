using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class LeaveBalanceResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LeaveBalanceViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class LeaveBalanceViewModel
    {
        public string LeaveName { get; set; }
        public string leaveTotal { get; set; }
        public string leaveUse { get; set; }
        
    }


    public class LeaveBalanceAllResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<LeaveBalanceAllViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class LeaveBalanceAllViewModel
    {
        public string LeaveName { get; set; }
        public string leaveTotal { get; set; }
        public string leaveDayCanUse { get; set; }

    }
}