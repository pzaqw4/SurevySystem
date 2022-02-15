<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="DetailPage04-1.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>作答內容匯出頁</title>
    <script>
        $(document).ready(function () {
            var table = $('#PostTable').DataTable({
                "dom":
                    `
                     <'row'<'col-sm-12 col-md-6'i>>
                     <'row'<'col-sm-12'tr>>
                    <'row'<'col-sm-12 col-md-7 'p>>`,
                "lengthMenu": [10],
                "order": [2, 'desc'],
                "language": {
                    "emptyTable": "找不到資料",
                    "zeroRecords": "找不到資料",
                    "sLoadingRecords": "載入資料中...",
                    "sSearch": "搜尋:",
                    "infoEmpty": "顯示第 0 到 0 篇，共 0 篇貼文",
                    "info": "顯示第 _START_  到 _END_ 筆，共 _TOTAL_ 筆資料",
                    "paginate": {
                        "first": "第一頁",
                        "last": "最後頁",
                        "next": "下一頁",
                        "previous": "上一頁"
                    },
                    "lengthMenu": "頁面顯示 _MENU_ 筆資料",
                }                 
            });
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetAnswerInfo",
                type: "GET",
                data: {},
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        table.row.add([
                            obj.AnsID,
                            obj.A_UserName,
                            obj.CreateTime,
                            `<a type="button" class="btn btn-sm" href="DetailPage04-2.aspx?AID=${obj.AnsID}"><img src="../Images/list.jpg" /></a>`
                        ]).draw(false);
                    }
                }
            });

        });
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
    <form runat="server"> 
    <asp:button type="submit" class="btn btn-dark" runat="server" Text="匯出CSV檔" ID="btnCSV" OnClick="btnCSV_Click" ToolTip="將問卷回答資料匯出"></asp:button>
    <table class="table table-striped table-bordered table-sm table-hover" id="PostTable">
        <thead>
            <tr>
                <th scope="col">編號</th>
                <th scope="col">姓名</th>
                <th scope="col">填寫時間</th>
                <th scope="col">觀看作答細節</th>
            </tr>
        </thead>
    </table>
    </form>
</asp:Content>
