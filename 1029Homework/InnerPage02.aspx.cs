using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _1029Homework
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string selectedPostID = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //檢查PID
                selectedPostID = Request.QueryString["PID"];
                if (selectedPostID == null)
                    Response.Redirect("ListPage01.aspx");
            }

            if (HttpContext.Current.Session["Name"] != null)
                this.txtName.Value = HttpContext.Current.Session["Name"] as string;
            if (HttpContext.Current.Session["Phone"] != null)
                this.txtPhone.Value = HttpContext.Current.Session["Phone"] as string;
            if (HttpContext.Current.Session["Email"] != null)
                this.txtEmail.Value = HttpContext.Current.Session["Email"] as string;
            if (HttpContext.Current.Session["Age"] != null)
                this.txtAge.Value = HttpContext.Current.Session["Age"] as string;

            Session.RemoveAll();  //修改按鈕用
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("ListPage01.aspx");
        }

        protected void btnSub_Click(object sender, EventArgs e)
        {
            string name = this.txtName.Value;
            string email = this.txtEmail.Value;
            string phone = this.txtPhone.Value;
            string age = this.txtAge.Value;
            string postID = Request.QueryString["PID"];


            ////按下送出，把資料暫存至session
            if (!string.IsNullOrWhiteSpace(name))
                HttpContext.Current.Session["Name"] = name;
            if (!string.IsNullOrWhiteSpace(email))
                HttpContext.Current.Session["Email"] = email;
            if (!string.IsNullOrWhiteSpace(phone))
                HttpContext.Current.Session["Phone"] = phone;
            if (!string.IsNullOrWhiteSpace(age))
                HttpContext.Current.Session["Age"] = age;
            
            Response.Redirect("ConfirmPage03.aspx?PID=" + postID);
        }
    }
}