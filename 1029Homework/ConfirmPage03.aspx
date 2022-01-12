<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfirmPage03.aspx.cs" Inherits="_1029Homework.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>確認內頁</title>
    <script>
        const pageUrl = new URL(window.location.href);
        var pid = pageUrl.searchParams.get("PID");

        $(document).ready(function () {
            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetPostInfo",
                type: "POST",
                data: { "PID": pid },
                success: function (result) {
                    if (null != result.Body) {  /* 問卷資料*/
                        $("#headText").text(result.Title);
                        $("#bodyText").append(result.Body);
                        $("#timeText").text("有效時間:" + result.Starttime + "~~" + result.Endtime);
                    }
                }
            });

            $.ajax({
                url: "/Handler/SystemHandler.ashx?ActionName=GetAllQus",
                type: "POST",
                data: { "PID": pid },
                success: function (result) {
                    var radVal = JSON.parse(sessionStorage.getItem("radVal"));//轉型sessionStorage
                    var chbVal = JSON.parse(sessionStorage.getItem("chbVal"));
                    var txtVal = JSON.parse(sessionStorage.getItem("txtVal"));
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        if (obj.Nullable == true)
                            htmltext += `<p>([必填!][必填!])`;
                        else
                            htmltext += `<p>`;
                        var htmltext = `<h4>第${i + 1}題：${obj.Caption}</h4>`;//第幾題跟題目名

                        for (var j = 0; j < radVal.length; j++) {
                            if (obj.QuID == radVal[j].key) {
                                htmltext += `<p>回答： ${radVal[j].value}<p>`;
                                break;
                            }
                        }
                        for (var k = 0; k < chbVal.length; k++) {
                            if (obj.QuID == chbVal[k].key) {
                                htmltext += `<p>回答： ${chbVal[k].value}<p>`;
                                break;
                            }
                        }
                        for (var l = 0; l < txtVal.length; l++) {
                            if (obj.QuID == txtVal[l].key) {
                                htmltext += `<p>回答： ${txtVal[l].value}<p>`;
                                break;
                            }
                        }

                        htmltext += `<hr class="invisible"/>`;
                        htmltext += `</br></div >`;
                        $("#ansText").append(htmltext);
                    }
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="row g-2" runat="server">
        <p class="fs-2 fw-bold" id="headText">[注意!] 不存在的頁面 [注意!]</p>
        <div id="bodyText" class="mb-3">
        </div>
        <small id="timeText"></small>
        <hr />
        <fieldset disabled>
            <div class="row">
                <div class="col-4 form-floating mb-3">
                    <input type="text" class="form-control" id="txtName" placeholder="123" required runat="server">
                    <label>姓名:</label>
                </div>
            </div>
            <div class="row">
                <div class="col-4 form-floating mb-3">
                    <input type="tel" class="form-control" id="txtPhone" placeholder="123" required runat="server">
                    <label>手機:</label>
                </div>
            </div>
            <div class="row">
                <div class="col-4 form-floating mb-3">
                    <input type="email" class="form-control" id="txtEmail" placeholder="111@111" required runat="server">
                    <label>Email:</label>
                </div>
            </div>
            <div class="row">
                <div class="col-4 form-floating mb-3">
                    <input type="number" class="form-control" id="txtAge" placeholder="111" runat="server">
                    <label>年齡:</label>
                </div>
            </div>
            <div class="col-9 form-floating mb-3">
                <asp:Literal ID="litAnswer" runat="server"></asp:Literal>
                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            </div>
            <div id="ansText">
                <%--顯示問題內容--%>
            </div>
        </fieldset>
        <hr class="my-4 invisible">
        <div class="col-12 form-floating mb-3">
            <asp:Button class="btn  btn-outline-primary " runat="server" Text="確認" ID="btnConf" OnClick="btnConf_Click" />
            <asp:Button class="btn btn-outline-secondary" runat="server" Text="修改" ID="btnFix" OnClick="btnFix_Click" />
        </div>
    </form>
</asp:Content>
