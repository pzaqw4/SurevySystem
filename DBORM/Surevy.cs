namespace DBORM
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Surevy")]
    public partial class Surevy
    {
        [Required]
        [StringLength(20)]
        public string Title { get; set; }

        public bool ActType { get; set; }

        [Column(TypeName = "date")]
        public DateTime Starttime { get; set; }

        [Column(TypeName = "date")]
        public DateTime Endtime { get; set; }

        [StringLength(100)]
        public string Body { get; set; }

        [Key]
        public Guid PostID { get; set; }

        public bool Available { get; set; }

        public virtual Surevy Surevy1 { get; set; }

        public virtual Surevy Surevy2 { get; set; }
    }
}
