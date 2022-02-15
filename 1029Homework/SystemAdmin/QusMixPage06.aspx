<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="QusMixPage06.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>常用問題管理</title>
    <script>
        $(document).ready(function () {
            var table = $('#PostTable').DataTable({
                "dom":
                    `<'row'<'col-sm-12'tr>>
                    <'row'<'col-sm-12 col-md-7 'p>>`,
                "lengthMenu": [10],
                "order": [0, 'asc'],
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
            $("#btnUpdate").hide();
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetQusMixInfo",
                type: "GET",
                data: {},
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        var selection;
                        if (obj.Type == 0) {
                            selection = "單選"
                        }
                        else if (obj.Type == 1) {
                            selection = "多選"
                        }
                        else {
                            selection = "文字"
                        }
                        var must = 'X';
                        if (obj.Nullable == true)
                            must = 'O';
                        table.row.add([
                            obj.QuID,
                            obj.Caption,
                            selection,
                            must,
                            obj.Ans,
                            `<button class="btn btn-sm btnEdit"  id="${obj.QuID}"><img src="../Images/fix.jpg"/></button>`
                        ]).draw(false);
                    }
                    $('.btnEdit').click(function () {
                        $("#btnUpdate").show();
                        $("#btnSave").hide();
                        var quid = $(this).attr("id");
                        $.ajax({
                            url: "/Handler/SystemHandler.ashx?ActionName=GetOneMixInfo",
                            type: "POST",
                            data: {
                                "QUID": quid
                            },
                            success: function (result) {
                                $("#txtQe").val(result.Caption);
                                $("#selType").val(result.Type);
                                $("#taAns").val(result.Ans);
                                if (result.Nullable == true)
                                    $("#cbMust").prop("checked", true);
                                else
                                    $("#cbMust").prop("checked", false);                               
                            }                            
                        });
                        $("#btnUpdate").click(function () {
                            var caption = $("#txtQe").val();
                            var type = $("#selType").val();
                            var must;
                            var ans = $("#taAns").val();
                            if ($("#cbMust").is(":checked"))
                                must = true;
                            else
                                must = false;
                            if (caption == "" || ans == "") {
                                alert('請加入問題以及回答說明!!');
                                return
                            }

                            $.ajax({
                                url: "/Handler/SystemHandler.ashx?ActionName=UpDateMix",
                                type: "POST",
                                data: {
                                    "QUID": quid,
                                    "Caption": caption,
                                    "Nullable": must,
                                    "Type": type,
                                    "Ans": ans
                                },
                                success: function (result) {
                                    alert("更新成功");
                                    window.location.replace(location.href);
                                }
                            });

                        });
                    })
                    $("#btnSave").click(function () {

                        var caption = $("#txtQe").val();
                        var type = $("#selType").val();
                        var must;
                        var ans = $("#taAns").val();
                        if ($("#cbMust").is(":checked"))
                            must = true;
                        else
                            must = false;
                        if (caption == "" || ans == "") {
                            alert('請加入問題以及回答說明!!');
                            return
                        }



                        if (confirm('確定加入??')) {
                            $.ajax({
                                url: "/Handler/SystemHandler.ashx?ActionName=CreateMix",
                                type: "POST",
                                data: {
                                    "Caption": caption,
                                    "Type": type,
                                    "Nullable": must,
                                    "Ans": ans
                                },
                                success: function (result) {
                                    alert("新增成功");
                                    window.location.replace(location.href);
                                }
                            });
                        }
                        else {
                            alert("新增失敗");
                        }

                    });
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
                if (confirm('確定刪除??')) {
                    $.ajax({
                        url: "/Handler/SystemHandler.ashx?ActionName=DeleteMixQus",
                        type: "POST",
                        data: {
                            "QUID": rowData[0][0]
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
    <h1>常用問題編輯</h1>
    <hr class="invisible">
    <form runat="server">
        <div class="row align-items-center" id="divEditor">
            <div class="col-auto mb-3">
                <label>問題</label>
            </div>
            <div class="col-auto mb-3">
                <input type="text" id="txtQe" />
            </div>
            <div class="col-auto mb-3">
                <select class="form-select" id="selType">
                    <option value="0">單選方塊</option>
                    <option value="1">複選方塊</option>
                    <option value="2">文字方塊</option>
                </select>
            </div>
            <div class="col-auto">
                <div class="form-check">
                    <input class="form-check-input" id="cbMust" type="checkbox">
                    <label class="form-check-label">必填</label>
                </div>
            </div>
        </div>
        <div class="row align-items-center">
            <div class="col-auto mb-3">
                <label>回答</label>
            </div>
            <div class="col-auto mb-3">
                <textarea id="taAns" required></textarea>
                <small>(多個選項請用分號;隔開)</small>
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-primary" id="btnSave">儲存</button>
                <button type="button" class="btn btn-primary" id="btnUpdate">更新</button>
                <button type="reset" class="btn btn-warning">清除</button>
            </div>
        </div>
        <hr>
    </form>
    <button type="button" class="btn btn-sm" id="DeleteBtn">
        <img src="../Images/trash.png" /></button>
    <small style="font-size: small">["請先點選想要刪除的項目"]</small>
    <table class="table table-striped table-bordered table-sm table-hover" id="PostTable">
        <thead>
            <tr>
                <th width="8%">編號</th>
                <th width="20%">問題</th>
                <th width="10%">類型</th>
                <th width="8%">必填</th>
                <th width="39%">選項</th>
                <th width="15%">編輯</th>
            </tr>
        </thead>
    </table>
</asp:Content>
