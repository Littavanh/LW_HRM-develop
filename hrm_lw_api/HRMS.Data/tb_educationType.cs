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
    
    public partial class tb_educationType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_educationType()
        {
            this.tb_empEducation = new HashSet<tb_empEducation>();
        }
    
        public int educationTypeID { get; set; }
        public string educationTypeCode { get; set; }
        public string educationTypeName1 { get; set; }
        public string educationTypeName2 { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_empEducation> tb_empEducation { get; set; }
    }
}
