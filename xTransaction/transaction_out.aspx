<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="transaction_out.aspx.cs" Inherits="AmpelflowApp.xTransaction.transaction_out" %>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content-header" style="padding-top:0px">
       <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../Content/plugins/numeral.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
        <script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>

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

            table tbody td{
                padding:inherit
            }
           div.divDisbled {
                 pointer-events: none;
                 opacity: 0.7;
            }

            div.boxsp {
                width: 95%;
                padding: 3px;
                border-radius: 3px 3px 3px 3px;
                border: 3px solid #b0bfa9;
                margin: 0;
                margin-left:28px
            }

             [name="tbl_v3selected_length"] {
                border-radius:3px 3px 3px 3px;
            }
            /*Tooltip*/
            .tooltipx {
                position:relative;
                display: inline-block;
                border-bottom: 1px dotted black; /* If you want dots under the hoverable text */
            }

                /* Tooltip text */
                .tooltipx .tooltipxtext {
                    visibility: hidden;
                    width: 120px;
                    background-color: #555;
                    color: #fff;
                    text-align: center;
                    padding: 5px 0 ;
                    border-radius: 6px;
                    /* Position the tooltip text */
                    position: absolute;
                    z-index: 5;
                    bottom: 125%;
                    left: 100%;
                    margin-left: -60px;
                    /* Fade in tooltip */
                    opacity: 0;
                    transition: opacity 0.3s;
                }

                    /* Tooltip arrow */
                    .tooltipx .tooltipxtext::after {
                        content: "";
                        position: absolute;
                        top: 100%;
                        left: 50%;
                        margin-left: -5px;
                        border-width: 5px;
                        border-style: solid;
                        border-color: #555 transparent transparent transparent;
                    }

                /* Show the tooltip text when you mouse over the tooltip container */
                .tooltipx:hover .tooltipxtext {
                    visibility: visible;
                    opacity: 1;
                }


                #tblWdSheet_Detail_filter {
                    display:none;
                }
                #tblWdSheet_Detail_length{
                    display:none;
                }
        </style>
         
        <script>
            tippy('#btnSheetwdEdit', {
                content: 'My tooltip!',
            });
        </script>
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
            var lastid;

            $(document).ready(function () {
                ProgressOn();

                setTimeout(function () {
                    displayprojectcbb();
                    display_tbl_matr_forpay();
                    check_insert_matr_forout();

                    var btnsheetcal = $('#btnsheetcalculate');
                    btnsheetcal.click(function () {

                        tstgetsheetforproject();

                    })

                    var btnCreatenewprojectsv = $('#btnCreatenewprojectsv');
                    btnCreatenewprojectsv.click(function () {
                        createnewprojectsv();
                    })

                    var btngetproject = $('#btngetproject')
                    btngetproject.click(function () {
                    })

                    var btn_txt_projectname = $('#txt_projectname');
                    btn_txt_projectname.click(function () {
                        modal_ampelflow_proj();
                    })

                    var btnorderset_calc = $('#btnorderset_calc');
                    btnorderset_calc.click(function () {
                        fnOrderset_calc();
                    })

                    var btnv3Selected = $('#btnv3Selected');
                    btnv3Selected.click(function () {
                        fn_v3selectedDisplay();

                    })


                    var selectprojecttype = $('#selectprojecttype');
                    selectprojecttype.change(function () {
                        $('#btnsheetSave').prop('disabled', true);
                    })


                  

                    $('body').removeClass('overlay');

                    ProgressOff();
                },1000)




                $('#getNewwithdrawid').on('click', function () {
                    //alert(1);
                    var $this = $(this);
                    $this.button('loading');
                    setTimeout(function () {
                        $this.button('reset');
                    }, 2000);
                });

            })

            function tstgetsheetforproject() {
                var orderset = $('#txtorderset').val();
                var sheetofprojectall;
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/tstgetmatrofprject',
                    method: 'post',
                    data: {
                        action: 'dpdisplaybyid',
                        id: $('#selectprojecttype').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                pcsperset = data[i].pcsperset;
                            })
                            sheetofprojectall = pcsperset * orderset;
                            $('#txtsheetofproject').val(numeral(sheetofprojectall).format('0,0.00'));

                            
                            $('#txtlabelsheet').html($('#txtsheetofproject').val());

                        }
                    }
                })
            }

            function display_tblsheetforpaymd() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/display_tblsheetforpaymd',
                    method: 'post',
                    data: {
                        action: 'display_tblsheetforpaymd',
                        matr_flag_group: 2
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var tblsheetforpaymd = $('#tblsheetforpaymd').DataTable();
                            tblsheetforpaymd.clear();
                            $.each(data, function (i, item) {
                                tblsheetforpaymd.row.add([

                                    '<div div class="text-left" style="padding-left:20px">' + data[i].lotcode + '</div>'
                                    , '<div div class="text-left" style="padding-left:20px">' + data[i].goodname1 + '</div>'
                                    , '<div>' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div>' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div>' + numeral(data[i].remain).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstcDisplaybyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div style="text-align: center;color:orange;width:20px" " data-toggle="tooltip" title="' + data[i].id + '">' +
                                    '<input type = "checkbox" value="' + data[i].id + '"/>' +
                                    '</div>'

                                ])
                                tblsheetforpaymd.draw();
                            });
                        }
                    }
                })
            }


            function fnOrderset_calc() {
                var v3use = 3.05;
                var v7use = 0.20;

                if ($('#selectprojecttype').val() == '' || $('#txt_Orderset').val() == '') {
                    //if ($('#selectprojecttype').val() == '' && $('#txt_Orderset').val() != '') {
                    //    $('#selectprojecttype').addClass('has-error');
                    //    $('#txt_Orderset').addClass('has-error');
                    //    Swal.fire({
                    //        icon: 'error',
                    //        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    //        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">เลือกรูปแบบโครงการ</strong></div>'

                    //    })
                    //} else if ($('#txt_Orderset').val() == '' && $('#selectprojecttype').val() != '') {

                    //    Swal.fire({
                    //        icon: 'error',
                    //        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    //        html: '<div class="txtLabel"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> กรุณาใส่จำนวนชุด</div>'

                    //    })
                    //} else if ($('#selectprojecttype').val() == '' && $('#txt_Orderset').val() == '') {
                    //    $('#selectprojecttype').addClass('has-error');
                    //    $('#txt_Orderset').addClass('has-error');
                    //    Swal.fire({
                    //        icon: 'error',
                    //        title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    //        html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red"> เลือกรูปแบบโครงการและใส่จำนวนชุด</strong></div>'

                    //    })
                    //}

                    var strerr = '';
                    if ($('#txtout_docu_no').val() == '') {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> เลขที่เอกสาร</div>'
                    }
                    if ($('#projectdate').val() == '') {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> วันที่เอกสาร</div>'
                    }if ($('#projectdate').val() == '') {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> วันที่เอกสาร</div>'
                    } if ($('#selectprojecttype').val() == '' || $('#selectprojecttype').val() == null) {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> รูปแบบโครงการ</div>'
                    } if ($('#selectedsheet').val() == '' || $('#selectedsheet').val() == null) {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> รายการวัตถุดิบ</div>'
                    } if ($('#v7InClude').val() == '' || $('#v7InClude').val() == null) {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> รายการV7</div>'
                    } if ($('#txt_v3id').val() == '') {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> รายการV3</div>'
                    } if ($('#txt_Orderset').val() == '') {
                        strerr += '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ระบุจำนวน Set</div>'
                    }

                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel16" style="color:#f27474"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: strerr,
                        confirmButtonText: '<div class="txtLabel">OK</div>',
                        confirmButtonColor: '#f27474'

                    })


                } else {
                    var orderset, projecttype, pcsperset;
                    orderset = $('#txt_Orderset').val();
                    projecttype = $('#selectprojecttype').val();

                    $.ajax({
                        url: '../../xTransaction/srv_transaction_out.asmx/display_projecttypeamntbyid',
                        method: 'post',
                        data: {
                            action: 'display_projecttypeamntbyid',
                            id: projecttype
                        },
                        dataType: 'json',
                        success: function (data) {
                            console.log(data);
                            if (data != '') {

                                $.each(data, function (i, item) {
                                    //alert(data[i].pcsperset);
                                    pcsperset = data[i].pcsperset;

                                    var v7suse = Math.ceil((v7use * orderset) / 3.05); //alert(v7suse);
                                    var v3suse = Math.round((v3use * orderset) / 3.05); //alert(v3suse);

                                    if ($('#txt_v3id').val() != '' && $('#v7InClude').val() != '') {
                                      
                                        $('#txtsheetofproject').val(numeral(orderset * data[i].pcsperset).format('0,0.00'))
                                      
                                        $('#btnsheetSave').css({ 'background': 'rgb(50, 219, 104)' });
                                        $('#btnsheetSave').prop('disabled', false);

                                    } else if ($('#txt_v3id').val() != '' && $('#v7InClude').val() == '') {
                                        
                                        $('#txtsheetofproject').val(numeral((orderset * data[i].pcsperset) - (v7suse * 1)).format('0,0.00'))
                                        $('#btnsheetSave').css({ 'background': 'rgb(50, 219, 104)' });
                                        $('#btnsheetSave').prop('disabled', false);

                                    } else if ($('#txt_v3id').val() == '' && $('#v7InClude').val() != '') {
                                        
                                        $('#txtsheetofproject').val(numeral((orderset * data[i].pcsperset) - (v3suse * 2)).format('0,0.00'))
                                        $('#btnsheetSave').css({ 'background': 'rgb(50, 219, 104)' });
                                        $('#btnsheetSave').prop('disabled', false);


                                    } else if ($('#txt_v3id').val() == '' && $('#v7InClude').val() == '') {
                                        
                                        $('#txtsheetofproject').val(numeral((orderset * data[i].pcsperset) - (v3suse * 2) - (v7suse * 1)).format('0,0.00'))
                                        $('#btnsheetSave').css({ 'background': 'rgb(50, 219, 104)' });
                                        $('#btnsheetSave').prop('disabled', false);
                                    }
                                });

                                //$('#btnorderset_calc').prop('disabled', false);
                                
                            }
                        }
                    })
                }


               

                

                
            }

            function projectactionmd() {

                $('#newprojectmd').modal('show');
            }

            function displayprojectmd() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/displayprojectmd',
                    method: 'post',
                    data: {
                        action: 'displayprojectmd'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var tblprojectaction = $('#tblprojectaction').DataTable();
                            tblprojectaction.clear();
                            $.each(data, function (i, item) {
                                tblprojectaction.row.add([

                                    '<div class="text-center">' + data[i].projectname + '</div>'
                                    //, '<div>' + data[i].projectdate + '</div>'
                                    , '<div class="text-center">' + data[i].projectdate + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].projectset).format('0,0.00') + '</div>'
                                    , '<div class="text-center">' + data[i].project_type_detail + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstcPrint(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 12px;color:#57cc99"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="tstcDisplaybyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'


                                ])
                                tblprojectaction.draw();
                            });
                        }
                    }
                })
            }

            function displayprojectcbb() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/displayprojectcbb',
                    method: 'post',
                    data: {
                        action: 'displayprojecttocbb'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var s = '<option value="0">-- เลือกรายการ --</option>';

                            for (var i = 0; i < data.length; i++) {
                                s += '<option value="' + data[i].id + '" data-toggle="tooltip" title="' + data[i].id + '">' + data[i].projectname + '</option>';
                            }
                            $("#getselectedproject").html(s);

                        } else if (data == '') {
                           
                            var s = '<option value="0">-- เลือกรายการ --</option>';
                            
                            $("#getselectedproject").html(s);
                        }
                    }
                })
            }

            function calsheetforpay() {


                var arr = [];
                var tblsheetforpaymd = $('#tblsheetforpaymd').DataTable();
                var checkedvalues = tblsheetforpaymd.$('input:checked').each(function () {
                    arr.push($(this).attr('value'))
                });
            }

            function display_tbl_matr_forpay() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/display_tbl_matr_forpay',
                    method: 'post',
                    data: {
                        action: 'displaytbl_matr_forpay'
                        , isdelete: 'false'
                        , isactive: 'true'
                        , matr_transac_type: '3'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_matr_forpay').DataTable().clear();
                            $('#tbl_matr_forpay').DataTable().destroy();


                            var tbl_matr_forpay = $('#tbl_matr_forpay').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                },'ordering':false,'autoWidth':false
                            });

                            $('[name=tbl_matr_forpay_length]').select2();

                            tbl_matr_forpay.clear();
                            $.each(data, function (i, item) {
                                tbl_matr_forpay.row.add([
                                    '<div class="txtLabel" style="cursor:pointer">' + sheetcheckstatus(data[i].sstatus) + '</div>'
                                    , '<div class="tooltipx" style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button" id="btnSheetwdEdit"  data-toggle="tooltip" data-title="แก้ไข" onclick="Display_Sheet_forpayById(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-placement="right"  style="font-size: 12px;color:#0077b6"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    ,'<div class="text-left" style="padding-left:5px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].sys_doc_ref + '</div>'
                                    //, '<div class="text-left" style="padding-left:5px">' + data[i].doc_no + '</div>'
                                    , '<div class="text-left" style="padding-left:5px">' + data[i].matr_goodname + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + data[i].priceperunitx + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].rvquanity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + numeral(data[i].remaquantity).format('0,0.00') + '</div>'
                                    //, '<div class="text-right" style="padding-right:5px">' + numeral(data[i].remaquantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-right:5px">' + ' - ' + '</div>'
                                    , '<div class="text-left" style="padding-right:5px">' + data[i].remark + '</div>'
                                   


                                ])
                                tbl_matr_forpay.draw();
                            });
                        }
                    }
                })
            }

            function sheetcheckstatus(sstatus) {
                //alert(sstatus);
                if (sstatus == 1) {
                    return '<div><i class="fa fa-check" data-toggle="tooltip" data-title="Success" aria-hidden="true" style="color:#06d6a0"></i></div>'
                } else if (sstatus == 0) {
                    return '<div><i class="fa fa-minus" data-toggle="tooltip" data-title="Work In Procress" aria-hidden="true" style="color:#d62828"></i></div>'
                } else { }
            }

            function Display_Sheet_forpayById(sysDoct) {

                tstclearinput();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/Display_Sheet_forpayById',
                    method: 'post',
                    data: {
                        action: 'Display_Sheet_forpayById'
                        , sys_doc_ref: sysDoct
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                $('#txtout_systemcode_ref').val(data[i].sys_doc_ref);
                                $('#projectdate').val(data[i].doc_date);
                                $('#txtout_docu_no').val(data[i].doc_no);

                                $('#selectedsheet').val(data[i].matr_code);
                                $('#selectedsheet').select2();

                                $('#selectedsuppliersheet').val(data[i].supplier_code);
                                $('#selectedsuppliersheet').select2();

                                $('#selectprojecttype').val(data[i].projecttype_id);
                                $('#selectprojecttype').select2();
                                
                                $('#txt_v3').val(data[i].v3name);
                                $('#txt_v3id').val(data[i].v3code);


                                $('#txt_Orderset').val()

                                $('#v7InClude').val(data[i].v7code);
                                $('#v7InClude').select2();
                                $('#txt_Orderset').val(data[i].orderamnt);
                                //$('#orderamnt').val();
                                $('#txtsheetofproject').val(data[i].quantity);
                                $('#txt_remark').val(data[i].remark);

                                $('#projectdate').prop('disabled', true);
                                $('#txtout_docu_no').prop('disabled', true);
                                $('#selectedsheet').prop('disabled', true);
                                $('#selectedsuppliersheet').prop('disabled', true);
                                $('#selectprojecttype').prop('disabled', true);
                                $('#txt_v3').prop('disabled', true);
                                $('#txt_Orderset').prop('disabled', true);
                                $('#v7InClude').prop('disabled', true);
                                $('#txtsheetofproject').prop('disabled', true);

                                $('#btnorderset_calc').prop('disabled', true);
                                $('#btnorderset_calc').css({ 'background': '#D6D6D6' })

                                $('#btnv3Selected').prop('disabled', true);
                                $('#btnv3Selected').css({ 'background': '#D6D6D6'})



                                $('#btnsheetSave').prop('disabled', false);
                                $('#btnsheetSave').css({ 'background': '#32db68' });



                            });
                        }
                    }
                })
                $('#txtid_checkEdit').val('CanEdit');
                Display_tblSheet_forpayById(sysDoct);
                $('#WDSheet_MainModalInput').modal('show');
            }

            function Display_tblSheet_forpayById(sysDoct) {
                //$('#tblWdSheet_Detail').DataTable().claer();
                //$('#tblWdSheet_Detail').DataTable().destroy();

                //var tblWdSheet_Detail = $('#tblWdSheet_Detail').DataTable();
                //tblWdSheet_Detail.claer();


                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/Display_tblSheet_forpayById',
                    method: 'post',
                    data: {
                        action: 'Display_tblSheet_forpayById'
                        , sysDoct: sysDoct
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert(data.length);
                            var tblWdSheet_Detail = $('#tblWdSheet_Detail').DataTable();
                            tblWdSheet_Detail.clear();
                            $.each(data, function (i, item) {
                                tblWdSheet_Detail.row.add([


                                    '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].matr_goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].quantity).format('0,0.0000') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].priceperunitx).format('0,0.0000') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].amount).format('0,0.0000') + '</div>'


                                ])
                                tblWdSheet_Detail.draw();


                            })
                        }   
                    }
                })
            }

            function getMultiGoodCode() {
                var allitem = '';
                var tblsheetforpaymd = $('#tblsheetforpaymd').DataTable();
                var arr = [];
                var checkedvalues = tblsheetforpaymd.$('input:checked').each(function () {
                    
                    arr.push($(this).attr('value'))
                });

                //alert(arr);
                //allitem = arr.join(';')

                if (arr.length == 1) {
                    $.ajax({
                        url: '../../xTransaction/srv_transaction_out.asmx/display_tblsheetforpaymdbyid',
                        method: 'post',
                        data: {
                            action: 'display_tblsheetforpaymdbyid',
                            matr_flag_group: 2
                        },
                        dataType: 'json',
                        success: function (data) {
                            if (data != '') {
                                
                                $.each(data, function (i, item) {
                                    $('#txtsheetoutid').val(data[i].ref_id);
                                    $('#txtsheetoutpriceperunit').val(data[i].priceperunit);
                                    
                                });
                            }
                        }
                    })
                       


                } else if (arr.length > 1) {
                    alert('arr.length : ' + arr.length);
                } else if (arr.length == 0) {
                    alert('กรุณาเลือกรายการ');
                }

                
            }

            function tstclearinput() {
                $('#txtprojectname1').val('');
                $('#txtprojectset1').val('');
                $('#txtremark1').val('');
                $('#txtprojectdate1').val('');
                $('#txt_sheetremain').val('');
                $('#txtout_systemcode_ref').val('');
                $('#txtout_docu_no').val('');

                $('#selectprojecttype').val('');
                $('#selectprojecttype').select2();

                $('#selectedsheet').val('');
                $('#selectedsheet').select2();

                $('#projectdate').val('');
                $('#txt_Orderset').val('');
                $('#txt_sheetremain').val('');
                $('#txtsheetofproject').val('');
                $('#txt_remark').val('');

                $('#txt_v3').val('');
                $('#txt_v3id').val('');






                
            }
          
            function modal_ampelflow_proj() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/modal_ampelflow_proj',
                    method: 'post',
                    data: {
                        action: 'getprojectdetail_display'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var tbl_ampelflow_proj = $('#tbl_ampelflow_proj').DataTable();
                            tbl_ampelflow_proj.clear();
                            $.each(data, function (i, item) {
                                tbl_ampelflow_proj.row.add([

                                    '<div class="text-center">' + data[i].projectdate + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].projectname + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].project_type_detail + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].projectset).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].sheetperset).format('0,0.00') + '</div>'
                                    
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="modal_ampelflow_projbyid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Save:' + data[i].id + '"  style="font-size: 12px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])

                                tbl_ampelflow_proj.draw();
                            });
                            $('#modal_ampelflow_proj').modal('show');
                        }
                    }
                })
            }

            function modal_ampelflow_projbyid(id) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/modal_ampelflow_projbyid',
                    method: 'post',
                    data: {
                        action: 'getprojectdetail_displaybyid',
                        id:id

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                            $.each(data, function (i, item) {
                                //alert(data.length);
                                $('#txt_projname').val(data[i].projectname);
                                $('#txt_projid').val(data[i].id);
                                $('#txtordersheet').val(numeral(data[i].sheetperset).format('0,0.00'));
                                $('#dump_txtordersheet').val(data[i].sheetperset);

                            });

                            $('#modal_ampelflow_proj').modal('hide');
                        }
                    }
                })
            }

            function getNewwithdrawid(wd_type) {

                

               
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/Getwithdraw_lastid',
                    method: 'post',
                    data: {
                        action: 'Getwithdraw_sheet_lastid'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (wd_type == 1) { //1=sheet
                            //('wd_type');
                            if (data != '') {

                                $('#tblWdSheet_Detail').DataTable().clear();
                                $('#tblWdSheet_Detail').DataTable().destroy();


                                var tblWdSheet_Detail = $('#tblWdSheet_Detail').DataTable({'ordering':false });
                                tblWdSheet_Detail.clear();

                                $.each(data, function (i, item) {
                                    if (data[i].lastid == '') {
                                        lastid = 'wd-s-00001'

                                        //alert(lastid);
                                        $('#txtout_systemcode_ref').val(lastid);
                                        check_insert_matr_forout();

                                        $('#btnv3Selected').css({ 'background': '#3c8dbc' });
                                        $('#btnorderset_calc').css({ 'background': '#3c8dbc' });
                                        $('#projectdate').val(currentdate2);


                                    } else {
                                        tstclearinput();
                                        //alert(data[i].lastid);
                                        $('#txtout_systemcode_ref').val(data[i].lastid);
                                        check_insert_matr_forout();
                                        $('#btnv3Selected').css({ 'background': '#3c8dbc' });
                                        $('#btnorderset_calc').css({ 'background': '#3c8dbc' });
                                        $('#projectdate').val(currentdate2);
                                    }
                                });




                                $('#btnorderset_calc').addClass('btnColor');
                                $('#divDisabledCover').removeClass('divDisbled')

                                $('#txtout_docu_no').prop('disabled', false);
                                $('#projectdate').prop('disabled', false);
                                $('#selectprojecttype').prop('disabled', false);
                                $('#selectedsuppliersheet').prop('disabled', false);
                                $('#selectedsheet').prop('disabled', false);
                                $('#v7InClude').prop('disabled', false);
                                $('#txt_Orderset').prop('disabled', false);
                                $('#WDSheet_MainModalInput').modal('show');

                            } else if (data == '') {

                                lastid = 'wd-s-00001'
                                
                                //alert(lastid);
                                $('#txtout_systemcode_ref').val(lastid);
                                check_insert_matr_forout();
                            } else {
                                console.log('getNewwithdrawid() : else ');
                                check_insert_matr_forout();
                            }



                        } else if (wd_type == 1) {//2=part

                        }
                       

                    }
                })
            }

            function check_insert_matr_forout() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/GetSheet_Ramain_forcheck',
                    method: 'post',
                    data: {
                        action: 'GetSheet_Remain_forcheck'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            
                            $.each(data, function (i, item) {
                                //alert(data[i].sRemain);
                                $('#txt_sheetremain').val(data[i].sRemain);
                                //alert(data[i].sRemain);
                                $('#txtRemaSheet').html('<strong style="color:orange">คงเหลือ:' + data[i].sRemain+'</strong>');

                                });

                            } else {
                                console.log('getNewwithdrawid() : else ');

                            }
                        }


                    
                })
            }

            function fn_v3selectedDisplay() {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/fn_v3selectedDisplay',
                    method: 'post',
                    data: {
                        action: 'fn_v3selectedDisplay'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $('#tbl_v3selected').DataTable().clear();
                            $('#tbl_v3selected').DataTable().destroy();


                            var tbl_v3selected = $('#tbl_v3selected').DataTable({ 'ordering': false });
                            $('[name=tbl_v3selected_length]').select2();

                            tbl_v3selected.clear();
                            $.each(data, function (i, item) {
                                tbl_v3selected.row.add([

                                    '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].matr_code + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].matr_goodname + '</div>'
                                   
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_v3selectedDisplaybyid(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID วัตถุดิบ:' + data[i].goodid + '"  style="font-size: 12px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])

                                tbl_v3selected.draw();
                            });
                            $('#modal_v3selected').modal('show');
                        }
                    }
                })


                
            }

            function fn_v3selectedDisplaybyid(goodid) {
                $('#btnsheetSave').prop('disabled', true);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_out.asmx/fn_v3selectedDisplaybyid',
                    method: 'post',
                    data: {
                        action: 'fn_v3selectedDisplaybyid'
                        ,goodid : goodid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') { 
                            
                            $.each(data, function (i, item) {
                                $('#txt_v3').val(data[i].matr_goodname);
                                if (data[i].goodid == '' || data[i].goodid == '99999') {
                                    $('#txt_v3id').val('');
                                } else {
                                    $('#txt_v3').val(data[i].matr_goodname);
                                    $('#txt_v3id').val(data[i].goodid);
                                }
                                
                            });
                            $('#modal_v3selected').modal('hide');
                        }
                    }
                })
            }
        </script>
    </section>
    <section class="content">
        <%--<div class="overlay"></div>--%>
        <div class="row">
            <div class="col-md-12">

                <div class="box bxbpdercolor" id="boxInput" style="border-radius: 5px">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="user-block">
                                <img src="../../Content/Icons/web512.png" alt="User Image">
                                <span class="username">
                                    <a href="#" class="txtSecondHeader"><strong>Material Record : บันทึกรายการเบิกวัตถุดิบ</strong></a>
                                    <span class="pull-right">
                                            <button type="button" id="btnReload" name="btnReload" class="btn btn-default btn-sm checkbox-toggle hidden" onclick="GetDataPageMenuAllReload()" data-toggle="tooltip" title="Reload">
                                                <i class="fa fa-refresh"></i>
                                            </button>
                                            <%--<button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick=" getNewwithdrawid(1)" data-toggle="tooltip" title="New Project!" style="color:#57cc99;border-color:#57cc99;background-color:#fff";>
                                                <i class="fa fa-plus"></i>
                                            </button>--%>
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
                                <!-- Custom Tabs -->
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab" >
                                       
                                        <li  class="active maincolor" style="border-radius:3px 3px 0px 0px"><a href="#tab_Sheet" class="txtLabel" id="tab_sheet" data-toggle="tab" ><strong><i class="fa fa-reorder margin-r-5"></i>Sheet</strong></a></li>
                                        <li  style="border-radius:3px 3px 0px 0px" class="hidden"><a href="#tab_matrmesh" id="tab_mesh" class="txtLabel" data-toggle="tab" ><strong><i class="fa fa-share-alt margin-r-5"></i>เบิกชีส [ของเสีย]</strong></a></li>
                                        
                                        <li class="pull-right"><%--<a href="#" class="text-muted"><i class="fa fa-gear"></i></a>--%>
                                            <a href="javascript:void(0)" class="pull-right primary" id="btn_outNewitemid" data-toggle="tooltip" data-title="สร้างรายการใหม่" onclick="getNewwithdrawid(1)" ><strong style="color:royalblue"><i class="fa fa-plus" style="font-size:12px;color:royalblue"></i> New</strong></a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                       
                                        <!-- /.tab-pane -->
                                        <input type="text" class="hidden" id="txt_transaction_id"  name="name" value="" />
                                        <div class="tab-pane active" id="tab_Sheet">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <strong style="font-size:18px"><i class="fa fa-chevron-right" aria-hidden="true"></i> <u>รายการเบิกชีส</u></strong>
                                                </div>
                                            </div>
                                            <br />
                                             <div class="row">
                                                 <div class="col-md-12">
                                                     <table class="table table-bordered table-striped txtLabel text-center table-hover table-sm elRadius2px" id="tbl_matr_forpay" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th style="width: 20px">#</th>
                                                            <th style="width: 20px">Date</th>
                                                            <th>System Ref.Docu</th>
