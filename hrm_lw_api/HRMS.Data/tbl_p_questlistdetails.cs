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
    
    public partial class tbl_p_questlistdetails
    {
        public int QTLID { get; set; }
        public Nullable<int> HDQID { get; set; }
        public Nullable<int> QTID { get; set; }
        public Nullable<int> Qno { get; set; }
        public string QName { get; set; }
        public string rec_type { get; set; }
        public Nullable<int> createby { get; set; }
        public Nullable<System.DateTime> createdate { get; set; }
        public Nullable<double> scores { get; set; }
    
        public virtual tbl_p_headerquestion tbl_p_headerquestion { get; set; }
    }
}
