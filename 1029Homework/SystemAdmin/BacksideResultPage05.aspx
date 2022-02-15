<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="BacksideResultPage05.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>統計資料</title>
    <script>
        function back() {
            history.back(-1);
        }

        const pageUrl = new URL(window.location.href);
        var pid = pageUrl.searchParams.get("PID");

        if (pid == null)
            alert('請選擇一篇問卷!!')
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
                        <a class="nav-link" href="DetailPage04-1.aspx">填寫資料</a>
                    </li>
                    <li class="nav-item">
                        <a class="navbar-brand active" aria-current="page" href="BacksideResultPage05.aspx">統計</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <asp:Label ID="lbTitle" runat="server" Text="標題名稱" Font-Size="X-Large"></asp:Label>
    <hr class="invisible" />
    <div class="container">
        <asp:PlaceHolder ID="chartPlace" runat="server"></asp:PlaceHolder>
        <br />
        <asp:Literal ID="ltCaption" runat="server"></asp:Literal><br />

    </div>
    <button type="button" onclick="back()" class="btn btn-outline-dark" >返回</button>
</asp:Content>
