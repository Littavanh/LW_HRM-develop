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
    
    public partial class tb_leaveApprove
    {
        public int leaveApproveID { get; set; }
        public string leaveApproveNo { get; set; }
        public int leaveRequestID { get; set; }
        public string noted { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    
        public virtual tb_leaveRequest tb_leaveRequest { get; set; }
    }
}
