<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="InnerPage02.aspx.cs" Inherits="_1029Homework.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問卷內容</title>
    <script>
        // 取得PostID
        const pageUrl = new URL(window.location.href);
        var pid = pageUrl.searchParams.get("PID");

        sessionStorage.clear();

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
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        if (obj.Nullable == true)
                            htmltext += `<p>([必填!][必填!])`;
                        else
                            htmltext += `<p>`;
                        var htmltext = `<h4>第${i + 1}題：${obj.Caption}</h4>`;//第幾題跟題目名

                        if (obj.Type == 0) {
                            var ansArr = (obj.Ans).split(";");
                            for (var j = 0; j < ansArr.length; j++) { //把所有選項都建出來
                                htmltext += `<input type="radio" class="ansRadio" id="${obj.QuID}" name="${obj.Ans}" value = ${ansArr[j]} />${ansArr[j]}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp`;
                            }
                        }
                        else if (obj.Type == 1) {
                            var ansArr = (obj.Ans).split(";");
                            for (var j = 0; j < ansArr.length; j++)
                                htmltext += `<input type="checkbox" class="ansChb" id="${obj.QuID}" name="${obj.Ans}" value =${ansArr[j]}  />${ansArr[j]}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp`;
                        }
                        else {
                            htmltext += `<textarea class="col-4 txtArea" id="${obj.QuID}" placeholder="請在此作答" name="" ></textarea>`;
                        }
                        htmltext += `<hr class="invisible"/>`;
                        htmltext += `</br></div >`;
                        $("#ansText").append(htmltext);
                    }
                    $(".ansRadio").click(function () {
                        let checkValue = $(this).val();
                        var checkID = $(this).attr("id");
                        var arr = JSON.parse(sessionStorage.getItem('radVal')) || [];
                        var inputObject = {
                            key: checkID, value: checkValue
                        };
                        if (arr.length > 0 && arr != null) {
                            var sameKey = false;                                   //為了不重復新增陣列內容(不重複push)
                            for (var i = 0; i < arr.length; i++) {                //檢查arr陣列內容
                                if (arr[i].key == checkID) {                     //檢查是否重複,若重複直接覆蓋
                                    arr[i] = inputObject;
                                    sameKey = true;
                                    break;                                          //跳出迴圈
                                }
                            }
                            if (sameKey == false)
                                arr.push(inputObject);
                        }
                        else {
                            arr.push(inputObject);
                        }
                        sessionStorage.setItem("radVal", JSON.stringify(arr));      //陣列轉為JSON,填入sessionStorage
                    });
                    $(".ansChb").click(function () {
                        var isChecked = $(this).is(":checked");
                        var chbarr = JSON.parse(sessionStorage.getItem('chbVal')) || [];   //判斷是否為新資料
                        let checkValue = $(this).val();
                        var checkID = $(this).attr("id");
                        var inputObject = {
                            key: checkID, value: checkValue + ";"
                        };
                        if (isChecked == true) {                                          //判斷是否點選
                            if (chbarr != null && chbarr.length > 0) {
                                var sameKey = false;
                                for (var i = 0; i < chbarr.length; i++) {
                                    if (chbarr[i].key == inputObject.key) {
                                        chbarr[i].value = chbarr[i].value.concat(inputObject.value);    //答案字串陣列加入新的字串
                                        sameKey = true;
                                        break;
                                    }
                                }
                                if (sameKey == false)
                                    chbarr.push(inputObject);         //寫入陣列
                            }
                            else {
                                chbarr.push(inputObject);             //寫入陣列
                            }                                                                  
                            sessionStorage.setItem("chbVal", JSON.stringify(chbarr));     //陣列轉為JSON,填入sessionStorage
                        }
                        else {                                       //若取消點選,則做檢查                               
                            if (chbarr != null && chbarr.length > 0) {
                                for (var i = 0; i < chbarr.length; i++) {
                                    if (chbarr[i].key == inputObject.key) {
                                        chbarr[i].value = chbarr[i].value.replace(inputObject.value, "");   //點選的值取代為空字串
                                        break;
                                    }
                                }
                                sessionStorage.setItem("chbVal", JSON.stringify(chbarr));          //填入sessionStorage
                            }
                        }
                    });
                    var text = document.getElementById(`${obj.QuID}`),
                        btn = document.getElementById("ContentPlaceHolder1_btnSub");
                    btn.onclick = function () {
                        var checkID = text.id;
                        var txtVal = text.value;
                        var txtArr = JSON.parse(sessionStorage.getItem('txtVal')) || [];
                        var inputObject = {
                            key: checkID, value: txtVal
                        };
                        if (txtArr != null && txtArr.length > 0) {
                            var sameKey = false;
                            for (var i = 0; i < txtArr.length; i++) {                //檢查arr陣列內容
                                if (txtArr[i].key == checkID) {                     //檢查是否重複,若重複直接覆蓋
                                    txtArr[i] = inputObject;
                                    sameKey = true;
                                    break;                                          //跳出迴圈
                                }
                            }
                            if (sameKey == false)
                                txtArr.push(inputObject);
                        }
                        else {
                            txtArr.push(inputObject);
                        }
                        sessionStorage.setItem("txtVal", JSON.stringify(txtArr));
                    }
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="row g-2 needs-validation" novalidate runat="server">
        <p class="fs-2 fw-bold" id="headText">[注意!] 不存在的頁面 [注意!]</p>
        <div id="bodyText" class="mb-3">
            <a></a>
        </div>
        <small id="timeText"></small>
        <hr />
        <div class="row">
            <div class="col-4 form-floating mb-3">
                <input type="text" class="form-control" id="txtName" placeholder="123" runat="server" required />
                <div class="invalid-feedback">請填入姓名!</div>
                <label for="txtName">請在此填入姓名</label>
            </div>
        </div>
        <div class="row">
            <div class="col-4 form-floating mb-3">
                <input type="tel" class="form-control" id="txtPhone" placeholder="123" pattern=".{10}" title="" required runat="server">
                <div class="invalid-feedback">請填入正確手機號碼!</div>
                <label for="txtPhone">請在此填入手機</label>
            </div>
        </div>
        <div class="row">
            <div class="col-4 form-floating mb-3">
                <input type="email" class="form-control" id="txtEmail" placeholder="111@111" required runat="server">
                <div class="invalid-feedback">請填入正確格式Email!</div>
                <label for="txtEmail">請在此填入 Email</label>
            </div>
        </div>
        <div class="row">
            <div class="col-4 form-floating mb-3">
                <input type="number" class="form-control" id="txtAge" placeholder="111" required runat="server">
                <div class="invalid-feedback">請填入年齡</div>
                <label for="txtAge">請在此填入年齡</label>
            </div>
        </div>
        <hr class="my-4 invisible">
        <div id="ansText">
            <%--顯示問題內容--%>
        </div>
        <hr class="invisible">
        <div class="col-12">
            <asp:Button class="btn  btn-outline-primary" runat="server" Text="確認" ID="btnSub" OnClick="btnSub_Click" />
            <button class="btn btn-outline-warning" type="reset">清除</button>
            <asp:Button runat="server" class="btn btn-outline-secondary" Text="取消" ID="btnCancel" OnClick="btnCancel_Click" />
        </div>
    </form>
</asp:Content>
