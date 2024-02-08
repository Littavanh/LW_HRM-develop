﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class ResponsiblePersonResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<ResponsiblePersonViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class ResponsiblePersonViewModel
    {
        public string empid { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
       
        
    }
}