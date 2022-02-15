<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="DetailPage04-2.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>作答內容資料頁</title>
    <style>
        div {
            /*border: 1px solid #000000;*/
        }
    </style>
    <script>
        const pageUrl = new URL(window.location.href);
        var aid = pageUrl.searchParams.get("AID");

        $(document).ready(function () {
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetanAnsInfo",
                type: "POST",
                data: { "AID": aid },
                success: function (result) {
                    var pid = result.PostID;
                    if (null != pid) {  /* 回答資料*/
                        $("#txtName").val(result.A_UserName);
                        $("#txtPhone").val(result.A_UserPhone);
                        $("#txtEmail").val(result.A_UserEmail);
                        $("#txtAge").val(result.A_UserAge);
                        $("#txtTime").text("作答時間為  :   " + result.CreateTime);
                    }

                    $("#barchartBtn").click(function () {
                        window.location.href = `BacksideResultPage05.aspx?PID=${pid}`;
                    })
                }
            });
        });

        function back() {
            history.back(-1);
        }
    </script>
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
                        <a class="nav-link" href="EditQAPage03.aspx">問題</a>
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

    <fieldset disabled>
        <div class="row">
            <div class="col-3">
                <label>姓名:</label>
                <input class="form-control bg-secondary text-white" id="txtName">
            </div>
            <div class="col-3">
                <label>手機:</label>
                <input class="form-control bg-secondary text-white" id="txtPhone">
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-3 ">
                <label>Email:</label>
                <input class="form-control bg-secondary text-white" id="txtEmail">
            </div>
            <div class="col-3 ">
                <label>年齡:</label>
                <input class="form-control bg-secondary text-white" id="txtAge">
            </div>
        </div>
        <small id="timeText"></small>
        <hr class="invisible" />
        <form runat="server">
            <div>
                <p>標題:</p>
                <asp:TextBox ID="txtTitle" runat="server" TextMode="MultiLine" style="width:40%"></asp:TextBox>
            </div>
            <div>
                <p>問題:</p>
                <asp:TextBox id="txtQus" runat="server" TextMode="MultiLine" style="width:40%"></asp:TextBox>
            </div>
            <div class="mb-3">
                <p>回答:</p>
                <asp:TextBox id="txtAns" runat="server" TextMode="MultiLine" style="width:40%"></asp:TextBox>
            </div>
        </form>
    </fieldset >
        <button type="button" class="btn btn-sm" id="barchartBtn"><img src="../Images/barchart.png"/></button>
        <button type="button" onclick="back()" class="btn btn-outline-dark" >返回</button>
</asp:Content>
