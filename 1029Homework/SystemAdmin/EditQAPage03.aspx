<%@ Page Title="" Language="C#" MasterPageFile="~/SystemAdmin/Backside.Master" AutoEventWireup="true" CodeBehind="EditQAPage03.aspx.cs" Inherits="_1029Homework.SystemAdmin.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>問題與回答編輯</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-3">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="EditPostPage02.aspx">問卷</a>
                        </li>
                        <li class="nav-item">
                            <a class="navbar-brand active" aria-current="page" href="EditQAPage03.aspx">問題</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="DetailPage04-1.aspx">填寫資料</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="BacksideResultPage05.aspx">統計</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div>
            <div class="row mb-3 col-md-4">
                <label class="col-sm-2 col-form-label">總類</label>
                <div class="col-sm-6">
                    <select class="form-select" runat="server">
                        <option>自訂問題</option>
                        <option>常見問題1</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row align-items-center">
            <div class="col-auto mb-3">
                <label>問題</label>
            </div>
            <div class="col-auto mb-3">
                <input type="text" runat="server" id="txtQe" required/>
            </div>
            <div class="invalid-feedback">
                請輸入問題
            </div>
        <div class="col-auto mb-3">
            <select class="form-select" runat="server" id="selType">
                <option value="0">單選方塊</option>
                <option value="1">複選方塊</option>
                <option value="2">文字方塊</option>
            </select>
        </div>
        <div class="col-auto">
            <div class="form-check">
                <input class="form-check-input" id="cbMust" type="checkbox" runat="server">
                <label class="form-check-label">必填</label>
            </div>
        </div>
        </div>
        <div class="row align-items-center">
            <div class="col-auto mb-3">
                <label>回答</label>
            </div>
            <div class="col-auto mb-3">
                <textarea runat="server" id="taAns" required></textarea>
                <small>(多個選項請用分號;隔開)</small>
            </div>
            <div class="col-auto">
                <asp:Button type="button" class="btn btn-primary" runat="server" ID="btnAdd" Text="加入" OnClick="btnAdd_Click" />
            </div>
        </div>
        <hr>
        <div class="mb-3">
            <asp:ImageButton runat="server" ImageUrl="../Images/trash.png" ID="ibtnDelete" OnClick="ibtnDelete_Click" ToolTip="刪除問題請按" OnClientClick="if (confirm('確定刪除嗎？')==false) {return false;}" UseSubmitBehavior="False"  />
            <asp:Button type="button" class="btn btn-dark" runat="server" ID="btnSubmit" Text="送出" OnClick="btnSubmit_Click" OnClientClick="if (confirm('確認送出嗎？')==false) {return false;}" UseSubmitBehavior="False" />
            <asp:Button type="button" class="btn btn-warning" runat="server" ID="btnCancel" Text="取消" OnClick="btnCancel_Click" />
        </div>

        <asp:GridView runat="server" ID="gvSurvey" AutoGenerateColumns="False" Width="748px" OnRowCommand="gvSurvey_RowCommand" OnRowDataBound="gvSurvey_RowDataBound" OnRowCreated="gvSurvey_RowCreated" CellPadding="4" CellSpacing="2">
            <Columns>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbselect" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="no" HeaderText="編號" />
                <asp:BoundField DataField="Q" HeaderText="問題" />
                <asp:BoundField DataField="ans" HeaderText="回答" />
                <asp:BoundField DataField="type" HeaderText="類型" />
                <asp:BoundField DataField="must" HeaderText="必填" />
                <asp:TemplateField HeaderText="操作功能">
                    <ItemTemplate>
                        <asp:LinkButton ID="LkB1" runat="server" Text='編輯' CommandName="LkB"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
    </form>
</asp:Content>
