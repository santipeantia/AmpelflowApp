<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="transaction_in.aspx.cs" Inherits="AmpelflowApp.transaction_in" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <section class="content-header">
       <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../Content/plugins/jquery.dropselect.js"></script>
        <script src="../../Content/plugins/currency.min.js"></script>
        <script src="../../Content/plugins/numeral.js"></script>
        <%--<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>--%>

       <%-- <script defer src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.15.3/js/v4-shims.js"></script>--%>

        
       
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
                border-radius: 3px;
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

            .selectric-customOptions .ico {
                display: inline-block;
                vertical-align: middle;
                zoom: 1;
                *display: inline;
                height: 50px;
                width: 30px;
                margin: 0 6px 0 0;
                background: url(img/browser-icons.png) no-repeat;
            }

            div.odisabled {
                pointer-events: none;
                opacity: 0.7;
            }

            div.sdisabled {
                pointer-events: none;
                opacity: 0.7;
            }

            div.cdisabled {
                pointer-events: none;
                opacity: 0.7;
            }

            div.mdisabled {
                pointer-events: none;
                opacity: 0.7;
            }

            a.disabled {
                pointer-events: none;
                cursor: default;
                opacity: 0.7;
                color: lightgray;
            }

            div.scdisabled {
                pointer-events: none;
                opacity: 0.7;
            }


            .btnEnabled {
                background-color: #3c8dbc;
            }

            body.modal-open {
                height: 100vh;
                overflow-y: hidden;
            }

            .modal {
                overflow-y: auto;
            }

            
            

        </style>

        <script> //init component

           
            

       
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
            var partareax;

           


            $(document).ready(function () {

                ProgressOn();


               
                $(document).on('show.bs.modal', '.modal', function (event) {
                    var zIndex = 1040 + (10 * $('.modal:visible').length);
                    $(this).css('z-index', zIndex);
                    setTimeout(function () {
                        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                    }, 0);
                });


             


                setTimeout(function () {

                    //$('#obtitemgo').addClass('btnDisabled');

                    var btnnewentry = $('#newentry');
                    btnnewentry.click(function () {
                        $('#MdAddReceive').modal({ backdrop: false });
                        $('#MdAddReceive').modal('show');
                    })


                    var btnidsGo = $('#idsGo');
                    btnidsGo.click(function () {
                        $('#MdGetcRef').modal({ backdrop: true });
                        $('#MdGetcRef').modal('show');
                    })

                    $('#matr_tab').on("click", "li", function (event) {
                        var activeTab = $(this).find('a').attr('href');
                        if (activeTab == '#tab_Coil') {

                            $('#rb_tblCoil').fadeIn(500);
                            $('#rb_tblSheet').fadeOut(500);
                            $('#rb_tblPart').fadeOut(500);
                            $('#rb_mesh').fadeOut(500);
                            $('#rb_screw').fadeOut(500);
                        } else if (activeTab == '#tab_Sheet') {
                            $('#rb_tblSheet').fadeIn(500);
                            $('#rb_tblCoil').fadeOut(500);
                            $('#rb_tblPart').fadeOut(500);
                            $('#rb_mesh').fadeOut(500);
                            $('#rb_screw').fadeOut(500);
                        } else if (activeTab == '#tab_matroption') {
                            $('#rb_tblPart').fadeIn(200);
                            $('#rb_tblCoil').fadeOut(500);
                            $('#rb_tblSheet').fadeOut(500);
                            $('#rb_mesh').fadeOut(500);
                            $('#rb_screw').fadeOut(500);
                        } else if (activeTab == '#tab_matrmesh') {
                            $('#rb_mesh').fadeIn(500);
                            $('#rb_tblCoil').fadeOut(500);
                            $('#rb_tblSheet').fadeOut(500);
                            $('#rb_tblPart').fadeOut(500);
                            $('#rb_screw').fadeOut(500);
                        } else if (activeTab == '#tab_matrscrew') {
                            $('#rb_screw').fadeIn(500);
                            $('#rb_mesh').fadeOut(500);
                            $('#rb_tblCoil').fadeOut(500);
                            $('#rb_tblSheet').fadeOut(500);
                            $('#rb_tblPart').fadeOut(500);
                        }
                    });


                    var obtnsheetgo = $('#obtnsheetgo');
                    obtnsheetgo.click(function () {
                        modal_osref_display();

                    })

                    var obtitemgo = $('#obtitemgo');
                    obtitemgo.click(function () {
                        omatr_itempartrefsheet();

                        $('#md_omatr_mdsheetforpart_oDisplay').modal('show');

                    })

                    var obtnsheettransacgo = $('#obtnsheettransacgo');
                    obtnsheettransacgo.click(function () {
                        modal_matr_sheettransac();
                        $('#modal_matr_sheettransac').modal('show');
                    })

                    var btnmd_omatr_mdsheetforpart_oDisplay = $('#btnmd_omatr_mdsheetforpart_oDisplay');
                    btnmd_omatr_mdsheetforpart_oDisplay.click(function () {
                        omatr_itempartrefsheet();
                        $('#md_omatr_mdsheetforpart_oDisplay').modal('show');
                    })

                    $('body').removeClass('overlay');

                    var btn_otransacnewid = $('#btn_otransacnewid');
                    btn_otransacnewid.click(function () {

                        $('#obtitemgo').addClass('btnEnabled');
                        fn_otransacnewid_check();
                        $('#odocu_date').val(currentdate2);
                        $('#modal_RvPart').modal('show');
                    })

                    var btn_ctransacnewid = $('#btn_ctransacnewid');
                    btn_ctransacnewid.click(function () {
                        setTimeout(function () {

                            fn_GetRv_coils_lastid();
                            $('#matr_date').val(currentdate2);
                            $('body').removeClass('overlay');

                            $('#txtMsgRemark').text('');
                            $('#modal_RvCoils').modal('show');
                        });

                    })

                    var btn_stransacnewid = $('#btn_stransacnewid');
                    btn_stransacnewid.click(function () {
                        fn_GetRv_sheet_lastid();
                        $('#modal_RvSheet').modal('show');
                    })

                    var btn_mGetlastid = $('#btn_mGetlastid');
                    btn_mGetlastid.click(function () {
                        fn_GetRv_mesh_lastid();
                    })

                    var mesh_itemgo = $('#mesh_itemgo');
                    mesh_itemgo.click(function () {
                        $('#modal_mesh_transac').modal('show');
                    })


                    var select_optionwsp = $('#select_optionwsp');
                    select_optionwsp.change(function () {
                        fn_select_optionwsp();
                    })


                    var btn_GetScrewNewID = $('#btn_GetScrewNewID');
                    btn_GetScrewNewID.click(function () {
                        GetScrewNewID();

                        $('#modal_rvscrew').modal('show');
                    })

                    var screw_itemgo = $('#screw_itemgo');
                    screw_itemgo.click(function () {
                        fn_GetScrewsDisplay();
                    })
                    //fn_GetMesh_dataWspDisplay();

                    var screw_Getamntgo = $('#screw_Getamntgo')
                    screw_Getamntgo.click(function () {
                        fn_GetAmountCalc();
                    })



                    var widGo = $('#widGo');
                    widGo.click(function () {
                        fn_GetwireItems();
                    })

                    var widCalcGo = $('#widCalcGo');
                    widCalcGo.click(function () {
                        fn_wireCalc();
                    })

                    fn_GetMeshDisplay();
                    fn_GetScrewDisplay();
                    tsttblDisplayCoil();
                    tsttblDisplaySheet();
                    fn_GetScrewDisplay()
                    oDisplay();

                    
                    $('body').removeClass('overlay');
                    ProgressOff();

                }, 1000);

            })

            function display_Supplier() {

                var value = $('#supplier-selected').dropselect('value');
                //alert('value:' + value);
            }

            function tsttblDisplayCoil() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ctstDisplaydata',
                    method: 'post',
                    data: {
                        action: 'cDisplay',
                        matr_flag_group: 1
                    },
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                        if (data != '') {

                            $('#tbl_matr_receive_coil').DataTable().clear();
                            $('#tbl_matr_receive_coil').DataTable().destroy();

                            var tbl_matr_receive_coil = $('#tbl_matr_receive_coil').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false
                            });
                            $('[name=tbl_matr_receive_coil_length]').select2();
                            tbl_matr_receive_coil.clear();

                            $.each(data, function (i, item) {
                                tbl_matr_receive_coil.row.add([
                                    coilcheckstatus(data[i].matr_status_flag)
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].doc_ref + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].vendorname + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].goodname1.substring(0,22) + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstcDisplaybyid(\'' + data[i].id + '\',\'' + data[i].matr_status_flag + '\')" class="btn-group checkbox-toggle" data-toggle="tooltip" data-placement="top" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ])
                            });

                            tbl_matr_receive_coil.draw();

                            tbl_matr_receive_coil.$('tr').tooltip({
                                placement: '',
                                html: true
                            });

                        } else {
                            console.log('Else no data')
                            var tbl_matr_receive_coil = $('#tbl_matr_receive_coil').DataTable();
                            tbl_matr_receive_coil.clear();
                            tbl_matr_receive_coil.draw();
                        }
                    }
                })
            }

            function tstcDisplaybyid(cid, flag_status) {
               
                
                tstclearinput();
                ProgressOn();
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ctstDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'cDisplaybyid',
                        matr_flag_group: 1,
                        id: cid
                    },
                    dataType: 'json',
                    success: function (data) {
                        var coilcode;
                        if (data != '') {
                            $('#cid').val(cid);
                            $.each(data, function (i, item) {
                                if (flag_status == 'true') { // มีการทำรับ Sheet เข้ามาแล้ว
                                   
                                    $('#txt_csys_doc_ref').val(data[i].doc_ref);
                                    $('#matr_refno').val(data[i].doc_ref);
                                    
                                    $('#matr_date').val(data[i].doc_date);

                                    $('#selectedsupplier').val(data[i].supplier_code);
                                    $('#selectedsupplier').select2();

                                    $('#selectedcoils').val(data[i].matr_code);
                                    $('#selectedcoils').select2();

                                    $('#matr_qty').val(numeral(data[i].quantity).format('0,0.00'));
                                    $('#matr_amnt').val(numeral(data[i].amount).format('0,0.0000'));
                                    $('#matr_perunit').val(numeral(data[i].priceperunit).format('0,0.0000'));
                                    $('#matr_remark').val(data[i].remark);

                                    $('#matr_refno').prop('disabled', true);
                                    $('#matr_date').prop('disabled', true);
                                    $('#selectedsupplier').prop('disabled', true);
                                    $('#selectedcoils').prop('disabled', true);
                                    $('#matr_qty').prop('disabled', true);
                                    $('#matr_amnt').prop('disabled', true);
                                    $('#matr_perunit').prop('disabled', true);
                                    $('#matr_remark').prop('disabled', true);


                                    //$('#idGo').prop('disabled', false);
                                    //$('#idGo').css({ 'background': '#3c8dbc' });
                                    $('#idGo').addClass('cdisabled');
                                    $('#idGo').css('background-color', '#d6d6d6');


                                    $('#btnCoilSave').prop('disabled', true);
                                    $('#btnCoilSave').css('background-color', '#d6d6d6');
                                    $('#btnCoilSave').css('border-color', '#d6d6d6');

                                    $('#txtMsgRemark').text('***ไม่สามารถแก้ไขได้ เนื่องจาก มีการรับ Sheet แล้ว')
                                    $('#txtMsgRemark').css('color','#f94144')

                              

                                } else if (flag_status == 'false') { //ยังไม่มีการทำรับ Sheet เข้ามา
                                    $('#txt_csys_doc_ref').val(data[i].doc_ref);
                                    $('#matr_refno').val(data[i].doc_ref);
                                    $('#matr_date').val(data[i].doc_date);

                                    $('#selectedsupplier').val(data[i].supplier_code);
                                    $('#selectedsupplier').select2();

                                    $('#selectedcoils').val(data[i].matr_code);
                                    $('#selectedcoils').select2();

                                    $('#matr_qty').val(numeral(data[i].quantity).format('0,0.00'));
                                    $('#matr_amnt').val(numeral(data[i].amount).format('0,0.0000'));
                                    $('#matr_perunit').val(numeral(data[i].priceperunit).format('0,0.0000'));
                                    $('#matr_remark').val(data[i].remark);

                                    $('#matr_date').prop('disabled', false);
                                    $('#matr_refno').prop('disabled', false);
                                    $('#selectedsupplier').prop('disabled', false);
                                    $('#selectedcoils').prop('disabled', false);
                                    $('#matr_qty').prop('disabled', false);
                                    $('#matr_amnt').prop('disabled', false);
                                    $('#matr_perunit').prop('disabled', false);
                                    $('#matr_remark').prop('disabled', false);

                                    $('#txtMsgRemark').text('');
                                    $('#idGo').removeClass('cdisabled');
                                    $('#idGo').css({ 'background': '#3c8dbc' });


                                }
                                


                               
                               

                                ProgressOff();
                            });

                            $('#divcDisabled').removeClass('cdisabled');
                           

                            $('#modal_RvCoils').modal('show');

                        }
                    }
                })
            }

            function tstcPrint(cid) {
                alert('Printed : ' + cid);
            }

            function tstclearinput() {

                $('#matr_qty').val('');
                $('#cid').val('');
                $('#matr_refno').val('');
                $('#matr_date').val('');
                //$('#coil-selected').dropselect('select', 0)

                $('#coil-selected').val(0);
                $('#coil-selected').select2();


               // $('#supplier-selected').dropselect('select', 0)
                $('#supplier-selected').val(0);
                $('#supplier-selected').select2();

                $('#matr_amnt').val('');
                $('#matr_perunit').val('');
                $('#matr_remark').val('');
                $('#smatr_CoilRefid').val('')
                $('#smatr_CoilRef').val('')
                $('#smatr_CoilAmnt').val('')
                $('#smatr_CoilAmnt1').val('')
                $('#smatr_packno').val('')
                $('#smatr_date').val('')
                //$('#s-supplier-selected').dropselect('select', 0)

                $('#s-supplier-selected').val(0);
                $('#s-supplier-selected').select2();



                //$('#s-Sheet-selected').dropselect('select', 0)
                $('#s-Sheet-selected').val(0);
                $('#s-Sheet-selected').select2();

                $('#smatr_qty').val('')
                $('#smatr_service').val('')
                $('#smatr_perunit').val('')
                $('#smatr_remark').val('')
                $('#out_cref').val('');
                $('#out_cmatr_code').val('');
                $('#out_cqty').val('');
                $('#out_camnt').val('');
                $('#out_cpunit').val('');
                $('#sdocu_no').val('');
                $('#priceperunit').val('');
                $('#selectedsupplier').select2('destroy');
                $('#selectedsupplier').val('');
                $('#selectedsupplier').select2();
                $('#selectedcoils').val('');
                $('#selectedcoils').select2();
                $('#costservice').val('');
                $('#sid').val('');
                $('#selectedsuppliersheet').val('');
                $('#selectedsuppliersheet').select2();
                $('#selectedsheet').val('');
                $('#selectedsheet').select2();
                $('#samount').val('');
                $('#txtitem_goodname').val('');
                $('#txtitem_goodcode').val('');
                $('#txtitem_partarea').val('');
                $('#odocu_no').val('');
                $('#txtrefs_detail').val('');
                $('#txtrefs_id').val('');
                $('#txtrefs_smatr_code').val('');
                $('#txtrefs_priceperunit').val('');
                $('#odocu_date').val('');
                $('#oQuantity').val('');
                $('#oCostservice').val('');
                $('#oPriceperunits').val('');
                $('#oRemark').val('');
                $('#sref_Oqty').val('');
                $('#txt_sysdoccode').val('');
                $('#oid').val('');
                $('#txtitem_sheetout_id').val('');
                $('#txtitem_sys_doc_ref').val('');
                $('#txtitem_priceperunit').val('');
                $('#oamount').val('');
                $('#txt_csys_doc_ref').val('');
                $('#txt_ssys_doc_ref').val('');
                $('#txtm_DocuDate').val('');
                $('#txtm_GoodID').val('');
                $('#txtm_priceperunit').val('');
                $('#txtm_GoodQty2').val('');
                $('#txtm_GoodQtyPcs').val('');
                $('#txtm_GoodPrice2').val('');
                $('#txtm_GoodAmnt').val('');
                $('#txtm_GoodName').val('');
                $('#txtm_InvNo').val('');
                $('#txtm_VendorID').val('');
                $('#txtm_VendorName').val('');
                $('#txt_CalcsheetAmnt').val('');
                $('#txt_v3id').val('');
                $('#txt_v3').val('');
                $('#txtsc_GoodName').val('');
                $('#txtsc_sys_code').val('');
                $('#txtsc_GoodID').val('');
                $('#txtsc_InvNo').val('');
                $('#txtsc_DocuDate').val('');
                $('#txtsc_qty').val('');
                $('#txtsc_priceperunit').val('');
                $('#txtsc_amnt').val('');
                $('#txtsc_Remark').val('');
                $('#txtitem_sheetpriceperunit').val('');
                $('#txtitem_rvremaining').val('');
                $('#txtitem_v7inc').val('');
                $('#txt_sysdoccode').val('')
                $('#txt_CalcsheetAmnt_rema').val('');
                $('#txtid_checkEdit').val('')
                $('#wmatr_goodname').val('');
                $('#wmatr_goodid').val('');
                $('#txt_wirelength_amnt').val('');
                $('#txt_CalcwireAmnt').val('');
                $('#txtitem_sheetid').val('');
                $('#txtitem_rmsheet').val('');
                $('#txtitem_rowCount').val('');

            }

            function tsttblDisplayCoilMd() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ctstDisplaydatamd',
                    method: 'post',
                    data: {
                        action: 'cDisplaymd',
                        matr_flag_group: 1,
                        matr_status_flag: 'false'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                           


                            var smatr_crefmd = $('#smatr_crefmd').DataTable();
                            smatr_crefmd.clear();
                            $.each(data, function (i, item) {
                                smatr_crefmd.row.add([
                                    '<div class="text-left txtLabel" style="padding-left:5px" >' + data[i].doc_date + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px" >' + data[i].doc_ref + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstsDisplaybyidmd(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 12px;color:#e76f51"><i class="fa fa-check-circle-o" aria-hidden="true"></i></i></a>' +
                                    '</div>'

                                ])
                            });

                            smatr_crefmd.draw();
                        } else if (data == '') {
                            var smatr_crefmd = $('#smatr_crefmd').DataTable();
                            smatr_crefmd.clear();
                            smatr_crefmd.draw();
                        }
                    }
                })
            }

            function tstsDisplaybyidmd(cid) {
                var camnt;

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ctstDisplaybyidmd',
                    method: 'post',
                    data: {
                        action: 'cdisplaybyidmd',
                        matr_flag_group: 1,
                        id: cid
                    },
                    dataType: 'json',
                    success: function (data) {
                        var coilcode;
                        if (data != '') {
                            $('#cid').val(cid);
                            $.each(data, function (i, item) {
                                $('#smatr_CoilRef').val(data[i].doc_ref);
                                $('#smatr_CoilAmnt').val(numeral(data[i].amount).format('0,0.0000'));
                                $('#smatr_CoilAmnt1').val(data[i].amount);
                                $('#smatr_CoilRefid').val(data[i].id);
                                $('#out_cref').val(data[i].doc_ref);
                                $('#out_cmatr_code').val(data[i].matr_code);
                                $('#out_cqty').val(data[i].quantity)
                                $('#out_camnt').val(data[i].amount)
                                $('#out_cpunit').val(data[i].priceperunit)


                            });
                            $('#MdGetcRef').modal({ backdrop: true });
                            $('#MdGetcRef').modal('hide');

                        }
                    }
                })
            }

            function coilcheckstatus(cstatus) {
                if (cstatus == true) {
                    return '<div><i class="fa fa-check checkbox-toggle" data-toggle="tooltip" title="Complete" style="color:#06d6a0"></i></div>'
                } else if (cstatus == false) {
                    return '<div><i class="fa fa-minus checkbox-toggle" data-toggle="tooltip" title="Work In Process" aria-hidden="true"  style="color:#d62828"></i></div>'
                } else { }

            }

            function scalPerUnit() {
                var camnt, sheetservice, sQty;
                var sPerUnit;


                if ($('#smatr_qty').val() == '' && $('#costservice').val() == '' && $('#smatr_CoilAmnt').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนแผ่นชีส,ค่าบริการตัดซอย,รายการ Coils อ้างอิง</strong></div>'

                    })

                }
                else if ($('#smatr_qty').val() == '' && $('#costservice').val() != '' && $('#smatr_CoilAmnt').val() != '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนแผ่นชีส</strong></div>'

                    })

                }
                else if ($('#smatr_qty').val() != '' && $('#costservice').val() == '' && $('#smatr_CoilAmnt').val() != '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบค่าบริการตัดซอย</strong></div>'

                    })

                }

                else if ($('#smatr_qty').val() != '' && $('#costservice').val() != '' && $('#smatr_CoilAmnt').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบรายการ Coils อ้างอิง</strong></div>'

                    })

                }

                else if ($('#smatr_qty').val() != '' && $('#costservice').val() == '' && $('#smatr_CoilAmnt').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบค่าบริการตัดซอยและรายการ Coils อ้างอิง</strong></div>'

                    })

                }

                else if ($('#smatr_qty').val() == '' && $('#costservice').val() != '' && $('#smatr_CoilAmnt').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนแผ่นชีสและรายการ Coils อ้างอิง</strong></div>'

                    })

                }

                else if ($('#smatr_qty').val() == '' && $('#costservice').val() == '' && $('#smatr_CoilAmnt').val() != '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนแผ่นชีสและค่าบริการตัดซอย</strong></div>'

                    })

                }
                else if ($('#smatr_qty').val() != '' && $('#costservice').val() != '' && $('#smatr_CoilAmnt').val() != '') {

                    //$('#smatr_CoilAmnt1').val()


                    camnt = $('#smatr_CoilAmnt1').val().replace(',', '');
                    sheetservice = $('#costservice').val().replace(',', '');
                    sQty = $('#smatr_qty').val().replace(',', '');

                    ///alert(camnt + '\n' + sheetservice + '\n' + sQty);



                    sPerUnit = numeral(camnt).add(sheetservice).divide(sQty);
                    sAmount = numeral(camnt).add(sheetservice);
                    $('#priceperunit').val(numeral(sPerUnit.value()).format('0,0.0000'));
                    $('#samount').val(numeral(sAmount.value()).format('0,0.0000'));


                    $('#btnsheetSave').css({ 'background-color' : '' });
                    $('#btnsheetSave').addClass('btn-success');
                    $('#btnsheetSave').prop('disabled', false);
                }


            }

            function tsttblDisplaySheet() {
                $.ajax({
                    //url: '../../xTransaction/srv_transaction_in.asmx/ststDisplaydata', ctstDisplaydata
                    url: '../../xTransaction/srv_transaction_in.asmx/ststDisplaydata',
                    method: 'post',
                    data: {
                        action: 'sdisplay',
                        matr_flag_group: 2
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_matr_receive_sheet').DataTable().clear();
                            $('#tbl_matr_receive_sheet').DataTable().destroy();


                            var tbl_matr_receive_sheet = $('#tbl_matr_receive_sheet').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false
                            });
                            $('[name=tbl_matr_receive_sheet_length]').select2();

                            tbl_matr_receive_sheet.clear();

                            $.each(data, function (i, item) {
                                tbl_matr_receive_sheet.row.add([
                                    //sheetcheckstatus(data[i].sflag_status)
                                    sheetcheckstatus(data[i].matr_status_flag)
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].packingno + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].costservice).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].priceperunit).format('0,0.0000') + '</div>'
                                    
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstsDisplaybyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="top" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    //, '<div style="text-align: center;">' +
                                    //'<a href="javascript:void(0)" type="button"   onclick="tstcRemovedata(\'' + data[i].id + '\',1)" class="btn-group" data-toggle="tooltip" data-placement="right" title="Remove:' + data[i].id + '"  style="font-size: 12px;color:#e76f51"><i class="fa fa-trash-o" aria-hidden="true"></i></a>' +
                                    //'</div>'
                                ])
                            });

                            tbl_matr_receive_sheet.draw();
                        } else if (data == '') {
                            var tbl_matr_receive_sheet = $('#tbl_matr_receive_sheet').DataTable();
                            tbl_matr_receive_sheet.clear();
                            tbl_matr_receive_sheet.draw();
                        }
                    }
                })
            }

            function tstsDisplaybyid(sid) {
                tstclearinput();
                ProgressOn();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ststDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'sdisplaybyid',
                        matr_flag_group: 2,
                        id: sid
                    },
                    dataType: 'json',
                    success: function (data) {
                        //alert(data.length);
                        if (data != '') {
                            $.each(data, function (i, item) {

                                $('#sid').val(data[i].id);
                                $('#txt_ssys_doc_ref').val(data[i].sys_doc_ref);
                                $('#smatr_CoilRef').val(data[i].doc_ref);
                                $('#smatr_CoilAmnt').val(numeral(data[i].amount).format('0,0.00'));
                                $('#smatr_CoilAmnt1').val(data[i].amount);
                                $('#smatr_CoilRefid').val(data[i].ref_id);
                                $('#out_cref').val(data[i].doc_ref);
                                $('#out_cmatr_code').val(data[i].matr_code);
                                $('#out_cqty').val(data[i].quantity)
                                $('#out_camnt').val(data[i].amount)
                                $('#out_cpunit').val(data[i].priceperunit)
                                $('#smatr_packno').val(data[i].packingno);
                                $('#sdocu_no').val(data[i].doc_no);
                                $('#smatr_date').val(data[i].doc_date);

                                $('#selectedsuppliersheet').val(data[i].supplier_code);
                                $('#selectedsuppliersheet').select2();
                                $('#selectedsheet').val(data[i].matr_code);
                                $('#selectedsheet').select2();

                                $('#smatr_qty').val(numeral(data[i].quantity).format('0,0.00'));
                                $('#costservice').val(numeral(data[i].costservice).format('0,0.00'));
                                $('#priceperunit').val(numeral(data[i].priceperunit).format('0,0.00'));
                                $('#matr_remark').val(data[i].remark)
                                $('#samount').val(numeral(data[i].amount).format('0,0.00'));


                            });

                            $('#divsDisabled').removeClass('sdisabled')
                            $('#idsGo').css({ 'background-color':'#3c8dbc'})
                            $('#oGo').css({ 'background-color': '#3c8dbc' })
                            $('#btnsheetSave').css({ 'background-color': '' })
                            $('#btnsheetSave').addClass('btn-success');
                            ProgressOff();


                        } else if (data == 0) {

                        }
                    }
                })
            }

            function sheetcheckstatus(sstatus) {
                if (sstatus == true) {
                    return '<div data-toggle="tooltip" data-title="Success" data-placement="top"><i class="fa fa-check" title="Success" aria-hidden="true" style="color:#06d6a0"></i></div>'
                } else if (sstatus == false) {
                    return '<div data-toggle="tooltip" data-title="Work In Process" data-placement="top"><i class="fa fa-minus" title="Work In Procress" aria-hidden="true" style="color:#d62828"></i></div>'
                } else { }
            }

            function modal_osref_display() {
                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/osref_display',
                    method: 'post',
                    data: {
                        action: 'osref_display'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            var tbl_getref_osheet = $('#tbl_getref_osheet').DataTable();
                            tbl_getref_osheet.clear();

                            $.each(data, function (i, item) {
                                tbl_getref_osheet.row.add([

                                    '<div>' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].vendorname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="osref_displaybyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 12px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });

                            tbl_getref_osheet.draw();
                            $('#modal_getref_osheet').modal('show');
                        } else if (data == '') {
                            var tbl_getref_osheet = $('#tbl_getref_osheet').DataTable();
                            tbl_getref_osheet.clear();
                            tbl_getref_osheet.draw();
                        }
                    }
                })
            }

            function osref_displaybyid(id) {
                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/osref_displaybyid',
                    method: 'post',
                    data: {
                        action: 'osref_displaybyid',
                        id: id

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('1');
                            //alert(data[0].matr_code);
                            $.each(data, function (i, item) {
                                $('#txtref_odetailall').val(data[i].matr_code);
                                $('#txtref_osperunit').val(data[i].priceperunit);
                                $('#txtref_otransacid').val(data[i].id);
                                $('#txtref_ogoodname').val(data[i].goodname1);
                                $('#txtref_olotcode').val();
                                $('#txtref_oqty').val(numeral(data[i].quantity).format('0,0.00'));
                            });

                            $('#modal_getref_osheet').modal('hide');

                        } else if (data == '') {
                            alert('ไม่มีข้อมูล');
                        }
                    }
                })
            }

            function modal_omatr_itemdisplay() {

                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_itemdisplay',
                    method: 'post',
                    data: {
                        action: 'omatr_itemdisplay '

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert(1111);
                            var tbl_omatr_itemdisplay = $('#tbl_omatr_itemdisplay').DataTable();
                            tbl_omatr_itemdisplay.clear();

                            $.each(data, function (i, item) {
                                tbl_omatr_itemdisplay.row.add([


                                    '<div>' + data[i].matr_goodcode + '</div>'
                                    , '<div class="text-right">' + data[i].goodname1 + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="modal_omatr_displaybyid(\'' + data[i].matr_code + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 12px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });

                            tbl_omatr_itemdisplay.draw();
                            $('#modal_omatr_itemdisplay').modal('show');
                        } else if (data == '') {
                            var tbl_omatr_itemdisplay = $('#tbl_omatr_itemdisplay').DataTable();
                            tbl_omatr_itemdisplay.clear();
                            tbl_omatr_itemdisplay.draw();
                            //var tbl_getref_osheet = $('#tbl_getref_osheet').DataTable();
                            //tbl_getref_osheet.clear();
                            //tbl_getref_osheet.draw();
                        }
                    }
                })
            }

            function modal_omatr_displaybyid(goodid) {
                //alert(goodid);
                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_itemdisplaybyid',
                    method: 'post',
                    data: {
                        action: 'omatr_itemdisplaybyid',
                        goodid: goodid

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert('1');

                            $.each(data, function (i, item) {

                                $('#txtitem_goodname').val(data[i].goodname1);
                                $('#txtitem_goodcode').val(data[i].matr_code);
                                $('#txtitem_partarea').val(data[i].partarea);

                            });

                            $('#modal_omatr_itemdisplay').modal('hide');

                        } else if (data == '') {
                            alert('ไม่มีข้อมูล');
                        }
                    }
                })
            }

            function oDisplay() {

                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/oDisplay',
                    method: 'post',
                    data: {
                        action: 'oDisplay'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_matr_receive_part').DataTable().clear();
                            $('#tbl_matr_receive_part').DataTable().destroy();


                            var tbl_matr_receive_part = $('#tbl_matr_receive_part').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false
                            });

                            $('[name=tbl_matr_receive_part_length]').select2();
                            tbl_matr_receive_part.clear();

                            $.each(data, function (i, item) {
                                tbl_matr_receive_part.row.add([

                                    '<div class="text-left" style="padding-left:10px">' + data[i].docu_date + '</div>'
                                    , '<div class="text-left" style="padding-left:10px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:10px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].costservice).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstsDisplaybyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="top" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });

                            tbl_matr_receive_part.draw();

                        } else if (data == '') {
                            var tbl_matr_receive_part = $('#tbl_matr_receive_part').DataTable();
                            tbl_matr_receive_part.clear();
                            tbl_matr_receive_part.draw();
                        }
                    }
                })
            }

            function modal_matr_sheettransac() {
                //alert('modal_matr_sheettransac');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/modal_matr_sheettransac_oDisplay',
                    method: 'post',
                    data: {
                        action: 'sheettransac_oDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_matr_sheettransac = $('#tbl_matr_sheettransac').DataTable();
                            tbl_matr_sheettransac.clear();
                            $.each(data, function (i, item) {
                                tbl_matr_sheettransac.row.add([

                                    //'<div>' + data[i].doc_date + '</div>'
                                    '<div>' + data[i].docu_date + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].doc_ref + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].packingno + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="modal_matr_sheettransacbyid(' + data[i].id + ')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-hand-pointer-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });

                            tbl_matr_sheettransac.draw();

                        } else if (data == '') {
                            var tbl_matr_sheettransac = $('#tbl_matr_sheettransac').DataTable();
                            tbl_matr_sheettransac.clear();
                            tbl_matr_sheettransac.draw();
                        }
                    }
                })

            }

            function modal_matr_sheettransacbyid(id) {
                //alert('modal_matr_sheettransacbyid' + id);
                $.ajax({

                    url: '../../xTransaction/srv_transaction_in.asmx/modal_matr_sheettransac_oDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'sheettransac_oDisplaybyid',
                        id: id

                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            $.each(data, function (i, item) {

                                $('#txtrefs_detail').val(data[i].goodname1 + ' ; ' + data[i].priceperunit);
                                $('#txtrefs_id').val(data[i].id);
                                $('#txtrefs_smatr_code').val(data[i].matr_code);
                                //$('#sref_supplier_code').val(data[i].supplier_code);
                                $('#txtrefs_priceperunit').val(data[i].priceperunit);

                            });

                            $('#modal_matr_sheettransac').modal('hide');

                        } else if (data == '') {

                        }
                    }
                })

            }

            function omatr_itempartrefsheet() {
                //alert('modal_matr_sheettransac');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_itempartrefsheet',
                    method: 'post',
                    data: {
                        action: 'omatr_itempartrefsheet'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {


                            $('#tbl_sheetpay').DataTable().clear();
                            $('#tbl_sheetpay').DataTable().destroy();


                            var tbl_sheetpay = $('#tbl_sheetpay').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false
                                ,'autoWidth' : false
                            });
                            $('[name=tbl_sheetpay_length]').select2();

                            tbl_sheetpay.clear();
                            $.each(data, function (i, item) {
                                tbl_sheetpay.row.add([

                                    //'<div>' + data[i].doc_date + '</div>'
                                    '<div>' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity_rv).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity_rm).format('0,0.00') + '</div>'
                                    //, '<div><a href="javascript:void(0)" type="button"   onclick="omatr_itemdisplaybysysdoc(1)" ><i class="fa fa-check-circle-o" aria-hidden="true"></i></a></div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="omatr_itemdisplaybysysdoc(\'' + data[i].sys_doc_ref + '\',\'' + data[i].id + '\',\'' + data[i].ref_id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="' + data[i].sys_doc_ref + '"  style="font-size: 15px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });

                            tbl_sheetpay.draw();

                            var tbl_partreceive = $('#tbl_partreceive').DataTable();
                            tbl_partreceive.clear();

                            $('.spinner').hide();
                            $('#tbl_partreceive').removeClass('overlay');

                        } else if (data == '') {
                            var tbl_sheetpay = $('#tbl_sheetpay').DataTable();
                            tbl_sheetpay.clear();
                            tbl_sheetpay.draw();
                        }
                    }
                })

            }

            function omatr_itemdisplaybysysdoc(syscodet, transac_id,transac_item_id) {


               

               
                $('.spinner').show();
                $('#txtpart_transacid').val(transac_id);
                $('#txtpart_transac_item_id').val(transac_item_id);
             
                //alert(syscodet);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_itemdisplaybysysdoc',
                    method: 'post',
                    data: {
                        action: 'omatr_itemdisplaybysysdoc',
                        syscodet: syscodet,
                        transac_id: transac_id
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_partreceive = $('#tbl_partreceive').DataTable();
                            tbl_partreceive.clear();
                            $.each(data, function (i, item) {
                                tbl_partreceive.row.add([


                                    '<div class="text-left" style="padding-left:15px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].itempart_qty).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].quantity_rv).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].balance).format('0,0.00') + '</div>'     
                                    , omatr_itemdisplaybysysdoc_setState(data[i].id, data[i].balance, data[i].itempart_goodid, syscodet)

                                ])
                            });

                            tbl_partreceive.draw();
                            $('.spinner').hide();
                            $('#tbl_partreceive').removeClass('overlay');
                        } else if (data == '') {
                            var tbl_partreceive = $('#tbl_partreceive').DataTable();
                            tbl_partreceive.clear();
                            tbl_partreceive.draw();
                            $('.spinner').hide();
                            Swal.fire({
                                icon: 'info',
                                title: '<div class="txtLabel"><strong>[ แจ้งเดือน ]</strong></div>',
                                html: '<div class="txtLabel"><strong style="color:red">หมายเหตุ : </strong><strong>' + syscodet + ' : ไม่มี Part ค้างรับ</strong></div>'

                            })

                        }
                    }

                })
            }

            function omatr_itemdisplaybysysdoc_setState(id, balance, goodid, syscodet) {

                if (balance <= 0 || goodid == '28112') {
                    return '<div style="text-align: center;">' +
                        '<a href="javascript:void(0)" type="button"   onclick="omatr_itemdisplaybysyscodeandid(\'' + id + '\',\'' + goodid + '\',\'' + syscodet + '\')" class="btn-group disabled" data-toggle="tooltip" data-placement="right"  style="font-size: 15px;color:#c7cfb7"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                        '</div>';
                } else {
                    return '<div style="text-align: center;">' +
                        '<a href="javascript:void(0)" type="button"   onclick="omatr_itemdisplaybysyscodeandid(\'' + id + '\',\'' + goodid + '\',\'' + syscodet + '\')" class="btn-group" data-toggle="tooltip" data-placement="right"   style="font-size: 15px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                        '</div>';
                }

            }



            function omatr_itemdisplaybysyscodeandid(transac_id, itemgoodid, syscodet) {
                ProgressOn();


                rvPart_rowCount(syscodet);

                $('body').addClass('overlay');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_itemdisplaybysyscodeandid',
                    method: 'post',
                    data: {
                        action: 'omatr_itemdisplaybysyscodeandid',
                        transac_id: $('#txtpart_transacid').val(),
                        syscodet: syscodet,
                        goodid: itemgoodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            tstclearinput();
                            $.each(data, function (i, item) {
                                fn_otransacnewid_check();
                                var goodid = data[i].itempart_goodid;


                                $('#txtitem_goodname').val(data[i].goodname);
                                $('#txtitem_goodcode').val(data[i].itempart_goodid);


                                if (data[i].itempart_goodid == '28103') {
                                    $('#divwirerow').removeClass('hidden');
                                }
                                else
                                {
                                    $('#divwirerow').addClass('hidden');
                                    $('#wmatr_goodname').val('');
                                    $('#wmatr_goodid').val('');
                                    $('#txt_wirelength_amnt').val('');
                                    $('#txt_CalcwireAmnt').val('');

                                }





                                if (data[i].id == 0 || data[i].id == '' || data[i].id == null) {
                                    $('#txtitem_sheetout_id').val($('#txtpart_transacid').val());
                                    $('#txtitem_sheetid').val($('#txtpart_transac_item_id').val());
                                } else {
                                    $('#txtitem_sheetout_id').val(data[i].id);
                                }



                               
                                $('#txtitem_sys_doc_ref').val(data[i].sys_doc_ref);
                                $('#txtitem_priceperunit').val(data[i].costsheetperunit);
                                $('#txtitem_rvremaining').val(data[i].quantity_rm);
                                $('#txtitem_v7inc').val(data[i].araesheared);
                                $('#oCostservice').val(numeral(data[i].costservice).format('0,0.00'));
                                $('#txtitem_sheetpriceperunit').val(data[i].sheetpriceperunit);
                                $('#txtitem_rmsheet').val(data[i].rmwdsheet);
                                $('#txt_CalcsheetAmnt_rema').val(parseFloat(data[i].rmwdsheet).toFixed(4));









                                if (goodid == '28099' || goodid == '28100' || goodid == '28097' || goodid == '28107' || goodid == '28108' || goodid == '39245' || goodid == '39284' || goodid == '39290') {
                                    //alert(11);
                                    if (data[i].rmwdsheet <= data[i].quantity_rm) {
                                        $('#oQuantity').val(numeral(data[i].rmwdsheet).format('0,0.00'));
                                        //alert(1);

                                    } else if (data[i].rmwdsheet > data[i].quantity_rm) {
                                        $('#oQuantity').val(numeral(data[i].quantity_rm).format('0,0.00'));
                                        //alert(2);
                                    }
                                } else {
                                    if (data[i].partCount < data[i].quantity_rm) {
                                        $('#oQuantity').val(numeral(data[i].partCount).format('0,0.00'));
                                    } else if (data[i].partCount > data[i].quantity_rm) {
                                        $('#oQuantity').val(numeral(data[i].quantity_rm).format('0,0.00'));
                                    }
                                }



                                partAreaRep(data[i].itempart_goodid, data[i].partarea);

                            });

                            $('#md_omatr_mdsheetforpart_oDisplay').modal('hide');
                            $('body').removeClass('overlay');
                            ProgressOff();
                        } else if (data == '') {
                            var tbl_partreceive = $('#tbl_partreceive').DataTable();
                            tbl_partreceive.clear();
                            tbl_partreceive.draw();
                        }
                    }
                })
            }




            function partAreaRep(goodid, partarea) {
                console.log(goodid, partarea);
                if (goodid == '28099' || goodid == '28100' || goodid == '28097' || goodid == '28107' || goodid == '28108' || goodid == '39245' || goodid == '39284' || goodid == '39290') {
                    $('#txtitem_partarea').val(3.05);
                } else {
                    $('#txtitem_partarea').val(partarea);
                }

            }

            function fn_otransacnewid_check() {
                
                ProgressOn();


                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetRv_optionpart_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRv_optionpart_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                if (data[i].rvo_lastid != '') {
                                    $('#txt_sysdoccode').val(data[0].rvo_lastid);
                                    $('#divDisabled').removeClass('odisabled')


                                    $('#obtitemgo').css('background', '#3C8DBC');
                                    $('#obtitemgo').prop('disabled', false)

                                    $('#sidGo').css('background', '#3C8DBC');//#3c8dbc
                                    $('#sidGo').prop('disabled', false)

                                    $('#widGo').css('background', '#3C8DBC');
                                    $('#widGo').prop('disabled', false);

                                    
                                    
                                } else if (data[i].rvo_lastid == '') {
                                    var lastid = 'wd-o-00001'
                                    $('#txt_sysdoccode').val(lastid);
                                    $('#divDisabled').removeClass('odisabled')
                                }

                            })

                            ProgressOff();

                        }

                    }
                })

            }
            function fn_Calc_opWithCostservice1() {
                
                if ($('#txtitem_goodcode').val() == '28103')
                {
                    console.log('v8');
                    if ($('#oQuantity').val() != '') {
                        var oQuantity, oCostservice, oPriceperunits, txt_CalcsheetAmnt, oamount, goodid, sheetUse;
                        var oQuantity = parseFloat($('#oQuantity').val());
                        var costservice = parseFloat($('#oCostservice').val());
                        var costserviceAll = oQuantity * costservice;
                        var wCostTotal = parseFloat($('#txt_CalcwireAmnt1').val());
                        

                        console.log('--oQuantity : ' + oQuantity);
                        console.log(parseFloat($('#txt_CalcwireAmnt1').val()));
                        
                        console.log('1x;' + wCostTotal+1);
                        console.log($('#txt_CalcwireAmnt').val() + ',' + oQuantity);
                        console.log(wCostTotal/oQuantity);
                  


                        //alert(costserviceAll);

                        goodid = $('#txtitem_goodcode').val();

                        if (goodid == '28099' || goodid == '28100' || goodid == '28097' || goodid == '28107' || goodid == '28108' || goodid == '39245' || goodid == '39284' || goodid == '39290') {

                            sheetUse = oQuantity

                        } else {

                            sheetUse = parseFloat($('#oQuantity').val()).toFixed(4) * parseFloat($('#txtitem_partarea').val()).toFixed(4) / parseFloat($('#txtitem_v7inc').val()).toFixed(4);
                        }




                        oamount = parseFloat($('#oQuantity').val()).toFixed(4) * parseFloat($('#txtitem_partarea').val()).toFixed(4) / parseFloat($('#txtitem_v7inc').val()).toFixed(4) + costserviceAll
                        oPriceperunits = sheetUse * parseFloat($('#txtitem_sheetpriceperunit').val()).toFixed(4);
                        console.log('oPriceperunits : ' + oPriceperunits);
                        console.log('SheetUse : ' + sheetUse);


                        if (parseFloat($('#oQuantity').val()) > parseFloat($('#txtitem_rvremaining').val()) || sheetUse > parseFloat($('#txtitem_rmsheet').val())) {
                            console.log(1);

                            if ($('#oQuantity').val() > $('#txtitem_rvremaining').val()) {
                                //alert(222);
                                console.log(2);

                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                    html: '<div class="txtLabel"><strong style="color:orange">PART : ' + $('#txtitem_goodname').val() + '</strong> ไม่พอในการรับวัตถุดิบ !!!</div>'

                                })
                                $('#btnAdjust').addClass('hidden');
                            }
                            else if (sheetUse > $('#txtitem_rmsheet').val()) {
                                console.log(3);

                                $('#txt_CalcsheetAmnt').val(numeral(Math.ceil(sheetUse)).format('0,0.0000'))
                                $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)).toFixed(4));
                                $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)) * oQuantity).toFixed(4)).format('0,0.0000'));


                                $('#btnAdjust').removeClass('hidden');
                                $('#obtnSave3').prop('disabled', false);
                                $('#obtnSave3').css({ 'background': '' });
                                $('#obtnSave3').addClass('btn-success');

                            }

                        } else if (sheetUse > $('#txtitem_rmsheet').val()) {
                            console.log(4);

                            $('#txt_CalcsheetAmnt').val(numeral(Math.round(sheetUse)).format('0,0.0000'))
                            $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)).toFixed(4));
                            $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)) * oQuantity).toFixed(2)).format('0,0.0000'));


                        } else {
                            console.log(5);
                            console.log('oPriceperunits : ' + oPriceperunits);
                            console.log('oQuantity :' + oQuantity);
                            $('#txt_CalcsheetAmnt').val(parseFloat(sheetUse).toFixed(0))


                            $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)).toFixed(4));
                            $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice + (wCostTotal / oQuantity)) * oQuantity).toFixed(2)).format('0,0.0000'));


                            $('#btnAdjust').addClass('hidden');

                            $('#obtnSave3').css({ 'background': '' });
                            $('#obtnSave3').addClass('btn-success');
                            $('#obtnSave3').removeAttr('disabled');
                        }
                       
                    } else {
                        console.log(6);

                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                            html: '<div class="txtLabel"><strong style="color:red">กรุณา : </strong><strong>ตรวจสอบจำนวนก่อนคำนวนต้นทุน</strong></div>'

                        })

                    }
                }
                else
                {
                    console.log('Not V8');
                    if ($('#oQuantity').val() != '') {
                        var oQuantity, oCostservice, oPriceperunits, txt_CalcsheetAmnt, oamount, goodid, sheetUse;
                        var oQuantity = parseFloat($('#oQuantity').val());
                        var costservice = parseFloat($('#oCostservice').val());
                        var costserviceAll = oQuantity * costservice;

                        //alert(costserviceAll);

                        goodid = $('#txtitem_goodcode').val();

                        if (goodid == '28099' || goodid == '28100' || goodid == '28097' || goodid == '28107' || goodid == '28108' || goodid == '39245' || goodid == '39284' || goodid == '39290') {

                            sheetUse = oQuantity

                        } else {

                            sheetUse = parseFloat($('#oQuantity').val()).toFixed(4) * parseFloat($('#txtitem_partarea').val()).toFixed(4) / parseFloat($('#txtitem_v7inc').val()).toFixed(4);
                        }




                        oamount = parseFloat($('#oQuantity').val()).toFixed(4) * parseFloat($('#txtitem_partarea').val()).toFixed(4) / parseFloat($('#txtitem_v7inc').val()).toFixed(4) + costserviceAll
                        oPriceperunits = sheetUse * parseFloat($('#txtitem_sheetpriceperunit').val()).toFixed(4);
                        console.log('oPriceperunits : ' + oPriceperunits);
                        console.log('SheetUse : ' + sheetUse);


                        if (parseFloat($('#oQuantity').val()) > parseFloat($('#txtitem_rvremaining').val()) || sheetUse > parseFloat($('#txtitem_rmsheet').val())) {
                            console.log(1);

                            if ($('#oQuantity').val() > $('#txtitem_rvremaining').val()) {
                                //alert(222);
                                console.log(2);

                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                    html: '<div class="txtLabel"><strong style="color:orange">PART : ' + $('#txtitem_goodname').val() + '</strong> ไม่พอในการรับวัตถุดิบ !!!</div>'

                                })
                                $('#btnAdjust').addClass('hidden');
                            }
                            else if (sheetUse > $('#txtitem_rmsheet').val()) {
                                console.log(3);

                                $('#txt_CalcsheetAmnt').val(numeral(Math.ceil(sheetUse)).format('0,0.0000'))
                                $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice).toFixed(4));
                                $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice) * oQuantity).toFixed(4)).format('0,0.0000'));


                                $('#btnAdjust').removeClass('hidden');
                                $('#obtnSave3').prop('disabled', false);
                                $('#obtnSave3').css({ 'background': '' });
                                $('#obtnSave3').addClass('btn-success');

                            }

                        } else if (sheetUse > $('#txtitem_rmsheet').val()) {
                            console.log(4);

                            $('#txt_CalcsheetAmnt').val(numeral(Math.round(sheetUse)).format('0,0.0000'))
                            $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice).toFixed(4));
                            $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice) * oQuantity).toFixed(2)).format('0,0.0000'));


                        } else {
                            console.log(5);
                            console.log('oPriceperunits : ' + oPriceperunits);
                            console.log('oQuantity :' + oQuantity);
                            $('#txt_CalcsheetAmnt').val(parseFloat(sheetUse).toFixed(0))
                            $('#oPriceperunits').val(parseFloat((oPriceperunits / oQuantity) + costservice).toFixed(4));
                            $('#oamount').val(numeral(parseFloat(((oPriceperunits / oQuantity) + costservice) * oQuantity).toFixed(2)).format('0,0.0000'));

                            $('#btnAdjust').addClass('hidden');

                            $('#obtnSave3').css({ 'background': '' });
                            $('#obtnSave3').addClass('btn-success');
                            $('#obtnSave3').removeAttr('disabled');
                        }
                        //alert(11);


                    } else {
                        console.log(6);

                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                            html: '<div class="txtLabel"><strong style="color:red">กรุณา : </strong><strong>ตรวจสอบจำนวนก่อนคำนวนต้นทุน</strong></div>'

                        })

                    }
                }



                



               
            }


            function fn_Calc_opWithCostservice() { // op = Option Part

                console.log(7);

                //fnCalcsheetAmnt($('#txtitem_goodcode').val());
                var CalcsheetAmnt;
                var s_priceperunit = parseFloat($('#txtitem_priceperunit').val());
                var oQuantity = parseFloat($('#oQuantity').val());
                var oCostservice = parseFloat($('#oCostservice').val());
                var oPriceperunits = parseFloat($('#txtitem_priceperunit').val()) + parseFloat($('#oCostservice').val())
                var partarea = parseFloat($('#txtitem_partarea').val());
                var oamount = oQuantity * (s_priceperunit + oCostservice)

                //alert(partarea);
                var goodid = $('#txtitem_goodcode').val();

                if (goodid == '28099' || goodid == '28100' || goodid == '28097' || goodid == '28107' || goodid == '28108' || goodid == '39245' || goodid == '39284' || goodid == '39290') {
                    //กรณีใช้ Sheet 1 แผ่น v3,v4,v5
                    CalcsheetAmnt = (oQuantity * partarea) / 3.05
                } else {

                    CalcsheetAmnt = (oQuantity * partarea) / 2.344; //3.05 พื้นที่ชีส/แผ่น
                }

                $('#oPriceperunits').val(numeral(oPriceperunits).format('0,0.00'));
                $('#oamount').val(numeral(oamount).format('0,0.00'));
                $('#txt_CalcsheetAmnt').val(numeral(Math.round(CalcsheetAmnt)).format('0,0.00'));
            }






            function fn_GetRv_coils_lastid() {
                ProgressOn();
                tstclearinput();

                $('body').addClass('overlay');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetRv_coils_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRv_coils_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                if (data[i].rvo_lastid != '') {
                                    //alert(data[0].rvc_lastid);
                                    $('#txt_csys_doc_ref').val(data[0].rvc_lastid);
                                    $('#idGo').css({ 'background':'#3c8dbc'});
                                    $('#divcDisabled').removeClass('cdisabled')
                                    $('#btnCoilSave').prop('disabled', true);
                                    $('#btnCoilSave').css({'background': '#D6D6D6'})
                                    $('#btnCoilSave').removeClass('btn-success');


                                    $('#matr_refno').prop('disabled', false);
                                    $('#matr_date').prop('disabled', false);
                                    $('#matr_date').val(currentdate2);
                                    $('#selectedsupplier').prop('disabled', false);
                                    $('#selectedcoils').prop('disabled', false);
                                    $('#matr_qty').prop('disabled', false);
                                    $('#matr_amnt').prop('disabled', false);
                                    $('#matr_perunit').prop('disabled', false);
                                    $('#matr_remark').prop('disabled', false);

                                    $('#idGo').removeClass('cdisabled');


                                    ProgressOff();

                                } else {

                                }

                            })


                        }

                    }
                })
            }



            function fn_GetRv_sheet_lastid() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetRv_sheets_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRv_sheets_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                if (data[i].rvs_lastid != '') {
                                    //alert(data[0].rvs_lastid);
                                    $('#txt_ssys_doc_ref').val(data[0].rvs_lastid);
                                    $('#idsGo').css({ 'background': '#3c8dbc' });
                                    $('#oGo').css({ 'background': '#3c8dbc' });
                                    $('#divsDisabled').removeClass('sdisabled')

                                    $('#smatr_date').val(currentdate2);
                                } else {

                                }

                            })


                        }

                    }
                })
            }

            function fn_GetRv_mesh_lastid() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetRv_mesh_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRv_mesh_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                if (data[i].mesh_lastid != '') {
                                    //alert(data[i].mesh_lastid);
                                    $('#txt_msysdoccode').val(data[0].mesh_lastid);
                                    $('#mDisabled').removeClass('mdisabled');
                                } else {

                                }

                            })


                        }

                    }
                })
            }

            function fn_GetMesh_dataWspDisplay(goodid) {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_meshwspitemdisplay',
                    method: 'post',
                    data: {
                        action: 'omatr_meshwspitemdisplay'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_mesh_transac = $('#tbl_mesh_transac').DataTable();
                            //$('#container').css('display', 'block');
                            //tbl_mesh_transac.columns.adjust().draw();
                            tbl_mesh_transac.clear();

                            $.each(data, function (i, item) {
                                tbl_mesh_transac.row.add([


                                    '<div>' + data[i].DocuDate + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].InvNO + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].GoodName + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].GoodQty2).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].GoodPrice2).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].GoodAmnt).format('0,0.00') + '</div>'
                                    //, fn_selectoption_state(data[i].InvNO)
                                    //, fn_selectoption_state(data[i].InvNO, data[i].POInvID)
                                    //, fn_selectoption_state(data[i].InvNO, data[i].POInvID)
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetMesh_dataWspDisplaybyid(\'' + data[i].POInvID + '\',\'' + goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].sys_doc_ref + '"  style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });


                            tbl_mesh_transac.draw();
                            //
                        } else if (data == '') {
                            var tbl_sheetpay = $('#tbl_sheetpay').DataTable();
                            tbl_sheetpay.clear();
                            tbl_sheetpay.draw();
                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }

            function fn_GetMesh_dataWspDisplaybyid(poinvid, goodid) {
                //alert(poinvid);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/omatr_meshwspitemdisplaybyid',
                    method: 'post',
                    data: {
                        action: 'omatr_meshwspitemdisplaybyid'
                        , poinvid: poinvid
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {
                        //alert(data.length);
                        if (data != '') {

                            $.each(data, function (i, item) {

                                //alert(data[i].POInvID);
                                $('#txtm_DocuDate').val(data[i].DocuDate);
                                $('#txtm_GoodName').val(data[i].GoodName);
                                $('#txtm_InvNo').val(data[i].InvNO);
                                $('#txtm_GoodID').val(data[i].GoodID);
                                $('#txtm_VendorID').val(data[i].Vendoeid);
                                $('#txtm_VendorName').val(data[i].VendorName);

                                if (data[i].GoodID == '39248' || data[i].GoodID == '39293') // ลวดตาข่าย
                                {
                                    $('#txtm_GoodQty2').val(numeral(data[i].GoodQty2).format('0,0.00'));
                                    $('#txtm_GoodQtyPcs').val(numeral(data[i].GoodQty2 * 24).format('0,0.00'));
                                    $('#txtm_priceperunit').val(numeral(data[i].GoodAmnt / (data[i].GoodQty2 * 24)).format('0,0.00'));
                                    $('#txtm_GoodAmnt').val(numeral(data[i].GoodAmnt).format('0,0.00'));

                                } else {
                                    $('#txtm_GoodQty2').val('-');
                                    $('#txtm_GoodQtyPcs').val(numeral(data[i].GoodQty2).format('0,0.00'));
                                    $('#txtm_priceperunit').val(numeral(data[i].GoodPrice2).format('0,0.00'));
                                    $('#txtm_GoodAmnt').val(numeral(data[i].GoodAmnt).format('0,0.00'));
                                }




                            });

                            $('#modal_mesh_transac').modal('hide');
                        } else if (data == '') {

                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }

            function fn_GetMeshDisplay() {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/fn_GetMeshDisplay',
                    method: 'post',
                    data: {
                        action: 'mDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_mesh = $('#tbl_mesh').DataTable();

                            tbl_mesh.clear();

                            $.each(data, function (i, item) {
                                tbl_mesh.row.add([
                                    '<div>' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].amount).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetMesh_dataWspDisplaybyid(\'' + data[i].POInvID + '\')" class="btn-group disabled" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].sys_doc_ref + '"  style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });
                            tbl_mesh.draw();
                            //
                        } else if (data == '') {
                            var tbl_sheetpay = $('#tbl_sheetpay').DataTable();
                            tbl_sheetpay.clear();
                            tbl_sheetpay.draw();
                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }

            function text_cssrequired() {
                //alert(1);
                var obj_check = $(".css-require");
                $("#divsDisabled").on("submit", function () {
                    obj_check.each(function (i, k) {
                        var status_check = 0;
                        if (obj_check.eq(i).find(":radio").length > 0 || obj_check.eq(i).find(":checkbox").length > 0) {
                            status_check = (obj_check.eq(i).find(":checked").length == 0) ? 0 : 1;
                        } else {
                            status_check = ($.trim(obj_check.eq(i).val()) == "") ? 0 : 1;
                        }
                        formCheckStatus($(this), status_check);
                    });
                    if ($(this).find(".has-error").length > 0) {
                        return false;
                    }
                });

                obj_check.on("change", function () {
                    var status_check = 0;
                    if ($(this).find(":radio").length > 0 || $(this).find(":checkbox").length > 0) {
                        status_check = ($(this).find(":checked").length == 0) ? 0 : 1;
                    } else {
                        status_check = ($.trim($(this).val()) == "") ? 0 : 1;
                    }
                    formCheckStatus($(this), status_check);
                });

                var formCheckStatus = function (obj, status) {
                    if (status == 1) {
                        obj.parent(".form-group").removeClass("has-error").addClass("has-success");
                        obj.next(".glyphicon").removeClass("glyphicon-warning-sign").addClass("glyphicon-ok");
                    } else {
                        obj.parent(".form-group").removeClass("has-success").addClass("has-error");
                        obj.next(".glyphicon").removeClass("glyphicon-ok").addClass("glyphicon-warning-sign");
                    }
                }
            }

            function fn_select_optionwsp() {
                var goodid = $('#select_optionwsp').val();
                fn_GetMesh_dataWspDisplay(goodid);
            }

            function fn_selectoption_state(invno, poinvid) {
                //alert(invno + ';' + poinvid);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/fn_selectoption_state',
                    method: 'post',
                    data: {
                        action: 'fn_selectoption_state'
                        , invno: invno

                    },
                    dataType: 'json',
                    success: function (data) {
                        var rowscount = data[0].rowscount;
                        fn_selectoption_statex(rowscount, invno, poinvid);
                    }


                })
            }

            function fn_selectoption_statex(rowscount, invno, poinvid) {
                //alert(typeof(rowscount)+';'+ invno + ';'+ poinvid)
                if (rowscount == 1) {
                    var strstate = '<div style="text-align: center;" class="disabled"><a href="javascript:void(0)" type="button" onclick="fn_GetMesh_dataWspDisplaybyid(\'' + data[i].POInvID + '\',\'' + goodid + '\')" class="btn-group disabled" data-toggle="tooltip" data-placement="right" title="Edit:' + invno + '" style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a></div>';
                    return strstate;

                }
                else {
                    var strstate = '< div style = "text-align: center;"  ><a href="javascript:void(0)" type="button" onclick="fn_GetMesh_dataWspDisplaybyid(\'' + data[i].POInvID + '\',\'' + goodid + '\')" class="btn-group " data-toggle="tooltip" data-placement="right" title="Edit:' + invno + '" style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a></div>';
                    return strstate;
                }
            }

            function GetScrewNewID() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetRv_optionpart_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRv_optionpart_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                //alert(data[i].rvo_lastid);
                                $('#txtsc_sys_code').val(data[i].rvo_lastid);
                                $('#scDisabled').removeClass('scdisabled');

                                

                                $('#screw_itemgo').css('background', '#3C8DBC');
                                $('#screw_itemgo').prop('disabled', false)

                                $('#screw_Getamntgo').css('background', '#3C8DBC');
                                $('#screw_Getamntgo').prop('disabled', false)
                                
                            })
                        }
                    }
                })
            }
            function fn_GetScrewsDisplay() {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetScrewsDisplay',
                    method: 'post',
                    data: {
                        action: 'GetScrewsDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            
                            var tbl_screw_transac = $('#tbl_screw_transac').DataTable();
                            tbl_screw_transac.clear();

                            $.each(data, function (i, item) {
                                tbl_screw_transac.row.add([
                                    '<div class="txtLabel" style="padding-left:5px">' + data[i].matr_goodcode + '</div>'
                                    , '<div class="txtLabel" style="padding-left:5px">' + data[i].goodname1 + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="GetScrewsDisplaybyid(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].goodid + '"  style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });
                            tbl_screw_transac.draw();
                            $('#modal_screw_transac').modal('show');
                        } else if (data == '') {
                            var tbl_screw_transac = $('#tbl_screw_transac').DataTable();
                            tbl_screw_transac.clear();
                            tbl_screw_transac.draw();
                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }

            function GetScrewsDisplaybyid(goodid) {
                //alert(1);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/GetScrewsDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'GetScrewsDisplaybyid'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            $('#txtsc_GoodName').val(data[0].goodname1);
                            $('#txtsc_GoodID').val(data[0].goodid);
                            //.each(data, function (i, item) {


                            //});

                        } else if (data == '') { }
                    }
                })
                $('#modal_screw_transac').modal('hide');
            }

            function fn_GetAmountCalc() {
                var txtsc_priceperunit = $('#txtsc_priceperunit').val();
                var txtsc_qty = $('#txtsc_qty').val();

                if (txtsc_priceperunit == '' && txtsc_qty == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนและราคาต้นทุนสกรู</strong></div>'
                    })
                } else if (txtsc_priceperunit != '' && txtsc_qty == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนสกรู</strong></div>'
                    })
                } else if (txtsc_priceperunit == '' && txtsc_qty != '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบราคาต้นทุนสกรู</strong></div>'
                    })
                } else {
                    $('#txtsc_amnt').val(numeral(txtsc_priceperunit * txtsc_qty).format('0,0.00'));
                    $('#btnSaveScrew').prop('disabled', false);
                    $('#btnSaveScrew').css({ 'background-color': '#32db68' });
                }



            }


            function fn_GetScrewDisplay() {
                //alert('fn_GetScrewDisplay');
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/fn_GetScrewsDisplay',
                    method: 'post',
                    data: {
                        action: 'scDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_screw = $('#tbl_screw').DataTable();

                            tbl_screw.clear();

                            $.each(data, function (i, item) {
                                tbl_screw.row.add([

                                    '<div class="text-left" style="padding-left:10px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:10px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:10px">' + data[i].goodname1 + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:10px">' + numeral(data[i].amount).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetMesh_dataWspDisplaybyid(\'' + data[i].POInvID + '\')" class="btn-group disabled" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].sys_doc_ref + '"  style="font-size: 12px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });
                            tbl_screw.draw();
                            //
                        } else if (data == '') {
                            var tbl_screw = $('#tbl_screw').DataTable();
                            tbl_screw.clear();
                            tbl_screw.draw();
                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }
            function rvPart_rowCount(sysDoct) {
               
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/fn_rvPart_rowCount',
                    method: 'post',
                    data: {
                        sysDoct: sysDoct
                    },
                    dataType: 'json',
                    success: function (data) { console.log(data);
                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#txtitem_rowCount').val(data[i].Part_RowCount)
                            });
                           
                        } else if (data == '') {
                           
                        }
                    }
                })
                //$('#modal_mesh_transac').modal('show');
            }


            function rvPart_AotuAdjust() {

                ProgressOn();
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/aInsert',
                    method: 'post',
                    data: {
                        
                        action : 'aInsert'
                        ,create_by : usr_name
                        , ref_doc: $('#txtitem_sys_doc_ref').val()
                        , ref_id: $('#txtitem_sheetout_id').val() 
                        , transac_type : 5
                        , goodid: '39249'
                        , quantity: parseInt($('#txt_CalcsheetAmnt').val() - $('#txt_CalcsheetAmnt_rema').val())
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data.statusText = 'OK')
                        {
                            aDisplay_SheetReCalc($('#txtitem_sheetout_id').val()); //ref_id
                        }
                       
                    }
                })

            }

            function aDisplay_SheetReCalc(ref_id) {

              
                $.ajax({
                    url: '../../xTransaction/srv_transaction_adjust.asmx/aDisplay_SheetReCalc',
                    method: 'post',
                    data: {

                        action: 'aDisplay_SheetReCalc'
                        ,ref_id : ref_id
                    },
                    dataType: 'json',
                    success: function (data) {
                        
                        
                        if (data != '') {
                            //alert(data.statusText);
                            
                            $.each(data, function (i, item) {
                                $('#txt_CalcsheetAmnt_rema').val(numeral(data[i].Rema_quantity).format('0,0.0000'));
                            });
                            ProgressOff();
                            Swal.fire(
                                'Good job!',
                                'You clicked the button!',
                                'success'
                            )
                        }

                    }
                })

            }

            function fn_GetwireItems() {
                
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/wDisplay',
                    method: 'post',
                    data: {

                        action: 'wDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            var tbl_wire_items = $('#tbl_wire_items').DataTable();

                            tbl_wire_items.clear();

                            $.each(data, function (i, item) {
                                tbl_wire_items.row.add([

                                    '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].matr_goodcode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname1 + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetwireItemsById(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" title="' + data[i].goodid + '" data-placement="right" title="Edit:' + data[i].sys_doc_ref + '"  style="font-size: 15px;color:#16c79a"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                            });
                            tbl_wire_items.draw();
                        }
                        else
                        {

                        }
                    }
                })
                $('#modal_wire_item').modal('show');
            }

            function fn_GetwireItemsById(goodid) {

                var wirelemgth = parseFloat($('#oQuantity').val()).toFixed(2) * 1.30;

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/wDisplayByid',
                    method: 'post',
                    data: {

                        action: 'wDisplayById'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#wmatr_goodname').val(data[i].goodname1);
                                $('#wmatr_goodid').val(data[i].goodid);
                                $('#txt_wirelength_amnt').val(numeral(wirelemgth).format('0,0.00'));
                                fn_wireCalc()
                                $('#sidGo').focus();
                            });

                           

                        }
                        else {

                        }
                    }
                })
                $('#modal_wire_item').modal('hide');
            }

            function fn_wRecalcQuantity() {
                ProgressOn();
                var oQuantity = parseFloat($('#oQuantity').val());

                $('#txt_wirelength_amnt').val(numeral(oQuantity * 1.3).format('0,0.00'));
                $('#txt_wirelength_amnt').val(numeral(oQuantity * 1.3).format('0,0.00'));
                
                    
                ProgressOff();

            }


            function fn_wireCalc() {
               
                ProgressOn();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/fn_wireCalc',
                    method: 'post',
                    data: {

                        action: 'wCalcamnt'
                        , goodid: $('#wmatr_goodid').val()
                        , wtotalQty: $('#txt_wirelength_amnt').val()
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                           
                            $.each(data, function (i, item) {
                                //alert(data[i])
                                if (data[i] == 'กรุณาตรวจสอบจำนวนตะแกรง')
                                {
                                    Swal.fire({
                                        icon: 'error',
                                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนตะแกรงคงเหลือ</strong></div>'
                                    })

                                }
                                else
                                {
                                    $('#txt_CalcwireAmnt').val(numeral(data[i]).format('0,0.00'));
                                    $('#txt_CalcwireAmnt1').val(data[i]);
                                }
                            });

                            ProgressOff();

                        }
                        else {
                            alert(1);
                        }
                    }
                })

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
                                    <a href="#" class="txtSecondHeader"><strong>Material Record : บันทึกรายการรับวัตถุดิบ</strong></a>
                                    <%--<span class="pull-right">
                                            <button type="button" id="btnReload" name="btnReload" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="GetDataPageMenuAllReload()" data-toggle="tooltip" title="Reload">
                                                <i class="fa fa-refresh"></i>
                                            </button>
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick=" getNewrvid(1)" data-toggle="tooltip" title="New Project!" style="color:#57cc99;border-color:#57cc99;background-color:#fff";>
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group hidden">
                                                <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>--%>
                                </span>
                                <span class="description txtLabel">Monitoring progression of projects</span>
                                
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Custom Tabs -->
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab" >
                                        <%--<li class="active "><a href="#tab_Coil"  class="txtLabel" data-toggle="tab">Coil</a></li>--%>
                                        <li  class="active maincolor" style="border-top-right-radius:3px;border-top-left-radius:3px"><a href="#tab_Coil"  class="txtLabel" data-toggle="tab" ><strong><i class="fa fa-leaf margin-r-5"></i>Coil</strong></a></li>
                                        <li  style="border-top-right-radius:3px;border-top-left-radius:3px"><a href="#tab_Sheet" class="txtLabel" id="tab_sheet" data-toggle="tab" ><strong><i class="fa fa-reorder margin-r-5"></i>Sheet</strong></a></li>
                                        <li  style="border-top-right-radius:3px;border-top-left-radius:3px"><a href="#tab_matroption" id="tab_option" class="txtLabel" data-toggle="tab" ><strong><i class="fa fa-cube margin-r-5"></i>Option-Part</strong></a></li>
                                        <li  style="border-top-right-radius:3px;border-top-left-radius:3px"><a href="#tab_matrmesh" id="tab_mesh" class="txtLabel hidden" data-toggle="tab" ><strong><i class="fa fa-share-alt margin-r-5"></i>From Winspeed</strong></a></li>
                                        <li  style="border-top-right-radius:3px;border-top-left-radius:3px"><a href="#tab_matrscrew" id="tab_screw" class="txtLabel" data-toggle="tab" ><strong><i class="fa fa-wrench margin-r-5"></i>Screw</strong></a></li>
                                        
                                        <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab_Coil">
                                            <div class="row">
                                                <div class="col-md-12 txtLabel">
                                                    <a href="javascript:void(0)" class="pull-right checkbox-toggle" id="btn_ctransacnewid" data-toggle="tooltip" title="New!"><strong><i class="fa fa-plus" style="font-size: 12px"></i> New</strong></a>

                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                                </div>
                                            </div>
                                            
                                            <%--  --%>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="jumbotron txtLabel" style="border-radius:3px;border:12px 12px 12px 12px">
                                                    <Label>Receive : Coils</Label> 
                                                </div>
                                                </div>
                                                
                                               </div>
                                            
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_matr_receive_coil" style="cursor: pointer; border-radius: 3px; width: 100%">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Docu Date</th>
                                                                <th>Docu Ref.</th>
                                                                <th>Supplier</th>
                                                                <th>Matetial Name</th>
                                                                <th>Price/Unit</th>
                                                                <th>Quantity</th>
                                                                <th>Total Amount</th>
                                                                <th style="width: 20px">#</th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>


                                      </div>
                                        <!-- /.tab-pane -->
                                        <div class="tab-pane" id="tab_Sheet">
                                            <div class="row">
                                                <div class="col-md-12 txtLabel">
                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                                    <a href="javascript:void(0)" class="pull-right checkbox-toggle" id="btn_stransacnewid" data-toggle="tooltip" title="New!"><strong><i class="fa fa-plus" style="font-size: 12px"></i> New</strong></a>

                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="jumbotron txtLabel" style="border-radius: 3px">
                                                        <label>Receive : Sheets</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_matr_receive_sheet" style="cursor: pointer; border-radius: 3px">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Docu Date</th>
                                                                <th>Docu cRef.</th>
                                                                <th>Packing No</th>
                                                                <th>GoodName</th>
                                                                <th>Quantity</th>
                                                                <th>Service Price</th>
                                                                <th>Unit/Price</th>
                                                                <th style="width: 20px">#</th>

                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                           
                                      </div>
                                        <!-- /.tab-pane -->
                                        <div class="tab-pane" id="tab_matroption" >
                                            <div class="row">
                                                <div class="col-md-12 txtLabel">
                                                  
                                                    <a href="javascript:void(0)" class="pull-right" id="btn_otransacnewid"><i class="fa fa-plus" style="font-size: 12px"></i><strong> New</strong></a>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="jumbotron txtLabel">
                                                        <label>Receive : Path-Option</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <table class="table table-bordered table-striped txtLabel text-center table-hover table-sm" id="tbl_matr_receive_part" style="cursor: pointer; border-radius: 3px">
                                                        <thead>
                                                            <tr>
                                                                <th>Docu Date</th>
                                                                <th>Docu NO.</th>
                                                                <th>Item Part</th>
                                                                <th>Service</th>
                                                                <th>Quantity</th>
                                                                <th>Price/Unit</th>
                                                                <th>Amount</th>

                                                                <th style="width: 20px">#</th>

                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>    

                                           <div id="divDisabled" class="row odisabled">
                                                <div class="col-md-12" style="font-weight: 100">
                                                  
                                                  
                                            </div>


                         
                                        </div>
                         
                                        </div>


                                        <!-- /.tab-pane -->
                                        <div class="tab-pane" id="tab_matrmesh" >
                                             <div class="col-md-12 txtLabel" style="margin-bottom:3px">
                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                                 <a href="javascript:void(0)" class="pull-right" id="btn_mGetlastid"><strong><i class="fa fa-plus" style="font-size:12px"></i> New</strong></a>
                                               
                                            </div>

                                             <div class="row" style="margin-left:12px;margin-right:12px">
                                                <div class="col-md-12  jumbotron txtLabel" style="border-radius:3px">
                                                    Receive : Mesh
                                                </div>
                                                
                                            </div>
                                           <div id="mDisabled" class="row mdisabled">
                                                <div class="col-md-12" style="font-weight: 100">
                                                    <div class="form-horizontal">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">เลขที่อ้างอิง : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                            
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="out_cpuit" id="txt_msysdoccode" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px"  disabled/>
                                                                                <input type="text" name="out_cpuit" id="mid" class="form-control txtLabel"  disabled/>
                                                                               
                                                                                

                                                                               


                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">รายการ : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                            
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_GoodName" id="txtm_GoodName" class="form-control txtLabel"  disabled/>
                                                                                <input type="text" name="txtm_GoodID" id="txtm_GoodID" class="form-control txtLabel" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                

                                                                                <div id="mesh_itemgo" class="input-group-addon"  style="border-bottom-right-radius:3px;border-top-right-radius:3px;background-color:#00c0ef;cursor:pointer;" >
                                                                                    <label class="txtLabel"   style="margin-bottom:auto;font-weight:500;cursor:pointer;color:azure">Go..</label>
                                                                                </div>


                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                     </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-sm-3 control-label txtLabel">เลขที่เอกสาร :</label>
                                                                        
                                                                        
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-code-fork"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_InvNo" id="txtm_InvNo" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px" />
                                                                            </div>
                                                                          
                                                                        </div>
                                                                    </div>
                                                                     
                                                                    
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-sm-3 control-label txtLabel">วันที่เอกสาร : </label>
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-calendar"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_DocuDate" id="txtm_DocuDate" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                
                                                            </div>
                                                        </div>


                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    
                                                                     
                                                                    
                                                                </div>
                                                                <div class="col-md-6">
                                                                   
                                                                </div>

                                                            </div>
                                                        </div>

                                                       <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">Supplier : </label>
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-calendar"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_VendorName" id="txtm_VendorName" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                                                <input type="text" name="txtm_VendorID" id="txtm_VendorID" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                                            </div>

                                                                        </div>
                                                                           
                                                                        </div>
                                                                    
                                                                </div>
                                                                <div class="col-md-6">
                                                                   
                                                                </div>
                                                            </div>

                                                            </div>
                                                      

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group" style="padding: 0px">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">จำนวน : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-bolt" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oQuantity" id="txtm_GoodQty2" class="form-control txtLabel text-right" />
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">ม้วน</div>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">จำนวนชิ้น : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oCostservice" id="txtm_GoodQtyPcs" class="form-control txtLabel text-right"  />
                                                                                 <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">ชิ้น</div>
                                                                                </div>
                                                                            </div>
                                                                           
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel ">ราคาต่อหน่วย : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oPriceperunits" id="txtm_priceperunit" class="form-control txtLabel text-right" disabled />
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">บาท/ชิ้น</div>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">ยอดรวม :</label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oRemark" id="txtm_GoodAmnt" class="form-control txtLabel text-right" style="padding-left: 0px;" />
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">บาท</div>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                 <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">Remark :</label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oRemark" id="mRemark" class="form-control txtLabel" style="padding-left: 0px;border-bottom-right-radius:3px;border-top-right-radius:3px" />
                                                                                
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                               
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                    <button type="button" class="btn btn-md pull-left txtLabel hidden"  style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-right txtLabel"  onclick="mtstSavedata(4)" style="background-color: #57cc99; color: azure; border-radius: 3px"><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                                                                </div>
                                                                
                                                                <%--<button type="button" class="btn btn-md btn-info pull-left txtLabel" onclick="$('#coil-selected').dropselect('select','39252')" style="background-color: #f94144; color: azure; border-radius: 3px">Get Cbb</button>--%>
                                                                <%--<button class="btn btn-default" type="button" onclick="$('#fruit-select').dropselect('selcte','pear');"> Manually select "pear" using javascript </button>--%>
                                                                
                                                            </div>
                                                        </div>
                                                    
                                                </div>
                                            </div>


                         
                                        </div>
                         
                                        </div>

                                        <div class="tab-pane" id="tab_matrscrew" >
                                             <div class="col-md-12 txtLabel" style="margin-bottom:3px">
                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                                 <a href="javascript:void(0)" class="pull-right" id="btn_GetScrewNewID"><strong><i class="fa fa-plus" style="font-size:12px"></i> New</strong></a>
                                               
                                            </div>

                                             <div class="row" style="margin-left:12px;margin-right:12px">
                                                <div class="col-md-12  jumbotron txtLabel" style="border-radius:3px">
                                                    Receive : Screw
                                                </div>
                                                
                                            </div>
                                           <div id="scDisabled" class="row scdisabled">
                                                <div class="col-md-12" style="font-weight: 100">
                                                    <div class="form-horizontal">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">เลขที่อ้างอิง : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                            
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="out_cpuit" id="txtsc_sys_code" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px"  disabled/>
                                                                                <input type="text" name="out_cpuit" id="scid" class="form-control txtLabel hidden"  disabled/>
                                                                               
                                                                                

                                                                               


                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">รายการ : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                            
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_GoodName" id="txtsc_GoodName" class="form-control txtLabel"  disabled/>
                                                                                <input type="text" name="txtm_GoodID" id="txtsc_GoodID" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                

                                                                                <div id="screw_itemgo" class="input-group-addon"  style="border-radius:0px 3px 3px 0px;background-color:#D6D6D6;cursor:pointer;" >
                                                                                    <label class="txtLabel"   style="margin-bottom:auto;font-weight:500;cursor:pointer;color:azure">Go..</label>
                                                                                </div>


                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                     </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-sm-3 control-label txtLabel">เลขที่เอกสาร :</label>
                                                                        
                                                                        
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-code-fork"></i>
                                                                                </div>
                                                                                <input type="text" name="txtm_InvNo" id="txtsc_InvNo" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px" />
                                                                            </div>
                                                                          
                                                                        </div>
                                                                    </div>
                                                                     
                                                                    
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-sm-3 control-label txtLabel">วันที่เอกสาร : </label>
                                                                        <div class="col-sm-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-calendar"></i>
                                                                                </div>
                                                                                <input type="text" name="txtsc_DocuDate" id="txtsc_DocuDate" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" placeholder="yyyy-MM-dd" />
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                
                                                            </div>
                                                        </div>


                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    
                                                                     
                                                                    
                                                                </div>
                                                                <div class="col-md-6">
                                                                   
                                                                </div>

                                                            </div>
                                                        </div>

                                                      

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group" style="padding: 0px">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">จำนวนตัว : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-bolt" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oQuantity" id="txtsc_qty" class="form-control txtLabel text-right" />
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">ตัว</div>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">ราคาต่อหน่วย : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oCostservice" id="txtsc_priceperunit" class="form-control txtLabel text-right"  />
                                                                                 <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">บาท/ตัว</div>
                                                                                </div>
                                                                            </div>
                                                                           
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel ">ราคารวม : </label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oPriceperunits" id="txtsc_amnt" class="form-control txtLabel text-right" disabled />
                                                                                <div class="input-group-addon" >
                                                                                    <div class="txtLabel">บาท</div>
                                                                                </div>
                                                                                <div id="screw_Getamntgo" class="input-group-addon"  style="border-radius:0px 3px 3px 0px;background-color:#D6D6D6;cursor:pointer;" >
                                                                                    <label class="txtLabel"   style="margin-bottom:auto;font-weight:500;cursor:pointer;color:azure"><i class="icofont-calculations"></i></label>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="col-md-3 control-label txtLabel">Remark :</label>
                                                                        <div class="col-md-9">
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oRemark" id="txtsc_Remark" class="form-control txtLabel" style="padding-left: 0px;border-bottom-right-radius:3px;border-top-right-radius:3px" />
                                                                                
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                 <div class="col-md-6">
                                                                    
                                                                </div>
                                                               
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                    <button type="button" class="btn btn-md pull-left txtLabel hidden" 
                                                                        style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-right txtLabel" id="btnSaveScrew" onclick="sctstSavedata(5)" style="background-color: #D6D6D6; color: azure; border-radius: 3px" disabled><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                                                                </div>
                                                                
                                                                <%--<button type="button" class="btn btn-md btn-info pull-left txtLabel" onclick="$('#coil-selected').dropselect('select','39252')" style="background-color: #f94144; color: azure; border-radius: 3px">Get Cbb</button>--%>
                                                                <%--<button class="btn btn-default" type="button" onclick="$('#fruit-select').dropselect('selcte','pear');"> Manually select "pear" using javascript </button>--%>
                                                                
                                                            </div>
                                                        </div>
                                                    
                                                </div>
                                            </div>


                         
                                        </div>
                         
                                        </div>
                                    </div>

                                    <!-- /.tab-content -->


                                    <br />
                                </div>

                                <!-- nav-tabs-custom -->

                            </div>
                        </div>
                        <%-- first start here--%>
                        <div class="box-body txtLabel">

                            <div class="col-md-4">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <div class="row" id="rb_mesh" style="display:none">
            <div class="col-md-12">
                <div class="box box-primary" style="border-radius: 5px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_mesh" style="cursor: pointer;border-radius:3px"> 
                                <thead>
                                    <tr>
                                    <th>วันที่เอกสาร</th>
                                    <th>เลขที่เอกสาร</th>
                                    <th>รายการ</th>
                                    <th>จำนวน</th>
                                    <th>ราคา/หน่วย</th>
                                    <th>จำนวนเงิน</th>
                                    
                                    <th style="width:20px">#</th>
                                    
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

                <div class="row" id="rb_screw" style="display:none">
            <div class="col-md-12">
                <div class="box box-primary" style="border-radius: 5px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_screw" style="cursor: pointer;border-radius:3px"> 
                                <thead>
                                    <tr>
                                    <th>วันที่เอกสาร</th>
                                    <th>เลขที่เอกสาร</th>
                                    <th>รายการ</th>
                                    <th>จำนวน</th>
                                    <th>ราคา/หน่วย</th>
                                    <th>จำนวนเงิน</th>
                                    
                                    <th style="width:20px">#</th>
                                    
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        


        <div class="modal fade " id="MdAddReceive" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important">
            <div class="modal-dialog" style="border-bottom-left-radius: 5px;">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="txtLabel">กลุ่มวัตถุดิบ</label>
                                </div>
                            </div>
                            <div class="col-md-8">
                                ddd
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>


        <div class="modal fade " id="MdGetcRef" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;border-radius:3px" >
            <div class="modal-dialog" style="border-bottom-left-radius: 5px;">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการสั่งซื้อวัตถุดิบ : Coils</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel elRadius5px" id="smatr_crefmd">
                                <thead class="txtLabel">
                                    <tr>
                                        <th class="text-center">วันที่</th>
                                        <th class="text-center">เลขที่ Inv.</th>
                                        <th class="text-center">ราคาต่อหน่อย</th>
                                        <th class="text-center">จำนวน</th>
                                        <th class="text-center">ยอดรวม</th>
                                        <th class="text-center" style="width:20px">#</th>
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
                        <button type="button" class="btn btn-primary txtLabel hidden" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_getref_osheet" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content"  style="border-radius: 10px;" >
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_getref_osheet" style="border-radius:3px;">
                                <thead>
                                    <tr>
                                        <th class="text-center">Docu Date</th>
                                        <th class="text-center">Item Name</th>
                                        <th class="text-center">Supplier</th>
                                        <th class="text-center">Quantity</th>
                                        <th class="text-center">Price/Unit</th>
                                        <th class="text-center">TOTAL Amount</th>
                                        <th class="text-center">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_omatr_itemdisplay" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content"  style="border-radius: 10px;" >
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_omatr_itemdisplay" style="border-radius:3px;width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-center">โค๊ด</th>
                                        <th class="text-center">ชื่อวัตถุดิบ</th>
                                        <th class="text-center" style="width:20px">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_matr_sheettransac" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content"  style="border-radius: 10px;" >
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_matr_sheettransac" style="border-radius:3px;width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-center">วันที่</th>
                                        <th class="text-center">เลขที่เอกสาร</th>
                                        <th class="text-center">วัตถุดิบ</th>
                                        <th class="text-center">เลขแพ๊กกิ้ง</th>
                                        <th class="text-center">ราคา/หน่วย</th>
                                        <th class="text-center">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
         <div class="modal fade " id="md_omatr_mdsheetforpart_oDisplay" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important">
            <div class="modal-dialog" style="border-bottom-left-radius: 5px;width:60%">
                <div class="modal-content" style="border-radius: 5px;">
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Part</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_sheetpay" style="border-radius:3px;width:100%">
                                <thead class="txtLabel">
                                    <tr width:100%">
                                        <th class="text-center">วันที่</th>
                                        <th class="text-center">เลขอ้างอิง</th>
                                        <th class="text-center">วัตถุดิบ</th>
                                        <th class="text-center">ราคาต่อหน่วย</th>
                                        <th class="text-center">จำนวน</th>
                                        <th class="text-center">จำนวนรับ</th>
                                        <th class="text-center">คงเหลือ</th>

                                        <th class="text-center">#</th>
                                    </tr>
                                    
                                </thead>
                                <tbody class="txtLabel">
                                   
                                </tbody>
                            </table>
                            </div>
                            
                        </div>
                        <hr />
                       
                       
                        </div>
                        <div class="row">
                            <div class="spinner" style="left:50%;top:65%"> </div>
                            <div class="col-md-12 txtLabel">
                                
                                <div class="col-md-12">
                                    <input type="text" name="name" id="txtpart_transac_item_id" class="hidden" value="" />
                                    <input type="text" name="name" id="txtpart_transacid" class="hidden" value="" />
                                    <input type="text" name="name" id="txtsheet_priceperunit" class="hidden" value="" />
                                    
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel overlay" id="tbl_partreceive" style="border-radius:3px;width:100%">
                                <thead class="txtLabel">
                                    <tr width:100%">
                                        <th class="text-center">วัตถุดิบ</th>
                                        <th class="text-center">จำนวนทั้งหมด</th>
                                        <th class="text-center">จำนวนรับแล้ว</th>
                                        <th class="text-center">จำนวนค้างรับ</th>
                                        <th class="text-center">#</th>
                                    </tr>
                                    
                                </thead>
                                <tbody class="txtLabel">
                                   
                                </tbody>
                            </table>
                           </div>
                        </div>
                           
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" style="background-color: #43B94A; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>


        <div class="modal fade " id="modal_mesh_transac" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content"  style="border-radius: 10px;" >
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label for="matr_group" class="col-sm-3 control-label txtLabel" style="padding: 0px 0px 0px 0px">รายการวัตถุดิบ : </label>

                                    
                                        <div class="txtLabel col-md-9">
                                            <select id="select_optionwsp" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                <option value=""> --- เลือกวัตถุดิบ --- </option>
                                                <option value="39245">V4 จั่ว-โปร่งแสง</option>
                                                <option value="39255">BOLT SUS 304 BSW 1/4"x3/4"</option>
                                                <option value="28111">BOLT SUS 304 BSW 1/4"x1/2"</option>
                                                <option value="28112">NUT SUS 304 1/4"</option>
                                                <option value="28113">แหวนอีแปะ SUS 304 1/4"</option>
                                                <option value="39256">แหวนอีแปะ SUS 304 1/4" 6 มม. ขอบ 20 มม.</option>
                                                <option value="39248">ลวดตาข่าย Gavanized 90cmx30m</option>
                                                <option value="39293">ลวดตาข่าย Stainless 1/4"ลวด#24 90cmx30m</option>
                                                <option value="28106">Dekseal True Blue Smooth B,14 G</option>
                                            </select>

                                        </div>
                            </div>
                            </div>
                            
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_mesh_transac" style="border-radius:3px;width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-center">วันที่</th>
                                        <th class="text-center">เลขที่ Inv.</th>
                                        <th class="text-center">รายการ</th>
                                        <th class="text-center">จำนวน</th>
                                        <th class="text-center">ราคา/หน่วย</th>
                                        <th class="text-center">ราคารวม</th>
                                        <th class="text-center">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_screw_transac" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" >
                <div class="modal-content"  style="border-radius: 5px;width:120%" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Screw</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_screw_transac" style="border-radius:3px;width:100%">
                                <thead class="txtLabel">
                                    <tr>
                                        <th class="text-center">รหัสสกรู</th>
                                        <th class="text-center">ชื่อสกรู</th>
                                        <th class="text-center">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>


        <div class="modal fade " id="modal_wire_item" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" >
                <div class="modal-content"  style="border-radius: 5px;width:120%" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการลวด V8</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_wire_items" style="border-radius:3px;width:100%">
                                <thead class="txtLabel">
                                    <tr>
                                        <th class="text-center">รหัสลวด</th>
                                        <th class="text-center">ชนิดลวด</th>
                                        <th class="text-center">#</th>
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
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_RvCoils" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog modal-lg" >
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Coils</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                               

                                <div id="divcDisabled" class="row cdisabled">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">เลขที่อ้างอิง : </label>
                                                    <div class="input-group">

                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-lightbulb-o"></i>
                                                        </div>
                                                        <input type="text" name="out_cpuit" id="txt_csys_doc_ref" class="form-control txtLabel css-require input-Radius-right" disabled />
                                                        <%--<input type="text" name="out_cpuit" id="oid" class="form-control txtLabel hidden"  disabled/>--%>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">เลขที่เอกสาร : </label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-cube" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" class="txtLabel form-control hidden" name="cid" id="cid" value="" />
                                                        <input type="text" name="matr_refno" id="matr_refno" class="form-control txtLabel css-require input-Radius-right" />
                                                        <%--<input type="text" name="cidx" id="cidx" class="form-control txtLabel" style="border-top-right-radius:3px;border-bottom-right-radius:3px" />--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel text-right">วันที่เอกสาร : </label>

                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0 0 3px">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" name="matr_date" id="matr_date" class="form-control txtLabel has-success input-Radius-right" placeholder="yyyy-MM-dd" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">Supplier :</label>
                                                    <select id="selectedsupplier" class="txtLabel" style="width: 100%; text-align: justify; height: 34px; border-radius: 3px" name="state">
                                                        <option value="">-- เลือก Supplier -- </option>
                                                        <option value="15224">บริษัท ตรีมิตรมาร์เก็ตติ้ง จำกัด</option>
                                                        <option value="15029">บริษัท เอ็นเอส บลูสโคป (ประเทศไทย) จำกัด</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel text-right">รายการวัตถุดิบ : </label>
                                                    <select id="selectedcoils" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="">-- เลือก Coils Material -- </option>
                                                        <option value="39251">Zincalum AZ 150 G300</option>
                                                        <option value="39252">Zincalum AZ 150 G550</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-4">
                                                <label for="matr_group" class="control-label txtLabel">จำนวน : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-bolt" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="matr_qty" id="matr_qty" class="form-control txtLabel text-right numeric" />
                                                    <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                        <span class="txtLabel">KG.</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">ราคารวมทั้งหมด : </label>

                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-btc" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="matr_amnt" id="matr_amnt" class="form-control css-require txtLabel text-right" />
                                                        <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                            <span class="txtLabel">บาท</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">
                                                        ราคาต่อหน่วย : 
                                                    </label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-btc" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="matr_perunit" id="matr_perunit" class="form-control txtLabel text-right" />
                                                        <div id="idGo" class="input-group-addon checkbox-toggle" onclick="calPerUnit()" data-toggle="tooltip" title="Calculate!" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #D6D6D6; cursor: pointer;">
                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-calculations"></i></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">Remark :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="matr_perunit" id="matr_remark" class="form-control txtLabel" style="padding-left: 0px; border-bottom-right-radius: 3px; border-top-right-radius: 3px" />

                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <div id="txtMsgRemark"></div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                    
                                </div>

                            </div>
                            
                        </div>

                    </div>

                    <div class="modal-footer">
                        
                         <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                         <button type="button" class="btn btn-md pull-left txtLabel hidden" onclick="text_cssrequired()" style="background-color: #f94144; color: azure; border-radius: 3px">Clearx</button>
                        <button type="button" class="btn btn-md pull-right txtLabel checkbox-toggle" id="btnCoilSave" onclick="tstSavedata(1)" data-toggle="tooltip" title="Save Coils" style="background-color: #D6D6D6; color: azure; border-radius: 3px" disabled><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="modal_RvSheet" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog modal-lg" >
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Sheet</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel text-right">เลขที่อ้างอิง :</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px" aria-disabled>
                                                        <i class="fa fa-lightbulb-o" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="smatr_CoilRef" id="txt_ssys_doc_ref" class="form-control txtLabel" disabled style="border-radius: 0px 3px 3px 0px" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">เลขที่เอกสาร :</label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-code-fork" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="sdocu_no" id="sdocu_no" class="form-control txtLabel" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel" style="padding: 3px 0 0 0">วันที่เอกสาร : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" name="matr_date" id="smatr_date" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" placeholder="yyyy-MM-dd" />
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel text-right">Coils อ้างอิง : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon input-Radius-left" aria-disabled style="border-radius: 3px 0px 0px 3px">
                                                        <i class="fa fa-link" aria-hidden="true"></i>
                                                    </div>

                                                    <input type="text" name="smatr_CoilRef" id="smatr_CoilRef" class="form-control txtLabel" disabled />
                                                    <input type="text" name="smatr_CoilRefid" id="smatr_CoilRefid" class="form-control txtLabel hidden" placeholder="smatr_CoilRefid" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="out_cref" id="out_cref" class="form-control txtLabel hidden" placeholder="out_cref" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="out_cmatr_code" id="out_cmatr_code" class="form-control txtLabel hidden" placeholder="out_cmatr_code" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="out_cqty" id="out_cqty" class="form-control txtLabel hidden" placeholder="out_cqty" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="out_camnt" id="out_camnt" class="form-control txtLabel hidden" placeholder="out_camnt" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="out_cpuit" id="out_cpunit" class="form-control txtLabel hidden" placeholder="out_cpunit" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <input type="text" name="sid" id="sid" class="form-control txtLabel hidden" placeholder="sid" style="border-bottom-left-radius: 3px; border-top-left-radius: 3px" disabled />
                                                    <div id="idsGo" class="input-group-addon checkbox-toggle" data-toggle="tooltip" title="เลือกCoils" onclick='tsttblDisplayCoilMd()' style="border-radius: 0px 3px 3px 0px; background-color: #D6D6D6; cursor: pointer;">
                                                        <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="fa fa-leaf margin-r-5"></i></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">ราคา Coil อ้างอิง</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-btc" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="smatr_CoilAmnt" id="smatr_CoilAmnt" class="form-control txtLabel text-right" disabled />
                                                    <input type="text" name="smatr_CoilAmnt1" id="smatr_CoilAmnt1" class="form-control txtLabel hidden " style="border-radius: 3px" disabled />
                                                    <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                        <label class="txtLabel" style="margin-bottom: 0px">บาท</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">เลขที่แพ็ค :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-tag" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="smatr_packno" id="smatr_packno" class="form-control txtLabel" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">Supplier : </label>


                                                <div class="txtLabel">
                                                    <select id="selectedsuppliersheet" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="">--- เลือก Supplier ---</option>
                                                        <option value="15035">บจก.บางกอกแปซิฟิคสตีล จำกัด</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel" style="padding: 0px 0px 0px 0px">รายการวัตถุดิบ : </label>


                                                <div class="txtLabel">
                                                    <select id="selectedsheet" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="">--- เลือกวัตถุดิบ --- </option>
                                                        <option value="39249">Sheet S1 G300</option>
                                                        <option value="39250">Sheet S1 G550</option>
                                                    </select>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">จำนวน : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-bolt" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="smatr_qty" id="smatr_qty" class="form-control txtLabel text-right" />
                                                    <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                        <label class="txtLabel" style="margin-bottom: 0px">แผ่น</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">ค่าบริการตัดซอย : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-btc" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="costservice" id="costservice" class="form-control txtLabel text-right" />
                                                    <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                        <label class="txtLabel" style="margin-bottom: 0px">บาท</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel text-right" style="padding-right: 0px">ราคาต่อหน่วย : </label>

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-btc" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="priceperunit" id="priceperunit" class="form-control txtLabel text-right" disabled />

                                                    <div id="oGo" class="input-group-addon checkbox-toggle" data-toggle="tooltip" title="Calculate!" onclick="scalPerUnit()" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #D6D6D6; cursor: pointer;">
                                                        <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-calculations"></i></label>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel" style="padding-right: 0px">ราคารวมทั้หงมด :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-btc" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="samount" id="samount" class="form-control txtLabel text-right" />
                                                    <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                        <label class="txtLabel" style="margin-bottom: 0px">บาท</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel" style="padding-right: 0px">Remark :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-commenting-o" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="stxtRemar" id="stxtRemark" class="form-control txtLabel text-right" style="border-radius: 0 3px 3px 0px" />

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                        <button type="button" class="btn btn-md pull-right txtLabel checkbox-toggle" data-toggle="tooltip" title="Save Sheet!" id="btnsheetSave" onclick="ststSavedata(2)" style="background-color: #D6D6D6; color: azure; border-radius: 3px" disabled><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                         
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
      </div>

        <div class="modal fade " id="modal_RvPart" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog modal-lg" >
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Sheet</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                               
                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">เลขที่อ้างอิง : </label>
                                                                            <div class="input-group">
                                                                            
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="out_cpuit" id="txt_sysdoccode" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px"  disabled/>
                                                                                <input type="text" name="out_cpuit" id="oid" class="form-control txtLabel hidden"  disabled/>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">เลขที่เอกสาร :</label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-code-fork"></i>
                                                                                </div>
                                                                                <input type="text" name="odocu_no" id="odocu_no" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px" />
                                                                            </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="matr_group" class="control-label txtLabel">วันที่เอกสาร : </label>
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                            <i class="fa fa-calendar"></i>
                                                                        </div>
                                                                        <input type="text" name="matr_date" id="odocu_date" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" placeholder="yyyy-MM-dd" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                                    
                                                            </div>

                                                     </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-4">
                                                                        <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">Part : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-lightbulb-o"></i>
                                                                                </div>
                                                                                <input type="text" name="out_cpuit" id="txtitem_goodname" class="form-control txtLabel"  disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_goodcode" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_sheetout_id" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_sheetid" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                               
                                                                                <input type="text" name="out_cpuit" id="txtitem_sys_doc_ref" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_priceperunit" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_partarea" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_balance" class="form-control txtLabel hidden"  style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_sheetpriceperunit" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_rvremaining" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_v7inc" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_rmsheet" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <input type="text" name="out_cpuit" id="txtitem_rowCount" class="form-control txtLabel hidden" style="border-bottom-left-radius:3px;border-top-left-radius:3px" disabled/>
                                                                                <div id="obtitemgo" data-toggle="tooltip" data-title="เลือก Part" class="input-group-addon"  style="border-radius:0px 3px 3px 0px;background-color: #D6D6D6;cursor:pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom:auto;cursor:pointer;color:azure;font-weight:600"><i class="fa fa-cubes" aria-hidden="true"></i></label>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="matr_group" class="control-label txtLabel">Supplier : </label>
                                                                    <div class="txtLabel">
                                                                        <select id="oselect_supplier" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                            <option value="15024">เจพี ดีไซน์ แอนด์ แมนูแฟคเจอร์ริ่ง เซอร์วิส จำกัด</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="matr_group" class="control-label txtLabel">ค่าตัดพับเจาะรู : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-btc" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="oCostservice" id="oCostservice" class="form-control txtLabel text-right" disabled/>
                                                                            <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                <div class="txtLabel">บาท/ชิ้น</div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                            </div>
                                                    </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-4">
                                                                <div class="form-group" style="padding: 0px">
                                                                        <label for="matr_group" class="control-label txtLabel">จำนวน Part ต้องการรับ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-bolt" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oQuantity" id="oQuantity" class="form-control txtLabel text-right" />
                                                                                <div class="input-group-addon" style="border-radius:0px 3px 3px 0px">
                                                                                    <div class="txtLabel">ชิ้น</div>
                                                                                </div>
                                                                            </div>
                                                                        
                                                                    </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="matr_group" class="control-label txtLabel ">ราคาต่อหน่วย : </label>

                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                            <i class="fa fa-btc" aria-hidden="true"></i>
                                                                        </div>
                                                                        <input type="text" name="oPriceperunits" id="oPriceperunits" class="form-control txtLabel text-right" disabled />
                                                                        <div id="sidGo" data-toggle="tooltip" data-title="คำนวนราคาทั้งหมด" class="input-group-addon" onclick="fn_Calc_opWithCostservice1()" style="border-radius: 0px 3px 3px 0px; background-color: #D6D6D6; cursor: pointer;" disabled>
                                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-calculations"></i></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">จำนวน Sheet :</label>
                                                                        <a class="pull-right hidden" id="btnAdjust"  onclick="rvPart_AotuAdjust()" style="cursor:pointer">Adjust Sheet</a>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_CalcsheetAmnt" id="txt_CalcsheetAmnt" class="form-control txtLabel text-right" style="padding-left: 0px;" />
                                                                                <input type="text" name="txt_CalcsheetAmnt" id="txt_CalcsheetAmnt_rema" class="form-control txtLabel text-right hidden" style="padding-left: 0px;" />
                                                                                <input type="text" name="txt_CalcsheetAmnt" id="txt_CalcsheetAmnt_diff " class="form-control txtLabel text-right hidden" style="padding-left: 0px;" />

                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">แผ่น</div>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="row hidden" id="divwirerow" >
                                                        <div class="col-md-12">
                                                            <div class="col-md-4">
                                                                <div class="form-group" style="padding: 0px">
                                                                        <label for="matr_group" class="control-label txtLabel">รายการลวดตะแกรง : </label>
                                                                        

                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-fire" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="wmatr_goodname" id="wmatr_goodname" class="form-control txtLabel text-right" disabled/>
                                                                                <input type="text" name="wmatr_goodid"  id="wmatr_goodid" class="form-control txtLabel text-right hidden" />

                                                                                <div id="widGo" data-toggle="tooltip" data-title="เลือกรายการลวดตาข่าย" class="input-group-addon" style="border-radius: 0px 3px 3px 0px; background-color: #D6D6D6; cursor: pointer;" disabled>
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="fa fa-th-list" aria-hidden="true"></i></label>
                                                                                </div>
                                                                            </div>
                                                                        
                                                                    </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="matr_group" class="control-label txtLabel ">จำนวนเมตร : </label>
                                                                    <a href="javascript:0" class="pull-right txtLabel" data-toggle="tooltip" data-title="reCalc" onclick="fn_wRecalcQuantity()"><i class="fa fa-refresh" aria-hidden="true" disabed></i></a>
                                                                   


                                                                    <div class="input-group">
                                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                            <i class="fa fa-btc" aria-hidden="true"></i>
                                                                        </div>
                                                                        <input type="text" name="txt_wirelength_amnt" id="txt_wirelength_amnt" class="form-control txtLabel text-right" disabled />
                                                                        <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                <div class="txtLabel">เมตร</div>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">ราคารวม :</label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_CalcsheetAmnt" id="txt_CalcwireAmnt" class="form-control txtLabel text-right" style="padding-left: 0px;" disabled/>
                                                                                <input type="text" name="txt_CalcsheetAmnt" id="txt_CalcwireAmnt1" class="form-control txtLabel text-right hidden" style="padding-left: 0px;" />
                                                                                
                                                                                <div id="widCalcGo" data-toggle="tooltip" data-title="คำนวณราคาลวดตะแกรง" class="input-group-addon" style="background-color: #3C8DBC; cursor: pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-calculations"></i></label>
                                                                                </div>
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">บาท</div>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">ยอดรวม :</label>
                                                                        
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-btc" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oRemark" id="oamount" class="form-control txtLabel text-right" style="padding-left: 0px;" />
                                                                                <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    <div class="txtLabel">บาท</div>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <div class="form-group">
                                                                        <label for="matr_group" class="control-label txtLabel">หมายเหตุ : </label>
                                                                        
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="oCostservice" id="oRemark" class="form-control txtLabel text-right"  />
                                                                                <%-- <div class="input-group-addon" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">
                                                                                    
                                                                                </div>--%>
                                                                            </div>
                                                                    </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-horizontal">
                                                       
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    
                                                                </div>

                                                                <div class="col-md-6">
                                                                    
                                                                    <%--<button type="button" class="btn btn-md pull-right txtLabel"  id="obtnSave3" onclick="otstSavedata(3)" style="background-color: #D6D6D6; color: azure; border-radius: 3px" disabled><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</button>--%>
                                                                </div>
                                                                
                                                                <%--<button type="button" class="btn btn-md btn-info pull-left txtLabel" onclick="$('#coil-selected').dropselect('select','39252')" style="background-color: #f94144; color: azure; border-radius: 3px">Get Cbb</button>--%>
                                                                <%--<button class="btn btn-default" type="button" onclick="$('#fruit-select').dropselect('selcte','pear');"> Manually select "pear" using javascript </button>--%>
                                                                
                                                            </div>
                                                        </div>
                                                    
                                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                       
                        <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                        <button type="button" class="btn btn-md pull-left txtLabel hidden" id="btnmd_omatr_mdsheetforpart_oDisplay" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                        <button type="button" class="btn btn-md pull-right txtLabel"  id="obtnSave3" onclick="otstSavedata(3)" style="background-color: #D6D6D6; color: azure; border-radius: 3px" disabled><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
      </div>

        <div class="modal fade " id="modal_rvscrew" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog modal-lg" >
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการรับ Sheet</strong></h4>
                    </div>
                    <div class="modal-body">
                        
                    </div>
                    <div class="modal-footer">
                       
                        
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
      </div>
    </section>
    <script>
        var cref, cdate, csupplier, citem, cqty, camnt, cpunit, cremark;
        var sref_c, scamnt, spackingno, sdocudate, ssupplier_code, smatr_code, sqty, samntservice, sperunit, sremark, sflag_status;
        function fnCoilSave() {
            cref = $('#matr_refno').val();
            cdate = $('#matr_date').val();
            //csupplier = $('#supplier-selected').dropselect('value');
            //citem = $('#coil-selected').dropselect('value');
            csupplier = $('#supplier-selected').val();
            citem = $('#coil-selected').val();
            cqty = $('#matr_qty').val();
            camnt = $('#matr_amnt').val();
            cpunit = $('#matr_perunit').val();
            cremark = $('#matr_remark').val();

        }

        function calPerUnit() {

            ProgressOn();

            if ($('#matr_qty').val() == '' && $('#matr_amnt').val() == '') {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนและราคารวม</strong></div>'

                })
            } else if ($('#matr_qty').val() == '' && $('#matr_amnt').val() != '') {

                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวน</strong></div>'

                })
            } else if ($('#matr_qty').val() != '' && $('#matr_amnt').val() == '') {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ กิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบราคารวม</strong></div>'

                })
            } else {
                var cal_cqty1 = $('#matr_qty').val();
                var cal_cqty2 = cal_cqty1.replace(',', '');
                var cal_camnt1 = $('#matr_amnt').val();
                var cal_camnt2 = cal_camnt1.replace(',', '');

                $('#matr_perunit').val(numeral(cal_camnt2).divide(cal_cqty2).format('0,0.0000'));
                $('#btnCoilSave').css({ 'background-color': ''})
                $('#btnCoilSave').addClass('btn-success');
                $('#btnCoilSave').prop('disabled', false);
            }

            ProgressOff();

        }


        function tstSavedata(matr_flag_group) {
            if ($('#cid').val() == '') { tstInsertdata(matr_flag_group); }
            else if ($('#cid').val() != '') { tstcUpdatedata(matr_flag_group); }
        }

        function ststSavedata(matr_flag_group) {
            if ($('#sid').val() == '') { //alert('ststSavedata : insert');
                tstInsertdata(matr_flag_group);
            }
            else if ($('#sid').val() != '') { //alert('tstcUpdatedata : update');
                tstcUpdatedata(matr_flag_group);
            }
        }

        function otstSavedata(matr_flag_group) {
            //alert('99989898');
            var rvremaining = parseFloat($('#txtitem_rvremaining').val());
            var oQuantity = parseFloat($('#oQuantity').val());

            if ($('#oid').val() == '') {
                if (oQuantity <= rvremaining) {
                    if ($('#odocu_date').val() == '') {
                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                            html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบวันรับสินค้า</strong></div>'

                        })
                    }
                    else {
                        tstInsertdata(matr_flag_group);
                    }

                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"> เนื่องจาก : รับ Part เกินจำนวนที่เหลือ ....</div>'

                    })
                }

            }
            else if ($('#oid').val() != '') { alert('otstcUpdatedata : update'); tstcUpdatedata(matr_flag_group); }
        }

        function mtstSavedata(matr_flag_group) {
            //alert(matr_flag_group);
            if ($('#mid').val() == '') { alert('mtstSavedata : insert'); tstInsertdata(matr_flag_group); }
            else if ($('#mid').val() != '') { alert('mtstcUpdatedata : update'); tstcUpdatedata(matr_flag_group); }
        }

        function sctstSavedata(matr_flag_group) {
            if ($('#scid').val() == '') { //alert('mtstSavedata : insert'); 
                tstInsertdata(matr_flag_group);
            }
            else if ($('#scid').val() != '') { //alert('mtstcUpdatedata : update'); 
                tstcUpdatedata(matr_flag_group);
            }
        }

        function tstInsertdata(matr_flag_group) {

            if (matr_flag_group == 1) { //1=coil Insert
                Swal.fire({
                    title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#57cc99',
                    cancelButtonColor: '#f94144',
                    confirmButtonText: '<div class="txtLabel"><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Yes, Saved!</strong></div>'
                }).then((result) => {
                    if (result.isConfirmed) {
                        if ($('#matr_date').val() == '' || $('#selectedcoils').val() == '') {
                            if ($('#matr_date').val() != '' && $('#selectedcoils').val() == '') {
                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">เลือกรายการวัตถุดิบ</strong></div>'

                                })
                            } else if ($('#matr_date').val() == '' && $('#selectedcoils').val() != '') {
                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ] </strong></div>',
                                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ใส่วันที่ในการรับวัตถุดิบ</strong></div>'

                                })
                            }
                            else if ($('#matr_date').val() == '' && $('#selectedcoils').val() == '') {
                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong> [ เกิดข้อผิดพลาด ] </strong></div>',
                                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">เลือกรายการวัตถุดิบ และ ใส่วันที่ในการรับวัตถุดิบ</strong></div>'

                                })
                            }
                        } else {
                            $.ajax({
                                url: '../../xTransaction/srv_transaction_in.asmx/ctstInsertdata',
                                method: 'POST',
                                data: {
                                    action: 'insert',
                                    create_by: usr_name,
                                    create_date: currentdate2,
                                    isdelete: 'false',
                                    isactive: 'true',
                                    matr_flag_group: matr_flag_group,
                                    matr_status_flag: 'false',
                                    matr_transac_type: '1',
                                    sys_doc_ref: $('#txt_csys_doc_ref').val(),
                                    doc_date: $('#matr_date').val(),
                                    doc_ref: $('#matr_refno').val(),
                                    matr_code: $('#selectedcoils').val(),
                                    supplier_code: $('#selectedsupplier').val(),
                                    quantity: $('#matr_qty').val(),
                                    priceperunit: $('#matr_perunit').val(),
                                    amount: $('#matr_amnt').val(),
                                    remark: $('#matr_remark').val()


                                },
                                dataType: 'json',
                                complete: function (data) {
                                    //alert(data.statusText);
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

                                                //alert(1);
                                                tsttblDisplayCoil();
                                                tstclearinput();
                                                $('#idGo').prop('disabled', true);
                                                $('#btnCoilSave').prop('disabled', true);
                                                $('#btnCoilSave').css('background-color', '#D6D6D6');


                                                $('#btnCoilSave').removeClass('btn-success');

                                                $('#divcDisabled').addClass('cdisabled');

                                                $('#modal_RvCoils').modal('hide');
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


                    }
                })
            }
            else if (matr_flag_group == 2) { // 2=sheet insert

                if ($('#smatr_date').val() == '' && $('#selectedsheet').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบวันที่เอกสารและเลือกรายการรับวัตถุดิบ</strong></div>'

                    })
                } else if ($('#smatr_date').val() != '' && $('#selectedsheet').val() == '') {

                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบและเลือกรายการรับวัตถุดิบ</strong></div>'

                    })
                } else if ($('#smatr_date').val() == '' && $('#selectedsheet').val() != '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบวันที่เอกสาร</strong></div>'

                    })
                } else {
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
                                url: '../../xTransaction/srv_transaction_in.asmx/ststInsertdata',
                                method: 'POST',
                                data: {
                                    action: 'sInsert',
                                    create_by: usr_name,
                                    create_date: currentdate2,
                                    isdelete: 'false',
                                    isactive: 'true',
                                    lotno: lotno,
                                    lottime: lottime,
                                    matr_flag_group: matr_flag_group,
                                    matr_status_flag: 'false',
                                    matr_transac_type: '1',

                                    sys_doc_ref: $('#txt_ssys_doc_ref').val(),
                                    ref_id: $('#smatr_CoilRefid').val(),
                                    doc_date: $('#smatr_date').val(),
                                    doc_ref: $('#out_cref').val(),
                                    doc_no: $('#sdocu_no').val(),
                                    matr_code: $('#selectedsheet').val(),
                                    supplier_code: $('#selectedsuppliersheet').val(),
                                    packingno: $('#smatr_packno').val(),
                                    costservice: $('#costservice').val(),
                                    quantity: $('#smatr_qty').val(),
                                    priceperunit: $('#priceperunit').val(),
                                    amount: $('#samount').val()


                                },
                                dataType: 'json',
                                complete: function (data) {
                                    console.log(data);
                                    if (data.statusText == 'OK') {
                                        //alert('success');
                                        Swal.fire({
                                            title: '<h3 class="txtLabel"><strong>บันทึกข้อมูลเรียบร้อย</strong></h3>',
                                            icon: 'success',
                                            confirmButtonColor: '#57cc99',
                                            cancelButtonColor: '#f94144',
                                            confirmButtonText: '<div class="txtLabel">Done</div>'
                                        }).then((result) => {
                                            if (result.isConfirmed) {

                                                //load table
                                                tsttblDisplayCoil();
                                                tsttblDisplaySheet();
                                                tsttblDisplayCoilMd();
                                                tstclearinput();
                                               

                                                $('#oGo').css({ 'background-color': '#D6D6D6' })
                                                $('#idsGo').css({ 'background-color': '#D6D6D6' })
                                                $('#btnsheetSave').css({ 'background-color': '#D6D6D6' });
                                                $('#btnsheetSave').removeClass('btn-success');
                                                $('#btnsheetSave').prop('disabled', true);
                                                $('#divsDisabled').addClass('sdisabled');


                                                $('#modal_RvSheet').modal('hide');
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


            }
            else if (matr_flag_group == 3) { //option part Insert
                //alert(333335)

                

                    
                Swal.fire({
                    title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#00a65a',
                    cancelButtonColor: '#d9534f',
                    confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                }).then((result) => {
                    if (result.isConfirmed) {

                        if ($('#txtitem_goodcode').val() == '28103') //V8 เนื่องจาก V8 ต้องมี Add ตะแกรงเพิ่ม
                        {
                            //alert(1);
                            $.ajax({
                                url: '../../xTransaction/srv_transaction_in.asmx/woInsert',
                                method: 'POST',
                                data: {
                                    action: 'oInsert'
                                    ,create_by: usr_name
                                    ,create_date: currentdate2

                                    ,matr_flag_group: 3
                                    ,matr_status_flag: 'false'
                                    ,matr_transac_type: '1'

                                    ,ref_id: $('#txtitem_sheetout_id').val()
                                    ,sys_doc_ref: $('#txt_sysdoccode').val() //
                                    ,doc_date: $('#odocu_date').val()
                                    ,doc_no: $('#odocu_no').val()
                                    ,matr_code: $('#txtitem_goodcode').val()
                                    ,supplier_code: $('#oselect_supplier').val()
                                    ,sRef_qty: $('#txt_CalcsheetAmnt').val()
                                    ,costservice: $('#oCostservice').val()
                                    ,quantity: $('#oQuantity').val()
                                    ,priceperunit: $('#oPriceperunits').val()
                                    ,amount: $('#oamount').val()
                                    ,remark: $('#oRemark').val()
                                    ,sys_doc_sref: $('#txtitem_sys_doc_ref').val()

                                    , wmatr_goodid: $('#wmatr_goodid').val()
                                    , wirelength_amnt: $('#txt_wirelength_amnt').val()
                                    , wirequantity: $('#txt_wirelength_amnt').val()
                                    , transac_item_id: $('#txtpart_transac_item_id').val()
                                },
                                dataType: 'json',
                                complete: function (data) {
                                    //alert(data.statusText);
                                    if (data.statusText == 'OK') {
                                        //alert(data.statusText);
                                        Swal.fire({
                                            title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></h3>',
                                            icon: 'success',
                                            confirmButtonColor: '#57cc99',
                                            cancelButtonColor: '#f94144',
                                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                                        }).then((result) => {
                                            if (result.isConfirmed) {



                                                var tbl_partreceive = $('#tbl_partreceive').DataTable();
                                                tbl_partreceive.clear().draw();



                                                tsttblDisplayCoil();
                                                tsttblDisplaySheet();
                                                tsttblDisplayCoilMd();
                                                tstclearinput();
                                                oDisplay();


                                                $('#obtitemgo').prop('disabled', true);
                                                $('#sidGo').prop('disabled', true);
                                                $('#sobtnSave3').prop('disabled', true);

                                                $('#obtitemgo').css({ 'background-color': '#D6D6D6' })
                                                $('#sidGo').css({ 'background-color': '#D6D6D6' })
                                                $('#obtnSave3').css({ 'background-color': '#D6D6D6' });
                                                $('#obtnSave3').removeClass('btn-success');


                                                $('#divDisabled').addClass('odisabled');
                                                $('#btnAdjust').addClass('hidden');

                                                $('#modal_RvPart').modal('hide');
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
                        else
                        {
                            $.ajax({
                                url: '../../xTransaction/srv_transaction_in.asmx/oInsert',
                                method: 'POST',
                                data: {


                                    action: 'oInsert',
                                    create_by: usr_name,
                                    create_date: currentdate2,

                                    matr_flag_group: 3,
                                    matr_status_flag: 'false',
                                    matr_transac_type: '1',



                                    ref_id: $('#txtitem_sheetout_id').val(),
                                    sys_doc_ref: $('#txt_sysdoccode').val(), //
                                    doc_date: $('#odocu_date').val(),
                                    doc_no: $('#odocu_no').val(),
                                    matr_code: $('#txtitem_goodcode').val(),
                                    supplier_code: $('#oselect_supplier').val(),
                                    sRef_qty: $('#txt_CalcsheetAmnt').val(),
                                    costservice: $('#oCostservice').val(),
                                    quantity: $('#oQuantity').val(),
                                    priceperunit: $('#oPriceperunits').val(),
                                    amount: $('#oamount').val(),
                                    remark: $('#oRemark').val(),
                                    sys_doc_sref: $('#txtitem_sys_doc_ref').val(),

                                    transac_item_id: $('#txtpart_transac_item_id').val()

                                },
                                dataType: 'json',
                                complete: function (data) {
                                    //alert(data.statusText);
                                    if (data.statusText == 'OK') {
                                        //alert(data.statusText);
                                        Swal.fire({
                                            title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></h3>',
                                            icon: 'success',
                                            confirmButtonColor: '#57cc99',
                                            cancelButtonColor: '#f94144',
                                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                                        }).then((result) => {
                                            if (result.isConfirmed) {



                                                var tbl_partreceive = $('#tbl_partreceive').DataTable();
                                                tbl_partreceive.clear().draw();



                                                tsttblDisplayCoil();
                                                tsttblDisplaySheet();
                                                tsttblDisplayCoilMd();
                                                tstclearinput();
                                                oDisplay();


                                                $('#obtitemgo').prop('disabled', true);
                                                $('#sidGo').prop('disabled', true);
                                                $('#sobtnSave3').prop('disabled', true);

                                                $('#obtitemgo').css({ 'background-color': '#D6D6D6' })
                                                $('#sidGo').css({ 'background-color': '#D6D6D6' })
                                                $('#obtnSave3').css({ 'background-color': '#D6D6D6' });
                                                $('#obtnSave3').removeClass('btn-success');


                                                $('#divDisabled').addClass('odisabled');
                                                $('#btnAdjust').addClass('hidden');

                                                $('#modal_RvPart').modal('hide');
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

                        
                    }
                })



            } else if (matr_flag_group == 4) { // Insert Mesh
                

                Swal.fire({
                    title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#57cc99',
                    cancelButtonColor: '#f94144',
                    confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '../../xTransaction/srv_transaction_in.asmx/mInsert',
                            method: 'POST',
                            data: {


                                action: 'mInsert',
                                create_by: usr_name,
                                create_date: currentdate2,
                                //isdelete: 'false',
                                //isactive: 'true',

                                matr_flag_group: matr_flag_group,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',



                                doc_date: $('#txtm_DocuDate').val(),
                                doc_no: $('#txtm_InvNo').val(),
                                matr_code: $('#txtm_GoodID').val(),
                                sys_doc_ref: $('#txt_msysdoccode').val(),
                                supplier_code: $('#txtm_VendorID').val(),
                                quantity: $('#txtm_GoodQtyPcs').val(),
                                priceperunit: $('#txtm_priceperunit').val(),
                                amount: $('#txtm_GoodAmnt').val(),
                                remark: $('#mRemark').val()




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


                                            tsttblDisplayCoil();
                                            tsttblDisplaySheet();
                                            tsttblDisplayCoilMd();
                                            fn_GetMeshDisplay();
                                            tstclearinput();
                                            $('#txt_msysdoccode').val('');
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
            } else if (matr_flag_group == 5) { //Insert Screw
                //alert('Insert Screw')
                if ($('#txtsc_DocuDate').val() == '') {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบวันในการรับสกรู</strong></div>'
                    })
                } else {
                    Swal.fire({
                        title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ?</strong></h3>',
                        icon: 'question',
                        showCancelButton: true,
                        cancelButtonText: '<div class="txtLabel">Cancle</div>',
                        confirmButtonColor: '#57cc99',
                        cancelButtonColor: '#f94144',
                        confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                url: '../../xTransaction/srv_transaction_in.asmx/scInsert',
                                method: 'POST',
                                data: {


                                    action: 'scInsert',
                                    create_by: usr_name,
                                    create_date: currentdate2,


                                    matr_flag_group: matr_flag_group,
                                    matr_status_flag: 'false',
                                    matr_transac_type: '1',

                                    doc_date: $('#txtsc_DocuDate').val(),
                                    doc_no: $('#txtsc_InvNo').val(),
                                    matr_code: $('#txtsc_GoodID').val(),
                                    sys_doc_ref: $('#txtsc_sys_code').val(),
                                    quantity: $('#txtsc_qty').val(),
                                    priceperunit: $('#txtsc_priceperunit').val(),
                                    amount: $('#txtsc_amnt').val(),
                                    remark: $('#txtsc_Remark').val()




                                },
                                dataType: 'json',
                                complete: function (data) {
                                    if (data.statusText == 'OK') {
                                        //alert('success');
                                        Swal.fire({
                                            title: '<h3 class="txtSecondHeader" style="font-weight:800">บันทึกข้อมูลเรียบร้อย...</h3>',
                                            icon: 'success',
                                            confirmButtonColor: '#57cc99',
                                            cancelButtonColor: '#f94144',
                                            confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                                        }).then((result) => {
                                            if (result.isConfirmed) {


                                                tsttblDisplayCoil();
                                                tsttblDisplaySheet();
                                                tsttblDisplayCoilMd();
                                                fn_GetMeshDisplay();
                                                fn_GetScrewDisplay();
                                                tstclearinput();
                                                $('#txt_msysdoccode').val('');

                                                $('#screw_itemgo').css('background', ' #D6D6D6');
                                                $('#screw_itemgo').prop('disabled', true);

                                                $('#screw_Getamntgo').css('background', ' #D6D6D6');
                                                $('#screw_Getamntgo').prop('disabled', true);

                                                $('#btnSaveScrew').css('background', ' #D6D6D6');
                                                $('#btnSaveScrew').prop('disabled', true);
                                                
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





            }

        }

        function tstcUpdatedata(matr_flag_group) {
            if (matr_flag_group == 1) { //1=coil update
                //alert('update coils matr_flag_group = 1')
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


                        //alert(
                        //    $('#matr_date').val() + '\n' +
                        //    $('#matr_refno').val() + '\n' +
                        //    $('#selectedcoils').val() + '\n' +
                        //    $('#selectedsupplier').val() + '\n' +
                        //    $('#matr_qty').val() + '\n' +
                        //    $('#matr_perunit').val() + '\n' +
                        //    $('#matr_amnt').val() + '\n' +
                        //    $('#matr_remark').val() 
                        //);

                        $.ajax({
                            url: '../../xTransaction/srv_transaction_in.asmx/ctstUpdatedata',
                            method: 'POST',
                            data: {


                                action: 'cUpdate',
                                id: $('#cid').val(),
                                update_by: usr_name,
                                update_date: currentdate2,
                                matr_flag_group: matr_flag_group,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',
                                doc_date: $('#matr_date').val(),
                                doc_ref: $('#matr_refno').val(),
                                matr_code: $('#selectedcoils').val(),
                                supplier_code: $('#selectedsupplier').val(),
                                quantity: $('#matr_qty').val(),
                                priceperunit: $('#matr_perunit').val(),
                                amount: $('#matr_amnt').val(),
                                remark: $('#matr_remark').val()

                            },
                            dataType: 'json',
                            complete: function (data) {
                                if (data.statusText == 'success') {
                                    //alert('success');
                                    Swal.fire({
                                        title: '<h3 class="txtSecondHeader"><strong><i class="fa fa-check-circle-o" aria-hidden="true"></i> บันทึกข้อมูลเรียบร้อย...</strong></h3>',
                                        icon: 'success',
                                        confirmButtonColor: '#57cc99',
                                        cancelButtonColor: '#f94144',
                                        confirmButtonText: '<div class="txtLabel"><strong>Done..!!</strong></div>'
                                    }).then((result) => {
                                        if (result.isConfirmed) {

                                            //load table
                                            tsttblDisplayCoil();
                                            tstclearinput();
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
            } else if (matr_flag_group == 2) { // 2=sheet update

                //alert('sheet update');
                Swal.fire({
                    title: ' < h3 class= "txtLabel" > <strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#57cc99',
                    cancelButtonColor: '#f94144',
                    confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '../../xTransaction/srv_transaction_in.asmx/ststUpdatedata',
                            method: 'POST',
                            data: {


                                action: 'sUpdate',
                                id: $('#sid').val(),
                                update_by: usr_name,
                                update_date: currentdate2,
                                matr_flag_group: matr_flag_group,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',

                                matr_flag_group: matr_flag_group,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',
                                ref_id: $('#smatr_CoilRefid').val(),
                                doc_date: $('#smatr_date').val(),

                                doc_ref: $('#out_cref').val(),
                                doc_no: $('#sdocu_no').val(),
                                matr_code: $('#selectedsheet').val(),
                                supplier_code: $('#selectedsuppliersheet').val(),
                                packingno: $('#smatr_packno').val(),
                                costservice: $('#costservice').val(),
                                quantity: $('#smatr_qty').val(),
                                priceperunit: $('#priceperunit').val(),
                                amount: $('#samount').val()

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
                                            tsttblDisplayCoil();
                                            tsttblDisplaySheet();
                                            tsttblDisplayCoilMd();
                                            tstclearinput();
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
            } else if (matr_flag_group == 3) { //Insert option part
                //alert($('#sref_Oqty').val());


                Swal.fire({
                    title: '< h3 class= "txtLabel" > <strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#57cc99',
                    cancelButtonColor: '#f94144',
                    confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '../../xTransaction/srv_transaction_in.asmx/oInsert',
                            method: 'POST',
                            data: {


                                action: 'oInsert',
                                create_by: usr_name,
                                create_date: currentdate2,
                                isdelete: 'false',
                                isactive: 'true',

                                matr_flag_group: 3,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',
                                ref_id: $('#txtref_otransacid').val(),
                                doc_date: $('#odocu_date').val(),
                                doc_no: $('#odocu_no').val(),
                                matr_code: $('#txtitem_id').val(),
                                sref_Oqty: $('#sref_Oqty').val(),
                                supplier_code: $('#oselect_supplier').val(),
                                costservice: $('#oCostservice').val(),
                                quantity: $('#oQuantity').val(),
                                priceperunit: $('#oPriceperunits').val(),
                                remark: $('#oRemark').val()




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


                                            tsttblDisplayCoil();
                                            tsttblDisplaySheet();
                                            tsttblDisplayCoilMd();
                                            tstclearinput();
                                            oDisplay();

                                            $('#modal_RvPart').modal('hide');
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



            } else if (matr_flag_group == 4) { // Insert Mesh
                alert(
                    'doc_date: ' + $('#txtm_DocuDate').val() + '\n' +
                    'doc_no:  ' + $('#txtm_InvNo').val() + '\n' +
                    'matr_code:  ' + $('#txtm_GoodID').val() + '\n' +
                    'supplier_code:  ' + $('#txtm_VendorID').val() + '\n' +
                    'quantity:  ' + $('#txtm_GoodQtyPcs').val() + '\n' +
                    'priceperunit:  ' + $('#otxtm_priceperunit').val() + '\n' +
                    'remark:  ' + $('#oRemark').val()

                );

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
                            url: '../../xTransaction/srv_transaction_in.asmx/oInsert',
                            method: 'POST',
                            data: {


                                action: 'mInsert',
                                create_by: usr_name,
                                create_date: currentdate2,
                                isdelete: 'false',
                                isactive: 'true',

                                matr_flag_group: 3,
                                matr_status_flag: 'false',
                                matr_transac_type: '1',



                                doc_date: $('#txtm_DocuDate').val(),
                                doc_no: $('#txtm_InvNo').val(),
                                matr_code: $('#txtm_GoodID').val(),
                                //sref_Oqty: $('#sref_Oqty').val(),
                                supplier_code: $('#txtm_VendorID').val(),
                                quantity: $('#txtm_GoodQtyPcs').val(),
                                priceperunit: $('#otxtm_priceperunit').val(),
                                remark: $('#oRemark').val()




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


                                            tsttblDisplayCoil();
                                            tsttblDisplaySheet();
                                            tsttblDisplayCoilMd();
                                            tstclearinput();
                                            oDisplay();
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

        }



        function tstcRemovedata(cid, matr_flag) {
            //alert(cid + '\n' + matr_flag);
            Swal.fire({
                title: '<h3 class="txtSecondHeader" style="font-weight:800">ต้องการลบข้อมูล...ใช่หรือไม่?</h3>',
                icon: 'question',
                showCancelButton: true,
                cancelButtonText: '<div class="txtLabel">Cancle</div>',
                confirmButtonColor: '#57cc99',
                cancelButtonColor: '#f94144',
                confirmButtonText: '<div class="txtLabel">Yes, Delete ...</div>'
            }).then((result) => {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_in.asmx/ctstRemovedata',
                    method: 'POST',
                    data: {
                        action: 'cRemovebyid'
                        , update_by: usr_name
                        , update_date: currentdate2
                        , matr_flag_group: matr_flag
                        , id: cid
                    },
                    dataType: 'json',
                    complete: function (data) {
                        if (data.statusText == 'success') {

                            Swal.fire({
                                title: '<h3 class="txtSecondHeader" style="font-weight:800">บันทึกข้อมูลเรียบร้อย...</h3>',
                                icon: 'success',
                                confirmButtonColor: '#57cc99',
                                cancelButtonColor: '#f94144',
                                confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                            }).then((result) => {
                                if (result.isConfirmed) {

                                    //load table
                                    tsttblDisplayCoil();
                                }
                            })
                        } else if (data.statusText == 'error') {

                            var datax = JSON.stringify(data);
                            //alert(datax);
                            Swal.fire({
                                icon: 'error',
                                title: '<h3 class="txtSecondHeader" style="font-weight:800">เกิดข้อผิดพลาด...</h3>',

                            })
                        }
                    }
                });
            })
        }

        function wInsert() {
            $.ajax({
                url: '../../xTransaction/srv_transaction_in.asmx/wInsert',
                method: 'POST',
                data: {


                    action: 'mInsert',
                    create_by: usr_name,
                    create_date: currentdate2,
                    isdelete: 'false',
                    isactive: 'true',

                    matr_flag_group: 3,
                    matr_status_flag: 'false',
                    matr_transac_type: '3',



                    doc_date: $('#txtm_DocuDate').val(),
                    doc_no: $('#txtm_InvNo').val(),
                    matr_code: $('#txtm_GoodID').val(),
                    //sref_Oqty: $('#sref_Oqty').val(),
                    //supplier_code: $('#txtm_VendorID').val(),
                    quantity: $('#txtm_GoodQtyPcs').val(),
                    priceperunit: $('#otxtm_priceperunit').val(),
                    remark: $('#oRemark').val()




                },
                dataType: 'json',
                complete: function (data) { }
            })
        }

    </script>


</asp:Content>
