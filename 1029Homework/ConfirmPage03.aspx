<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ConfirmPage03.aspx.cs" Inherits="_1029Homework.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>確認內頁</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="row g-2 needs-validation" novalidate>
        <p class="fs-2 fw-bold">問卷標題</p>
        <fieldset disabled>
        <div class="col-9 form-floating mb-3">
            <input type="text" class="form-control"  placeholder="123" required>
            <label for="floatingAcc">姓名</label>
        </div>
        <div class="col-9 form-floating mb-3">
            <input type="tel" class="form-control"  placeholder="123" required>
            <label for="floatingAcc">手機</label>
        </div>
        <div class="col-9 form-floating mb-3">
            <input type="email" class="form-control" placeholder="111@111" required>          
            <label for="floatingEmail">Email</label>
        </div>
        <div class="col-9 form-floating mb-3">
            <input type="number" class="form-control" placeholder="111">
            <label for="floatingBirthDate">年齡</label>
        </div>
        <div class="col-9 form-floating mb-3">
            <label for="floatingBirthDate">問卷內容</label>
        </div>
        </fieldset>
        <hr class="my-4 invisible">
        <div class="col-12 form-floating mb-3">
            <a class="btn btn-sm btn-outline-secondary guestFunc" href="ResultPage04.aspx">確認</a>
            <%--<button class="btn btn-outline-primary" type="submit">確認</button>--%>
            <a class="btn btn-sm btn-outline-secondary guestFunc" href="InnerPage02.aspx">修改</a>
            <%--<button class="btn btn-outline-danger" type="button">取消</button>--%>
        </div>
    </form>
</asp:Content>
