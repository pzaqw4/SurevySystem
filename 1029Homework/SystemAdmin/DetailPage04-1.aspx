<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="DetailPage04-1.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>作答內容匯出頁</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-3">
        <div class="container-fluid">           
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                     <li class="nav-item">
                        <a class="nav-link"  href="EditPostPage02.aspx">問卷</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"  href="EditQAPage03.aspx">問題</a>
                    </li>
                    <li class="nav-item">
                        <a class="navbar-brand active" aria-current="page" href="DetailPage04-1.aspx">填寫資料</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="BacksideResultPage05.aspx">統計</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <button type="submit" class="btn btn-dark">匯出</button>
    <table class="table table-striped table-hover">
  <thead>
    <tr>
      <th scope="col">編號</th>
      <th scope="col">姓名</th>
      <th scope="col">填寫時間</th>
      <th scope="col"><a href="DetailPage04-2.aspx">觀看細節</a></th>
    </tr>
  </thead>
  <tbody>
    <tr>

    </tr>
    <tr>

    </tr>
    <tr>

    </tr>
  </tbody>
</table>
</asp:Content>
