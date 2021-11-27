<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ListPage01.aspx.cs" Inherits="_1029Homework.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問卷系統首頁</title>
    <style>
        div {
           //border: 1px solid #000000;
        }
    </style>
       <script>
           $(document).ready(function () {
               var table = $('#PostTable').DataTable({
               });
               function AddRow(obj) {
                   table.row.add([
                       `<a href="InnerPage02.aspx" class="text-decoration-none">${obj.Title}<a>`,
                   ]).draw(false);
               };

               //Get all post's information
               $.ajax({
                   url: "/Handler/SystemHandler.ashx?ActionName=GetAllPost",
                   type: "GET",
                   data: {},
                   success: function (result) {
                       for (var i = 0; i < result.length; i++) {
                           var obj = result[i];
                           AddRow(obj);
                       }
                   }
               });
           });
       </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form>
        <div>
            <p class="fs-2 fw-bold">首頁</p>
            <div>
                <a>歡迎使用問卷查詢功能</a>
            </div>
             <div class="mb-3">
                <a>進入後台請登入管理員帳號</a>
            </div>
        </div>
        <hr />
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
     <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th class="th-sm" width="10%">編號</th>
                <th class="th-sm" width="35%">問卷標題</th>
                <th class="th-sm" width="10%">狀態</th>
                <th class="th-sm" width="15%">開始時間</th>
                <th class="th-sm" width="15%">結束時間</th>
                <th class="th-sm" width="15%">統計結果</th>
            </tr>
        </thead>
    </table>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</asp:Content>
