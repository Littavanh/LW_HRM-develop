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
    
    public partial class v_request_all
    {
        public int leaveRequestID { get; set; }
        public string leaveRequestNo { get; set; }
        public Nullable<int> empID { get; set; }
        public string noted { get; set; }
        public Nullable<int> delegateEmpID { get; set; }
        public string fileAttached { get; set; }
        public string empTitleName { get; set; }
        public string firstName1 { get; set; }
        public string lastName1 { get; set; }
        public string firstName2 { get; set; }
        public string lastName2 { get; set; }
        public string status_text { get; set; }
        public byte[] empPhoto { get; set; }
        public string empPosition { get; set; }
        public string requestType { get; set; }
        public string empMobile { get; set; }
        public string empEmail { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<int> managerID { get; set; }
    }
}