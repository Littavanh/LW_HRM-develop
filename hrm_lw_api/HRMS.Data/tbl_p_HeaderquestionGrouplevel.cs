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
    
    public partial class tbl_p_HeaderquestionGrouplevel
    {
        public int HQGID { get; set; }
        public Nullable<int> HDQID { get; set; }
        public Nullable<int> GLUID { get; set; }
        public Nullable<System.DateTime> Cratedate { get; set; }
        public Nullable<int> createby { get; set; }
        public string rec_type { get; set; }
    
        public virtual tbl_P_GroupLevels tbl_P_GroupLevels { get; set; }
        public virtual tbl_p_headerquestion tbl_p_headerquestion { get; set; }
    }
}