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
    
    public partial class tb_SLDRT_loanDetail
    {
        public int SLDRT_loanDetailID { get; set; }
        public Nullable<int> SLDRT_loanID { get; set; }
        public Nullable<System.DateTime> monthBL { get; set; }
        public Nullable<double> acc_balance { get; set; }
        public Nullable<double> monthlyPay { get; set; }
        public Nullable<double> loan_incen { get; set; }
        public Nullable<double> pay_amount { get; set; }
        public Nullable<double> totalBL { get; set; }
        public Nullable<int> paidStatus { get; set; }
        public Nullable<System.DateTime> payDate { get; set; }
        public Nullable<int> status_id { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    
        public virtual tb_SLDRT_loan tb_SLDRT_loan { get; set; }
    }
}
