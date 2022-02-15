<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="BacksideListPage01.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>後台列表頁</title>
    <script>
        $(document).ready(function () {
            var table = $('#PostTable').DataTable({
                "dom":
                    `<'row'<'col-sm-12 col-md-7 'f>>
                     <'row'<'col-sm-12 col-md-6'i>>
                     <'row'<'col-sm-12'tr>>
                    <'row'<'col-sm-12 col-md-7 'p>>`,
                "lengthMenu": [10],
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
            table.column(1).visible(false);
            table.column(2).visible(false);
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetAllPost",
                type: "GET",
                data: {},
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        table.row.add([
                            obj.ID,
                            obj.PostID,
                            obj.Title,
                            `<a href="../InnerPage02.aspx?PID=${obj.PostID}" >${obj.Title}<a>`,
                            obj.Available,
                            obj.Starttime,
                            obj.Endtime,
                            `<a href="../ResultPage04.aspx?PID=${obj.PostID}" >前往<a>`,
                        ]).draw(false);
                    }
                }
            });
            $('#PostTable tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
            var deletePost = function () {
                var rowData = table.rows('.selected').data().toArray();
                if (confirm(`即將刪除此'${rowData[0][2]}'問卷,不會後悔??`)) {
                
                    $.ajax({
                        url: "/Handler/SystemHandler.ashx?ActionName=DeletePost",
                        type: "POST",
                        data: {
                            "PID": rowData[0][1]
                        },
                        success: function (result) {
                            if ("Success" == result) {
                                alert('刪除成功!!');
                                table.row('.selected').remove().draw(false);
                            }
                            else {
                                alert('刪除失敗!!');
                            }
                        }
                    });
                }
                else {
                    alert('刪除失敗!!');
                }
            };
            $('#DeleteBtn').click(function () {
                deletePost();
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--   <form>
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
    </form>--%>
    <p class="fs-4">
        新增貼文&nbsp;
        <a type="button" class="btn btn-sm" href="EditPostPage02.aspx"><img src="../Images/addplus.png" /></a>
    </p>
     <p class="fs-4">
       刪除貼文&nbsp;
               <button type="button" class="btn btn-sm" id="DeleteBtn"><img src="../Images/trash.png"/></button>
                <small style="font-size:small">["請先點選想要刪除的問卷"]</small>
    </p>

    <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th class="th-sm" width="7%">編號</th>
                <th>PostID</th>
                <th>Title</th>
                <th class="th-sm" width="25%">問卷標題</th>
                <th class="th-sm" width="7%">狀態</th>
                <th class="th-sm" width="15%">開始時間</th>
                <th class="th-sm" width="15%">結束時間</th>
                <th class="th-sm" width="15%">統計結果</th>
            </tr>
        </thead>
    </table>
</asp:Content>
