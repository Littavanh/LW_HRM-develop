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
    
    public partial class v_empOT
    {
        public int otRequestID { get; set; }
        public string otRequestNo { get; set; }
        public Nullable<int> empID { get; set; }
        public Nullable<int> otTypeID { get; set; }
        public System.DateTime startDate { get; set; }
        public System.DateTime endDate { get; set; }
        public System.TimeSpan otStartTime { get; set; }
        public System.TimeSpan otEndTime { get; set; }
        public string noted { get; set; }
        public string fileAttached { get; set; }
        public Nullable<int> managerID { get; set; }
        public string otTypeText { get; set; }
        public int otSettingID { get; set; }
        public System.TimeSpan startTime { get; set; }
        public System.TimeSpan endTime { get; set; }
        public string rateCode { get; set; }
        public string otSettingType { get; set; }
        public Nullable<System.TimeSpan> ots_startTime { get; set; }
        public Nullable<System.TimeSpan> ots_endTime { get; set; }
        public Nullable<int> minusHour { get; set; }
        public Nullable<double> otSettingValues { get; set; }
        public double qtyHour { get; set; }
        public Nullable<int> status_ID { get; set; }
        public int otRequestDetailID { get; set; }
    }
}
