<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="report_cost.aspx.cs" Inherits="AmpelflowApp.xReporting.report_cost" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
       <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../Content/plugins/numeral.js"></script>
        <%--<script src="../../Content/plugins/FixedHeader-3.1.8/js/dataTables.fixedHeader.min.js"></script>
        <link href="../../Content/plugins/FixedHeader-3.1.8/css/fixedHeader.dataTables.min.css" rel="stylesheet" />--%>


       <%-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/dt-1.10.24/fh-3.1.8/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs/dt-1.10.24/fh-3.1.8/datatables.min.js"></script>--%>

       <%-- <script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/3.2.1/js/dataTables.fixedColumns.min.js"></script>--%>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs/jq-3.3.1/dt-1.10.24/fc-3.3.2/fh-3.1.8/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs/jq-3.3.1/dt-1.10.24/fc-3.3.2/fh-3.1.8/datatables.min.js"></script>



        <style>
            #idGo:hover {
                background-color: #00a7d0 !important;
            }

            .swal2_modal {
                border-radius: 10px;
            }

            #idsGo:hover {
                background-color: #00a7d0 !important;
            }

            .Zebra_DatePicker_Icon_Wrapper {
                width: 100%;
            }

            .nav-tabs-custom > .nav-tabs > li.active {
                border-top-color: #3c8dbc;
            }

            .bxbpdercolor {
                border-top-color: #3c8dbc;
            }

            .select2-container--default .select2-selection--single {
                padding-top: 3px;
                padding-bottom: 3px;
                height: auto;
                margin-top: 0px;
                border-radius : 3px;
            }

            .select2-state-h7-container {
                margin-top: 0px
            }

            .select2-state-b8-container {
                margin-top: 0px
            }

            input[type=search] {
                border-radius: 3px;
            }
           
            .label-padding{
                padding : 0px
            }

            .card {
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
                transition: all 0.2s ease-in-out;
                box-sizing: border-box;
                width: 100%;
                margin-top: 10px;
                margin-bottom: 10px;
                background-color: #FFF;
                border-radius: 5px 5px 5px 5px;
            }

                .card:hover {
                    box-shadow: 0 5px 5px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
                }

                .card > .card-inner {
                    padding: 10px;
                }

                .card .header h2, h3 {
                    margin-bottom: 0px;
                    margin-top: 0px;
                }

                .card .header {
                    margin-bottom: 5px;
                }

                .card img {
                    width: 100%;
                }


        </style>
         
        <script>
            var pcsperset;
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
                ProgressOn();

                setTimeout(function () {

                    //$('#txt_projtypeSelect').val(0).change();
                    $('#txt_projtypeSelect').select2("val", "0");
                    
                    $('#RptsDate').val(currentdate2);
                    $('#RpteDate').val(currentdate2);
                    //fnGettblrptCostProject();
                    //fnGetrpt_ProjectAll();


                    var btnGetDate = $('#btnGetDate')
                    btnGetDate.click(function () {
                        var strdate = $('[name="daterangepicker_start"]').val();
                        alert(strdate);
                    })


                    var btn_GetProject = $('#btn_GetProject')
                    btn_GetProject.click(function () {
                        tbl_project_rpt();
                    })


                    var btnProjSelect = $('#btnProjSelect');
                    btnProjSelect.click(function () {
                        //$('#mdlProjSelect').modal('show');
                    })

                    //var projtypeSelect = $('#txt_projtypeSelect');fnGettblrptCostProject
                    //projtypeSelect.change(function () {}


                    var btnGetData = $('#btnGetData');
                    btnGetData.click(function () {
                            

                        if ($('#txt_projtypeSelect').val() == '1' && $('#RptsDate').val() != '' && $('#RpteDate').val() != '') { //แยกตามโครงการ

                                $('#txtMainModal_CostPerProject').text('');
                                $('#txtMainModal_CostPerProject').html('<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนตามโครงการ : ระหว่างวันที่ <Label style="color:#a5dc86;text-decoration: underline">' + $('#RptsDate').val() + '</Label> ถึง <Label style="color:#a5dc86;text-decoration: underline">' + $('#RpteDate').val() + '</Label></strong>');

                            //fnGettblrptCostProject();
                                fnGetrpt_ProjectAll();

                                $('#modal_CostPerProj').modal('show')
                            }
                            else if ($('#txt_projtypeSelect').val() == '2' && $('#RptsDate').val() != '' && $('#RpteDate').val() != '') { //แยกตาม Inv
                                //txtMainmodal_CostPerInv
                                $('#txtMainmodal_CostPerInv').text('');
                                $('#txtMainmodal_CostPerInv').html('<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนแยกตาม Inv. : ระหว่างวันที่ <Label style="color:#a5dc86;text-decoration: underline">' + $('#RptsDate').val() + '</Label> ถึง <Label style="color:#a5dc86;text-decoration: underline">' + $('#RpteDate').val() + '</Label></strong>');

                                fnGettblrptCostProject()

                                $('#modal_CostPerInv').modal('show')
                            }
                            else if ($('#txt_projtypeSelect').find(':selected').val() == 0 || $('#RptsDate').val() == '' || $('#RpteDate').val() == '')
                            {
                            //alert($('#txt_projtypeSelect').find(':selected').val());
                                var strMsg='';
                                //alert(strMsg);

                                if ($('#txt_projtypeSelect').find(':selected').val() == 0)
                                {
                                    
                                    strMsg += '<div class="txtLabel pull-left"><i class="fa fa-times-circle-o" aria-hidden="true" style="color:#f27474"></i> กรุณาเลือกรายงาน</div>'
                                    
                                }
                                if ($('#RptsDate').val() == '' || $('#RpteDate').val() == '')
                                {
                                    strMsg += '<div class="txtLabel  pull-left"><i class="fa fa-times-circle-o" aria-hidden="true" style="color:#f27474"></i> กรุณาใส่ช่วงเวลารายงาน</div>'
                                    
                                }


                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel16" style="text-decoration:underline;color:#f27474"><strong>เกิดข้อผิดพลาด</strong></div>',
                                    html: strMsg,
                                    confirmButtonText: '<div class="txtLabel">OK</div>',
                                    confirmButtonColor: '#f27474'
                                    
                                })
                            }
                        })

                        $('#tblrptCostAll_filter').text('')
                        $('#tblrptCostAll_filter').html('<span class="btn-group" style="border-radius:2px">'
                            + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel" onclick="fnRptCostAll(\'Excel\')" data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                            + '<button type="button" class="btn btn-sm  btn-default  txtLabel "  id="btnPrintPdf" onclick="fnRptCostAll(\'Pdf\')" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                            + '</span >')

                        
                        $('#tblrptCostAllByprojid_filter').text('')
                        $('#tblrptCostAllByprojid_filter').html('<span class="btn-group" style="border-radius:2px">'
                            + '<button type="button" class="btn btn-sm btn-default  txtLabel " id="btnPrintExcel_job1" onclick="fnRptCost_job1(\'Excel\')" data-toggle="tooltip" title="Print Excel" style="background:transparent;color:green"><strong><i class="fa fa-file-excel-o" aria-hidden="true"></i></strong></button>'
                            + '<button type="button" class="btn btn-sm  btn-default  txtLabel "  id="btnPrintPdf_job1" onclick="fnRptCost_job1(\'Pdf\')" data-toggle="tooltip" title="Print PDF" style="background:transparent;color:red" ><strong><i class="fa fa-file-pdf-o" aria-hidden="true"></i></strong></button>'
                            + '</span >')


                  

                    $('body').removeClass('overlay');
                    ProgressOff();



                    $(document).on('show.bs.modal', '.modal', function () {
                        var zIndex = 1040 + (10 * $('.modal:visible').length);
                        $(this).css('z-index', zIndex);
                        setTimeout(function () {
                            $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                        }, 0);
                    });


                   

                    /*$('select option[value="0"]').attr("selected", true);*/
                }, 1000);

                

                ProgressOff();

            })

            function tbl_project_rpt() {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/Getproject_display',
                    method: 'post',
                    data: {
                        action: 'Getproject_display'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var tbl_project_rpt = $('#tbl_project_rpt').DataTable();
                            tbl_project_rpt.clear();
                            $.each(data, function (i, item) {
                                tbl_project_rpt.row.add([
                                    '<div class="text-center">' + data[i].projectdate + '</div>'
                                    , '<div class="text-center">' + data[i].projectname + '</div>'
                                    , '<div class="text-center">' + data[i].project_type_detail + '</div>'
                                    //, '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tbl_project_rptbyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].matr_goodid + '"  style="font-size: 13px;color:#e63946"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'


                                ])
                                tbl_project_rpt.draw();
                                $('#modal_project_rpt').modal('show');
                            });
                        } else {

                        }
                    }
                })
            }

            function tbl_project_rptbyid(id) {
                //alert(id);
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/Getproject_displaybyid',
                    method: 'post',
                    data: {
                        action: 'Getproject_displaybyid',
                        id : id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                            $.each(data, function (i, item) {
                                
                                $('#txtproject_name').val(data[i].projectname);
                                $('#txtproject_id').val(data[i].id)
                                
                            });
                            $('#modal_project_rpt').modal('hide');
                        } else {

                        }
                    }
                })
            }

            function vw_report_byproject() {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/vw_reportyproject',
                    method: 'post',
                    data: {
                        action: 'vw_report_byprojectbyid',
                        id: $('#txtproject_id').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('55555');
                            var tbl_allproject = $('#tbl_allproject').DataTable();
                            tbl_allproject.clear();
                            $.each(data, function (i, item) {
                                tbl_allproject.row.add([
                                    '<div class="text-center">' + data[i].projectdate + '</div>'
                                    , '<div class="text-left">' + data[i].goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].itempart_qty).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].itempart_costsheetperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].totalamnt).format('0,0.00') + '</div>'
                                ])
                                tbl_allproject.draw();
                            });
                        } else {
                            alert('vw_report_byproject()');
                        }
                    }
                })
            }

            function fnGettblProjSelect() {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/vw_reportyproject',
                    method: 'post',
                    data: {
                        action: 'vw_report_byprojectbyid',
                        id: $('#txtproject_id').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('55555');
                            var tbl_allproject = $('#tbl_allproject').DataTable();
                            tbl_allproject.clear();
                            $.each(data, function (i, item) {
                                tbl_allproject.row.add([
                                    '<div class="text-center">' + data[i].projectdate + '</div>'
                                    , '<div class="text-left">' + data[i].goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].itempart_qty).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].itempart_costsheetperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].totalamnt).format('0,0.00') + '</div>'
                                ])
                                tbl_allproject.draw();
                            });
                        } else {
                            alert('fnGettblProjSelect()');
                        }
                    }
                })
            }

            function fnGettblrptCostProject() {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/GettblrptCostProject',
                    method: 'post',
                    data: {
                        action: 'GettblrptCostProject'
                        , sDate: $('#RptsDate').val()
                        , eDate: $('#RpteDate').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                           //alert('55555');
                         
                            var tblrptCostProject = $('#tblrptCostProject').DataTable();


                            tblrptCostProject.clear();
                            $.each(data, function (i, item) {
                                tblrptCostProject.row.add([
                                    '<div class="text-center txtLabel" style="padding-left:5px">' + data[i].rown + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].CustName + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].projectname + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].invno + '</div>'
                                    , '<div class="text-right txtLabel">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGettblrptCostProjectAction(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].matr_goodid + '"  style="font-size: 13px;color:#e63946"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ])
                                tblrptCostProject.draw();
                            });
                        } else {

                            $('#tblrptCostProject').DataTable().clear();
                            $('#tblrptCostProject').DataTable().destroy();

                            var tblrptCostProject = $('#tblrptCostProject').DataTable({ 'ordering': false });
                            $('[name="tblrptCostProject_length"]').select2();

                            Swal.fire({
                                icon: 'warning',
                                title: '<div class="txtLabel16" style="text-decoration:underline;color:#f8bb86"><strong>ไม่มีรายการ</strong></div>',
                                confirmButtonText: '<div class="txtLabel">OK</div>',
                                confirmButtonColor: '#f8bb86'

                            })
                        }
                    }
                })
            }

            function fnGettblrptCostProjectAction(sys_doc_ref) {
                fnRemoveText();
                fnGettblrptCostProjectDetail(sys_doc_ref);
                fnGettblrptCostProjectByid(sys_doc_ref);
            }

            


            function fnGettblrptCostProjectDetail(sys_doc_ref) {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/GetProductCustDetail',
                    method: 'post',
                    data: {
                        action: 'GetProductCustDetail'
                        , sys_doc_ref: sys_doc_ref
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#CustName').text(':: ' + data[i].CustName);
                                $('#Address').text('ที่อยู่ : ' + data[i].Address);
                                $('#ProjectName').text('ชื่อโครงการ : ' + data[i].ProjectName);
                                $('#ProductName').text('ชื่อสินค้า : ' + data[i].goodname);
                                $('#Quantity').text('จำนวน : ' + numeral(data[i].quantity).format('0,0.00') + ' ชุด');
                                $('#Priceperunit').text('ราคาต่อหน่วย : ' + numeral(data[i].priceperunit).format('0,0.00') + ' บาท/หน่วย');
                                $('#Amount').text('ยอดรวม : ' + numeral(data[i].amount).format('0,0.00') + ' บาท');
                                document.getElementById("<%= txtSysdocCode.ClientID %>").value = sys_doc_ref;
                                



                            })
                        }
                    }
                })
            }

            function fnGettblrptCostProjectByid(sys_doc_ref) {
                //alert(sys_doc_ref);
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/GettblrptCostProjectByid',
                    method: 'post',
                    data: {
                        action: 'GettblrptCostProjectByid',
                        sys_doc_ref : sys_doc_ref
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('55555');

                            //$('#tblGetProjSelect').DataTable().clear();
                            //$('#tblGetProjSelect').DataTable().destroy();



                            var tblGetProjSelect = $('#tblGetProjSelect').DataTable();
                            tblGetProjSelect.clear();
                            $.each(data, function (i, item) {
                                tblGetProjSelect.row.add([
                                    '<div class="text-center txtLabel" >' + data[i].rown + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                ])
                                tblGetProjSelect.draw();
                            });
                            $('#mdlGetProjSelect').modal('show');
                        } else {
                            alert('fnGettblrptCostProjectByid');
                        }
                    }
                })
            }

            function fnGettbl_costproject_items(sys_doc_ref) {
               
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/GettblrptCostProjectByid',
                    method: 'post',
                    data: {
                        action: 'GettblrptCostProjectByid',
                        sys_doc_ref: sys_doc_ref
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            
                            console.log(data);

                            $('#tbl_costproject_items').DataTable().clear();
                            $('#tbl_costproject_items').DataTable().destroy();

                            var tbl_costproject_items = $('#tbl_costproject_items').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false, 'scrollX': false,'autoWidth' : false
                            });

                            $('[name="tbl_costproject_items_length"]').select2();

                            tbl_costproject_items.clear();

                            $.each(data, function (i, item) {
                                tbl_costproject_items.row.add([
                                    '<div class="text-center txtLabel" >' + data[i].rown + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                ])
                                tbl_costproject_items.draw();
                            });
                            $('#modal_costproject_items').modal('show');
                        } else {
                            alert('fnGettblrptCostProjectByid');
                        }
                    }
                })
            }


            function fnRemoveText() {
                $('#CustName').empty();
                $('#Address').empty();
                $('#ProjectName').empty();
                $('#ProductName').empty();
                $('#Quantity').empty();
                $('#Priceperunit').empty();
                $('#Amount').empty();
            }

            function fnPrintProject(PrintType) {
               
                document.getElementById("<%= txtPrintType.ClientID %>").value = PrintType;
                document.getElementById("<%= btnOnPrint.ClientID %>").click();
            }

            function fnGetrpt_ProjectAll() {
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/Getrpt_ProjectAll',
                    method: 'post',
                    data: {
                        action: 'rpt_ProjectAll'
                        ,sDate: $('#RptsDate').val()
                        , eDate: $('#RpteDate').val()

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            //alert(data.length);

                            $('#tblrptCostAll').DataTable().clear();
                            $('#tblrptCostAll').DataTable().destroy();

                            var tblrptCostAll = $('#tblrptCostAll').DataTable({ fixedHeader: true, 'scrollX': false, 'ordering': false, 'autoWidth': false });

                            tblrptCostAll.columns.adjust().fixedColumns().relayout();
                            $('[name=tblrptCostAll_length]').select2();
                            tblrptCostAll.clear();

                            $.each(data, function (i, item) {
                                tblrptCostAll.row.add([

                                     '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetrpt_ProjectAllByprojid(\'' + data[i].Projectid + '\',\'' + data[i].projectname + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].matr_goodid + '"  style="font-size: 13px;color:#e63946"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div class="text-left">' + data[i].CustName + '</div>'
                                    , '<div class="text-left">' + data[i].projectname + '</div>'
                                    , '<div class="text-left">' + data[i].project_type_detail + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantitymeter).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costspart).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costoption).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].swaste).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costpermeter).format('0,0.00') + '</div>'
                                   
                                ])
                                tblrptCostAll.draw();
                            });
                            
                            
                        } else {


                            $('#tblrptCostAll').DataTable().clear();
                            $('#tblrptCostAll').DataTable().destroy();
                            

                            var tblrptCostAll = $('#tblrptCostAll').DataTable({ fixedHeader: true, 'scrollX': false, 'ordering': false, 'autoWidth': false });
                            tblrptCostAll.columns.adjust().fixedColumns().relayout();
                            $('[name="tblrptCostAll_length"]').select2();



                            Swal.fire({
                                icon: 'warning',
                                title: '<div class="txtLabel16" style="text-decoration:underline;color:#f8bb86"><strong>ไม่มีรายการ</strong></div>',
                                confirmButtonText: '<div class="txtLabel">OK</div>',
                                confirmButtonColor: '#f8bb86'

                            })
                        }
                    }
                })
            }

            function fnGetrpt_ProjectAllByprojid(projectid, projectname) {

                ProgressOn();
              
                $.ajax({
                    url: '../../xReporting/srv_report_cost.asmx/Getrpt_ProjectAllByprojid',
                    method: 'post',
                    data: {
                        action: 'rpt_ProjectAllByprojid'
                        , projectid: projectid

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                           

                            var tblrptCostAllByprojid = $('#tblrptCostAllByprojid').DataTable();

                            tblrptCostAllByprojid.clear();
                            $('#txtProject_item').html('');
                            $('#txtProject_item').html('<strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนตามโครงการ : [ โครงการ : ' + data[0].projectname + ' ]</strong>');
                  

                            document.getElementById('<%= txtProjId.ClientID%>').value = projectid
                            document.getElementById('<%= txtProjname.ClientID %>').value = projectname
                           // $('#txtProjId').val(projectid);
                            //$('#txtProject_item').text('<strong>-</strong>');

                            $.each(data, function (i, item) {
                                tblrptCostAllByprojid.row.add([

                                    '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGettbl_costproject_items(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="View:' + data[i].sys_doc_ref + '"  style="font-size: 13px;color:#e63946"><i class="fa fa-search-plus" aria-hidden="true"></i></a>' +
                                    '</div>'
                                       
                                    ,'<div class="text-left">' + data[i].CustName + '</div>'
                                    , '<div class="text-left">' + data[i].projectname + '</div>'
                                    , '<div class="text-left">' + data[i].project_type_detail + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantitymeter).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costspart).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costoption).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].swaste).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].costpermeter).format('0,0.00') + '</div>'

                                ])
                                tblrptCostAllByprojid.draw();
                            });

                            $('#modal_CostPerProjByprojid').modal('show');
                            ProgressOff();
                        } else {
                            alert('fnGetrpt_ProjectAllByprojid');
                        }
                    }
                })
            }

            function fnRptCostAll(RptAllType) {
                //alert(RptAllType);
                alert($('[name=daterangepicker_start]').val());

                document.getElementById("<%= txtRptCostAllType.ClientID %>").value = RptAllType;
                document.getElementById("<%= btnRptCostAll.ClientID %>").click();

            }

            function fnRptCost_job1(RptAllType)
            {
                document.getElementById("<%= txtRptAllType_job1.ClientID %>").value = RptAllType;
                document.getElementById("<%= btnRptCost_job1.ClientID %>").click();
            }

            function fnRptCostAll1()
            {


            }

            

            

        </script>
    </section>
    <section class="content" style="padding-top:0px">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary" id="boxInput" style="border-radius: 3px">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="user-block">
                                <img src="../../Content/Icons/web512.png" alt="User Image">
                                <span class="username">
                                    <a href="#" class="txtSecondHeader"><strong>Cost Report : รายงานคำนวณต้นทุน</strong></a>
                                    <span class="pull-right">
                                            <button type="button" id="btnReload" name="btnReload" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="GetDataPageMenuAllReload()" data-toggle="tooltip" title="Reload">
                                                <i class="fa fa-refresh"></i>
                                            </button>
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="projectactionmd()" data-toggle="tooltip" title="New Project!" style="color:#57cc99;border-color:#57cc99;background-color:#fff";>
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group hidden">
                                                <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>
                                </span>
                                <span class="description txtLabel">Monitoring progression of projects</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab" >
                                        <li  class="active" style="border-radius:3px 3px 0"><a href="#tab_Sheet" class="txtLabel" id="tab_sheet" data-toggle="tab" ><strong><i class="fa fa-file-text-o" aria-hidden="true"></i> รายงานต้นทุน</strong></a></li>                                       
                                        <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <input type="text" class="hidden" id="txt_transaction_id"  name="name" value="" />
                                        <div class="tab-pane active" id="tab_Sheet">
                                            <div class="row" style="margin-left: 15px; margin-right: 15px">
                                                <div class="col-md-12  jumbotron txtLabel" style="border-radius: 5px;">
                                                    Cost Reports : รายงานต้นทุนสินค้า  
                                                </div>
                                            </div>
                                            <div class="row" style="padding-bottom:10px">
                                                <div class="col-md-12">
                                                     <div class="col-md-6">
                                                        <div class="formm-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left">เลือกรายงาน : </label>
                                                            <select id="txt_projtypeSelect" class="txtLabel" style="width: 100%; text-align: justify;" name="state">
                                                                   <option value="0" selected>Rpt - เลือกรายงาน</option>
                                                                   <option value="1">Rpt - แยกตามโครงการ</option>
                                                                   <option value="2">Rpt - แยกตาม Inv</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                  
                                                    
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label class="txtLabel"> Start Date:</label>

                                                            <div class="input-group">
                                                                <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                                    <i class="fa fa-calendar"></i>
                                                                </div>
                                                                <input type="text" class="form-control pull-right txtLabel" id="RptsDate" style="border-radius:0px 3px 3px 0px">
                                                            </div>
                                                            <!-- /.input group -->
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label class="txtLabel">End Date :</label>

                                                            <div class="input-group">
                                                                <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                                    <i class="fa fa-calendar"></i>
                                                                </div>
                                                                <input type="text" class="form-control pull-right txtLabel" id="RpteDate" style="border-radius:0px 3px 3px 0px">
                                                            </div>
                                                            <!-- /.input group -->
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6" style="padding-top: 25px">
                                                        <div class="form-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left"></label>
                                                            <%--<div class="btn btn-group pull-left" style="padding-top: 0px">--%>
                                                                <button type="button" id="btnGetData" class="btn btn-sm btn-warning txtLabel pull-left"><i class="icofont-download-alt"></i> ดึงข้อมูล</button>
                                                            <%--</div>--%>
                                                            <div class="btn btn-group  pull-right" style="padding: 0px">
                                                                <button type="button" class="btn btn-sm btn-success txtLabel pull-left hidden" id="btnPrintAllPdf" onclick="fnRptCostAll('Pdf')"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Print Pdf</button>
                                                                
                                                                <%--<input type="text" runat="server" name="txt_RptAllType" class="hidden" id="txtRptAllType" value=""/>--%>
                                                                <%--<button type="button" runat="server"  onserverclick="rptAllOnPrint" name="btnrptCostAll" id="btnrptCostAll" class="btn btn-warning txtLabel hidden"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>--%>
                                                                <%--<button type="button" class="btn btn-sm btn-success txtLabel pull-left hidden" id="btnPrintAllExcel"  onclick="fnRptCostAll('Excel')"><i class="fa fa-file-excel-o" aria-hidden="true"></i> Print Excel</button>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            

                                            <%--<div class="row" style="padding-bottom:10px">
                                                <div class="col-md-12">
                                                     <div class="col-md-6">
                                                        <div class="formm-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left">เลือกรายงาน : </label>
                                                            <select id="txt_projtypeSelect" class="txtLabel" style="width: 100%; text-align: justify;" name="state">
                                                                    <option value="1">Rpt แยกตามโครงการ</option>
                                                                    <option value="2">Rpt แยกตาม Inv</option>
                                                            </select>   
                                                        </div>
                                                    </div>
                                                  
                                                    <div class="col-md-6" style="padding-top: 25px">
                                                        <div class="form-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left"></label>
                                                            <div class="btn btn-group pull-left" style="padding-top: 0px">
                                                                <button type="button" class="btn btn-sm btn-warning txtLabel pull-right"><i class="icofont-download-alt"></i> ดึงข้อมูล</button>
                                                            </div>
                                                            <div class="btn btn-group  pull-right" style="padding: 0px">
                                                                <button type="button" class="btn btn-sm btn-success txtLabel pull-left" id="btnPrintAllPdf" onclick="fnRptCostAll('Pdf')"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Print Pdf</button>
                                                                
                                                                <input type="text" runat="server" name="txt_RptAllType" class="hidden" id="Text1" value=""/>
                                                                <button type="button" runat="server"  onserverclick="rptAllOnPrint" name="btnrptCostAll" id="Button1" class="btn btn-warning txtLabel hidden"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
                                                                <button type="button" class="btn btn-sm btn-success txtLabel pull-left" id="btnPrintAllExcel"  onclick="fnRptCostAll('Excel')"><i class="fa fa-file-excel-o" aria-hidden="true"></i> Print Excel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            
                                            <%--<div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left">เลือกโครงการ : </label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                                    <i class="fa fa-industry" aria-hidden="true"></i>
                                                                </div>
                                                                <input type="text" name="txt_Orderset" id="txt_Orderset" class="form-control txtLabel text-right" disabled />
                                                                <div id="btnorderset_calc" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; cursor: pointer; background-color: #00c0ef">
                                                                   
                                                                    <label id="btnProjSelect" class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6" style="padding-top: 25px">
                                                        <div class="form-group txtLabel">
                                                            <label for="matr_group" class="control-label txtLabel" style="text-align: left"></label>
                                                            <div class="btn btn-group pull-left" style="padding-top: 0px">
                                                                <button type="button" class="btn btn-sm btn-warning txtLabel pull-right">ดึงข้อมูล</button>
                                                            </div>
                                                            <div class="btn btn-group  pull-right" style="padding: 0px">
                                                                <button type="button" class="btn btn-sm btn-success txtLabel pull-left"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Print Pdf</button>
                                                                <button type="button" class="btn btn-sm btn-success txtLabel pull-left"><i class="fa fa-file-excel-o" aria-hidden="true"></i> Print Excel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <br />

                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body txtLabel">

                            <div class="col-md-4">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        
       
        

        <div class="modal fade " id="modal_project_rpt" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
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
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_project_rpt" style="border-radius: 3px;width:100%">
                                        <thead>
                                            <tr>
                                               
                                                
                                                <th class="text-center">เลขที่</th>
                                                <th class="text-center">ชื่อโครงการ</th>
                                                <th class="text-center">รูปแบบโครงการ</th>
                                                <th class="text-center" style="width:13px">#</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                            <button type="button" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                        </div>
                    </div>
                 
                </div>
                
            </div>


        <div class="modal fade " id="mdlProjSelect" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">เลือกโครงการ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                               <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tblProjSelect" style="border-radius:3px;width:100%;cursor:pointer">
                                <thead>
                                    <tr>
                                        <%--lotno,doc_ref,doc_no,matr_code ,mi.goodname,packingno,priceperunit,quantity--%>
                                        <th class="text-center">วันที่</th> <%--lotno--%>
                                        <th class="text-center">ชื่อลูกค้า</th>
                                        <th class="text-center">ชื่อโครงการ</th> <%--priceperunit--%>
                                        <th class="text-center">ชื่อสินค้า</th> <%--quantity--%>
                                        <th class="text-center">ยอดรวม</th>
                                        <th class="text-center">#</th>
                                    </tr>
                                    
                                </thead>
                                <tbody>
                                   
                                </tbody>
                                   <%--<tfoot>
                                       <tr>
                                           <th>SUM selected:</th>
                                           <th id="sum">0 </th>
                                           <th colspan="2" style="text-align: right">Total:</th>
                                           <th></th>
                                           <th></th>
                                       </tr>
                                   </tfoot>--%>
                            </table>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                        <button type="button" class="btn btn-primary pull-left txtLabel"  onclick="calsheetforpay()" style="border-radius: 3px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" onclick="getMultiGoodCode()" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="mdlGetProjSelect" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog modal-lg" style="width:95%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-radius:5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-atom"></i> รายการต้นทุนสินค้าและวัตถุดิบ</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div style="padding: 10px 10px 60px 10px">
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <h2 id="CustName" class="txtHeader"></h2>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <span class="btn-group">
                                                            <button type="button" class="btn btn-default btn-sm txtLabel" onclick="fnPrintProject('Pdf')" style="background-color:transparent;color:red"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
                                                            <button type="button" class="btn btn-default btn-sm txtLabel" onclick="fnPrintProject('Excel')" style="background-color:transparent;color:green"><i class="fa fa-file-excel-o" aria-hidden="true"></i></button>
                                                        </span>
                                                        
                                                    </div>
                                                </div>
                                                
                                                <h4 class="txtLabel16" id="Address"></h4>
                                                <h4 class="txtLabel16" id="ProjectName"></h4>
                                                <h4 class="txtLabel16" id="ProductName"></h4>
                                                <h4 class="txtLabel16" id="Quantity"></h4>
                                                <h4 class="txtLabel16" id="Priceperunit"></h4>
                                                <h4 class="txtLabel16" id="Amount"></h4>
                                                <input type="text" class="input-sm hidden" runat="server" name="txtPrintType" id="txtPrintType" />
                                                <input type="text" class="input-sm hidden" runat="server" name="txtSysdocCode" id="txtSysdocCode" />
                                                <br />
                                                 <div class="btn-group pull-right">
                                                    <%--<button type="button" class="btn btn-success txtLabel" onclick="fnPrintProject('Pdf')"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Print Pdf</button>
                                                    <button type="button" class="btn btn-success txtLabel" onclick="fnPrintProject('Excel')" style="border-radius:0px 3px 3px 0px"><i class="fa fa-file-excel-o" aria-hidden="true"></i> Print Excel</button>--%>
                                                    <button type="button" runat="server"  onserverclick="OnPrint" name="btnOnPrint" id="btnOnPrint" class="btn btn-warning txtLabel hidden"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
                                                </div>
                                                
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="col-md-6 txtLabel">
                                        <table class="table table-bordered table-striped table-condensed table-hover txtLabel table-sm" id="tblGetProjSelect" style="border-radius: 3px; width: 100%">
                                            <thead class="txtLabel">
                                                <tr>
                                                    <th>ลำดับ</th>
                                                    <th class="text-center">วันที่</th>
                                                    <th class="text-center" style="padding-left: 10px">รายการวัตถุดิบ</th>
                                                    <th class="text-center" style="padding-left: 10px">จำนวน</th>
                                                    <th class="text-center" style="padding-left: 10px">ราคาต่อหน่วย</th>
                                                    <th class="text-center" style="width: 13px; padding-left: 10px">จำนวนเงิน</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                          
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                            <button type="button" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                        </div>
                    </div>

                </div>

            </div>
        
        <div class="modal fade " id="modal_CostPerInv" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-md" style="border-radius: 5px;width:80%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " id="txtMainmodal_CostPerInv"><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนแยกตาม Inv.</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">

                        <div class="row">
                            <div class="col-md-12">
                                 <table class="table table-bordered table-striped txtLabel text-center table-hover table-sm" id="tblrptCostProject" style="cursor: pointer; border-radius: 3px; width: 100%">
                                <thead>
                                    <tr>
                                        <th>ลำดับ</th>
                                        <th>วันที่</th>
                                        <th>ชื่อลูกค้า</th>
                                        <th>ชื่อโครงการ</th>
                                        <th>Inv No.</th>
                                        <th>จำนวน</th>
                                        <th>ราคาต่อหน่วย</th>
                                        <th>ยอดรวม</th>
                                        <th style="width: 20px">#</th>
                                    </tr>
                                </thead>
                            </table>
                            </div>
                           
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                        <%--<button type="button" class="btn btn-primary txtLabel" style="border-radius: 3px" id="btnGetitemData"><strong><i class="fa fa-check-square-o" aria-hidden="true"></i> Get Itemlist</strong></button>--%>
                    </div>คิ
                </div>
            </div>
        </div>

        <div class="modal fade " id="modal_CostPerProj" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-lg" style="border-radius: 5px;width:95%">
                 <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " id="txtMainModal_CostPerProject"><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนตามโครงการ</strong></h4>                  
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12">
                                <button runat="server" class="pull-right" onserverclick="rptAllOnPrint" id="btnRptCostAll" hidden>btnRptCostAll</button>
                                <input type="text" class="pull-right" runat="server" id="txtRptCostAllType" hidden/>
                                
                            </div>
                            
                        </div>
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped txtLabel text-center table-hover table-sm" id="tblrptCostAll" style="cursor: pointer; border-radius: 3px">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>ลูกค้า</th>
                                            <th>โครงการ</th>
                                            <th>รูปแบบ</th>
                                            <th>จำนวนชุด</th>
                                            <th>จำนวนเมตร</th>
                                            <th>PartV1-V8</th>
                                            <th>Bolt,Nust,สกรู</th>
                                            <th>Sheet เสีย</th>
                                            <th>รวม</th>
                                            <th>ต้นทุน/ชุด</th>
                                            <th>ต้นทุน/เมตร</th>

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

        <div class="modal fade " id="modal_CostPerProjByprojid" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-lg" style="border-radius: 5px;width:95%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " id="txtProject_item"><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนตามโครงการ : </strong></h4>
                       
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">

                           
                            <div class="col-md-12 txtLabel">
                                 <input type="text" name="name" id="txtRptAllType_job1" runat="server" class="hidden"/>
                                 <input type="text" name="name" id="txtProjId" runat="server" class="hidden"/>
                                 <input type="text" id="txtProjname" runat="server" class="hidden"/>
                                 <button type="button" runat="server" id="btnRptCost_job1" onserverclick="rptCost_job1OnPrint" class="hidden">print pdf job1</button>
                                <table class="table table-bordered table-striped txtLabel text-center table-hover table-sm" id="tblrptCostAllByprojid" style="cursor: pointer; border-radius: 3px; width: 100%">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>ลูกค้า</th>
                                            <th>โครงการ</th>
                                            <th>รูปแบบ</th>
                                            <th>จำนวนชุด</th>
                                            <th>จำนวนเมตร</th>
                                            <th>PartV1-V8</th>
                                            <th>Bolt,Nust,สกรู</th>
                                            <th>Sheet เสีย</th>
                                            <th>รวม</th>
                                            <th>ต้นทุน/ชุด</th>
                                            <th>ต้นทุน/เมตร</th>

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

        <div class="modal fade " id="modal_costproject_items" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
            <div class="modal-dialog modal-md" style="border-radius: 5px;width:60%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel " ><strong><i class="fa fa-cubes" aria-hidden="true"></i> รายงาน : ต้นทุนตามโครงการ : </strong></h4>
                       
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">

                           
                            <div class="col-md-12 txtLabel">
                                 <input type="text" name="name" id="Text1" runat="server" class="hidden"/>
                                 <input type="text" name="name" id="Text2" runat="server" class="hidden"/>
                                 <input type="text" id="Text3" runat="server" class="hidden"/>
                                 <button type="button" runat="server" id="Button1" onserverclick="rptCost_job1OnPrint" class="hidden">print pdf job1</button>
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel table-sm" id="tbl_costproject_items" style="border-radius: 3px; width: 100%">
                                            <thead class="txtLabel">
                                                <tr>
                                                    <th>ลำดับ</th>
                                                    <th class="text-center">วันที่</th>
                                                    <th class="text-center" style="padding-left: 10px">รายการวัตถุดิบ</th>
                                                    <th class="text-center" style="padding-left: 10px">จำนวน</th>
                                                    <th class="text-center" style="padding-left: 10px">ราคาต่อหน่วย</th>
                                                    <th class="text-center" style="width: 13px; padding-left: 10px">จำนวนเงิน</th>
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
                      
                    </div>
                </div>
            </div>
        </div>

        

    </section>
</asp:Content>
