<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="transaction_adjust.aspx.cs" Inherits="AmpelflowApp.xTransaction.transaction_adjust" %>

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
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
     <%--   <script defer src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.15.3/js/v4-shims.js"></script>--%>

        
        <style>
             #idGo:hover{
                background-color : #00a7d0 !important;
            }
            .swal2_modal{
                border-radius : 10px;
            }
            #idsGo:hover{
                background-color : #00a7d0 !important;
            }
            .Zebra_DatePicker_Icon_Wrapper{
                width:100%;
            }
            
           
            .bxbpdercolor {
                border-top-color :#00b4d8;
            }
            span.select2-selection__arrow{
                top:8px
            }
            .select2-container--default .select2-selection--single{
                
                height : 35px;
                border : 1px solid #ccc;
                margin-top : 3px
            }
            div.divAdjustDisabled {
                pointer-events: none;
                opacity: 0.7;
            }


            .select2-state-h7-container{
                margin-top : 0px
            }
            .select2-state-b8-container{
                margin-top:0px
            }

            input[type=search]{
                border-radius:5px;
            }

            table.dataTable tbody th, table.dataTable tbody td {
                    padding: 4px 10px; /* e.g. change 8x to 4px here */
            }

            [name="tbl_DisplaySheetAdjust_length"] {
                border-radius:3px 3px 3px 3px;
            }
            
            [name="tbl_DisplayPartAdjust_length"] {
                border-radius:3px 3px 3px 3px;
            }
        </style>
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

                ProgressOn();
                

                setTimeout(function(){


                    var aidCalGo = $('#aidCalGo');
                    aidCalGo.click(function () {
                        aCalamount();
                    })
                    aDisplay();
                    $('body').removeClass('overlay');

                    var btnGetTransac = $('#btnGetTransac');
                    btnGetTransac.click(function () {
                        //fnGetTransacRv();
                        //alert(1);
                        DisplaySheetAdjust();
                    })

                    var btnAdjSave = $('#btnAdjSave');
                    btnAdjSave.click(function () {
                        aSaveData();
                    })

                    var btn_Adjust_transacnewid = $('#btn_Adjust_transacnewid');
                    btn_Adjust_transacnewid.click(function () {

                        fn_GetAdjustCode();
                        $('#Modal_itemsadjust').modal('show');

                        $('#divAdjustDisabled').removeClass('divAdjustDisabled');
                        $('#btnGetTransac').css({ 'background-color': '#3C8DBC' })
                        $('#aidCalGo').css({ 'background-color': '#3C8DBC' })
                        
                    })



                    var btn_itemsgo = $('#itemsgo');
                    btn_itemsgo.click(function () {
                        fn_GetItemsAll();
                    })

                    var btnGetTransacList = $('#btnGetTransacList');
                    btnGetTransacList.click(function () {
                        fn_GetTransaction_list()
                    })

                    var btn_adjcalc = $('#btn_adjcalc');
                    btn_adjcalc.click(function () {
                        fn_adjCalc();
                    })

                    var btn_adjsave = $('#btn_adjsave');
                    btn_adjsave.click(function () {
                        
                        fn_validateSave();
                    })

                    ProgressOff();
                },1000)



                
            });

            

            function aClearInput() {
                $('#aMatr_itemname').val('');
                $('#aRef_id').val('');
                $('#aMatr_itemid').val('');
                $('#idsa').val('');
                $('#adocu_date').val('');
                $('#aQuantity').val('');
                $('#aAmount').val('');
                $('#aPriceperunnit').val('');
                $('#aRemark').val('');
                $('#aMatr_itemname').val('');
                $('#aMatr_itemid').val('');
                $('#amatr_sysCode').val('');
                $('#selecttransactype').val(1);
                $('#aQuantity').val('');
                $('#aAmount').val('');
                $('#aPriceperunnit').val('');
                $('#aRemark').val('');
                $('#aDate').val('');
            }

            function aDisplay() {
               
                    $.ajax({
                        //url: '../../xTransaction/Tst.Stock_Transaction_Inc.asmx/ststDisplaydata', ctstDisplaydata
                        url: '../../xTransaction/srv_transaction_adjust.asmx/DisplayAdjustAll',
                        method: 'post',
                        data: {
                            action: 'adjustDisplay'
                           
                        },
                        dataType: 'json',
                        success: function (data) {
                            if (data != '') {

                                
                                $('#tbl_adjustmaterial').DataTable().clear();
                                $('#tbl_adjustmaterial').DataTable().destroy();



                                var tbl_adjustmaterial = $('#tbl_adjustmaterial').DataTable({ 'ordering': false, 'scrollX': true });
                                $('[name="tbl_adjustmaterial_Length"]').select2();
                                tbl_adjustmaterial.clear();

                                $.each(data, function (i, item) {
                                    tbl_adjustmaterial.row.add([

                                        '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].doc_no+ '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].doc_date + '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodcode + '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + data[i].adjust_quantity + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                        //, '<div class="text-right txtLabel" style="padding-right:10px">' + numeral(data[i].adjust_quantity).format('0,0.00') + '</div>'
                                        //, '<div style="text-align: center;">' +
                                        //'<a href="javascript:void(0)" type="button"   onclick="aDisplaybyid(\'' + data[i].id + '\')" class="btn-group txtLabel" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 15px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                        //'</div>'
                                      
                                    ])
                                });

                                tbl_adjustmaterial.draw();
                            } else if (data == '') {
                               
                            }
                        }
                    })
                }
            
            function aDisplaybyid(atransacid) {
                $.ajax({
                    
                    url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/aDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'aDisplaybyid',
                        id : atransacid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#aMatr_itemname').val(data[i].goodname1);
                                $('#aRef_id').val(data[i].ref_id)
                                $('#aMatr_itemid').val(data[i].matr_code);
                                $('#idsa').val(data[i].id);
                                $('#adocu_date').val(data[i].docu_date);
                                $('#aQuantity').val(numeral(data[i].quantity).format('0,0.00'));
                                $('#aAmount').val(numeral(data[i].amount).format('0,0.00'));
                                $('#aPriceperunnit').val(numeral(data[i].priceperunit).format('0,0.00'));
                                $('#aRemark').val(data[i].remark);
                            });     

                        } else if (data == '') {
                            
                        }
                    }
                })
            }

            function directiontypeicon(transac_type)
            {
                //alert(transac_type);
                if (transac_type == 4) { return '<div class="text-center" data-toggle="tooltip" data-placement="right" title="Edit:จ่ายออก" ><i class="fa fa-chevron-left" aria-hidden="true" style="color:#e63946"></i></div>'}
                else if (transac_type == 5) { return '<div class="text-center" data-toggle="tooltip" data-placement="right" title="Edit:รับเข้า" ><i class="fa fa-chevron-left" aria-hidden="true" style="color:#16db93"></i></div>' }
            }

            function mdTransaction() {

                $.ajax({
                    //url: '../../xTransaction/Tst.Stock_Transaction_Inc.asmx/ststDisplaydata', ctstDisplaydata
                    url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/mda_Transaction',
                    method: 'post',
                    data: {
                        action: 'mdTransaction'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_atransaction').DataTable().clear();
                            $('#tbl_atransaction').DataTable().destroy();
                            var tbl_atransaction = $('#tbl_atransaction').DataTable({'ordering':false});

                            //var tbl_atransaction = $('#tbl_atransaction').DataTable({
                            //    'ordering':false,
                            //    'initComplete': function (settings, json) {
                            //        tbl_atransaction.columns.adjust().draw();
                            //    }
                            //});
                           
                            tbl_atransaction.clear();

                            $.each(data, function (i, item) {

                                tbl_atransaction.row.add([
                                    '<div>' + data[i].matr_code + '</div>'
                                    , '<div>' + data[i].goodname1 + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="mdTransactionbyid(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 15px;color:#f72585"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                   
                                ])
                            });

                            tbl_atransaction.draw();
                        } else if (data == '') {
                            alert(1);
                            tbl_atransaction.clear();
                            tbl_atransaction.destroy();
                            var tbl_atransaction = $('#tbl_atransaction').DataTable();
                            tbl_atransaction.clear();
                            tbl_atransaction.draw();
                        }
                    }
                })
                $('#mdTransaction').modal('show');
            }

            function mdTransactionbyid(goodid) {
                
                $.ajax({
                    //url: '../../xTransaction/Tst.Stock_Transaction_Inc.asmx/ststDisplaydata', ctstDisplaydata
                    url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/mda_Transactionbyid',
                    method: 'post',
                    data: {
                        action: 'mdTransactionbyid'
                        ,goodid : goodid

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('success 29');
                            

                            $.each(data, function (i, item) {
                                $('#aMatr_itemname').val(data[i].goodname1);
                                $('#aMatr_itemid').val(data[i].goodid);
                                //$('#aPriceperunnit').val(numeral(data[i].priceperunit).format('0,0.00'));
                               
                            });

                            $('#mdTransaction').modal('hide');
                        } else if (data == '') {
                            
                        }
                    }
                })
                $('#mdTransaction').modal('show');
            }

            function aCalamount() {
                var apricerperunit = $('#aPriceperunnit').val();
                var aquantity = $('#aQuantity').val();
                $('#aAmount').val(numeral(apricerperunit * aquantity).format('0,0.00'));

            }

            function fnGetTransacRv() {
                alert(1);
                $('#GetTransacRv').modal('show');
            }


            function DisplaySheetAdjust() {
                $('#GetTransacRv').modal('show');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/tbl_DisplaySheetAdjust',
                    method: 'post',
                    data: { action: 'tbl_DisplaySheetAdjust'},
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                        

                            //var tbl_DisplayPartAdjust = $('#tbl_DisplayPartAdjust').DataTable();
                            //$('#tbl_DisplaySheetAdjust').DataTable().clear();
                           

                            var tbl_DisplaySheetAdjust = $('#tbl_DisplaySheetAdjust').DataTable({
                                'ordering': false, drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }});
                            tbl_DisplaySheetAdjust.clear();

                            $.each(data, function (i, item) {
                                tbl_DisplaySheetAdjust.row.add([
                                    
                                    
                                     '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].DocDate + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].sys_doc_ref + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:10px">' + numeral(data[i].squantity).format('0,0.00') + '</div>'
                                    , '<div class="txtLabel" style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="DisplaySheetAdjustBySysCodeText(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="View:' + data[i].sys_doc_ref + '"  style="font-size: 15px;color:#18A558"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    
                                ])

                            });
                            tbl_DisplaySheetAdjust.draw();
                            
                            
                        } else if (data == '') {

                        }

                        $('#GetTransacRv').modal('show');
                    }
                })
            }
            function DisplaySheetAdjustBySysCode(sysCode) {
                $.ajax({
                    url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/DisplaySheetAdjustBySysCode',
                    method: 'post',
                    data: {
                        action: 'DisplaySheetAdjustBySysCode'
                        ,sysCode:sysCode
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $('#tbl_DisplayPartAdjust').DataTable().clear();
                            $('#tbl_DisplayPartAdjust').DataTable().destroy();

                            var tbl_DisplayPartAdjust = $('#tbl_DisplayPartAdjust').DataTable({
                                'ordering': false, 'ordering': false, drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                } });
                            tbl_DisplayPartAdjust.clear();
                            $.each(data, function (i, item) {
                                tbl_DisplayPartAdjust.row.add([

                                    '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].sys_doc_ref + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodnamei + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:10px">' + numeral(data[i].wd_quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:10px">' + numeral(data[i].rv_quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:10px">' + numeral(data[i].rema_quantity).format('0,0.00') + '</div>'
                                ])
                            });
                            tbl_DisplayPartAdjust.draw();
                            $('#GetTransacRv').modal('show');
                        } else if (data == '') {
                            Swal.fire({
                                icon: 'warning',
                                title: '<div class="txtLabel"><strong>[ แจ้งเตือน ] </strong></div>',
                                html: '<div class="txtLabel"><strong>Msg. : </strong><strong style="color:red">รายการเบิก Sheet ตามหมายเลข  ' + '<div style="color:green">' + sysCode + '</div>' + ' ทำรายการรับ Part เรียบร้อย</strong></div>'

                            })
                            $('#tbl_DisplayPartAdjust').DataTable().clear();
                            $('#tbl_DisplayPartAdjust').DataTable().destroy();
                            var tbl_DisplayPartAdjust = $('#tbl_DisplayPartAdjust').DataTable({ 'ordering': false });
                            tbl_DisplayPartAdjust.clear();

                        }
                    }
                })
            }
            function fnRmQuantity(rmQuantity) {
                if (rmQuantity > 0) {
                    $('#aQuantity').val(0 - rmQuantity);
                    $('#selecttransactype').val(4);
                    $('#selecttransactype').select2();
                
                } else if (rmQuantity < 0) {
                    $('#aQuantity').val(rmQuantity * (-1));
                    $('#selecttransactype').val(5);
                    $('#selecttransactype').select2();
                    
                 
                }
            }

            function DisplaySheetAdjustBySysCodeText(sysCode) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/DisplaySheetAdjustBySysCode',
                    method: 'post',
                    data: {
                        action: 'DisplaySheetAdjustBySysCode'
                        , sysCode: sysCode
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                            $.each(data, function (i, item) {
                                $('#aMatr_itemname').val(data[i].goodname);
                                $('#aMatr_itemid').val(data[i].goodid);
                                $('#amatr_sysCode').val(data[i].sys_doc_ref);
                                $('#aDate').val(currentdate2);
                                fnRmQuantity(data[i].DiffQuantityALL);                              
                                $('#aAmount').val('-');
                                $('#amatr_id').val();
                                $('#transaction_id').val(data[i].Transaction_id);
                                $('#aQuantity').val(data[i].Rema_quantity);
                            })

                            $('#GetTransacRv').modal('hide');
                        } else if (data == '') {
                            console.log('vv')
                        }
                    }
                })
            }

            function fn_GetItemsAll() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/GetItemsAll',
                    method: 'post',
                    data: {
                        action: 'GetItemsAll'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $('#tbl_GetitemsAll').DataTable().clear();
                            $('#tbl_GetitemsAll').DataTable().destroy();

                            var tbl_GetitemsAll = $('#tbl_GetitemsAll').DataTable({
                                'ordering': false, drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                } });
                            $('[name="tbl_GetitemsAll_length"]').select2();
                            tbl_GetitemsAll.clear();
                            $.each(data, function (i, item) {
                                tbl_GetitemsAll.row.add([

                                    '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetItemsAllById(\'' +  data[i].goodid +  '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="' + data[i].goodid + '"  style="font-size: 15px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodcode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                   
                                   
                                ])
                            });
                            tbl_GetitemsAll.draw();
                            $('#modal_GetitemsAll').modal('show');
                        } else if (data == '') {
                            
                            $('#tbl_GetitemsAll').DataTable().clear();
                            $('#tbl_GetitemsAll').DataTable().destroy();
                            var tbl_GetitemsAll = $('#tbl_GetitemsAll').DataTable({ 'ordering': false });
                            tbl_GetitemsAll.clear();
                            Swal.fire({
                                icon: 'warning',
                                title: '<div class="txtLabel"><strong>[ แจ้งเตือน ] </strong></div>',
                                html: '<div class="txtLabel"><strong>Msg. : </strong><strong style="color:red">รายการเบิก Sheet ตามหมายเลข  ' + '<div style="color:green">' + sysCode + '</div>' + ' ทำรายการรับ Part เรียบร้อย</strong></div>'

                            })
                            $('#modal_GetitemsAll').modal('show');

                        }
                    }
                })
            }
            function fn_GetItemsAllById(goodid) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/GetItemsAllById',
                    method: 'post',
                    data: {
                        action: 'GetItemsAllById'
                        ,goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                            $.each(data, function (i, item) {
                                $('#matr_itemsnametext').val(data[i].goodcode + ' | ' + data[i].goodname)
                                $('#matr_itemsname').val(data[i].goodname);
                                $('#matr_itemsid').val(data[i].goodid);
                            });
                           
                            $('#modal_GetitemsAll').modal('hide');
                        } else if (data == '') {

                           

                        }
                    }
                })
            }

            function fn_GetTransaction_list(goodid) {
                if ($('#matr_itemsid').val() == '') {
                    Swal.fire({
                        title: '<h4 class="txtLabel" style="color:#3fc3ee"><strong>[:ไม่มีรายการปรับปรุง]</strong></h4>',
                        icon: 'info',
                    })
                }
                else
                {
                    $.ajax({
                        url: '../../xTransaction/srv_transaction_adjust.asmx/GetTransaction_list',
                        method: 'post',
                        data: {
                            action: 'GetListAll'
                            , goodid: $('#matr_itemsid').val()
                        },
                        dataType: 'json',
                        success: function (data) {
                            if (data != '') {

                                $('#tbl_GetTransaction_LIst').DataTable().clear();
                                $('#tbl_GetTransaction_LIst').DataTable().destroy();
                                var tbl_GetTransaction_LIst = $('#tbl_GetTransaction_LIst').DataTable({
                                    'ordering': false, 'ordering': false, drawCallback: function (settings) {
                                        $('[data-toggle="tooltip"]').tooltip();
                                    } });
                                $('[name="tbl_GetTransaction_LIst_length"]').select2();

                                tbl_GetTransaction_LIst.clear();

                                $.each(data, function (i, item) {
                                    tbl_GetTransaction_LIst.row.add([

                                        '<div style="text-align: center;">' +
                                        '<a href="javascript:void(0)" type="button"   onclick="fn_GetTransaction_listByid(\'' + data[i].Transaction_id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="' + data[i].Transaction_id + '"  style="font-size: 15px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                        '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].DocDate + '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].doc_no + '</div>'
                                        , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].rv_quantity).format('0,0.00') + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].wd_quantity).format('0,0.00') + '</div>'
                                        , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].rema_quantity).format('0,0.00') + '</div>'


                                    ])
                                });
                                tbl_GetTransaction_LIst.draw();
                                $('#modal_GetTransaction_LIst').modal('show');
                            } else if (data == '') {



                            }
                        }
                    })
                }

                
            }

            function fn_GetTransaction_listByid(transac_id) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/GetTransaction_listById',
                    method: 'post',
                    data: {
                        action: 'GetListAllById'
                        , transac_id: transac_id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#matr_transacid').val(data[i].Transaction_id);
                                $('#matr_transacdocno').val(data[i].doc_no);
                                $('#matr_rmqty').val(data[i].rema_quantity);
                                $('#matr_rmperunit').val(data[i].priceperunit);
                                $('#matr_docdate').val(data[i].DocDate);
                                
                              

                            });
                            
                            $('#modal_GetTransaction_LIst').modal('hide');
                        } else if (data == '') {

                            Swal.fire({
                                icon: 'info',
                                title: '<div class="txtLabel" style="color:#3fc3ee"><strong>[:ไม่มีรายการคงเหลือ ] </strong></div>',
                               

                            })

                        }
                    }
                })
            }

            function fn_GetTransaction_listByid(transac_id) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/GetTransaction_listById',
                    method: 'post',
                    data: {
                        action: 'GetListAllById'
                        , transac_id: transac_id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#matr_transacid').val(data[i].Transaction_id);
                                $('#matr_transacdocno').val(data[i].doc_no);
                                $('#matr_rmqty').val(data[i].rema_quantity);
                                $('#matr_rmperunit').val(data[i].priceperunit);
                                $('#matr_docdate').val(data[i].DocDate);
                                $('#matr_adjustperunit').val(data[i].priceperunit);
                            });

                            $('#modal_GetTransaction_LIst').modal('hide');
                        } else if (data == '') {

                            Swal.fire({
                                icon: 'info',
                                title: '<div class="txtLabel" style="color:#3fc3ee"><strong>[:ไม่มีรายการคงเหลือ ] </strong></div>',


                            })

                        }
                    }
                })
            }

            function fn_GetAdjustCode() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/fn_GetAdjustCode',
                    method: 'post',
                    data: { action: 'GetAdj_itemsId' },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#matr_adjustcode').val(data[i].adjcode)
                                $('#matr_adjdate').val(currentdate2);
                            });

                            
                        } else if (data == '') {

                            Swal.fire({
                                icon: 'info',
                                title: '<div class="txtLabel" style="color:#3fc3ee"><strong>[:ไม่มีรายการคงเหลือ ] </strong></div>',


                            })

                        }
                    }
                })
            }

            function fn_adjCalc() {
                if ($('#matr_adjustqty').val() == '' || isNaN(parseFloat($('#matr_adjustqty').val())))
                {
                    Swal.fire({
                        icon: 'error', 
                        title: '<div class="txtLabel" style="color:#f27474"><strong>[:กรุณาใส่จำนวน ]</strong></div>',
                    })
                }
                else
                {
                    var adjqty = parseFloat($('#matr_adjustqty').val());
                    var rmqty = parseFloat($('#matr_rmqty').val());
                    
                    if (adjqty > rmqty) {
                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel" style="color:#f27474"><strong>[:กรุณาตรวจสอบจำนวนคงเหลือใน Lot]</strong></div>',
                        })
                    }
                    else
                    {
                        ProgressOn();
                        var qty = parseFloat($('#matr_adjustqty').val())
                        var perunit = parseFloat($('#matr_adjustperunit').val())
                        var amnt = qty * perunit

                        $('#matr_adjustamnt').val(numeral(amnt).format('0,0.0000'));
                        $('#btn_adjsave').prop('disabled',false);
                        ProgressOff();
                    }

                   
                }
                
            }

            function clearData() {
                $('#matr_itemsnametext').val('');
                $('#matr_itemsname').val('');
                $('#matr_itemsid').val('');
                $('#matr_transacdocno').val('');
                $('#matr_transacid').val('');
                $('#matr_rmqty').val('');
                $('#matr_rmperunit').val('');
                $('#matr_adjustcode').val('');
                $('#matr_adjdate').val('');
                $('#matr_adjustqty').val('');
                $('#matr_adjustperunit').val('');
                $('#matr_adjustamnt').val('');
                $('#matr_adjustremark').val('');

            }

        </script>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-md-12">

                    <div class="box box-primary" id="boxInput" style="border-radius: 5px">
                        <div class="box-header">
                            <div class="box-body">
                                <div class="user-block">
                                    <img src="../../Content/Icons/web512.png" alt="User Image">
                                    <span class="username">
                                        <a href="#" class="txtSecondHeader"><strong>Adjust Record : ปรับปรุง เพิ่ม - ลด วัตถุดิบ</strong></a>
                                    </span>
                                    <span class="description txtLabel">Monitoring progression of projects</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <!-- Custom Tabs -->
                                    <div class="nav-tabs-custom">
                                        <ul class="nav nav-tabs" id="matr_tab">
                                            <li class="active" style="border-radius:3px 3px 0px 0px "><a href="#tab_Coil" class="txtLabel" data-toggle="tab"><strong><i class="fa fa-reorder margin-r-5"></i> ปรับปรุงรายการวัตถุดิบ</strong></a></li>
                                            <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab_Coil">
                                                <div class="txtLabel" style="margin-bottom: 3px">
                                                    <a href="javascript:void(0)" class="pull-right" id="btn_Adjust_transacnewid"><strong><i class="fa fa-plus" style="font-size: 12px"></i> New</strong></a>
                                                </div>
                                                
                                                    <div class="col-md-12  jumbotron txtLabel" style="border-radius: 5px;">
                                                        Adjust : ปรับปรุงเพิ่มลดรายการวัตถุดิบ
                                                    </div>
                                                <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_adjustmaterial" style="cursor: pointer; border-radius: 5px; width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-center">เลขที่เอกสาร</th>
                                                <th class="text-center">วันที่เอกสาร</th>
                                                <th class="text-center">รหัสวัตถุดิบ</th>
                                                <th class="text-center">ชื่อวัตถุดิบ</th>
                                                <th class="text-center">จำนวน</th>
                                                <th class="text-center">ราคาต่อหน่วย</th>
                                                <th class="text-center">ยอดรวม</th>
                                                        </tr>
                                                    </thead>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                   

                                </div>
                            </div>
                           
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade " id="mdTransaction" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
                <div class="modal-dialog" style="border-bottom-left-radius: 20px;width:50%">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการปรับปรุงแผ่นชีส (ปรับปรุงจากการคำนวนระบบ)</h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_atransaction" style="border-radius: 5px;width:100%">
                                        <thead>
                                            <tr>
                                                <th class="text-center">เลขที่เอกสาร</th>
                                                <th class="text-center">วันที่เอกสาร</th>
                                                <th class="text-center">รหัสวัตถุดิบ</th>
                                                <th class="text-center">ชื่อวัตถุดิบ</th>
                                                <th class="text-center">จำนวน</th>
                                                <th class="text-center">ราคาต่อหน่วย</th>
                                                <th class="text-center">ยอดรวม</th>
                                                
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

            <div class="modal fade " id="GetTransacRv" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
                <div class="modal-dialog" style="width:50%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <%--<h4 class="modal-title txtHeader"><strong><i class="fab fa-accusoft"></i> รายการปรับปรุง : Sheet</strong></h4>--%>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการปรับปรุง : Sheet</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_DisplaySheetAdjust" style="border-radius: 5px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center txtLabel15Header">เลขที่อ้างอิง</th>
                                                <th class="text-center txtLabel15Header">วันที่</th>
                                                <th class="text-center txtLabel15Header">รหัสวัตถุดิบ</th>
                                                <th class="text-center txtLabel15Header">ชื่อวัตถุดิบ</th>
                                                <th class="text-center txtLabel15Header">จำนวน</th>
                                                <th class="text-center txtLabel15Header">ราคาต่อหน่วย</th>
                                                <th class="text-center txtLabel15Header">ยอดรวม</th>
                                                <th class="text-center txtLabel15Header" style="width:20px">จำนวนเบิก</th>
                                                <th class="text-center txtLabel15Header" style="width: 15px">#</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                            <%--<hr />
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_DisplayPartAdjust" style="border-radius: 5px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center txtLabel15Header">เลขที่ระบบ</th>
                                                <th class="text-center txtLabel15Header">รายการ</th>
                                                <th class="text-center txtLabel15Header">จำนวนทั้งหมด</th>
                                                <th class="text-center txtLabel15Header">จำนวนรับ</th>
                                                <th class="text-center txtLabel15Header">จำนวนคงค้าง</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </div>--%>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 5px">Close</button>
                            <button type="button" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 5px">Save changes</button>
                        </div>
                    </div>
                 
                </div>
                
            </div>

            <div class="modal fade " id="Modal_itemsadjust">
                <%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-md" style="border-bottom-left-radius: 5px; width: 60%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> ปรับปรุงรายการวัตถุดิบ </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row txtLabel">
                                <div class="col-md-12">
                                    <%--<div class="col-md-12" style="border: 1px solid #ccc!important; border-radius: 5px">--%>
                                        <div class="col-md-8">
                                            <div class="form-group " style="padding: 0px">
                                                <label for="matr_group" class="control-label txtLabel">วัตถุดิบ : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-fire" aria-hidden="true"></i>
                                                    </div>

                                                    <input type="text" name="matr_itemstext" id="matr_itemsnametext" class="form-control txtLabel text-right" disabled />
                                                    <input type="text" name="matr_itemsname" id="matr_itemsname" class="form-control txtLabel text-right hidden" disabled />
                                                    <input type="text" name="matr_itemsid" id="matr_itemsid" class="form-control txtLabel text-right hidden" />

                                                    <div id="itemsgo" data-toggle="tooltip" data-title="เลือกวัตถุดิบ" class="input-group-addon" style="border-radius: 0px 3px 3px 0px; background-color: #3c8dbc; cursor: pointer;">
                                                        <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="fa fa-th-list" aria-hidden="true"></i></label>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    <div class="col-md-4">
                                        <div class="form-group " style="padding: 0px">
                                            
                                            <label for="matr_group" class="control-label txtLabel">รายการปรับปรุง : </label>

                                            <div class="input-group">
                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                    <i class="fa fa-fire" aria-hidden="true"></i>
                                                </div>
                                                <input type="text" name="matr_goodname" id="matr_transacdocno" class="form-control txtLabel text-right" disabled />
                                                <input type="text" name="matr_goodid" id="matr_transacid" class="form-control txtLabel text-right hidden" />

                                                <div id="btnGetTransacList" data-toggle="tooltip" data-title="เลือกรายการ" class="input-group-addon" style="border-radius: 0px 3px 3px 0px; background-color: #3c8dbc; cursor: pointer;" >
                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="fa fa-th-list" aria-hidden="true"></i></label>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>

                            </div>

                            <div class="row txtLabel">
                                <div class="col-md-12">
                                    <%--<div class="col-md-12" style="border: 1px solid #ccc!important; border-radius: 5px">--%>
                                        <div class="col-md-4">
                                            <div class="form-group " style="padding: 0px">
                                                <label for="matr_group" class="control-label txtLabel">ยอดวัตถุดิบคงเหลือ (ตาม Lot) : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-fire" aria-hidden="true"></i>
                                                    </div>

                                                    <input type="text" name="matr_itemstext" id="matr_rmqty" class="form-control txtLabel text-right" disabled />
                                                   <div class="input-group-addon" style="border-top-right-radius: 5px; border-bottom-right-radius: 3px">
                                                                    <span class="txtLabel">หน่วย</span>
                                                                </div>

                                                </div>
                                            </div>

                                        </div>
                                    <div class="col-md-4">
                                        <div class="form-group " style="padding: 0px">
                                            
                                            <label for="matr_group" class="control-label txtLabel">ราคาต่อหน่วย : </label>

                                            <div class="input-group">
                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                    <i class="fa fa-fire" aria-hidden="true"></i>
                                                </div>
                                                <input type="text" name="matr_rmperunit" id="matr_rmperunit" class="form-control txtLabel text-right" disabled style="border-radius:0px 3px 3px 0px" />

                                            </div>
                                        </div>
                                        
                                    </div>
                                     <div class="col-md-4">
                                         <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">วันที่เอกสาร : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_rmperunit" id="matr_docdate" class="form-control txtLabel text-right" disabled />
                                                 <div class="input-group-addon" style="border-top-right-radius: 5px; border-bottom-right-radius: 3px">
                                                     <span class="txtLabel">บาท</span>
                                                 </div>
                                             </div>
                                         </div>
                                        
                                    </div>
                                </div>

                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                         <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">เลขที่รายการ : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_adjustcode" id="matr_adjustcode" class="form-control txtLabel text-right" disabled style="border-radius:0px 3px 3px 0px " />
                                                 
                                             </div>
                                         </div>
                                        
                                    </div>
                                    <div class="col-md-4">
                                        <label for="matr_group" class="control-label txtLabel">ประเภท : </label>
                                        <select id="select_adjusttype" class="txtLabel" style="width: 100%; text-align: justify; height: 80px;border:1px solid #d2d6de" name="state" >
                                                <option value="0"> --- เลือกวัตถุดิบ --- </option>
                                                <option value="4">ปรับปรุง รับเข้า</option>
                                                <option value="5">ปรับปรุง จ่ายออก</option>
                                               
                                            </select>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="matr_group" class="control-label txtLabel">วันที่ : </label>
                                            <div class="input-group">
                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" name="matr_adjdate" id="matr_adjdate" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                            </div>


                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                         <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">จำนวน : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_adjustqty" id="matr_adjustqty" class="form-control txtLabel text-right" />
                                                 <div id="btn_adjcalc" class="input-group-addon" style="border-radius:0px 3px 3px 0px;cursor:pointer;background-color: #3c8dbc;color: azure" >
                                                     <i class="fa fa-calculator" aria-hidden="true"></i>
                                                 </div>

                                             </div>
                                         </div>
                                        </div>
                                    <div class="col-md-4">
                                        <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">ราคาต่อหน่วย : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_adjustperunit" id="matr_adjustperunit" class="form-control txtLabel text-right" disabled style="border-radius:0px 3px 3px 0px " />
                                                 
                                             </div>
                                         </div>
                                    </div>
                                        <div class="col-md-4">
                                            <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">ยอดรวม : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_adjustamnt" id="matr_adjustamnt" class="form-control txtLabel text-right" disabled style="border-radius:0px 3px 3px 0px " />
                                                 
                                             </div>
                                         </div>
                                        </div>
                                        
                                        
                                    </div>
                                  
                                    
                                </div>
                            
                            
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <div class="form-group " style="padding: 0px">

                                             <label for="matr_group" class="control-label txtLabel">หมายเหตุ : </label>

                                             <div class="input-group">
                                                 <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                     <i class="fa fa-fire" aria-hidden="true"></i>
                                                 </div>
                                                 <input type="text" name="matr_adjustcode" id="matr_adjustremark" class="form-control txtLabel text-right" disabled style="border-radius:0px 3px 3px 0px " />
                                                 
                                             </div>
                                         </div>

                                    </div>
                                </div>
                            </div>
                            
                        </div>

                        <div class="modal-footer">
                            <div class="col-md-12">
                                <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                            <button type="button" class="btn btn-success pull-right txtLabel" id="btn_adjsave" style="border-radius: 3px" disabled><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</button> <%--//data-dismiss="modal" --%>
                            </div>
                            
                            
                        </div>
                    </div>

                </div>

            </div>

            
            <div class="modal fade " id="modal_GetitemsAll" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
                <div class="modal-dialog modal-lg" >
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <%--<h4 class="modal-title txtHeader"><strong><i class="fab fa-accusoft"></i> รายการปรับปรุง : Sheet</strong></h4>--%>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการปรับปรุง : Sheet</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_GetitemsAll" style="border-radius: 5px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center txtLabel15Header" style="width: 15px">#</th>
                                                <th class="text-center txtLabel15Header">รหัสวัตถุดิบ</th>
                                                <th class="text-center txtLabel15Header">ชื่อวัตถุดิบ</th>
                                                
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

            <div class="modal fade " id="modal_GetTransaction_LIst" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 5px">
                <div class="modal-dialog modal-lg" style="width:80%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <%--<h4 class="modal-title txtHeader"><strong><i class="fab fa-accusoft"></i> รายการปรับปรุง : Sheet</strong></h4>--%>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการปรับปรุง : Sheet</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_GetTransaction_LIst" style="border-radius: 5px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center txtLabel15Header" style="width: 15px">#</th>
                                                <th class="text-center txtLabel15Header">วันที่</th>
                                                <th class="text-center txtLabel15Header">เลขเอกสาร</th>
                                                <th class="text-center txtLabel15Header">รายการวัตถุดิบ</th>
                                                <th class="text-center txtLabel15Header">รายการรับ</th>
                                                <th class="text-center txtLabel15Header">ราคาต่อหน่วย</th>
                                                <th class="text-center txtLabel15Header">รายการจ่าย</th>
                                                <th class="text-center txtLabel15Header">คงเหลือ</th>
                                                
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


        </section>
    <script>
        function testt() {
            var day = 'yess';
            //var x = (day == "yes") ? "Good Day!" : (day == "no") ? "Good Night!" : "";
            var x = (day == "yes") ? "Good Day!" : "v";
            alert(x);
        }

        function validateComponent() {
            if ($('#amatr_sysCode').val() == '') {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ] </strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบรายการปรับปรุง</strong></div>'

                })
            } else {
                aSaveData();
            }
        }
        function aSaveData() {  //1 = Insert , 2 = Edit
            var aRemark = ($('#aRemark').val() == '') ? null : $('#aRemark').val();
            
            Swal.fire({
                title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></h3>',
                icon: 'question',
                showCancelButton: true,
                cancelButtonText: '<div class="txtLabel">Cancle</div>',
                confirmButtonColor: '#57cc99',
                cancelButtonColor: '#f94144',
                confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
            }).then((result) => {
                if (result.isConfirmed) {
                        $.ajax({
                            url: '../../xTransaction/srv_transaction_adjust.asmx/aInsert',
                            method: 'POST',
                            data: {
            
                                action: 'aInsert',
                                create_by: usr_name,
                                
                                ref_doc: $('#amatr_sysCode').val(),
                                transac_type: 5,
                                goodid: $('#aMatr_itemid').val(),
                                quantity: $('#aQuantity').val(),
                                remark: $('#aRemark').val()

                            },
                            dataType: 'json',
                            complete: function (data) {
                                if (data.statusText == 'OK') {
                                    //alert('success');
                                    Swal.fire({
                                        title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong>',
                                        icon: 'success',
                                        confirmButtonColor: '#57cc99',
                                        cancelButtonColor: '#f94144',
                                        confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                                    }).then((result) => {
                                        if (result.isConfirmed) {


                                            adjClearData();
                                            $('#Modal_itemsadjust').modal('hide');
                                           
                                          
                                        }
                                    })
                                } else if (data.statusText == 'error') {

                                    Swal.fire({
                                        icon: 'error',
                                        title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                                    })
                                }
                            }
                        });
                    


                }
            })

        }



        function insert_atransaction() {

            //alert($('#aRef_id').val() + '\n' + 
            //    $('#adocu_date').val() + '\n' + 
            //    $('#aMatr_itemid').val() + '\n' +
            //    $('#aQuantity').val() + '\n' + 
            //    $('#aPriceperunnit').val() + '\n' + 
            //    $('#aAmount').val() + '\n' + 
            //    $('#aRemark').val() 
            //    )
 

            $.ajax({
                url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/aInsert',
                method: 'POST',
                data: {
                    action: 'aInsert',
                    create_by: usr_name,
                    create_date: currentdate2,
                    isdelete: 'false',
                    isactive: 'true',

                    matr_status_flag: 0,
                    matr_transactype: $('#selecttransactype').val(),

                    ref_id: $('#aRef_id').val(),
                    doc_date: $('#adocu_date').val(),
                    matr_code: $('#aMatr_itemid').val(),
                    quantity: $('#aQuantity').val(),
                    priceperunit: $('#aPriceperunnit').val(),
                    amount: $('#aAmount').val(),
                    remark: $('#aRemark').val()


                },
                dataType: 'json',
                complete: function (data) {
                    if (data.statusText == 'success') {
                        //alert('success');
                        Swal.fire({
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">บันทึกข้อมูลเรียบร้อย...</h3>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                
                                //load table

                                aClearInput();
                                aDisplay();
                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                        })
                    }
                },
                error: function (err) {
                    console.log(err);
                }

            });
        }

        function update_atransaction(savetype)
        {
            $.ajax({
                url: '../../xTransaction/Tst.Stock_Adjust_srv.asmx/aUpdate',
                method: 'POST',
                data: {
                    
                    action: 'aUpdate',
                    id: savetype,
                    update_by: usr_name,
                    update_date: currentdate2,
                   

                    matr_status_flag: 0,
                    matr_transactype: $('#selecttransactype').val(),

                    ref_id: $('#aRef_id').val(),
                    doc_date: $('#adocu_date').val(),
                    matr_code: $('#aMatr_itemid').val(),
                    quantity: $('#aQuantity').val(),
                    priceperunit: $('#aPriceperunnit').val(),
                    amount: $('#aAmount').val(),
                    remark: $('#aRemark').val()


                },
                dataType: 'json',
                complete: function (data) {
                    if (data.statusText == 'success') {
                        //alert('success');
                        Swal.fire({
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">บันทึกข้อมูลเรียบร้อย...</h3>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                        }).then((result) => {
                            if (result.isConfirmed) {

                                //load table

                                aClearInput();
                                aDisplay();
                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                        })
                    }
                },
                error: function (err) {
                    console.log(err);
                }

            });
        }

        function fn_validateSave()
        {
           
            var adjtype = parseInt($('#select_adjusttype').val())
            console.log(typeof(adjtype));
            if (adjtype == 4) //out
            {
                alert(4);
                
            }
            else if (adjtype == 5) //in
            {
                
                fn_adjSvaeOut();
            }
            else if (adjtype == 0)
            {

            }
            
        }
        function fn_adjSaveIn()
        {
            $.ajax({
                url: '../../xTransaction/srv_transaction_adjust.asmx/aInsert',
                method: 'POST',
                data: {

                    action: 'aInsert',
                    create_by: usr_name,

                    ref_doc: $('#amatr_sysCode').val(),
                    transac_type: 5,
                    goodid: $('#aMatr_itemid').val(),
                    quantity: $('#aQuantity').val(),
                    remark: $('#aRemark').val()

                },
                dataType: 'json',
                complete: function (data) {
                    if (data.statusText == 'OK') {
                        //alert('success');
                        Swal.fire({
                            title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                        }).then((result) => {
                            if (result.isConfirmed) {


                                aDisplay();
                                aClearInput();


                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                        })
                    }
                }
            });
        }
        function fn_adjSvaeOut()
        {
            $.ajax({
                url: '../../xTransaction/srv_transaction_adjust.asmx/fn_adjSvaeOut',
                method: 'POST',
                data: {

                    action: 'adjSvaeOut'
                    ,create_by: usr_name
                    ,doc_no: $('#matr_adjustcode').val()
                    ,doc_date: $('#matr_adjdate').val()
                    , matr_code: $('#matr_itemsid').val()
                    , ref_id: $('#matr_transacid').val()
                    , transac_type: 4
                    , quantity: $('#matr_adjustqty').val()
                    , priceperunit: $('#matr_adjustperunit').val()
                    , amount: $('#matr_adjustamnt').val()
                    , remark: $('#matr_adjustremark').val()

                },
                dataType: 'json',
                complete: function (data) {
                    if (data.statusText == 'OK') {
                        alert('success');
                        console.log(data);
                        Swal.fire({
                            title: '<h3 class="txtLabel" style="color:#a5dc86"><strong>[บันทึกข้อมูลเรียบร้อย]</strong>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                        }).then((result) => {
                            if (result.isConfirmed) {


                                $().modal('hide')


                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                        })
                    }
                }
            });
        }
    </script>

    
</asp:Content>
