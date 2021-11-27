namespace DBORM
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Answer
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int AnsID { get; set; }

        [Required]
        [StringLength(50)]
        public string A_UserName { get; set; }

        [Required]
        [StringLength(10)]
        public string A_UserPhone { get; set; }

        [Required]
        [StringLength(50)]
        public string A_UserEmail { get; set; }

        public int A_UserAge { get; set; }

        public DateTime CreateTime { get; set; }

        [Column("Answer")]
        [Required]
        [StringLength(100)]
        public string Answer1 { get; set; }

        public Guid PostID { get; set; }
    }
}
