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
    
    public partial class tb_leaveRequestDetail
    {
        public int leaveRequestDetailID { get; set; }
        public Nullable<int> leaveRequestID { get; set; }
        public Nullable<System.DateTime> startDate { get; set; }
        public Nullable<System.DateTime> endDate { get; set; }
        public Nullable<double> amountDay { get; set; }
    
        public virtual tb_leaveRequest tb_leaveRequest { get; set; }
    }
}
