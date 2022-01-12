using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class QuestionInfoModel
    {
        public Guid PostID { get; set; }
        public int QuID { get; set; }
        public string Caption{ get; set; }
        public bool Nullable { get; set; }
        public string Ans { get; set; }
        public int Type { get; set; }
        public bool Available { get; set; }
    }
}
