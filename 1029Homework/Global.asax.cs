using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace _1029Homework
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
        }
        protected void Application_EndRequest(object sender, EventArgs e)
        {
            string cookieName = System.Web.Security.FormsAuthentication.FormsCookieName;
            if (Response.Cookies.Count > 0)
            {
                foreach (string s in Response.Cookies.AllKeys)
                {
                    if (s == cookieName)
                    {
                        Response.Cookies[cookieName].HttpOnly = false;
                    }
                }
            }
        }
    }
}