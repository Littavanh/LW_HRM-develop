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
    
    public partial class tb_sso
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_sso()
        {
            this.tb_empSSO = new HashSet<tb_empSSO>();
        }
    
        public int ssoID { get; set; }
        public Nullable<int> ssoTypeID { get; set; }
        public Nullable<double> minBase { get; set; }
        public Nullable<double> maxBase { get; set; }
        public Nullable<double> employeeRate { get; set; }
        public Nullable<double> employerRate { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_empSSO> tb_empSSO { get; set; }
        public virtual tb_ssoType tb_ssoType { get; set; }
    }
}