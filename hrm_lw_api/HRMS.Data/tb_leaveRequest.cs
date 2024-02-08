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
    
    public partial class tb_leaveRequest
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_leaveRequest()
        {
            this.tb_leaveApprove = new HashSet<tb_leaveApprove>();
            this.tb_leaverequestdetailx = new HashSet<tb_leaverequestdetailx>();
            this.tb_leaveRequestDetail = new HashSet<tb_leaveRequestDetail>();
            this.tb_request_upload = new HashSet<tb_request_upload>();
        }
    
        public int leaveRequestID { get; set; }
        public string leaveRequestNo { get; set; }
        public Nullable<int> empID { get; set; }
        public Nullable<int> leaveTypeID { get; set; }
        public string leaveDay { get; set; }
        public Nullable<System.DateTime> startDate { get; set; }
        public Nullable<System.DateTime> endDate { get; set; }
        public Nullable<System.DateTime> returnDate { get; set; }
        public Nullable<double> amountDay { get; set; }
        public string noted { get; set; }
        public Nullable<int> delegateEmpID { get; set; }
        public string imagePath { get; set; }
        public string fileAttached { get; set; }
        public string fileType { get; set; }
        public Nullable<int> managerID { get; set; }
        public Nullable<int> transactionType { get; set; }
        public Nullable<System.DateTime> expDate { get; set; }
        public string referAdd { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> from_device { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
        public Nullable<bool> leavemorning { get; set; }
        public Nullable<bool> leaveafternoon { get; set; }
        public Nullable<System.DateTime> lastApproveDate { get; set; }
    
        public virtual tb_employees tb_employees { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_leaveApprove> tb_leaveApprove { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_leaverequestdetailx> tb_leaverequestdetailx { get; set; }
        public virtual tb_leaveRequest tb_leaveRequest1 { get; set; }
        public virtual tb_leaveRequest tb_leaveRequest2 { get; set; }
        public virtual tb_leaveTranType tb_leaveTranType { get; set; }
        public virtual tb_leaveType tb_leaveType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_leaveRequestDetail> tb_leaveRequestDetail { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_request_upload> tb_request_upload { get; set; }
    }
}