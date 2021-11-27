using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace DBORM
{
    public partial class DBModel : DbContext
    {
        public DBModel()
            : base("name=DefaultConnectionString")
        {
        }

        public virtual DbSet<Answer> Answers { get; set; }
        public virtual DbSet<MixQu> MixQus { get; set; }
        public virtual DbSet<Question> Questions { get; set; }
        public virtual DbSet<Surevy> Surevies { get; set; }
        public virtual DbSet<UserInfo> UserInfoes { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Answer>()
                .Property(e => e.A_UserPhone)
                .IsUnicode(false);

            modelBuilder.Entity<Surevy>()
                .HasOptional(e => e.Surevy1)
                .WithRequired(e => e.Surevy2);

            modelBuilder.Entity<UserInfo>()
                .Property(e => e.Phone)
                .IsUnicode(false);
        }
    }
}
