//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HRMS.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_p_score
    {
        public int PSCID { get; set; }
        public Nullable<double> score_min { get; set; }
        public Nullable<double> score_max { get; set; }
        public string score_grade { get; set; }
        public string score_info { get; set; }
        public Nullable<int> createby { get; set; }
        public Nullable<System.DateTime> createdate { get; set; }
    }
}