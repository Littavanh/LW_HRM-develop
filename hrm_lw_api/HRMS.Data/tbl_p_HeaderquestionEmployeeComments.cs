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
    
    public partial class tbl_p_HeaderquestionEmployeeComments
    {
        public int HECID { get; set; }
        public Nullable<int> emp_id { get; set; }
        public Nullable<int> commentby { get; set; }
        public Nullable<int> hdqid { get; set; }
        public string textcomments { get; set; }
        public Nullable<System.DateTime> commentdate { get; set; }
        public string RecType { get; set; }
        public Nullable<int> RecjectTo { get; set; }
    }
}
