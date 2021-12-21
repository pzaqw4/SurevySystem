using DBORM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _1029Homework.SystemAdmin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
        }
        protected void BtnConfirm_Click(object sender, EventArgs e)
        {

            string title = this.textTitle.Value;
            string body = this.textBody.Value;
            bool ava;

            if (CheckInput())
            {
                DateTime str = DateTime.Parse(this.startDate.Value);
                DateTime end = DateTime.Parse(this.endDate.Value);
         
                if (cbAvailable.Checked)
                    ava = true;
                else
                    ava = false;

                Survey Survey = new Survey
                {
                    ID= DBFuctions.PostManager.GetnewID(),
                    PostID = Guid.NewGuid(),
                    Title = title,
                    Available = ava,
                    Body = body,
                    Starttime = str,
                    Endtime = end,
                };
                DBFuctions.PostManager.CreateSurvey(Survey);
                Session["PostID"] = Survey.PostID;

                Response.Redirect($"EditQAPage03.aspx?PostID={Survey.PostID}");
            }

        }
        private bool CheckInput()
        {

            if (string.IsNullOrWhiteSpace(this.textTitle.Value) || string.IsNullOrEmpty(this.textTitle.Value))
            {
                this.lblTitle.InnerHtml = "<span style='color:red'>請輸入標題</span>";
                return false;
            }


            if (string.IsNullOrWhiteSpace(this.textBody.Value) || string.IsNullOrEmpty(this.textBody.Value))
            {
                this.lblBody.InnerHtml = "<span style='color:red'>請輸入描述內容</span>";
                return false;
            }

            if (string.IsNullOrEmpty(this.startDate.Value))
            {
                this.lblStart.InnerHtml = "<span style='color:red'>請輸入時間</span>";
                return false;
            }
            if (string.IsNullOrEmpty(this.endDate.Value))
            {
                this.lblEnd.InnerHtml = "<span style='color:red'>請輸入時間</span>";
                return false;
            }

            return true;
        }

        protected void btnclear_Click(object sender, EventArgs e)
        {
            this.lblTitle.InnerHtml = "<span style='color:black'>請輸入問卷標題</span>";
            this.lblBody.InnerHtml = "<span style='color:black'>請輸入問卷描述內容</span>";
            this.lblStart.InnerHtml = "<span style='color:black'>請輸入問卷開始時間</span>";
            this.lblEnd.InnerHtml = "<span style='color:black'>請輸入問卷結束時間</span>";

            this.textTitle.Value="";
            this.textBody.Value="";
            this.startDate.Value = "";
            this.endDate.Value = "";
        }
    }
}