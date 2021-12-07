namespace DBORM
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Survey")]
    public partial class Survey
    {
        [Key]
        public Guid PostID { get; set; }

        public int ID { get; set; }

        [Required]
        [StringLength(50)]
        public string Title { get; set; }

        [Required]
        [StringLength(500)]
        public string Body { get; set; }

        public DateTime Starttime { get; set; }

        public DateTime Endtime { get; set; }

        public int ActType { get; set; }

        public bool Available { get; set; }
    }
}
