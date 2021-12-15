<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="LoginPage05.aspx.cs" Inherits="_1029Homework.LoginPage05" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>登入頁面</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form class="row g-3 needs-validation" novalidate>
        <p class="fs-2 fw-bold">會員登入</p>
        <div class="row mb-3">
            <div class="col-2 text-center">
                <label for="txtAcc" class="form-label">帳號 : </label>
            </div>
            <div class="col-4">
                <input type="text" class="form-control" id="txtAcc" value="" required>
                <div class="invalid-feedback">
                    請填入帳號!
                </div>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-2 text-center">
                <label for="txtPwd" class="form-label">密碼 : </label>
            </div>
            <div class="col-4">
                <input type="password" class="form-control" id="txtPwd" value="" required pattern=".{5,15}" title="">
                <div class="invalid-feedback">
                    請填入正確密碼!
                </div>
            </div>
        </div>
        <div class="col-12">
            <button class="btn btn-primary" type="submit">送出</button>
        </div>
        <hr class="my-4">
    </form>
    
    <script>
        (function () {

            var forms = document.querySelectorAll('.needs-validation')
            var redirect = function () { window.location.href = "SystemAdmin/BacksideListPage01.aspx"; }

            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function () {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    else {
                        var acc = $("#txtAcc").val();
                        var pwd = $("#txtPwd").val();
                        event.preventDefault()
                        $.ajax({
                            url: "Handler/SystemHandler.ashx?ActionName=Login",
                            type: "POST",
                            data: {
                                "Account": acc,
                                "Password": pwd,
                            },
                            success: function (result) {                                
                                var authx = document.cookie.indexOf(".ASPXAUTH");
                                if ("Success" == result[0]) {
                                    if (authx == 0) {
                                        alert('登入成功');
                                        sessionStorage.setItem("Name", result[1]);
                                        redirect();
                                    }
                                }
                                else {
                                    alert('登入失敗,請確認帳號密碼!!');
                                }
                            }
                          
                        });
                    }
                    form.classList.add('was-validated')
                }, false)
            });
        })()
    </script>
</asp:Content>
