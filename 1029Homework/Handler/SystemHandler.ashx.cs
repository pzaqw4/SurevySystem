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

            else if (actionName == "GetAllPost")
            {
                List<SurveyInfoModel> allPostInfo = PostManager.GetAllPostInfo();
                SendDataByJSON(context, allPostInfo);
            }

        }


        private void SendDataByJSON(HttpContext context, object statusMsg)
        {
            string jsonText = Newtonsoft.Json.JsonConvert.SerializeObject(statusMsg);
            context.Response.ContentType = "application/json";
            context.Response.Write(jsonText);
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