<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="BacksideListPage01.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>後台列表頁</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form>
        <div class="mb-3 ">
            <input type="search" placeholder="請輸入查詢問卷標題">
        </div>
        <div class="mb-3">
            <label class="form-label">開始時間</label>
            <input type="search">
            <label class="form-label">結束時間</label>
            <input type="search">
            <button type="submit" class="btn btn-primary">搜尋</button>
        </div>
        <hr />
    </form>
    <div>        
        <button type="button" class="btn btn-default btn-sm">
            <img src="../Images/trash.png" />
        </button>
        <button type="button" class="btn btn-default btn-sm">
            <img src="../Images/addplus.png" />
        </button>
    </div>
    <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th class="th-sm" width="10%">編號</th>
                <th class="th-sm" width="35%"><a href="../InnerPage02.aspx">問卷標題</a></th>
                <th class="th-sm" width="10%">狀態</th>
                <th class="th-sm" width="15%">開始時間</th>
                <th class="th-sm" width="15%">結束時間</th>
                <th class="th-sm" width="15%"><a href="BacksideResultPage05.aspx">統計結果</a></th>
            </tr>
        </thead>
    </table>
</asp:Content>
