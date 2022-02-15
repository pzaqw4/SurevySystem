<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="EditPostPage02.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>新增問卷</title>
    <style type="text/css">
        .auto-style2 {
            width: 320px;
            height: 121px;
        }
    </style>
    <script>
        //設定日期最小值為今天
        $(document).ready((function () {
            $('[type="date"].min-today').prop('min', function () {
                return new Date().toJSON().split('T')[0];
            });

        }));
    </script>
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
    <form class="needs-validation" novalidate runat="server">
        <div class="row mb-3 align-items-center">
            <label class="col-sm-2 col-form-label" id="lblTitle" runat="server">請輸入問卷標題</label>
            <div class="col-sm-10">
                <input id="textTitle" runat="server" />
            </div>
        </div>
        <div class="row mb-3 align-items-center">
            <label class="col-sm-2 col-form-label" id="lblBody" runat="server">請輸入問卷描述內容</label>
            <div class="col-sm-10">
                <textarea class="auto-style2" id="textBody" runat="server"></textarea>
            </div>
        </div>
        <div class="row mb-3 align-items-center">
            <label class="col-sm-2 col-form-label" runat="server" id="lblStart">請輸入問卷開始時間</label>
            <div class="col-sm-10">
                <input type="date" class="min-today" id="startDate" runat="server">
            </div>
        </div>
        <div class="row mb-3 align-items-center">
            <label class="col-sm-2 col-form-label" runat="server" id="lblEnd">請輸入問卷結束時間</label>
            <div class="col-sm-10">
                <input type="date" class="min-today" id="endDate" runat="server">
            </div>
        </div>
        <div class="col-auto mb-3">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" runat="server" id="cbAvailable" checked>
                <label class="form-check-label">已啟用</label>
            </div>
        </div>
        <div>
            <asp:Button class="btn btn-outline-primary" ID="BtnConfirm" OnClick="BtnConfirm_Click" runat="server" Text="確認" />
            <asp:Button class="btn btn-outline-warning" Text="清除" runat="server" ID="btnclear" OnClick="btnclear_Click" />
        </div>
    </form>
</asp:Content>