<%--                                                            <th>Project</th>--%>
                                                            <th>Material</th>
                                                            <th>price/Unit</th>
                                                            <th>Quantity</th>
                                                            <th>RV-Quantity</th>
                                                            <th>Remaining</th>
                                                            <%--<th>Adj.Quntity</th>--%>
                                                            <th>Amount</th>
                                                            <th>Remark</th>
                                                            
                                                        </tr>
                                                    </thead>
                                                </table>
                                                 </div>
                                                         
                                        </div>

                                           
                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                               
                                               
                                           
                                            
               
                           
                        
                    
                                            <%--<div id="divDisabledCover" class="divDisbled">
                                                <div class="row" style="margin-left: 12px; margin-right: 12px">
                                                    <div class="col-md-12  jumbotron txtLabel" style="border-radius: 3px;">
                                                        เบิกชีส ผลิต
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 ">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="matr_group" class="control-label txtLabel text-right">เลขอ้างอิง :</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                        <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                                    </div>
                                                                    <input type="text" name="projectdate" id="txtout_systemcode_ref" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" disabled />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="matr_group" class="control-label txtLabel">เลขที่เอกสาร :</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-radius: 3px 0px 0px 2pxx">
                                                                        <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                                    </div>
                                                                    <input type="text" name="projectdate" id="txtout_docu_no" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="matr_group" class="control-label txtLabel">วันที่เอกสาร:</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                        <i class="fa fa-calendar"></i>
                                                                    </div>
                                                                    <input type="text" name="projectdate" id="projectdate" class="form-control txtLabel has-success" style="border-radius: 0px 3px 3px 0px" placeholder="yyyy-MM-dd" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-3">
                                                            <div class="form-group ">
                                                                <label for="matr_group" class="control-label txtLabel">รูปแบบ Proj :</label>
                                                                <select id="selectprojecttype" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                    <option value="">--- เลือกรูปแบบโครงการ ---</option>
                                                                    <option value="1">ทึบแสง</option>
                                                                    <option value="2">โปร่งแสง</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group" style="padding: 0px">
                                                                <label for="matr_group" class="control-label txtLabel">Supplier:</label>
                                                                <select id="selectedsuppliersheet" style="width: 100%; text-align: justify; height: 38px" name="state">
                                                                    <option value="15024">เจพี ดีไซน์ แอนด์ แมนูแฟคเจอร์ริ่ง เซอร์วิส จำกัด</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <div class="form-group" style="padding: 0px">
                                                                <label for="matr_group" class="ontrol-label txtLabel">รายการวัตถุดิบ:</label>
                                                                <select id="selectedsheet" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                    <option value="">--- เลือกวัตถุดิบ ---</option>
                                                                    <option value="39249">Sheet S1 G300</option>
                                                                    <option value="39250">Sheet S1 G550</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row ">
                                                    <div class="col-md-12">
                                                        <div class="col-md-3">
                                                            <div class="form-group" style="padding: 0px">
                                                                <label for="matr_group" class="control-label txtLabel">รายการ V7</label>
                                                                <select id="v7InClude" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                    <option value="28102">InClude V7</option>
                                                                    <option value="">Not InClude V7</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="matr_group" class="control-label txtLabel">รายการ V3 :</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="3px 0px 0px 3px">
                                                                        <i class="fa fa-btc" aria-hidden="true"></i>
                                                                    </div>
                                                                    <input type="text" name="txt_v3" id="txt_v3" class="form-control txtLabel text-right" />
                                                                    <input type="text" name="txt_v3id" id="txt_v3id" class="form-control txtLabel text-right hidden" />
                                                                    <div id="btnv3Selected" class="input-group-addon elRadius2px" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6">
                                                                        <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure;"><strong><i class="fa fa-cube" aria-hidden="true"></i></strong></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="matr_group" class="control-label txtLabel">จำนวนชุด :</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                        <i class="fa fa-industry" aria-hidden="true"></i>
                                                                    </div>
                                                                    <input type="text" name="txt_Orderset" id="txt_Orderset" class="form-control txtLabel text-right" />
                                                                    <div id="btnorderset_calc" class="input-group-addon" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6">
                                                                       
                                                                        <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><strong><i class="icofont-calculations"></i></strong></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="control-label txtLabel">จำนวนแผ่นชีส:</label>
                                                                <label id="txtRemaSheet" class="control-label txtLabel pull-right"></label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                        <i class="fa fa-reorder"></i>
                                                                    </div>
                                                                    <input type="text" name="txtsheetofproject" id="txt_sheetremain" class="form-control txtLabel text-right hidden" />
                                                                    <input type="text" name="txtsheetofproject" id="txtsheetofproject" class="form-control txtLabel text-right" />
                                                                    <div id="btnsheetcalculate" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; cursor: pointer;">
                                                                        <label class="txtLabel" style="margin-bottom: auto;">แผ่น</label>
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
                                                                <label for="matr_group" class="control-label txtLabel">หมายเหตุ :</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                                        <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                    </div>
                                                                    <input type="text" name="txt_Orderset" id="txt_remark" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                    <hr />
                                                    <br />
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-left txtLabel" onclick="tstclearinput()" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-right txtLabel" id="btnsheetSave" onclick="save_matr_forout()" style="background-color:#D6D6D6; color: azure; border-radius: 3px" disabled><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <br />  
                                                </div>--%>
                                            </div>

                                             <div class="tab-pane" id="tab_matrmesh" >
                                             <div class="col-md-12 txtLabel" style="margin-bottom:3px">
                                                    <%--<button class="btn btn-sm btn-success txtLabel pull-right">New</button>--%>
                                                 <a href="javascript:void(0)" class="pull-right" id="btn_mGetlastid"><strong><i class="fa fa-plus" style="font-size:12px"></i> New</strong></a>
                                               
                                            </div>

                                             <div class="row" style="margin-left:12px;margin-right:12px">
                                                <div class="col-md-12  jumbotron txtLabel" style="border-radius:3px">
                                                    เบิกชีส ของเสีย
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
                                                                    <button type="button" class="btn btn-md pull-left txtLabel hidden" id="" style="background-color: #f94144; color: azure; border-radius: 3px">Clear</button>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <button type="button" class="btn btn-md pull-right txtLabel"  onclick="mtstSavedata(4)" style="background-color: #57cc99; color: azure; border-radius: 3px">Save Data</button>
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
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
        <div class="row" id="rb_tblCoil"> <%--row_box_table_coil--%>
            
        </div>

        <div class="row" id="rb_tblSheet" style="display:none" > <%--row_box_table_coil--%>
            <div class="col-md-12">
                <div class="box bxbpdercolor" style="border-radius: 8px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-striped table-bordered table-hover table-condensed txtLabel16 elRadius5px" id="tbl_matr_receive_sheet" style="cursor: pointer;border-radius:10px"> 
                                <thead >
                                    <tr >
                                    <th style="width:20px">Status</th>
                                    <th>Docu Date</th>
                                    <th>Docu cRef.</th>
                                    <th>Packing No</th>
                                    <th>GoodName</th>
                                    <th>Quantity</th>
                                    <th>Service Price</th>
                                    <th>Unit/Price</th>
                                    
                                    <th style="width:20px">#</th>
                                    <th style="width:20px">#</th>
                                    
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="row" id="rb_tblPart" style="display:none"> <%--row_box_table_coil--%>
            <div class="col-md-12">
                <div class="box bxbpdercolor" style="border-radius: 8px">
                    <div class="box-header">
                        <div class="box-body txtLabel">
                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_matr_receive_part" style="cursor: pointer"> 
                                <thead>
                                    <tr>
                                    <th>Docu Date</th>
                                    <th>Docu Ref.</th>
                                    <th>Supplier</th>
                                    <th>Price/Unit</th>
                                    <th>Quantity</th>
                                    <th>Total Amount</th>
                                    
                                    <th style="width:20px">#</th>
                                    <th style="width:20px">#</th>
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
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="txtLabel">กลุ่มวัสดุ</label>
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


        <div class="modal fade " id="MdGetcRef" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;" >
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;width:120%">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการสั่งซื้อวัตถุดิบ</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-sm table-bordered table-striped table-condensed table-hover txtLabel display compact nowrap" id="smatr_crefmd" style="border-radius:3px">
                                <thead>
                                    <tr>
                                        <th class="text-center">Docu Date</th>
                                        <th class="text-center">Docu Ref.</th>
                                        <th class="text-center">Supplier</th>
                                        <th class="text-center">Price/Unit</th>
                                        <th class="text-center">Quantity</th>
                                        <th class="text-center">Total Amount</th>
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


        <div class="modal fade " id="sheetforpaymd" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">รายการ Sheet ใน Stock</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="jumbotron" style="border-radius:3px;margin:auto">
                                    <div class="row">
                                        <div class="col-md-12">
                                           <h3>จำนวน Sheet ของโปรเจค : <h4 id="txtlabelsheet"></h4> </h3> 
                                            
                                        </div>
                                        
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                        <%--<div class="row">
                            <input type="text" name="name" id="txtsheetofproject1"  value="" />
                        </div>--%>
                        <br />
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                               <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tblsheetforpaymd" style="border-radius:3px;width:100%;cursor:pointer">
                                <thead>
                                    <tr>
                                       
                                        <th class="text-center">Lot Ref.</th> 
                                        <th class="text-center">ชื่อวัตถุดิบ</th>
                                        <th class="text-center">ราคาต่อหน่วย</th>
                                        <th class="text-center">จำนวนรับ</th>
                                        <th class="text-center">คงเหลือ</th>
                                       

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
                        <button type="button" class="btn btn-primary pull-left txtLabel"  onclick="calsheetforpay()" style="border-radius: 3px">Close</button>
                        <button type="button" class="btn btn-primary txtLabel" onclick="getMultiGoodCode()" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div class="modal fade " id="newprojectmd" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content" style="border-radius: 10px;">
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">Create New Project</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        

                      <%--  txtprojectname1
                            selectprojecttype1
                            txtprojectset
                            txtprojectdate1--%>
                            
                                 <div class="row" style="margin-top:3px">
                                         <div class="col-md-6">
                                             <div class="form-group">
                                                 <label for="matr_group" class="col-sm-3 control-label txtLabel" style="padding-left:3px;padding-right:3px">โครงการ :</label>
                                                 <div class="col-sm-9">
                                                     <%--<input type="text" class="txtLabel hidden " name="cid" id="sid" value="" />--%>
                                                     <input type="text" name="txtprojectname1" id="txtprojectname1" class="form-control txtLabel" style="border-radius: 3px" />
                                                 </div>
                                             </div>


                                         </div>
                                         <div class="col-md-6">
                                             <div class="form-group">
                                                 <label for="matr_group" class="col-sm-3 control-label txtLabel">ชนิด :</label>
                                                 <div class="txtLabel col-md-9">
                                                     <select id="selectprojecttype1" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                         <option value="1">ทึบแสง</option>
                                                         <option value="2">โปร่งแสง</option>
                                                     </select>
                                                 </div>
                                             </div>
                                         </div>
                                 </div>
                                                                 
                         
                        <div class="row" style="margin-top:3px;">
                            
                                     <div class="col-md-6">
                                    <div class="form-group" style="padding: 0px">
                                        <label for="matr_group" class="col-md-3 control-label txtLabel" style="padding-left:3px;padding-right:3px">จำนวน :</label>
                                        <div class="txtLabel col-md-9">
                                            <input type="text" name="txtprojectset1" id="txtprojectset1" class="form-control txtLabel has-success text-right" style="border-radius: 3px" />
                                        </div>

                                       <%-- <div class="txtLabel col-md-9">
                                            <select id="selectedsheet" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                <option value="39249">Sheet S1 G300</option>
                                                <option value="39250">Sheet S1 G550</option>
                                            </select>
                                        </div>--%>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="matr_group" class="col-sm-3 control-label txtLabel">วันที่ :</label>
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" name="txtprojectdate1" id="txtprojectdate1" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                            </div>

                                        </div>
                                    </div>

                                </div>                                      
                            
                         </div>
                        <div class="row" style="margin-top:3px;margin-bottom:10px">
                            
                                     <div class="col-md-12">
                                    <div class="form-group" style="padding: 0px">
                                        <label for="matr_group" class="col-md-1 control-label txtLabel" style="padding-left:3px;padding-right:0px;">หมายเหตุ:</label>
                                        <div class="txtLabel col-md-11" >
                                            <input type="text" name="txtremark1" id="txtremark1" class="form-control txtLabel has-success pull-right" style="border-radius: 3px;width:96%" />
                                        </div>

                                       <%-- <div class="txtLabel col-md-9">
                                            <select id="selectedsheet" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                <option value="39249">Sheet S1 G300</option>
                                                <option value="39250">Sheet S1 G550</option>
                                            </select>
                                        </div>--%>
                                    </div>
                                </div>
                                                                 
                            
                         </div>

                                   
                        <hr />
                             
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                               <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tblprojectaction" style="border-radius:3px;width:100%;cursor:pointer">
                                <thead>
                                    <tr>
                                        <th class="text-center">Proj. name</th> 
                                        <th class="text-center">Proj. set</th>
                                        <th class="text-center">Proj. date</th>
                                        <th class="text-center">Proj. Type</th>
                                        <th class="text-center">#</th>
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
                        <button type="button" id="btnCreatenewprojectsv" class="btn btn-primary txtLabel" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>


        <div class="modal fade " id="modal_ampelflow_proj" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 20px;">
                <div class="modal-content"  style="border-radius: 10px;" >
                    <div class="modal-header" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #48cae4">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtHeader" style="color: antiquewhite; font-weight: 500">โครงการ Ampel</h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_ampelflow_proj" style="border-radius:3px;width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-center">วันที่</th>
                                        <th class="text-center">ชื่อโครงการ</th>
                                        <th class="text-center">รูปแบบ</th>
                                        <th class="text-center">จำนวนชุด</th>
                                        <th class="text-center">จำนวนชีส</th>
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

         <div class="modal fade " id="WDSheet_MainModalInput" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-radius:5px 5px 0px 0px ">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> ข้อมูลการเบิกชีส</strong></h4>
                    </div>
                    <div class="modal-body">
                            <div class="row">
                                        <div class="col-md-12 ">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel text-right">เลขอ้างอิง :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="projectdate" id="txtout_systemcode_ref" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" disabled />
                                                        <input type="text" name="txtid_checkEdit" id="txtid_checkEdit" class="form-control txtLabel has-success hidden" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" disabled />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">เลขที่เอกสาร :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="projectdate" id="txtout_docu_no" class="form-control txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">วันที่เอกสาร:</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" name="projectdate" id="projectdate" class="form-control txtLabel has-success" style="border-radius: 0px 3px 3px 0px" placeholder="yyyy-MM-dd" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                    
                                        <div class="col-md-12">
                                             <div class="col-md-3">
                                                <div class="form-group ">
                                                    <label for="matr_group" class="control-label txtLabel">รูปแบบ Proj :</label>
                                                    <select id="selectprojecttype" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="">-- เลือกรูปแบบโครงการ --</option>
                                                        <option value="1">ทึบแสง</option>
                                                        <option value="2">โปร่งแสง</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group" style="padding: 0px">
                                                    <label for="matr_group" class="control-label txtLabel">Supplier:</label>
                                                    <select id="selectedsuppliersheet" style="width: 100%; text-align: justify; height: 38px" name="state">
                                                        <option value="15024">เจพี ดีไซน์ แอนด์ แมนูแฟคเจอร์ริ่ง เซอร์วิส จำกัด</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group" style="padding: 0px">
                                                    <label for="matr_group" class="ontrol-label txtLabel">รายการวัตถุดิบ:</label>
                                                    <select id="selectedsheet" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="">--- เลือกวัตถุดิบ ---</option>
                                                        <option value="39249">Sheet S1 G300</option>
                                                        <option value="39250">Sheet S1 G550</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                            
                                        
                                    
                                    
                                        <div class="col-md-12">
                                            <div class="col-md-6">
                                                <div class="form-group" style="padding: 0px">
                                                    <label for="matr_group" class="control-label txtLabel">รายการ V7</label>
                                                    <select id="v7InClude" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                        <option value="28102">InClude V7</option>
                                                        <option value="">Not InClude V7</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">รายการ V3 :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="3px 0px 0px 3px">
                                                            <i class="fa fa-btc" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txt_v3" id="txt_v3" class="form-control txtLabel text-right" disabled/>
                                                        <input type="text" name="txt_v3id" id="txt_v3id" class="form-control txtLabel text-right hidden" />
                                                        <div id="btnv3Selected" class="input-group-addon elRadius2px" data-toggle="tooltip" data-title="เลือก Part V3" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6">
                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure;"><strong><i class="fa fa-cube" aria-hidden="true"></i></strong></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    
                                   
                                        <div class="col-md-12">

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">จำนวนชุด :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-industry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txt_Orderset" id="txt_Orderset"  class="form-control txtLabel text-right" />
                                                        <div id="btnorderset_calc" class="input-group-addon" data-toggle="tooltip" data-title="คำนวณแผ่นชีส" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6">
                                                            <%--background-color:#00c0ef--%>
                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><strong><i class="icofont-calculations"></i></strong></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label txtLabel">จำนวนแผ่นชีส:</label>
                                                    <label id="txtRemaSheet" class="control-label txtLabel pull-right"></label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-reorder"></i>
                                                        </div>
                                                        <input type="text" name="txtsheetofproject" id="txt_sheetremain" class="form-control txtLabel text-right hidden" />
                                                        <input type="text" name="txtsheetofproject" id="txtsheetofproject" class="form-control txtLabel text-right" disabled />
                                                        <div id="btnsheetcalculate" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; cursor: pointer;">
                                                            <label class="txtLabel" style="margin-bottom: auto;">แผ่น</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                   
                                    
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">หมายเหตุ :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txt_Orderset" id="txt_remark" class="form-control txtLabel text-left" style="border-radius: 0px 3px 3px 0" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                <hr />
                                        <div class="col-md-12">
                                            <div class="col-md-12 txtLabel">
                                            <h4 class="txtLabel"><strong><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i> รายการชีส</strong></h4>
                                            <table class="table table-bordered table-striped table-condensed table-hover " id="tblWdSheet_Detail" style="border-radius: 3px;width:100%">
                                                <thead class="txtLabel">
                                                    <tr>
                                                        <th class="text-center">รายการวัตถุดิบ</th>
                                                        <th class="text-center">จำนวน</th>
                                                        <th class="text-center">ราคาต่อหน่วย</th>
                                                        <th class="text-center">ราคารวม</th>
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
                       
                        <button type="button" class="btn btn-md pull-right txtLabel" id="btnsheetSave" onclick="save_matr_forout()" style="background-color:#D6D6D6; color: azure; border-radius: 3px" disabled><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                    </div>
                </div>
             </div>
             </div>
        

        <div class="modal fade " id="modal_v3selected" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
            <div class="modal-dialog" style="border-bottom-left-radius: 5px;">
                <div class="modal-content"  style="border-radius: 5px;" >
                    <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการ Part V3</strong></h4>
                    </div>
                    <div class="modal-body" style="padding-bottom: 0px">
                        <div class="row">
                            <div class="col-md-12 txtLabel">
                                <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_v3selected" style="border-radius:3px;width:100%">
                                <thead class="txtLabel">
                                    <tr>
                                        <th class="text-center">รหัสวัตถุดิบ</th>
                                        <th class="text-center">ชื่อวัตถุดิบ</th>
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
       
    </section>
    <script>
        function CheckBeforeSave() {
            if ($('#txtid_checkEdit').val() == 'CanEdit') {
                //Update

            } else {
                //save
                save_matr_forout();
            }
        }


        function createnewprojectsv() {

            Swal.fire({
                title: '<h3 class="txtLabel" style="color:#85C1E9"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่? ]</strong></h3>',
                icon: 'question',
                showCancelButton: true,
                cancelButtonText: '<div class="txtLabel">Cancle</div>',
                confirmButtonColor: '#57cc99',
                cancelButtonColor: '#f94144',
                confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '../../xTransaction/srv_transaction_out.asmx/tstInsertprojectdata',
                        method: 'POST',
                        data: {
                            action: 'Insertofproject',
                            create_by: usr_name,
                            create_date: currentdate2,
                            isdelete: 'false',
                            isactive: 'true',
                            projectdate: $('#txtprojectdate1').val(),
                            projectname: $('#txtprojectname1').val(),
                            projecttype: $('#selectprojecttype1').val(),
                            projectset: $('#txtprojectset1').val(),
                            remark: $('#txtremark1').val()


                        },
                        dataType: 'json',
                        complete: function (data) {
                            if (data.statusText == 'success') {
                                //alert('success');
                                Swal.fire({
                                    title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่? ]</strong></h3>',
                                    icon: 'success',
                                    confirmButtonColor: '#57cc99',
                                    cancelButtonColor: '#f94144',
                                    confirmButtonText: '<div class="txtLabel">Done..!!</div>'
                                }).then((result) => {
                                    if (result.isConfirmed) {

                                        tstclearinput();
                                        displayprojectmd();
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

        function save_matr_forout() {
            if ($('#projectdate').val() == '') {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบวันที่ในการเบิกวัตถุดิบ</strong></div>'
                })
            }
            else {
                var str = $('#txtsheetofproject').val();
                var strpcs = parseInt($('#txtsheetofproject').val().replace(',', ''));
                Swal.fire({
                    title: '<h3 class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่? ]</strong></h3>',
                    icon: 'question',
                    showCancelButton: true,
                    cancelButtonText: '<div class="txtLabel">Cancle</div>',
                    confirmButtonColor: '#57cc99',
                    cancelButtonColor: '#f94144',
                    confirmButtonText: '<div class="txtLabel">Yes, Saved!</div>'
                }).then((result) => {
                    if (result.isConfirmed) { //insert
                        //if ($('#txt_transaction_id').val() == '') {
                        if ($('#txtid_checkEdit').val() == '') {
                            if (parseInt($('#txtsheetofproject').val().replace(',', '')) < parseInt($('#txt_sheetremain').val().replace(',', ''))) {
                                insert_matr_forout();
                                display_tbl_matr_forpay();
                                check_insert_matr_forout();
                            } else {
                                //alert('Sheet เหลือไม่พอในการเบิก');
                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบ Sheet ใน Stock เหลือน้อยกว่าจำนวนเบิก</strong></div>'

                                })
                            }


                        }
                        else {
                            //alert('Update');
                            update_matr_forout()

                        }


                    } else { //update
                    }
                })
            }

            
        }

        function insert_matr_forout() {

            //alert($('#txt_remark').val());
            $.ajax({
                url: '../../xTransaction/srv_transaction_out.asmx/insertsheet_matr_forout',
                method: 'POST',
                data: {
                    action: 'insertsheet_matr_forout',
                    create_by: usr_name,
                    create_date: currentdate2,
                    isdelete: 'false',
                    isactive: 'true',
                    matr_flag_group: 2,
                    matr_status_flag: 0,
                    matr_transactype: 3,
                    sys_doc_ref: $('#txtout_systemcode_ref').val(),
                    docu_no: $('#txtout_docu_no').val(),
                    doc_date: $('#projectdate').val(),
                    matr_code: $('#selectedsheet').val(),
                    supplier_code: $('#selectedsuppliersheet').val(),
                    quantity: $('#txtsheetofproject').val(),
                    projecttype: $('#selectprojecttype').val(),
                    orderset: $('#txt_Orderset').val(),
                    sheetofproject: $('#txtsheetofproject').val(),
                    v3id: $('#txt_v3id').val(),
                    v7Include: $('#v7InClude').val(),
                    remark: $('#txt_remark').val()
                },
                dataType: 'json',
                complete: function (data) {
                    //console.log(data);
;                    if (data.statusText == 'OK') {
                        Swal.fire({
                            title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></h3>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel"><strong>Done..!!</strong></div>'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                display_tbl_matr_forpay();
                                tstclearinput();

                                $('#WDSheet_MainModalInput').modal('hide');

                                $('#btnsheetSave').prop('disabled', true);
                                $('#btnv3Selected').prop('disabled', true);
                                $('#btnorderset_calc').prop('disabled', true);

                                $('#btnsheetSave').css({ 'background': '#D6D6D6' });
                                $('#btnv3Selected').css({ 'background': '#D6D6D6' });
                                $('#btnorderset_calc').css({ 'background': '#D6D6D6' });
                                
                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">[ เกิดข้อผิดพลาด ]</h3>',

                        })
                    }
                }
            });
        }

        function update_matr_forout() {
            $.ajax({
                url: '../../xTransaction/srv_transaction_out.asmx/update_matr_forout',
                method: 'POST',
                data: {
                    action: 'UpdateSheetWd'
                    , SysDoct: $('#txtout_systemcode_ref').val()
                    , Remark: $('#txt_remark').val()
                    , update_by: usr_name
                    , update_date:currentdate2
                },
                dataType: 'json',
                complete: function (data) {
                    //console.log(data);
                    ; if (data.statusText == 'OK') {
                        Swal.fire({
                            title: '<h3 class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></h3>',
                            icon: 'success',
                            confirmButtonColor: '#57cc99',
                            cancelButtonColor: '#f94144',
                            confirmButtonText: '<div class="txtLabel"><strong>Done..!!</strong></div>'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                display_tbl_matr_forpay();
                                tstclearinput();

                                $('#WDSheet_MainModalInput').modal('hide');

                                $('#btnsheetSave').prop('disabled', true);
                                $('#btnv3Selected').prop('disabled', true);
                                $('#btnorderset_calc').prop('disabled', true);

                                $('#btnsheetSave').css({ 'background': '#D6D6D6' });
                                $('#btnv3Selected').css({ 'background': '#D6D6D6' });
                                $('#btnorderset_calc').css({ 'background': '#D6D6D6' });

                            }
                        })
                    } else if (data.statusText == 'error') {

                        Swal.fire({
                            icon: 'error',
                            title: '<h3 class="txtSecondHeader" style="font-weight:800">[ เกิดข้อผิดพลาด ]</h3>',

                        })
                    }
                }
            });

        }

       

    </script>
    

</asp:Content>
