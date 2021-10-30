<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="BacksideResultPage05.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>統計資料</title>
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
                        <a class="nav-link"  href="DetailPage04-1.aspx">填寫資料</a>
                    </li>
                    <li class="nav-item">
                        <a class="navbar-brand active" aria-current="page" href="BacksideResultPage05.aspx">統計</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div>
        <label>問卷內容</label>
    </div>
</asp:Content>
