using DBFuctions;
using DBORM;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _1029Homework.SystemAdmin
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string currentPostID = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["PostID"] == null)
            //{
            //    Response.Redirect("EditPostPage02.aspx");
            //}
            if (!IsPostBack)
            {
                currentPostID = Request.QueryString["PostID"];
                if (currentPostID == null)
                    Response.Redirect("EditPostPage02.aspx");



                var qus = DBFuctions.PostManager.GetQusMixInfo();

                for (int i = 0; i < qus.Count; i++)
                {
                    string title = qus[i].Caption.ToString();
                    string quid = qus[i].QuID.ToString();
                    this.ddlMix.Items.Add(new ListItem(title, quid));
                }
                AddDefaultFirstRecord();

                DataTable dt = new DataTable();
                DataRow dr;
                dt.TableName = "Answer2";
                dt.Columns.Add(new DataColumn("Qus", typeof(string)));
                dt.Columns.Add(new DataColumn("ans", typeof(string)));
                dt.Columns.Add(new DataColumn("type", typeof(string)));
                dt.Columns.Add(new DataColumn("must", typeof(string)));
                dt.Columns.Add(new DataColumn("no", typeof(int)));
                dr = dt.NewRow();
                dt.Rows.Add(dr);
                //將表單存到ViewState
                ViewState["Answer2"] = dt;
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            AddNewRecordRowToGrid();
        }
        private void AddDefaultFirstRecord()
        {
            //創建表單  
            DataTable dt = new DataTable();
            DataRow dr;
            dt.TableName = "Answer";
            dt.Columns.Add(new DataColumn("Qus", typeof(string)));
            dt.Columns.Add(new DataColumn("ans", typeof(string)));
            dt.Columns.Add(new DataColumn("type", typeof(string)));
            dt.Columns.Add(new DataColumn("must", typeof(string)));
            dt.Columns.Add(new DataColumn("no", typeof(int)));
            dr = dt.NewRow();
            dt.Rows.Add(dr);
            //將表單存到ViewState
            ViewState["Answer"] = dt;
            //綁定ViewState 
            gvSurvey.DataSource = dt;
            gvSurvey.DataBind();
        }
        private void AddNewRecordRowToGrid()
        {
            // 檢查ViewState
            if (ViewState["Answer"] != null)
            {
                //從ViewState取表單   
                DataTable dtCurrentTable = (DataTable)ViewState["Answer"];
                DataRow drCurrentRow = null;

                if (dtCurrentTable.Rows.Count > 0)
                {
                    string must;
                    if (cbMust.Checked)
                    {
                        must = "是";
                    }
                    else
                    {
                        must = "否";
                    }

                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        //將每一行加到表單中  
                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["Qus"] = txtQe.Value;
                        drCurrentRow["ans"] = taAns.Value;
                        if (selType.Value == "0")
                        {
                            drCurrentRow["type"] = "單選方塊";
                        }
                        else if (selType.Value == "1")
                        {
                            drCurrentRow["type"] = "複選方塊";
                        }
                        else if (selType.Value == "2")
                        {
                            drCurrentRow["type"] = "文字方塊";
                        }
                        drCurrentRow["must"] = must;
                        drCurrentRow["no"] = 0;
                    }
                    //刪初始空行  
                    if (dtCurrentTable.Rows[0][0].ToString() == "")
                    {
                        dtCurrentTable.Rows[0].Delete();
                        dtCurrentTable.AcceptChanges();
                    }

                    //將新增的行加到表單中   
                    dtCurrentTable.Rows.Add(drCurrentRow);
                    //新增每一行,將表單存到ViewState
                    ViewState["Answer"] = dtCurrentTable;
                    //綁上Gridview的新Row
                    gvSurvey.DataSource = dtCurrentTable;
                    gvSurvey.DataBind();
                }
            }
        }
        protected void gvSurvey_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)                    //GridView自動編號
            {
                int id = e.Row.RowIndex + 1;
                e.Row.Cells[1].Text = id.ToString();
            }
        }

        protected void gvSurvey_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "LkB")
            {
                //拿到linkButton所在的GridViewRow
                GridViewRow gvrow = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                int index = gvrow.RowIndex;

                string qt = gvSurvey.Rows[index].Cells[2].Text.Trim();
                string ans = gvSurvey.Rows[index].Cells[3].Text.Trim();
                string type = gvSurvey.Rows[index].Cells[4].Text.Trim();
                string must = gvSurvey.Rows[index].Cells[5].Text.Trim();

                txtQe.Value = qt;
                taAns.Value = ans;

                if (type == "單選方塊")
                {
                    selType.Value = "0";
                }
                else if (type == "複選方塊")
                {
                    selType.Value = "1";
                }
                else
                {
                    selType.Value = "2";
                }

                if (must == "是")
                {
                    cbMust.Checked = true;
                }
                else
                {
                    cbMust.Checked = false;
                }

                if (index == 0)                                                     //如果從索引1開始刪除第一個勾選資料
                {
                    DataTable dtCurrentTable = (DataTable)ViewState["Answer"];
                    dtCurrentTable.Rows[index].Delete();
                    dtCurrentTable.AcceptChanges();
                    ViewState["Answer2"] = dtCurrentTable;                          //提前先將刪除後資料放入新的ViewState存放
                                                                                    //綁上Gridview的新Row
                    gvSurvey.DataSource = dtCurrentTable;
                    gvSurvey.DataBind();
                    AddDefaultFirstRecord();                                        //重新綁定初始資料格
                    DataTable dtCurrentTable2 = (DataTable)ViewState["Answer2"];
                    ViewState["Answer"] = dtCurrentTable2;                          //將刪除後資料放入原ViewState["Answer"]
                    gvSurvey.DataSource = dtCurrentTable2;
                    gvSurvey.DataBind();
                    if (dtCurrentTable2.Rows.Count < 1)
                    {
                        AddDefaultFirstRecord();                                    //重新綁定初始資料格
                    }
                }
                else
                {
                    DataTable dtCurrentTable = (DataTable)ViewState["Answer"];
                    dtCurrentTable.Rows[index].Delete();
                    dtCurrentTable.AcceptChanges();
                    ViewState["Answer"] = dtCurrentTable;
                    //綁上Gridview的新Row
                    gvSurvey.DataSource = dtCurrentTable;
                    gvSurvey.DataBind();
                }
            }
        }



        protected void gvSurvey_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //從第一列檢索 LinkBut​​ton 控件

                LinkButton LinkButton1 = (LinkButton)e.Row.FindControl("LkB1");

                //使用行的索引設置 LinkBut​​ton 的 CommandArgument屬性

                LinkButton1.CommandArgument = e.Row.RowIndex.ToString();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            var pid = Guid.Parse(Session["PostID"].ToString());
            DBFuctions.PostManager.DeletePost(pid);
            Response.Redirect("BacksideListPage01.aspx");
        }

        protected void ibtnDelete_Click(object sender, ImageClickEventArgs e)
        {
            int count = 0;
            int sum = 1;
            int s = 0;
            foreach (GridViewRow row in gvSurvey.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox cbox = row.Cells[0].FindControl("cbselect") as CheckBox;

                    if (cbox.Checked)
                    {
                        DataTable dtCurrentTable = (DataTable)ViewState["Answer"];
                        int idx = row.RowIndex;

                        if (idx == 0)                                  //如果從索引1開始刪除第一個勾選資料
                        {

                            dtCurrentTable.Rows[idx].Delete();
                            dtCurrentTable.AcceptChanges();
                            ViewState["Answer2"] = dtCurrentTable;     //因為後面綁定初始值ViewState["Answer"]恢復初始值,先將刪除後資料放入新的ViewState存放

                            //綁上Gridview的新Row
                            gvSurvey.DataSource = dtCurrentTable;
                            gvSurvey.DataBind();
                            s += 1;
                            AddDefaultFirstRecord();                   //重新綁定初始資料格

                            DataTable dtCurrentTable2 = (DataTable)ViewState["Answer2"];
                            ViewState["Answer"] = dtCurrentTable2;    //將刪除後資料放入原ViewState["Answer"]
                            gvSurvey.DataSource = dtCurrentTable2;
                            gvSurvey.DataBind();

                            if (dtCurrentTable2.Rows.Count < 1)
                            {
                                AddDefaultFirstRecord();                   //重新綁定初始資料格
                            }
                        }
                        else if (s > 0)                               //刪除多筆,調整索引值
                        {
                            dtCurrentTable.Rows[idx - sum].Delete();
                            dtCurrentTable.AcceptChanges();

                            ViewState["Answer2"] = dtCurrentTable;
                            //綁上Gridview的新Row
                            gvSurvey.DataSource = dtCurrentTable;
                            gvSurvey.DataBind();

                            AddDefaultFirstRecord();

                            DataTable dtCurrentTable2 = (DataTable)ViewState["Answer2"];
                            ViewState["Answer"] = dtCurrentTable2;
                            gvSurvey.DataSource = dtCurrentTable2;
                            gvSurvey.DataBind();
                            sum += 1;
                        }

                        if (idx > 0 && s == 0)                         //如果從索引1以外的開始刪除第一個勾選資料
                        {
                            if (count == 0)                            //計算是否刪除多個
                            {
                                dtCurrentTable.Rows[idx].Delete();
                                dtCurrentTable.AcceptChanges();
                                ViewState["Answer"] = dtCurrentTable;
                                //綁上Gridview的新Row
                                gvSurvey.DataSource = dtCurrentTable;
                                gvSurvey.DataBind();
                                count += 1;
                            }
                            else                                       //刪除多筆,調整索引值
                            {
                                dtCurrentTable.Rows[idx - sum].Delete();
                                dtCurrentTable.AcceptChanges();
                                ViewState["Answer"] = dtCurrentTable;
                                //綁上Gridview的新Row
                                gvSurvey.DataSource = dtCurrentTable;
                                gvSurvey.DataBind();
                                sum += 1;
                            }
                        }
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            foreach (GridViewRow row in gvSurvey.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    int qid = int.Parse(DateTime.Now.ToString("sssffff"));
                    Guid pid = Guid.Parse(Session["PostID"].ToString());
                    var cap = row.Cells[2].Text;
                    var ans = row.Cells[3].Text;
                    string type = row.Cells[4].Text;
                    int result;                               //轉型
                    string must = row.Cells[5].Text;
                    bool bo;                                  //轉型

                    if (type == "單選方塊")
                    {
                        result = 0;
                    }
                    else if (type == "複選方塊")
                    {
                        result = 1;
                    }
                    else
                    {
                        result = 2;
                    }

                    if (must == "是")
                        bo = true;
                    else
                        bo = false;



                    Question question = new Question
                    {
                        QuID = qid,
                        PostID = pid,
                        Caption = cap,
                        Ans = ans,
                        Type = result,
                        Nullable = bo
                    };
                    PostManager.CreateQuestion(question);
                }
            }

            Response.Redirect("DetailPage04-1.aspx");
        }

        protected void ddlMix_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMix.SelectedIndex != 0)
            {
                int quid =Convert.ToInt32(ddlMix.SelectedValue);
                var qus = DBFuctions.PostManager.GetOneMixInfo(quid);
                this.txtQe.Value = qus.Caption;
                this.taAns.Value = qus.Ans;

                if (qus.Type == 0)
                {
                    selType.Value =(0).ToString();
                }
                else if (qus.Type == 1)
                {
                    selType.Value = (1).ToString();
                }
                else
                {
                    selType.Value = (2).ToString();
                }

                if (qus.Nullable == true)
                {
                    cbMust.Checked = true;
                }
                else
                {
                    cbMust.Checked = false;
                }
            }
        }
    }
}