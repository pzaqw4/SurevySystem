<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="EditPostPage02.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>新增問卷</title>
    <style type="text/css">
        .auto-style2 {
            width: 320px;
            height: 121px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-3">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="navbar-brand active" aria-current="page" href="EditPostPage02.aspx">問卷</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="EditQAPage03.aspx">問題</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="DetailPage04-1.aspx">填寫資料</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="BacksideResultPage05.aspx">統計</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
     <form class="needs-validation" novalidate>
    <div class="row mb-3 align-items-center">
        <label class="col-sm-2 col-form-label">請輸入問卷標題</label>
        <div class="col-sm-10">
            <input type="text">
        </div>
    </div>
    <div class="row mb-3 align-items-center">
        <label class="col-sm-2 col-form-label">請輸入問卷描述內容</label>
        <div class="col-sm-10">
        <textarea class="auto-style2"></textarea>
            </div>
    </div>
    <div class="row mb-3 align-items-center">
        <label class="col-sm-2 col-form-label">請輸入問卷開始時間</label>
        <div class="col-sm-10">
        <input type="date">
            </div>
    </div>
    <div class="row mb-3 align-items-center">
        <label class="col-sm-2 col-form-label">請輸入問卷結束時間</label>
        <div class="col-sm-10">
        <input type="date">
            </div>
    </div>
    <div class="col-auto mb-3">
        <div class="form-check">
            <input class="form-check-input" type="checkbox">
            <label class="form-check-label">已啟用</label>
        </div>
    </div>
    <div>
        <a class="btn btn-sm btn-outline-secondary guestFunc" href="EditQAPage03.aspx">新增</a>
        <%--<button class="btn btn-outline-primary" type="submit">確認</button>--%>
        <button class="btn btn-outline-warning" type="reset">清除</button>
    </div>
         </form>
</asp:Content>
