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
    
    public partial class tb_bank
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tb_bank()
        {
            this.tb_empBankAccount = new HashSet<tb_empBankAccount>();
        }
    
        public int bankID { get; set; }
        public string BankShortName { get; set; }
        public string BankLongName { get; set; }
        public Nullable<int> status_ID { get; set; }
        public Nullable<int> user_add { get; set; }
        public Nullable<System.DateTime> date_add { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tb_empBankAccount> tb_empBankAccount { get; set; }
    }
}
