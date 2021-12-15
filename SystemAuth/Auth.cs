using DBFuctions;
using DBORM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Security;

namespace SystemAuth
{
    public class Auth
    {
        public static UserInfo GetAccountInfo(string account)
        {
            try
            {
                using (DBModel context = new DBModel())
                {
                    var query =
                        (from item in context.UserInfoes
                         where item.Account == account
                         select item);

                    var list = query.ToList();

                    if (list.Count == 1)
                        return list[0];
                    else
                        return null;
                }
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static bool AccountPasswordAuthentication(string inputPwd, string dbPwd)
        {
            try
            {

                if (string.Compare(inputPwd, dbPwd, false) == 0)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                Logger.WriteLog(ex);
                return false;
            }
        }
        /// <summary> 建立驗證Cookie </summary>
        /// <param name="userInfo"></param>
        public static void LoginAuthentication(UserInfo userInfo)
        {
            string userID = userInfo.UserID.ToString();
            bool isPersistance = false;

            FormsAuthentication.SetAuthCookie(userInfo.Account, isPersistance);

            FormsAuthenticationTicket ticket =
                new FormsAuthenticationTicket(
                    1,
                    userInfo.Account,
                    DateTime.Now,
                    DateTime.Now.AddHours(1),
                    isPersistance,
                    userID
                );

            FormsIdentity identity = new FormsIdentity(ticket);
            HttpCookie cookie =
                new HttpCookie(
                    FormsAuthentication.FormsCookieName,
                    FormsAuthentication.Encrypt(ticket)
                );

            // Set false for page read .ASPXAUTH cookie
            cookie.HttpOnly = false;

            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        //public static void SignOut()
        //{
        //    //移除瀏覽器的表單驗證
        //    FormsAuthentication.SignOut();
        //}
    }
}
