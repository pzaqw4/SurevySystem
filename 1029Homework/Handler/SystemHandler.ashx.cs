using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DBFuctions;
using DBORM;
using Models;
using SystemAuth;

namespace _1029Homework.Handler
{
    public class SystemHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string actionName = context.Request.QueryString["ActionName"];

            if (string.IsNullOrEmpty(actionName))
            {
                context.Response.StatusCode = 400;
                context.Response.ContentType = "text/plain";
                context.Response.Write("ActionName is required");
                context.Response.End();
            }

            if (actionName == "Login")
            {
                string[] statusMsg = new string[2];

                try
                {
                    string acc = Convert.ToString(context.Request.Form["Account"]);
                    string pwd = Convert.ToString(context.Request.Form["Password"]);

                    UserInfo userInfo = Auth.GetAccountInfo(acc);

                    // check account exist
                    if (userInfo == null)
                    {
                        statusMsg[0] = "帳號或密碼錯誤";
                        SendDataByJSON(context, statusMsg);
                        return;
                    }

                    // Check Password
                    if (Auth.AccountPasswordAuthentication(pwd, userInfo.Password))
                    {
                        Auth.LoginAuthentication(userInfo);
                        statusMsg[0] = "Success";
                        statusMsg[1] = userInfo.Name;
                    }
                    else
                    {
                        statusMsg[0] = "帳號或密碼錯誤";
                    }

                    SendDataByJSON(context, statusMsg);
                }
                catch (Exception ex)
                {
                    Logger.WriteLog(ex);
                    SendDataByJSON(context, statusMsg);
                    return;
                }

            }
            //else if (actionName == "Logout")
            //{
            //    Auth.SignOut();
            //}


            else if (actionName == "GetAllPost")
            {
                List<SurveyInfoModel> allPostInfo = PostManager.GetAllPostInfo();
                SendDataByJSON(context, allPostInfo);
            }

            else if (actionName == "GetPostInfo")
            {
                try
                {
                    // 從ajax取得PID
                    var ajaxPID = context.Request.Form["PID"];

                    // 取得貼文資料
                    SurveyInfoModel postInfo = PostManager.GetOnePostInfo(ConverStringToGuid(ajaxPID));

                    // 寫入Response
                    SendDataByJSON(context, postInfo);
                }
                catch (Exception ex)
                {
                    Logger.WriteLog(ex);
                }
            }
            else if (actionName == "GetAllQus")
            {
                try
                {
                    // 從ajax取得PID
                    var ajaxPID = context.Request.Form["PID"];

                    // 取得貼文的全部留言
                    List<QuestionInfoModel> allQus = PostManager.GetAllQuestion(ConverStringToGuid(ajaxPID));

                    // 寫入Response
                    SendDataByJSON(context, allQus);
                }
                catch (Exception ex)
                {
                    Logger.WriteLog(ex);
                }
            }
            else if (actionName == "DeletePost")
            {
                try
                {
                    string strPID = context.Request.Form["PID"];
                    string result = string.Empty;

                    // check guid
                    result = PostManager.DeletePost(ConverStringToGuid(strPID));

                    // send to ajax
                    SendDataByJSON(context, result);
                }
                catch (Exception ex)
                {
                    Logger.WriteLog(ex);
                    SendDataByJSON(context, "警告!發生錯誤");
                }
            }

        }


        private void SendDataByJSON(HttpContext context, object statusMsg)
        {
            string jsonText = Newtonsoft.Json.JsonConvert.SerializeObject(statusMsg);
            context.Response.ContentType = "application/json";
            context.Response.Write(jsonText);
        }

        private Guid ConverStringToGuid(string sourceGuid)
        {
            if (!Guid.TryParse(sourceGuid, out Guid outputGuid))
            {
                throw new Exception("Guid 轉型錯誤");
            }

            return outputGuid;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}