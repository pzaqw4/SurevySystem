using DBFuctions;
using DBORM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Text;

namespace _1029Homework
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        string selectedPostID = null;
        HttpCookie ansCookie = HttpContext.Current.Request.Cookies["ansVal"];
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //檢查PID
                selectedPostID = Request.QueryString["PID"];
                if (selectedPostID == null)
                    Response.Redirect("ListPage01.aspx");

                if (HttpContext.Current.Session["Name"] != null)
                    this.txtName.Value = HttpContext.Current.Session["Name"] as string;
                if (HttpContext.Current.Session["Phone"] != null)
                    this.txtPhone.Value = HttpContext.Current.Session["Phone"] as string;
                if (HttpContext.Current.Session["Email"] != null)
                    this.txtEmail.Value = HttpContext.Current.Session["Email"] as string;
                if (HttpContext.Current.Session["Age"] != null)
                    this.txtAge.Value = HttpContext.Current.Session["Age"] as string;

                if (ansCookie == null)
                {
                    Response.Write("<Script language='JavaScript'>alert('沒有答案的問卷沒有意義,請確認作答後再送出!!'); history.go(-1); </Script>");
                }

            }
        }

        public class JsonAns
        {
            public string key;
            public string value;
        }

        protected void btnFix_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["PID"];
            Response.Redirect("InnerPage02.aspx?PID=" + id);
        }

        protected void btnConf_Click(object sender, EventArgs e)
        {
            string postID = Request.QueryString["PID"];
            string name = HttpContext.Current.Session["Name"] as string;
            string phone = HttpContext.Current.Session["Phone"] as string;
            string email = HttpContext.Current.Session["Email"] as string;
            string age = HttpContext.Current.Session["Age"] as string;


            if (ansCookie != null)
            {
                JsonAns[] answers = JsonConvert.DeserializeObject<JsonAns[]>(HttpUtility.UrlDecode(ansCookie.Value, Encoding.UTF8));//cookie編碼取值防止亂碼
                string allAns = JsonConvert.SerializeObject(answers);


                Answer answer = new Answer
                {
                    AnsID = int.Parse(DateTime.Now.ToString("mmss")),
                    A_UserName = name,
                    A_UserPhone = phone,
                    A_UserEmail = email,
                    A_UserAge = Convert.ToByte(age),
                    Answer1 = allAns,
                    CreateTime = DateTime.Now.ToLocalTime(),
                    PostID = Guid.Parse(postID)
                };
                PostManager.CreateAnswer(answer);
            }
            Session.RemoveAll();
            Response.Write("<Script language='JavaScript'>alert('提交成功!!! 感謝作答'); location.href='ListPage01.aspx'; </Script>");
        }
    }
}