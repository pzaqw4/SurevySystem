<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ResultPage04.aspx.cs" Inherits="_1029Homework.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>統計結果</title>
    <style>
        div {
            //border: 1px solid #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lbTitle" runat="server" Text="標題名稱" Font-Size="X-Large"></asp:Label>
    <hr class="invisible" />
    <div class="container">
        <asp:PlaceHolder ID="chartPlace" runat="server"></asp:PlaceHolder>
        <br />
        <asp:Literal ID="ltCaption" runat="server"></asp:Literal><br />

    </div>
</asp:Content>
