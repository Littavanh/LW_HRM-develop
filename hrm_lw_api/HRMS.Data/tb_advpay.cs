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
    
    public partial class tb_advpay
    {
        public int advPayID { get; set; }
        public string transactionNo { get; set; }
        public Nullable<int> advpayMonth { get; set; }
        public Nullable<int> advpayYear { get; set; }
        public Nullable<int> empID { get; set; }
        public string empNo { get; set; }
        public string fullName { get; set; }
        public Nullable<System.DateTime> advpayDate { get; set; }
        public Nullable<double> advPay { get; set; }
        public string noted { get; set; }
        public Nullable<int> status_id { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
        public string statusText { get; set; }
    
        public virtual tb_employees tb_employees { get; set; }
    }
}
