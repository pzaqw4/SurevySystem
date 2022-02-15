using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace _1029Homework.SystemAdmin
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //檢查PID
                string selectedPostID = Request.QueryString["PID"];
                if (selectedPostID == null)
                    Response.Redirect("DetailPage04-1.aspx");
                
                    

                Guid guid = Guid.Parse(selectedPostID);   //取得標題
                var survey = DBFuctions.PostManager.GetOnePostInfo(guid);
                this.lbTitle.Text = "問卷標題 :" + "     " + survey.Title;

                var allQus = DBFuctions.PostManager.GetAllQuestion(guid);//取guid問卷所有問題資料
                var allAns = DBFuctions.PostManager.GetAnswerInfoByPID(guid);//依guid取那篇問卷所有回答資料

                //string[] titleArr = new string[100];
                string[] xValues = new string[0];
                int[] yValues = new int[0];

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

                                    Array.Resize(ref xValues, xValues.Length + 1);   //擴張陣列大小
                                    Array.Resize(ref yValues, yValues.Length + 1);
                                    xValues[y] = sum[y].Key.ToString();     //選項名稱
                                    yValues[y] = sum[y].count;              //個數
                                }
                            }

                        }
                        foreach (var item in xValues)  //處理不必要的數值
                        {
                            if (item == null)
                            {
                                Array.Resize(ref xValues, xValues.Length - 1);
                                Array.Resize(ref yValues, yValues.Length - 1);
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
                                                 // Chart1.Legends.Add("Legends1"); //圖例集合說明
            Chart1.Series.Add("Series1"); //數據序列集合
            //Chart1.Series.Add("Series2");

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
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.IsClustered = true;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Rotation = 40;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Inclination = 50;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.PointDepth = 30;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.WallWidth = 0;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.LightStyle = LightStyle.Realistic;
            Chart1.ChartAreas["ChartArea1"].BackColor = Color.FromArgb(240, 240, 240);
            Chart1.ChartAreas["ChartArea1"].AxisX2.Enabled = AxisEnabled.False;
            Chart1.ChartAreas["ChartArea1"].AxisY2.Enabled = AxisEnabled.False;
            Chart1.ChartAreas["ChartArea1"].AxisY2.MajorGrid.Enabled = false;

            //Y軸線顏色
            Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = Color.FromArgb(150, 150, 150);

            //X軸
            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = Color.FromArgb(150, 150, 150);
            Chart1.ChartAreas["ChartArea1"].AxisX.Title = "選項名稱";
            Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;
            Chart1.ChartAreas["ChartArea1"].AxisY.LabelStyle.Format = "#,###";
            Chart1.ChartAreas["ChartArea1"].AxisY.Title = "人數";
            Chart1.ChartAreas["ChartArea1"].AxisY.Interval = 2;

            //Chart1.ChartAreas["ChartArea1"].AxisY2.Maximum = 200;
            //Chart1.ChartAreas["ChartArea1"].AxisY2.Interval = 5;

            //設定 Legends(圖表說明文字)-------------------------------------------------------------------------
            //Chart1.Legends["Legends1"].Docking = Docking.Right; //自訂顯示位置
            //Chart1.Legends["Legends1"].BackColor = Color.FromArgb(235, 235, 235);//背景色          
            //Chart1.Legends["Legends1"].BackHatchStyle = ChartHatchStyle.DarkDownwardDiagonal;  //斜線背景
            //Chart1.Legends["Legends1"].BorderWidth = 1;
            //Chart1.Legends["Legends1"].BorderColor = Color.FromArgb(200, 200, 200);

            //設定 Series1-----------------------------------------------------------------------



            Chart1.Series["Series1"].ChartType = SeriesChartType.Column;
            Chart1.Series["Series1"].Points.DataBindXY(xValues, yValues);
            //Chart1.Series["Series1"].Legend = "Legends1";          
            //Chart1.Series["Series1"].Label = "#VALX\n#PERCENT{P1}";
            Chart1.Series["Series1"].Label = "#VALX\n#VALY\n#PERCENT{P1}";
            Chart1.Series["Series1"].LabelFormat = "#,###";
            Chart1.Series["Series1"].MarkerSize = 8;



            //字體設定

            Chart1.Series["Series1"].Font = new System.Drawing.Font("Trebuchet MS", 10, System.Drawing.FontStyle.Bold);

            Chart1.Series["Series1"].LabelBackColor = Color.FromArgb(150, 255, 255, 255);
            Chart1.Series["Series1"].Color = Color.Aqua;
            Chart1.Series["Series1"].IsValueShownAsLabel = true;


            //Chart1.Series["Series2"].Points.DataBindXY(xValues, yValues2);
            //Chart1.Series["Series2"].Legend = "Legends1";
            //Chart1.Series["Series2"].LegendText = titleArr[1];
            //Chart1.Series["Series2"].LabelFormat = "#,###";
            //Chart1.Series["Series2"].MarkerSize = 8;
            //Chart1.Series["Series2"].LabelForeColor = Color.FromArgb(255, 103, 0);
            //Chart1.Series["Series2"].Font = new System.Drawing.Font("Trebuchet MS", 10, System.Drawing.FontStyle.Bold);
            //Chart1.Series["Series2"].LabelBackColor = Color.FromArgb(150, 255, 255, 255);
            //Chart1.Series["Series2"].Color = Color.Blue;
            //Chart1.Series["Series2"].IsValueShownAsLabel = true;
            return Chart1;
        }
    }
}