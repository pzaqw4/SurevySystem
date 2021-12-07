<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ListPage01.aspx.cs" Inherits="_1029Homework.WebForm1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問卷系統首頁</title>
    <script type="text/javascript">
        $(document).ready(function () {
            var table = $('#PostTable').DataTable({
                "dom":
                    `<'row'<'col-sm-12 col-md-7 'f>>
                     <'row'<'col-sm-12 col-md-6'i>>
                     <'row'<'col-sm-12'tr>>
                    <'row'<'col-sm-12 col-md-7 'p>>`,
                "lengthMenu": [10],
                "ordering": false,
                "language": {
                    "emptyTable": "找不到貼文",
                    "zeroRecords": "找不到貼文",
                    "sLoadingRecords": "載入資料中...",
                    "sSearch": "搜尋:",
                    "infoEmpty": "顯示第 0 到 0 篇，共 0 篇貼文",
                    "info": "顯示第 _START_  到 _END_ 篇，共 _TOTAL_ 篇貼文",
                    "paginate": {
                        "first": "第一頁",
                        "last": "最後頁",
                        "next": "下一頁",
                        "previous": "上一頁"
                    },
                    "lengthMenu": "頁面顯示 _MENU_ 篇貼文",
                }
            });
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetAllPost",
                type: "GET",
                data: {},
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        table.row.add([
                            obj.ID,
                            `<a href="InnerPage02.aspx?PID=${obj.PostID}" >${obj.Title}<a>`,
                            obj.Available,
                            obj.Starttime,
                            obj.Endtime,
                            `<a href="ResultPage04.aspx?PID=${obj.PostID}" >前往<a>`
                        ]).draw(false);

                    }
                }
            });

        });
    </script>
    <style>
        div {
            //border: 1px solid #000000;
        }
    </style>
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
        <%-- <div class="mb-3 ">
            <input type="search" placeholder="請輸入查詢問卷標題">
        </div>--%>
        <%--        <div class="mb-3">
            <label class="form-label">開始時間</label>
            <input type="search">
            <label class="form-label">結束時間</label>
            <input type="search">
            <button type="submit" class="btn btn-primary">搜尋</button>
        </div>--%>
    </form>
    <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th class="th-sm bg-dark p-2 text-white" width="10%">編號</th>
                <th class="th-sm bg-dark p-2 text-white bg-opacity-75" width="35%">問卷標題</th>
                <th class="th-sm bg-dark p-2 text-dark bg-opacity-50" width="10%">狀態</th>
                <th class="th-sm bg-dark p-2 text-dark bg-opacity-25" width="15%">開始時間</th>
                <th class="th-sm bg-dark p-2 text-dark bg-opacity-10" width="15%">結束時間</th>
                <th class="th-sm  p-2 text-dark" width="15%">統計結果</th>
            </tr>
        </thead>
    </table>
</asp:Content>
