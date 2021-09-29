<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="report_stock.aspx.cs" Inherits="AmpelflowApp.xReporting.report_stocknet" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../Content/plugins/jquery.dropselect.js"></script>
        <script src="../../Content/plugins/currency.min.js"></script>
        <script src="../../Content/plugins/numeral.js"></script>
        <%--<script src="../../Content/plugins/QuantumAlert/minfile/quantumalert.js"></script>--%>
        <script src="https://cdn.jsdelivr.net/gh/cosmogicofficial/quantumalert@latest/minfile/quantumalert.js" charset="utf-8"></script>
        <link href="../../Content/plugins/QuantumAlert/minfile/quantumalert.css" rel="stylesheet" />
        <%--<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>--%>

        
        <%--<h1 class="txtHeader">รายการ : รายงานสินค้าคงคลัง</h1>--%>
        <style>
            .nav-tabs-custom > .nav-tabs > li.active {
                border-top-color: #3c8dbc;
            }

            .bxbpdercolor {
                border-top-color: #3c8dbc;
            }

            

            .textBoxinit {
                border-radius: 0px 3px 3px 0px;
                width: 100%
            }

            .textBoxaddons {
                border-radius: 3px 0px 0px 3px;
            }

            .txtLabelx {
                font-family: 'Athiti', sans-serif;
                font-size: 15px;
                font-weight: normal;
            }

            .has-error .select2-selection {
                border-color: rgb(185, 74, 72) !important;
            }


            /*----------------------------------------------------*/
            .spinner {
                height: 60px;
                width: 60px;
                margin: auto;
                display: flex;
                position: absolute;
                -webkit-animation: rotation .6s infinite linear;
                -moz-animation: rotation .6s infinite linear;
                -o-animation: rotation .6s infinite linear;
                animation: rotation .6s infinite linear;
                border-left: 6px solid rgba(0, 174, 239, .15);
                border-right: 6px solid rgba(0, 174, 239, .15);
                border-bottom: 6px solid rgba(0, 174, 239, .15);
                border-top: 6px solid rgba(0, 174, 239, .8);
                border-radius: 100%;
            }

            @-webkit-keyframes rotation {
                from {
                    -webkit-transform: rotate(0deg);
                }

                to {
                    -webkit-transform: rotate(359deg);
                }
            }

            @-moz-keyframes rotation {
                from {
                    -moz-transform: rotate(0deg);
                }

                to {
                    -moz-transform: rotate(359deg);
                }
            }

            @-o-keyframes rotation {
                from {
                    -o-transform: rotate(0deg);
                }

                to {
                    -o-transform: rotate(359deg);
                }
            }

            @keyframes rotation {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(359deg);
                }
            }

            #overlayx {
                position: absolute;
                display: none;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0,0,0,0.5);
                z-index: 2;
                cursor: pointer;
            }


            /*----------------------------------------------------*/



        </style>
        <script>
            //Setting Spinner Overlay spinner

            function on() {
                document.getElementById("overlayx").style.display = "flex";
            }

            function off() {
                document.getElementById("overlayx").style.display = "none";
            }
        </script>



        <script>
            var emp_id = '<%= Session["emp_id"] %>';
            var usr_name = '<%= Session["usr_name"] %>';
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
            var currentdate2 = yyyy + '-' + mm + '-' + dd;
            var vendorid, coilid, coilref;
            var activeTab;
            var lotno = yyyy + mm + dd;
            var lottime = tt;


            $(document).ready(function () {
                setTimeout(function () {
                    ProgressOn();

                    $("input[type='checkbox'], input[type='radio']").iCheck({
                        checkboxClass: 'icheckbox_minimal',
                        radioClass: 'iradio_minimal'
                    });

                    $('#sectionContent').fadeIn(500);
                    $('body').removeClass('overlay');

                    var btnReportTypeSelected = $('#btnReportTypeSelected');
                    btnReportTypeSelected.change(function () {

                        var btnReportTypeSelected = $('#btnReportTypeSelected').val()

                        if (btnReportTypeSelected == 1) {

                            $('#btnSelectControl').removeClass('has-error');
                            $('#txt_rpt_sDate').prop('disabled', true);
                            $('#txt_rpt_eDate').prop('disabled', true);
                            $('#eDate1').prop('disabled', false);
                            $('#txt_rpt_eDate1').prop('disabled', false);
                            $('#eDate1').val('');

                            $('#DivDataStockNet').fadeIn(100);
                            $('#DivDateMovement').fadeOut(100);



                           
                           
                        } else if (btnReportTypeSelected == 2) {
                            
                            $('#btnSelectControl').removeClass('has-error');
                            $('#txt_rpt_sDate').prop('disabled', false);
                            $('#txt_rpt_eDate').prop('disabled', false);
                            $('#eDate1').prop('disabled', true);
                            $('#divRpt_eDate1').removeClass('has-error');
                            $('#eDate1').val('');

                            $('#sDate1x').prop('disabled', false);
                            $('#eDate1x').prop('disabled', false);

                            $('#DivDataStockNet').fadeOut(100);
                            $('#DivDateMovement').fadeIn(100);

                          
                        } else if (btnReportTypeSelected == 0) {
                            $('#btnSelectControl').removeClass('has-error');
                            $('#txt_rpt_sDate').prop('disabled', true);
                            $('#txt_rpt_eDate').prop('disabled', true);
                            $('#txt_rpt_eDate1').prop('disabled', true);
                            $('#divRpt_eDate1').removeClass('has-error');

                            $('#DivDataStockNet').fadeOut(100);
                            $('#DivDateMovement').fadeout(100);
                            

                        }

                    })

                    

                  

                    Display_GetMaterial_Item();
                    ProgressOff();

                    var btnGetMaterial = $('#btnGetMaterial');
                    btnGetMaterial.click(function(){
                       
                        $('#modal_material').modal('show');
                    })

                    var btnGetitemData = $('#btnGetitemData');
                    btnGetitemData.click(function(){
                        getMultiGoodCode();
                    })

                    var btnGetStock_View = $('#btnGetStock_View');
                    btnGetStock_View.click(function () {

                        if ($('#eDate1').val() == '' || $('#txtitemlistx').val() == '') {

                            var strerr = '';
                            if ($('#eDate1').val() == '')
                            {
                                strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ตรวจสอบ : วันของรายงาน</div>'
                            }
                            if ($('#txtitemlistx').val() == '')
                            {
                                strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ตรวจสอบ : รายการวัตถุดิบ</div>'
                            }

                            Swal.fire({
                                icon: 'error',
                                title: '<div class="txtLabel16" style="color:#f27474"><strong>เกิดข้อผิดพลาด</strong></div>',
                                html: strerr,
                                confirmButtonText: '<div class="txtLabel">OK</div>',
                                confirmButtonColor: '#f27474'

                            })

                        } else {
                            GetView_rptStockNet();
                        }
                        

                        
                    })






                    $('#tbl_GoodItem_filter').text('')
                    $('#tbl_GoodItem_filter').html('<span class="btn-group">' + 
                        '<button type="button" class="btn btn-default btn-sm checkbox-toggle" id="btnGetCheck" data-toggle="tooltip" title="Check All" data-original-title="Check All!" style="border-radius:3px;background-color:transparent;color:green"> <i class="fa fa-check-square-o" aria-hidden="true"></i></button >' +
                        '<button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" id="btnGetunCheck" data-toggle="tooltip" title="unCheck All" data-original-title="unCheck All!" style="border-radius:3px;background-color:transparent;color:red" ><i class="fa fa-square-o" aria-hidden="true"></i></button >' +
                        '</span>');

                    $('#tbl_ViewStockNet_filter').text('')
                    $('#tbl_ViewStockNet_filter').html('<span class="btn-group" style="border-radius:2px">'
                        + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel" onclick="PrintExcel()"  data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                        + '<button type="button" class="btn btn-sm  btn-default  txtLabel " id="btnPrintPdf" onclick="PrintPdf()" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                        + '</span >')
                                                         

                    $('#tbl_ViewStockmovement_filter').text('')
                    $('#tbl_ViewStockmovement_filter').html('<span class="btn-group" style="border-radius:2px">'
                        + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel" onclick="PrintExcel()"  data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                        + '<button type="button" class="btn btn-sm  btn-default  txtLabel " id="btnPrintPdf" onclick="PrintPdf_rptmovement()" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                        + '</span >')


                                          
                    var btnGetCheck = $('#btnGetCheck')
                    btnGetCheck.click(function () {
                        var tbl_GoodItem = $('#tbl_GoodItem').DataTable();
                        $("input", tbl_GoodItem.rows({ search: 'applied' }).nodes()).each(function () {
                            $(this).prop("checked", true);
                        })

                        $('#btnGetCheck').addClass('hidden');
                        $('#btnGetunCheck').removeClass('hidden');
                    })

                    var btnGetunCheck = $('#btnGetunCheck')
                    btnGetunCheck.click(function () {
                        var tbl_GoodItem = $('#tbl_GoodItem').DataTable();
                        $("input", tbl_GoodItem.rows({ search: 'applied' }).nodes()).each(function () {
                            $(this).prop("checked", false);
                        })
                        $('#btnGetCheck').removeClass('hidden');
                        $('#btnGetunCheck').addClass('hidden');
                    })

                    var btnGetStock_Movement_View = $('#btnGetStock_Movement_View');
                    btnGetStock_Movement_View.click(function () {

                        $('#Model_StockMovement').html('<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายการเคลื่อนไหววัตถุดิบ ระหว่าง ' + $('#sDate1x').val() + ' ถึง ' + $('#eDate1x').val() +'</strong>');
                        $('#modal_ViewStockMovement').modal('show');

                        document.getElementById("<%= serv_sDate1x.ClientID%>").value = $('#sDate1x').val();
                        document.getElementById("<%= serv_eDate1x.ClientID%>").value = $('#eDate1x').val();
              

                    })

                }, 1500)
            });

            function ClearInput() {
                $('#txtitemlist').val('');
                $('#txtitemlist1').val('');
                $('#eDate1').val('');


            }


            function GetStock_Reports() {
                //1-รายงานเยอดคงเหลือ
                //2-รายงานเคลื่อนไหวสินค้า
                var btnReportTypeSelected = $('#btnReportTypeSelected').val()
                if (btnReportTypeSelected == 1) {
                    var eDate1 = $('#eDate1').val();
                   
                    if (eDate1 == '') {
                        //$('#divRpt_eDate1').addClass('has-error');
                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel"><strong>[เกิดข้อผิดพลาด]</strong></div>',
                            html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ใส่ข้อมูลวันสิ้นสุด</strong></div>'
                        })

                    } else if (eDate1 != '') {
                        //$('#divRpt_eDate1').removeClass('has-error');
                        GetStrock_Reports_Type1();

                    } else {
                        console.log(1);
                    }

                } else if (btnReportTypeSelected == 2) {
                    //alert(2+';'+293);
                    $('#btnSelectControl').removeClass('has-error');
                    var sdate = $('#txt_rpt_sDate');
                    var eDate = $('#txt_rpt_eDate');
                    //alert(sDate + ' ' + eDate)
                } else if (varProjtype_Selected == 0) {
                    $('#btnSelectControl').addClass('has-error');

                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">เลือกรูปแบบรายงาน</strong></div>'

                    })
                }
            }
            function GetStrock_Reports_Type1() {


            }
            function GetStrock_Reports_Type2() {

            }

            function Display_GetMaterial_Item() {
                    $.ajax({
                        url: '../../xReporting/srv_report_stock.asmx/Display_GetMaterial_Item',
                        method: 'post',
                        data: {action: 'Display_GetMaterial_Item'},
                        dataType: 'json',
                        success: function (data) {
                            if (data != '') {
                                var tbl_GoodItem = $('#tbl_GoodItem').DataTable();
                                tbl_GoodItem.clear();
                                $.each(data, function (i, item) {
                                    tbl_GoodItem.row.add([
                                        '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodcode + '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodname + '</div>'
                                        , '<div class="text-center">' + data[i].strCheckbox + '</div>'
                                        , '<div style="text-align: center;"><input type="checkbox" value="' + data[i].matr_goodid + '">'


                                    ])
                                    tbl_GoodItem.draw();
                                });
                            } else {

                            }
                        }
                    })
            }

            function getMultiGoodCode() {
               
                var allitem = '';
                var tbl_GoodItem = $('#tbl_GoodItem').DataTable();
                var arr = [];
                var checkedvalues = tbl_GoodItem.$('input:checked').each(function () {
                    arr.push($(this).attr('value'))
                });

                allitem = arr.join(';')
                function getGoodCode(item, index) {
                    console.log(index + ':' + item)
                }

                //alert(allitem);
                //alert($('#branchCode1').val());
                $('#txtitemlistx').val(allitem);


                //alert(allitem);

                if (allitem != '') {
                    $.ajax({
                        url: '../../xReporting/srv_report_stock.asmx/Getitemlist',
                        method: 'post',
                        data: { action: 'getitemlist', allitems: allitem },
                        dataType: 'json',
                        success: function (data) {
                            if (data != '') {
                                $.each(data, function (i, item) {
                                    $('#txtitemlist').val(data[i].allteims);
                                    console.warn(allitem);
                                    document.getElementById("<%= serv_txtitemlist.ClientID%>").value = allitem;
                                })

                            }
                        }
                    })
                    $('#modal_material').modal('hide')

                } else if (allitem != '') {

                    $('#modal_material').modal('hide')

                } else {

                }



               
            }

            function GetView_rptStockNet() {
                console.log('GetView_rptStockNet()');
                ProgressOn();
                $.ajax({
                    url: '../../xReporting/srv_report_stock.asmx/GetView_rptStockNet',
                    method: 'post',
                    data: {
                        eDate1: $('#eDate1').val()
                        , allitems: $('#txtitemlistx').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_ViewStockNet').DataTable().clear();
                            $('#tbl_ViewStockNet').DataTable().destroy();

                            var groupColumn = 0;

                            var tbl_ViewStockNet = $('#tbl_ViewStockNet').DataTable({
                                "ordering": false,
                                "autoWidth": false,
                                
                                "columnDefs": [
                                    { "visible": false, "targets": groupColumn }
                                ],
                                "order": [[groupColumn, 'asc']],
                                "displayLength": 10,
                                "drawCallback": function (settings) {
                                    var api = this.api();
                                    var rows = api.rows({ page: 'current' }).nodes();
                                    var last = null;

                                    api.column(groupColumn, { page: 'current' }).data().each(function (group, i) {
                                        if (last !== group) {
                                            $(rows).eq(i).before(
                                                '<tr class="group"><td colspan="6">' + group + '</td></tr>'
                                            );

                                            last = group;
                                        }
                                    });
                                }
                            });
                            
                            tbl_ViewStockNet.clear();

                            $('[name=tbl_ViewStockNet_length]').removeClass('input-sm');
                            $('[name=tbl_ViewStockNet_length]').select2();

                            $('#txtDateModalViewStock').text('');
                            $('#txtDateModalViewStock').html('<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายการวัตถุดิบคงเหลือ : ถึงวันที่ <Label style="color:#a5dc86;text-decoration:underline">' + $('#eDate1').val() + '</Label></strong>');

                            $('#tbl_ViewStockNet_filter').text('')
                            $('#tbl_ViewStockNet_filter').html('<span class="btn-group" style="border-radius:2px">'
                                + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel" onclick="PrintExcel()" data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                                + '<button type="button" class="btn btn-sm  btn-default  txtLabel "  id="btnPrintPdf" onclick="PrintPdf()" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                                + '</span >')



                            $.each(data, function (i, item) {
                                tbl_ViewStockNet.row.add([
                                    '<div class="text-left txtLabel" style="padding-left:5px"><strong><u>' + data[i].projectname + '</u></strong></div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    ,'<div class="text-left txtLabel" style="padding-left:5px">' + data[i].docu_no + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].remark_transac + ' - ' + data[i].vendorname + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].remaQty).format('0,0.00') + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].CostTotal).format('0,0.00') + '</div>'
                                    


                                ])
                                tbl_ViewStockNet.draw();
                                $('#modal_ViewStockNet').modal('show')
                                ProgressOff();
                            });
                        } else {

                            ProgressOff();

                        }
                    }
                })


            }

            


            function PrintPdf() {

                ProgressOn();

                
                setTimeout(
                    function () {
                        ProgressOff()
                    },1000 )

                //alert(1);

                document.getElementById("<%= serv_btnReportTypeSelected.ClientID %>").value = $('#btnReportTypeSelected').val();
                document.getElementById("<%= serv_eDate1.ClientID%>").value = $('#eDate1').val();
                document.getElementById("<%= serv_btnPrintPdf1.ClientID%>").click();
            }

            function PrintExcel() {
                ProgressOn();

                //alert(1);

                setTimeout(
                    function () {
                        ProgressOff()
                    }, 1000)

                document.getElementById("<%= serv_btnReportTypeSelected.ClientID %>").value = $('#btnReportTypeSelected').val();
                document.getElementById("<%= serv_eDate1.ClientID%>").value = $('#eDate1').val();
                document.getElementById("<%= serv_btnPrintExcel1.ClientID%>").click();
            }


            function GetView_StockMovement() {
                ProgressOn();
                $.ajax({
                    url: '../../xReporting/srv_report_stock.asmx/GetView_StockMovement',
                    method: 'post',
                    data: {
                        sDate1x : $('#sDate1x').val()
                        ,eDate1x :$('#eDate1x').val()
                        ,items : $('#txtitemlistx').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_ViewStockNet').DataTable().clear();
                            $('#tbl_ViewStockNet').DataTable().destroy();

                            var groupColumn = 0;

                            var tbl_ViewStockNet = $('#tbl_ViewStockNet').DataTable({
                                "ordering": false,
                                "autoWidth": false,

                                "columnDefs": [
                                    { "visible": false, "targets": groupColumn }
                                ],
                                "order": [[groupColumn, 'asc']],
                                "displayLength": 8,
                                "drawCallback": function (settings) {
                                    var api = this.api();
                                    var rows = api.rows({ page: 'current' }).nodes();
                                    var last = null;

                                    api.column(groupColumn, { page: 'current' }).data().each(function (group, i) {
                                        if (last !== group) {
                                            $(rows).eq(i).before(
                                                '<tr class="group"><td colspan="5">' + group + '</td></tr>'
                                            );

                                            last = group;
                                        }
                                    });
                                }
                            });
                            $('[name=tbl_ViewStockNet_length]').select2();

                            tbl_ViewStockNet.clear();


                            $('#tbl_ViewStockNet_filter').text('')
                            $('#tbl_ViewStockNet_filter').html('<span class="btn-group" style="border-radius:2px">'
                                + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel" onclick="PrintExcel()" data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                                + '<button type="button" class="btn btn-sm  btn-default  txtLabel "  id="btnPrintPdf" onclick="PrintPdf()" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                                + '</span >')



                            $.each(data, function (i, item) {
                                tbl_ViewStockNet.row.add([
                                    '<div class="text-left txtLabel" style="padding-left:5px"><strong><u>' + data[i].projectname + '</u></strong></div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].docu_no + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].remark_transac + ' - ' + data[i].vendorname + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].remaQty).format('0,0.00') + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-left txtLabel text-right" style="padding-left:5px">' + numeral(data[i].CostTotal).format('0,0.00') + '</div>'



                                ])
                                tbl_ViewStockNet.draw();
                                $('#modal_ViewStockNet').modal('show')
                                ProgressOff();
                            });
                        } else {

                            ProgressOff();

                        }
                    }
                })
            }

            function PrintPdf_rptmovement() {

                document.getElementById("<%= serv_TypeReport.ClientID
    %>").value = "pdf";


                document.getElementById("<%= serv_btn_pdf_rptmovement.ClientID%>").click();
                
            }


        </script>


    </section>
    <section class="content" id="sectionContent" style="display: none">
        <%--<div id="overlayx" onclick="off()">
          
           <div class="spinner"></div>
         
        </div>--%>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary" id="boxInput" style="border-radius: 3px">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="user-block">
                                <img src="../../Content/Icons/web512.png" alt="User Image">
                                <span class="username">
                                    <a href="#" class="txtSecondHeader"><strong>รายงาน : รายงานสินค้าคงเหลือ</strong></a>
                                </span>
                                <span class="description txtLabel">Monitoring progression of projects</span>
                            </div>
                            <br />
                        <div class="row">
                            <div class="col-md-12">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab">
                                        <li class="active" style="border-radius: 3px 3px 0px 0px"><a href="#tab_Coil" class="txtLabel" data-toggle="tab"><strong><i class="fa fa-file-text-o" aria-hidden="true"></i> รายงานวัตถุดิบคงเหลือ</strong></a></li>
                                        <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active">
                                            <%--  --%>
                                            <div class="row" style="margin-left: 15px; margin-right: 15px">
                                                <div class="col-md-12  jumbotron txtLabel" style="border-radius: 5px;">
                                                    Stock Reports : รายงานสินค้าคงเหลือ  
                                                </div>
                                            </div>
                                            <%--<div class="row">--%>
                                                <div class="col-md-12">
                                                    <div class="col-md-4">
                                                        <div class="form-group" id="btnSelectControl">
                                                            <label for="" class="txtLabel">Report Type : </label>
                                                            <div class="input-group txtlabel" style="width: 100%;">
                                                             
                                                                <div class="txtLabel" id="btnSelectControl1">
                                                                    <select id="btnReportTypeSelected" class="txtLabel" style="width: 100%;text-align: justify; height: 34px" name="state">
                                                                        <option value="0">--- ประเภทรายงาน --- </option>
                                                                        <option value="1">รายงาน ยอดวัตถุดิบคงเหลือ</option>
                                                                        <option value="2">รายงาน ยอดวัตถุดิบเคลื่อนไหวสินค้า</option>
                                                                    </select>
                                                                    <input type="text" runat="server" class="hidden" id="serv_btnReportTypeSelected" name="name" value="" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row hidden">
                                                            <div class="col-md-6" id="DivsDate">
                                                                <div class="form-group">
                                                                    <label for="" class="txtLabel">Start : </label>
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                        <input type="text" name="txt_sDate" id="txt_rpt_sDate" class="form-control txtLabel  text-left textBoxinit " placeholder="yyyy-MM-dd" disabled style="border-radius: 0px 3px 3px 0px" />
                                                                       <input type="text" runat="server" name="Movement_sDatex" id="Movement_sDatex" class="form-control txtLabel  text-left textBoxinit hidden" placeholder="yyyy-MM-dd" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            
                                                        </div>
                                                       
                                                        </div>
                                                   
                                                       
                                                    <div class="col-md-8">
                                                        <div class="form-group">
                                                            <label for="" class="txtLabel">รายการวัตถุดิบ : </label>
                                                            <div class="input-group ">
                                                                <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                    <i class="fa fa-cubes" aria-hidden="true"></i>
                                                                </div>
                                                                <input type="text" name="txtitemlist1" id="txtitemlist" class="form-control txtLabel" placeholder="กรุณาเลือกรายการวัตถุดิบ"/>
                                                                <input type="text" name="txtitemlist1" id="txtitemlistx" class="form-control txtLabel hidden" />
                                                                <input type="text" name="txtitemlist1" id="serv_txtitemlist" runat="server" class="form-control txtLabel hidden" />
                                                                <div id="btnGetMaterial" class="input-group-addon" style="border-radius: 0px 3px 3px 0px; background-color: #3c8dbc; cursor: pointer;">
                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-calculations"></i></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                        <div class="row" style="bottom:0px">
                                                            <div class="col-md-12">
                                                            <%--<button type="button" id="btnGetStock_View" class="btn btn-sm btn-warning txtLabel pull-left"><strong><i class="icofont-download-alt"></i> ดึงข้อมูล</strong></button>--%>
                                                            <%--<button type="button" class="btn btn-sm btn-success txtLabel pull-right" id="btnPrintPdf"><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Print PDF</strong></button>--%>
                                                                <button type="button" class="btn btn-sm btn-warning txtLabel pull-right hidden" id="serv_btnPrintExcel1" runat="server" onserverclick="OnPrintExcel"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>Print PDF</button>
                                                            <button type="button" class="btn btn-sm btn-warning txtLabel pull-right hidden" id="serv_btnPrintPdf1" runat="server" onserverclick="OnPrintPDF"><i class="fa fa-file-pdf-o" aria-hidden="true"></i>Print PDF</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                            <div class="col-md-12 " id="DivDataStockNet" style="display:none">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4  classeDate" id="DiveDate1">
                                                            <div class="form-group">
                                                                <label for="" class="txtLabel">End : </label>
                                                                <div id="divRpt_eDate1">
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                        <input type="text" name="eDate1" id="eDate1" class="form-control txtLabel text-left textBoxinit " placeholder="yyyy-MM-dd" style="border-radius: 0px 3px 3px 0px" disabled />
                                                                        <input type="text" runat="server" id="serv_eDate1" class="hidden" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8" style="padding-top:2.5%">
                                                            <div class="form-">
                                                                <span class="pull-left">
                                                                    <span class="pull-left">
                                                                        <button type="button" id="btnGetStock_View" class="btn btn-sm btn-warning txtLabel pull-left"><strong><i class="icofont-download-alt"></i> แสดงข้อมูล</strong></button>
                                                                    </span>
                                                                </span>
                                                               
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                            <div class="col-md-12" id="DivDateMovement" style="display:none">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4  classeDate" id="DivsDate1x">
                                                            <div class="form-group">
                                                                <label for="" class="txtLabel">Start : </label>
                                                               
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                        <input type="text" name="sDate1" id="sDate1x" class="form-control txtLabel text-left textBoxinit " placeholder="yyyy-MM-dd" style="border-radius: 0px 3px 3px 0px" disabled />
                                                                        <%--<input type="text" runat="server" id="serv_sDext1x" class="hidden" />--%>
                                                                    </div>
                                                               
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4  classeDate" id="DiveDate1x">
                                                            <div class="form-group">
                                                                <label for="" class="txtLabel">End : </label>
                                                               
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                        <input type="text" name="sDate1" id="eDate1x" class="form-control txtLabel text-left textBoxinit " placeholder="yyyy-MM-dd" style="border-radius: 0px 3px 3px 0px" disabled />
                                                                        <%--<input type="text" runat="server" id="serv_eDate1x" class="hidden" />--%>
                                                                    </div>
                                                               
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4" style="padding-top:2.5%">
                                                            <div class="form-">
                                                                <span class="pull-left">
                                                                    <span class="pull-left">
                                                                        <button type="button" id="btnGetStock_Movement_View" class="btn btn-sm btn-warning txtLabel pull-left"><strong><i class="icofont-download-alt"></i> แสดงข้อมูล</strong></button>
                                                                    </span>
                                                                </span>
                                                               
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                                    <%--<div class="col-md-6">
                                                        <table class="table table-sm table-bordered table-hover table-condensed table-striped" id="tbl_GoodItem">
                                                            <thead class="txtLabel">
                                                                <tr>
                                                                    <th class="text-center">GoodCode</th>
                                                                    <th class="text-center">Goodname</th>
                                                                    <th class="text-center">#</th>

                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>--%>
                                                </div>
                                                <%--</div>--%>
                                                    
                                                    
                                                    
                                            
                                                
                                
                                                 
                                            
                                                
                                                    
                                            <div class="row">
                                                <div class="col-md-6" style="padding-top: 25px">
                                                        <div class="form-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left"></label>

                                                            
                                                           
                                                            <%--<input type="text" id="PrintType" class="hidden" runat="server"/>--%>
                                                            

                                                        </div>
                                                    </div>
                                            </div>  
                                                    
                                              
                                              </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row hidden">
            <div class="col-md-12">
                <div class="box box-primary" style="border-radius: 3px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_rpt_stocknet" style="cursor: pointer; border-radius: 5px; width: 100%">
                                <thead>
                                    <tr>
                                        <th>วันที่</th>
                                        <th>ชื่อโครงการ</th>
                                        <th>ชื่อลูกค้า</th>
                                        <th>ประเภทโครงการ</th>
                                        <th>จำนวนชุด</th>

                                        <th style="width: 20px">#</th>
                                        <th style="width: 20px">#</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row hidden">
            <div class="col-md-12">
                <div class="box box-primary" style="border-radius: 3px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_rpt_stockmovement" style="cursor: pointer; border-radius: 5px; width: 100%">
                                <thead>
                                    <tr>
                                        <th>วันที่</th>
                                        <th>ชื่อโครงการ</th>
                                        <th>ชื่อลูกค้า</th>
                                        <th>ประเภทโครงการ</th>
                                        <th>จำนวนชุด</th>

                                        <th style="width: 20px">#</th>
                                        <th style="width: 20px">#</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="modal_projsupplier" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการการรับวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_projsupplier" style="border-radius: 5px; width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="text-right" style="width: 70px; text-align: center">รหัสลูกค้า</th>
                                            <th class="text-center">ชื่อลูกค้า</th>
                                            <th class="text-center" style="width: 15px">#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 5px">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="modal_material" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-lg" style="border-radius: 5px;">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel "><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายการการรับวัตถุดิบ</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-sm table-bordered table-hover table-condensed table-striped" id="tbl_GoodItem" style="border-radius">
                                                            <thead class="txtLabel">
                                                                <tr>
                                                                    <th class="text-center">GoodCode</th>
                                                                    <th class="text-center">Goodname</th>
                                                                    <th class="text-center">#</th>

                                                                </tr>
                                                            </thead>
                                                        </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" style="border-radius: 3px" id="btnGetitemData"><strong><i class="fa fa-check-square-o" aria-hidden="true"></i> Get Itemlist</strong></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="modal_ViewStockNet" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-lg" style="border-radius: 5px;width:95%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " id="txtDateModalViewStock"><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายการวัตถุดิบคงเหลือ</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-sm table-bordered table-hover table-condensed table-striped" id="tbl_ViewStockNet" style="border-radius">
                                    <thead class="txtLabel">
                                        <tr>
                                            <th class="text-center">รายการ</th>
                                            <th class="text-center">วันที่เอกสาร</th>
                                            <th class="text-center">เลขที่เอกสาร</th>
                                            <th class="text-center">คำอธิบาย</th>
                                            <th class="text-center">คงเหลือ</th>
                                            <th class="text-center">ต้นทุน/หน่วย</th>
                                            <th class="text-center">ต้นทุน/รวม</th>

                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                        <%--<button type="button" class="btn btn-primary txtLabel" style="border-radius: 3px" id="btnGetitemData"><strong><i class="fa fa-check-square-o" aria-hidden="true"></i> Get Itemlist</strong></button>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="modal_ViewStockMovement" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-lg" style="border-radius: 5px;width:95%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " id="Model_StockMovement"></h4>
                            <%--<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายการเคลื่อนไหววัตถุดิบ</strong>--%>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="col-md-12">
                            <input type="text" runat="server" id="serv_sDate1x" class="hidden"/><input type="text" runat="server" id="serv_eDate1x" class="hidden"/><input type="text" runat="server" id="serv_TypeReport" class="hidden"/><button runat="server" id="serv_btn_pdf_rptmovement" onserverclick="OnPrint_StockMovement" class="hidden"></button><button runat="server" id="serv_btn_excel_rptmovement" class="hidden"></button>
                        </div>
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-sm table-bordered table-hover table-condensed table-striped" id="tbl_ViewStockmovement" style="border-radius">
                                    <thead class="txtLabel">
                                        <tr>
                                            <th class="text-center">รายการ</th>
                                            <th class="text-center">วันที่เอกสาร</th>
                                            <th class="text-center">เลขที่เอกสาร</th>
                                            <th class="text-center">คำอธิบาย</th>
                                            <th class="text-center">คงเหลือ</th>
                                            <th class="text-center">ต้นทุน/หน่วย</th>
                                            <th class="text-center">ต้นทุน/รวม</th>

                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                        <%--<button type="button" class="btn btn-primary txtLabel" style="border-radius: 3px" id="btnGetitemData"><strong><i class="fa fa-check-square-o" aria-hidden="true"></i> Get Itemlist</strong></button>--%>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>