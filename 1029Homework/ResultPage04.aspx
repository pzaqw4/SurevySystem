<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ResultPage04.aspx.cs" Inherits="_1029Homework.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>統計結果</title>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="Scripts/highcharts.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <p class="fs-2 fw-bold">問卷標題</p>
    <div id="container" style="width: 550px; height: 400px; margin: 0 auto"></div>
<script language="JavaScript">
    $(document).ready(function () {
        var chart = {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        };
        var title = {
            text: ''
        };
        var tooltip = {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        };
        var plotOptions = {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}%</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        };
        var series = [{
            type: 'pie',
            name: '圓餅圖',
            data: [
                ['', 100.0]
            ]
        }];

        var json = {};
        json.chart = chart;
        json.title = title;
        json.tooltip = tooltip;
        json.series = series;
        json.plotOptions = plotOptions;
        $('#container').highcharts(json);
    });
</script>
</asp:Content>
