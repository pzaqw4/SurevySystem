using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _1029Homework
{
    public partial class WebForm3 : System.Web.UI.Page
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

                if (HttpContext.Current.Session["Name"] != null)
                    this.txtName.Value = HttpContext.Current.Session["Name"] as string;
                if (HttpContext.Current.Session["Phone"] != null)
                    this.txtPhone.Value = HttpContext.Current.Session["Phone"] as string;
                if (HttpContext.Current.Session["Email"] != null)
                    this.txtEmail.Value = HttpContext.Current.Session["Email"] as string;
                if (HttpContext.Current.Session["Age"] != null)
                    this.txtAge.Value = HttpContext.Current.Session["Age"] as string;
            }
        }

        protected void btnFix_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["PID"];
            Response.Redirect("InnerPage02.aspx?PID=" + id);
        }

        protected void btnConf_Click(object sender, EventArgs e)
        {

        }
    }
}