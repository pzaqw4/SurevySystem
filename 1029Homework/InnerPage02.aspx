<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="InnerPage02.aspx.cs" Inherits="_1029Homework.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問卷內容</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="row g-2 needs-validation" novalidate>
        <p class="fs-2 fw-bold">問卷標題</p>
        <div>
            <a>問卷介紹</a>
        </div>
        <div class="col-7 form-floating mb-3">
            <input type="text" class="form-control" id="floatingName" placeholder="123" required>
            <div class="invalid-feedback">請填入姓名!</div>
            <label for="floatingAcc">請在此填入姓名</label>
        </div>
        <div class="col-7 form-floating mb-3">
            <input type="tel" class="form-control" id="floatingAcc" placeholder="123" required pattern="{10}" title="">
            <div class="invalid-feedback">請填入正確手機號碼!</div>
            <label for="floatingAcc">請在此填入手機</label>
        </div>
        <div class="col-7 form-floating mb-3">
            <input type="email" class="form-control" id="floatingEmail" placeholder="111@111" required>
            <div class="invalid-feedback">請填入正確格式Email!</div>
            <label for="floatingEmail">請在此填入 Email</label>
        </div>
        <div class="col-7 form-floating mb-3">
            <input type="number" class="form-control" id="floatingBirthDate" placeholder="111">
            <div class="invalid-feedback">請填入年齡</div>
            <label for="floatingBirthDate">請在此填入年齡</label>
        </div>
        <div>
            <a>問卷選項內容</a>
        </div>
        <hr class="my-4 invisible">
        <div class="col-12">
            <a class="btn btn-sm btn-outline-secondary guestFunc" href="ConfirmPage03.aspx">確認</a>
            <%--<button class="btn btn-outline-primary" type="submit">確認</button>--%>
            <button class="btn btn-outline-warning" type="reset">清除</button>
            <a class="btn btn-sm btn-outline-secondary guestFunc" href="ListPage01.aspx">取消</a>
            <%--<button class="btn btn-outline-danger" type="button">取消</button>--%>
        </div>
    </form>

</asp:Content>
