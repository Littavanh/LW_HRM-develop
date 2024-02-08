using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class MyAttendanceParam
    {
        
    }

    public class MyAttendanceCheckInOutParam
    {
        public string TokenKey { get; set; }
        public DateTime CheckDataTime { get; set; }
        public string longitude { get; set; }
        public string latitude { get; set; }
        public string checkInOut { get; set; }
        public byte[] picture { get; set; }
    }


    public class MyAttendanceCheckInOutResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<MyAttendanceResultViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class MyAttendanceResultViewModel
    {
        public string checkInOut { get; set; }
        public string CheckDateTime { get; set; }       
        public byte[] pic { get; set; }
        
    }

}