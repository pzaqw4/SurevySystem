<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="EditQAPage03.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問題與回答編輯</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-3">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="EditPostPage02.aspx">問卷</a>
                    </li>
                    <li class="nav-item">
                        <a class="navbar-brand active" aria-current="page" href="EditQAPage03.aspx">問題</a>
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
    <form>
        <div class="row mb-3 col-md-4">
            <label class="col-sm-2 col-form-label">總類</label>
            <div class="col-sm-6">
                <select class="form-select">
                    <option selected>自訂問題</option>
                    <option>常見問題1</option>
                </select>
            </div>
        </div>
    </form>
    <form class="row align-items-center">
        <div class="col-auto mb-3">
            <label>問題</label>
        </div>
        <div class="col-auto mb-3">
            <input type="text" />
        </div>
        <div class="col-auto mb-3">
            <select class="form-select">
                <option value="0" selected>單選方塊</option>
                <option value="1">複選方塊</option>
                <option value="2">文字方塊</option>
            </select>
        </div>
        <div class="col-auto">
            <div class="form-check">
                <input class="form-check-input" type="checkbox">
                <label class="form-check-label">必填</label>
            </div>
        </div>
    </form>
    <form class="row align-items-center">
        <div class="col-auto mb-3">
            <label>回答</label>
        </div>
        <div class="col-auto mb-3">
            <input type="text" />
        </div>
        <div class="col-auto">
            <button type="button" class="btn btn-primary">加入</button>
        </div>
    </form>
    <div>
        <button type="button" class="btn btn-default btn-sm">
            <img src="../Images/trash.png" />
        </button>
    </div>
    <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0">
        <thead>
            <tr>
                <th class="th-sm" width="5%"></th>
                <th class="th-sm" width="5%">編號</th>
                <th class="th-sm" width="25%">問題</th>
                <th class="th-sm" width="15%">總類</th>
                <th class="th-sm" width="5%">必填</th>
                <th class="th-sm" width="15%"><a href="BacksideResultPage05.aspx">統計結果</a></th>
            </tr>
        </thead>
    </table>
</asp:Content>
