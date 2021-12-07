using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class SurveyInfoModel
    {
        public Guid PostID { get; set; }
        public int ID { get; set; }
        public string Title { get; set; }
        public string Starttime { get; set; }
        public string Endtime { get; set; }
        public string Body { get; set; }
        public int ActType { get; set; }
        public bool Available { get; set; }

    }
}
