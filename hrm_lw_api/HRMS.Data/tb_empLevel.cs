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
    
    public partial class tb_empLevel
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_empLevel()
        {
            this.tb_empInfo = new HashSet<tb_empInfo>();
        }
    
        public int empLevelID { get; set; }
        public string empLevelCode { get; set; }
        public string empLevelName1 { get; set; }
        public string empLevelName2 { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
        public Nullable<int> levelsigndays { get; set; }
        public Nullable<int> pr_groupID { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_empInfo> tb_empInfo { get; set; }
    }
}