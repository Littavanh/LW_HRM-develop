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
    
    public partial class tbl_p_headerquestion
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_p_headerquestion()
        {
            this.tb_evaluate_emp = new HashSet<tb_evaluate_emp>();
            this.tbl_p_employeeHeaderquestion = new HashSet<tbl_p_employeeHeaderquestion>();
            this.tbl_p_HeaderquestionGrouplevel = new HashSet<tbl_p_HeaderquestionGrouplevel>();
            this.tbl_p_listquestionemp = new HashSet<tbl_p_listquestionemp>();
            this.tbl_p_questlistdetails = new HashSet<tbl_p_questlistdetails>();
        }
    
        public int HDQID { get; set; }
        public Nullable<int> headerNo { get; set; }
        public Nullable<int> headerYear { get; set; }
        public string headername { get; set; }
        public Nullable<System.DateTime> startdate { get; set; }
        public Nullable<System.DateTime> enddate { get; set; }
        public string rec_type { get; set; }
        public Nullable<System.DateTime> createdate { get; set; }
        public Nullable<int> createby { get; set; }
        public Nullable<double> kpi_percent { get; set; }
        public Nullable<double> kbi_percent { get; set; }
        public Nullable<int> GLUID { get; set; }
        public Nullable<int> processNumber { get; set; }
        public string processDescript { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_evaluate_emp> tb_evaluate_emp { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_p_employeeHeaderquestion> tbl_p_employeeHeaderquestion { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_p_HeaderquestionGrouplevel> tbl_p_HeaderquestionGrouplevel { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_p_listquestionemp> tbl_p_listquestionemp { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_p_questlistdetails> tbl_p_questlistdetails { get; set; }
    }
}
