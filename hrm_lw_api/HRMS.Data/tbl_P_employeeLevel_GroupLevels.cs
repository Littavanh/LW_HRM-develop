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
    
    public partial class tbl_P_employeeLevel_GroupLevels
    {
        public int PEGEID { get; set; }
        public Nullable<int> PUSLID { get; set; }
        public Nullable<int> GLUID { get; set; }
        public Nullable<int> EMP_ID { get; set; }
        public Nullable<int> createby { get; set; }
        public Nullable<System.DateTime> createdate { get; set; }
    
        public virtual tbl_P_GroupLevels tbl_P_GroupLevels { get; set; }
        public virtual tbl_P_GroupLevels tbl_P_GroupLevels1 { get; set; }
        public virtual tbl_P_GroupLevels tbl_P_GroupLevels2 { get; set; }
        public virtual tbl_P_Userlevels tbl_P_Userlevels { get; set; }
    }
}