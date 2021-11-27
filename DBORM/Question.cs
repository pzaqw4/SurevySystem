namespace DBORM
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Question
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int QuID { get; set; }

        [Required]
        [StringLength(50)]
        public string Caption { get; set; }

        public int Type { get; set; }

        public bool Nullable { get; set; }

        [Required]
        [StringLength(50)]
        public string Ans { get; set; }

        public bool Available { get; set; }

        public Guid PostID { get; set; }
    }
}
