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
    
    public partial class tb_email_send
    {
        public int emailID { get; set; }
        public Nullable<int> emp_id { get; set; }
        public string email_address { get; set; }
        public string email_subject { get; set; }
        public string emil_body { get; set; }
        public string sendFrom { get; set; }
        public Nullable<System.DateTime> date_send { get; set; }
        public Nullable<int> status_id { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    }
}
