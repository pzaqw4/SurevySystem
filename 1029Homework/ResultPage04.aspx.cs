using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace _1029Homework
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //檢查PID
                string selectedPostID = Request.QueryString["PID"];
                if (selectedPostID == null)
                    Response.Redirect("ListPage01.aspx");

                Guid guid = Guid.Parse(selectedPostID);   //取得標題
                var survey = DBFuctions.PostManager.GetOnePostInfo(guid);
                this.lbTitle.Text = "問卷標題 :" +"     "  +survey.Title;

                var allQus = DBFuctions.PostManager.GetAllQuestion(guid);//取guid問卷所有問題資料
                var allAns = DBFuctions.PostManager.GetAnswerInfoByPID(guid);//依guid取那篇問卷所有回答資料

                string[] xValues = new string[100];
                int[] yValues = new int[100];

                List<JsonAns> jsonList = new List<JsonAns>();
                List<string> msgList = new List<string>();

                for (int i = 0; i < allAns.Count; i++)  //總共問卷回答數量
                {
                    var ansList = JsonConvert.DeserializeObject(allAns[i].Answer1).ToString();
                    JsonAns[] answers = JsonConvert.DeserializeObject<JsonAns[]>(ansList);
                    for (int j = 0; j < answers.Length; j++)
                    {
                        jsonList.Add(answers[j]);
                    }

                }


                for (int i = 0; i < allQus.Count; i++)  //總共問題數量
                {
                    if (allQus[i].Type == 2)   //問答題不做圖表
                    {
                        string txtTitle = "第" + (i + 1) + "題 :  " + allQus[i].Caption + "\n" + "此題沒有選項";
                        string[] xValues1 = { "0" };  //選項名稱
                        int[] yValues1 = { 0 };  //選項所佔的比例
                        Chart chart = CreateChart(txtTitle, xValues1, yValues1);
                        this.chartPlace.Controls.Add(chart);
                    }
                    else
                    {
                        string txtTitle = "第" + (i + 1) + "題 :  " + allQus[i].Caption;

                        for (int j = 0; j < jsonList.Count(); j++)  //一篇回答問卷中得到的答案數量
                        {
                            if (Convert.ToInt32(jsonList[j].key) == allQus[i].QuID)
                            {

                                string[] vs = jsonList[j].value.Split(',');   //切割多選答案

                                for (int a = 0; a < vs.Count(); a++)  //所有答案加入List
                                {
                                    if (vs[a] != "")
                                    {
                                        msgList.Add(vs[a].Trim());
                                    }
                                }

                                var q =
                                              from p in msgList
                                              group p by p.ToString() into g
                                              select new
                                              {
                                                  g.Key,
                                                  count = g.Count()
                                              };

                                var sum = q.ToList();
                                for (int y = 0; y < sum.Count(); y++)
                                {
                                    xValues[y] = sum[y].Key.ToString();     //選項名稱
                                    yValues[y] = sum[y].count;              //個數
                                }
                            }

                        }
                        Chart chart = CreateChart(txtTitle, xValues, yValues);
                        this.chartPlace.Controls.Add(chart);
                        msgList.Clear();                        //避免殘留上一題資料
                    }


                }
            }

        }
        public class JsonAns
        {
            public string key;
            public string value;
        }
        /// <summary>
        /// 建立圓餅圖的方法
        /// </summary>
        /// <param name="txtTitle">表頭</param>
        /// <param name="xValues">項目</param>
        /// <param name="yValues">數值</param>
        private Chart CreateChart(string txtTitle, string[] xValues, int[] yValues)
        {

            //ChartAreas,Series,Legends 基本設定-------------------------------------------------
            Chart Chart1 = new Chart();
            Chart1.ChartAreas.Add("ChartArea1"); //圖表區域集合
            Chart1.Legends.Add("Legends1"); //圖例集合說明
            Chart1.Series.Add("Series1"); //數據序列集合

            //設定 Chart-------------------------------------------------------------------------
            Chart1.Width = 500;
            Chart1.Height = 400;
            Title title = new Title();
            title.Text = txtTitle;
            title.Alignment = ContentAlignment.MiddleCenter;
            title.Font = new System.Drawing.Font("Trebuchet MS", 14F, FontStyle.Bold);
            Chart1.Titles.Add(title);

            //設定 ChartArea1--------------------------------------------------------------------
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
            Chart1.ChartAreas[0].AxisX.Interval = 1;

            //設定 Legends(圖表說明文字)-------------------------------------------------------------------------
            Chart1.Legends["Legends1"].Docking = Docking.Right; //自訂顯示位置
            Chart1.Legends["Legends1"].BackColor = Color.FromArgb(235, 235, 235);//背景色          
            Chart1.Legends["Legends1"].BackHatchStyle = ChartHatchStyle.DarkDownwardDiagonal;  //斜線背景
            Chart1.Legends["Legends1"].BorderWidth = 1;
            Chart1.Legends["Legends1"].BorderColor = Color.FromArgb(200, 200, 200);

            //設定 Series1-----------------------------------------------------------------------

            Chart1.Series["Series1"].ChartType = SeriesChartType.Pie;
            Chart1.Series["Series1"].Points.DataBindXY(xValues, yValues);
            Chart1.Series["Series1"].LegendText = "#VALX: [ #PERCENT{P1} ]"; //X軸 + 百分比
            Chart1.Series["Series1"].Label = "#VALX\n#PERCENT{P1}"; //X軸 + 百分比
                                                                    

            //字體設定

            Chart1.Series["Series1"].Font = new System.Drawing.Font("Trebuchet MS", 10, System.Drawing.FontStyle.Bold);
            Chart1.Series["Series1"].Points.FindMaxByValue().LabelForeColor = Color.Red;
            Chart1.Series["Series1"].BorderColor = Color.FromArgb(255, 101, 101, 101);
            Chart1.Series["Series1"]["PieLabelStyle"] = "Outside"; //數值顯示在圓餅外
            Chart1.Series["Series1"]["PieDrawingStyle"] = "Default";//設定圓餅效果，除 Default 外其他效果3D不適用

            return Chart1;
        }

    }
}