using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DBFuctions;
using DBORM;
using Models;

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

            if (actionName == "GetAllPost")
            {
                List<SurevyInfoModel> allPostInfo = PostManager.GetAllPostInfo();
                SendDataByJSON(context, allPostInfo);
            }
            else if (actionName == "GetPostInfo")
            {
                try
                {
                    // 從ajax取得PID
                    var ajaxPID = "EFC84782-68A1-4FAD-BCFE-46AC68087488";

                    // 取得貼文資料
                    SurevyInfoModel postInfo = PostManager.GetOnePostInfo(ConverStringToGuid(ajaxPID));

                    // 寫入Response
                    SendDataByJSON(context, postInfo);
                }
                catch (Exception ex)
                {
                    throw ex;
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