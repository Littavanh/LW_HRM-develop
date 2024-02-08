using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class ViewFileResult
    {
        public string ModelErrors { get; set; }
        public ViewFileViewModel ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class ViewFileViewModel
    {  
        public Byte[] AttachedFile { get; set; }
        public string filename { get; set; }
    }
}