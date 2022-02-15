using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class AnswerInfoModel
    {
        public int AnsID { get; set; }

        public string A_UserName { get; set; }

        public string A_UserPhone { get; set; }

        public string A_UserEmail { get; set; }

        public int A_UserAge { get; set; }

        public string CreateTime { get; set; }
        public string Answer1 { get; set; }

        public Guid PostID { get; set; }
    }
}
