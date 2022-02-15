using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _1029Homework.SystemAdmin
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int aid = Convert.ToInt32(Context.Request.QueryString["AID"]);
            var ansInfo = DBFuctions.PostManager.GetOneAnswerInfo(aid);
            Guid pid = ansInfo.PostID;
            var surveyInfo = DBFuctions.PostManager.GetOnePostInfo(pid);
            var qusInfo = DBFuctions.PostManager.GetAllQuestion(pid);


            this.txtTitle.Text = surveyInfo.Title;
            for (int i = 0; i < qusInfo.Count(); i++)
            {
                txtQus.Text += "第" + (i + 1) + "題 :" + " " + qusInfo[i].Caption.Trim() + ";" + "\r\n ";
            }
            string[] ansVal = (ansInfo.Answer1).Split(';') ;
            for (int i = 0; i < ansVal.Count(); i++)
            {
                txtAns.Text += "第" + (i + 1) + "題 :" + " " + ansVal[i].Trim() + ";" + "\r\n ";
            }
        }
    }
}