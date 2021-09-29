<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="transaction_product.aspx.cs" Inherits="AmpelflowApp.xTransaction.transaction_product" %>


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

        <%--<h1 class="txtHeader">จัดการ : ข้อมูลสินค้าสำเร็จรูป</h1>--%>
        <style>
           
            #v7Select{
                border-radius: 0px 3px 3px 0px;
            }

            div.projdisabled {
                pointer-events: none;
                opacity: 0.7;
            }

            input[type=search] {
                border-radius: 3px;
            }
            /*.select2-selection select2-selection--single { border-radius:3px; }
             div.productfgDisabled{
                 pointer-events: none;
                 opacity: 0.7;*/
            }

            .modal_Customer {
                width: 100%;
            }

            .card {
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
                transition: all 0.2s ease-in-out;
                box-sizing: border-box;
                width : 100%;
                margin-top: 10px;
                margin-bottom: 10px;
                background-color: #FFF;
                border-radius : 5px 5px 5px 5px ;
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

            .btnx {
                border: 2px solid black;
                background-color: white;
                color: black;
                padding: 6px 15px;
                font-size: 15px;
                cursor: pointer;
                border-radius: 3px;
            }
            .btnx-sm{
                 padding: 4px 10px;
                 font-size: 12px;
            }

            /* Green */
            .success {
                border-color: #4CAF50;
                color: green;
            }

                .success:hover {
                    background-color: #4CAF50;
                    color: white;
                }

            /* Blue */
            .info {
                border-color: #2196F3;
                color: dodgerblue;
            }

                .info:hover {
                    background: #2196F3;
                    color: white;
                }

            /* Orange */
            .warning {
                border-color: #ff9800;
                color: orange;
            }

                .warning:hover {
                    background: #ff9800;
                    color: white;
                }

            /* Red */
            .danger {
                border-color: #f44336;
                color: red;
            }

                .danger:hover {
                    background: #f44336;
                    color: white;
                }

            /* Gray */
            .default {
                border-color: #e7e7e7;
                color: black;
            }

                .default:hover {
                    background: #e7e7e7;
                }
            [name="tbl_fgGet_Matrial_length"] {
                border-radius:3px 3px 3px 3px;
            } 
            [name="tbl_GetProduct_Display_length"] {
                border-radius:3px 3px 3px 3px;
            }

            [name="tbl_v3selected_length"] {
                border-radius:3px 3px 3px 3px;
            }
            
            [name="tbl_ProvinceCustomer_length"] {
                border-radius:3px 3px 3px 3px;
            }
            
            

            .modal { overflow: auto !important; }
            
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
            var counter = 0;
            var goodStockqtyVar;


            $(document).ready(function () {

                ProgressOn();
                setTimeout(function () {

                    $('.content').fadeIn(500);

                    //fn_GetCustomer();
                    fgGet_material();
                    fnGetProductDisplay();
                    fnGet_WdProductDisplay()
                   

                    var btn_productNewID = $('#btn_productNewID')
                    btn_productNewID.click(function () {
                        GetProductRV_NewID();
                    })

                    var btn_productPayNewID = $('#btn_productPayNewID');
                    btn_productPayNewID.click(function () {
                        GetProductWD_NewID();
                    })

                    var btn_Getproject_Datatowd = $('#btn_Getproject_Datatowd')
                    btn_Getproject_Datatowd.click(function () {
                        Getproject_DatatowdDisplay();
                    })

                    var btn_GetDetailfg = $('#btn_GetDetailfg')
                    btn_GetDetailfg.click(function () {
                        fnGetDetailfgDisplay();
                    });

                    var btn_wdoforfg = $('#btn_wdoforfg')
                    btn_wdoforfg.click(function () {
                        //fnGet_Insertitempart_wdforfg();
                        Check_fnGet_Insertitempartoption();
                    })


                    var btn_v3id = $('#btn_v3id');
                    btn_v3id.click(function () {
                        fn_v3selectedDisplay();
                    })


                    //var btn_optionAdd = $('#btn_optionAdd');
                    //btn_optionAdd.click(function () {
                    //    fn_getoptionAdd();
                    //})

                    setTimeout(function () {
                        $('body').removeClass('overlay');
                    }, 500)



                    $("#addrow").on("click", function () {
                        var newRow = $("<tr>");
                        var cols = "";

                        //cols += '<td><input type="text" class="form-control input " name="name"' + counter + '" style="border-radius:3px" /></td>';
                        cols += '<td><input type="text" id="rowsNum' + counter + '" value=' + counter + ' class="hidden"><input type="text" id="goodid' + counter + '" class="hidden"><div class="input-group">' + //<div>' + counter + '</div>
                            '<input type="text" name ="name"' + counter + ' id="goodcode' + counter + '" class="form-control input" style="border-radius:3px 0px 0px 3px" placeholder="เลือกรายการวัตถุดิบ" disabled/>' +
                            '<div id="btn_optionAdd" class="input-group-addon" data-toggle="tooltip" data-title="เลือกรายการ" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #3C8DBC; cursor: pointer;">' +
                            '<label class="txtLabel" onclick="modal_fgGet_material(' + counter + ')" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure"><i class="icofont-ui-zoom-in"></i></label>' +
                            '</div></div></td>';
                        cols += '<td><input type="text" class="form-control input " name ="name"' + counter + '" id="goodname' + counter + '"  style="border-radius:3px" disabled /></td>';
                        cols += '<td><input type="text" class="form-control input text-right decimal-number" name ="name"' + counter + '" id="goodStockqty' + counter + '" style="border-radius:3px" placeholder="0,00.00" disabled/><input type="number" class="form-control input text-right decimal-number hidden" name ="name"' + counter + '" id="goodStockqtyx' + counter + '" style="border-radius:3px" placeholder="0,00.00" disabled/></td>';
                        cols += '<td><input type="text" class="form-control input text-right decimal-number" name ="name"' + counter + '" id="goodqty' + counter + '" style="border-radius:3px" placeholder="0,00.00"/></td>';
                        cols += '<td><div class="btn-group text-center" style="padding-top:3px" >' +
                            '<div class="btn-group"><a href="javascript:void(0)"  type="button" data-toggle="tooltip" data-title="ลบ!" class="ibtnDel btn btn-sm btn-danger "><i class="fa fa-trash" aria-hidden="true" style="font-size=15px"></i></a>' +
                            '</div></td>';

                        newRow.append(cols);
                        $("table.order-list").append(newRow);
                        counter++;
                    });



                    $("table.order-list").on("click", ".ibtnDel", function (event) {
                        $(this).closest("tr").remove();
                        counter -= 1
                    });

                    $(document).on("input", ".decimal-number", function (e) {
                        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
                    });


                    
                    $('#btn_GetCustomer').click(function () { fn_GetCustomerAll(); })
                    $('#btn_reItemCalc').click(function () { reCalcItem(); })
                    $('#btnItemofproject').click(function () { fnGet_Itemofprojectedit(); })


                    //btnItemofproject


                    var btn_GetProductPayout = $('#btn_GetProductPayout');
                    btn_GetProductPayout.click(function () {
                        GetProductWdfg_trasacwsp();
                    })

                    var btntab_Coilx = $('#tab_Coilx');
                    btntab_Coilx.click(function () {
                        $('#box_tbl_mngproject').fadeIn(200);
                        $('#box_tbl_WdProduct').fadeOut(200);

                    })

                    var btntab_fgpayoutx = $('#tab_fgpayoutx');
                    btntab_fgpayoutx.click(function () {
                        $('#box_tbl_WdProduct').fadeIn(200);
                        $('#box_tbl_mngproject').fadeOut(200);
                    })


                    var btnSyncCustomer = $('#btnSyncCustomer');
                    btnSyncCustomer.click(function () {
                            
                    })

                    var btn_GetSheet = $('#btn_GetSheet');
                    btn_GetSheet.click(function () {
                        fnGetProductSheetAdd();
                        $('#modal_AddSheet').modal('show');
                    })

                    var btn_GetInv = $('#btn_GetInv');
                    btn_GetInv.click(function(){
                        fnGetInv();
                    })

                   

                    ProgressOff();
                },1000)

                $(document).on('show.bs.modal', '.modal', function (event) {
                    var zIndex = 1040 + (10 * $('.modal:visible').length);
                    $(this).css('z-index', zIndex);
                    setTimeout(function () {
                        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                    }, 0);
                });
                
            });

            


            function calculateRow(row) {
                var price = +row.find('input[name^="price"]').val();

            }

            function calculateGrandTotal() {
                var grandTotal = 0;
                $("table.order-list").find('input[name^="price"]').each(function () {
                    grandTotal += +$(this).val();
                });
                $("#grandtotal").text(grandTotal.toFixed(2));
            }

            function ClearInput() {
                $('#txtProduct_fg_code').val('');
                $('#txtproduct_detail').val('');
                $('#txtproduct_code').val('');
                $('#txtproduct_id').val('');
                $('#txtitem_sys_doc_ref').val('');
                $('#txtdoc_date').val('');
                $('#txtproduct_goodname').val('');
                $('#txtproduct_goodid').val('');
                $('#txtCustomer_name').val('');
                $('#txtCustomer_name').val('');
                $('#txtCustomer_id').val('');
                $('#txtCust_addr').val('');
                $('#txtwdfg_custname').val('');
                $('#txtwdfg_custid').val('');
                $('#txtwdfg_projname').val('');
                $('#txtwdfg_goodname').val('');
                $('#txtwdfg_goodid').val('');
                $('#txtwdfg_qty').val('');
                $('#txtwdfg_priceperunit').val('');
                $('#txtwdfg_amnt').val('');
                $('#txtwdfg_sys_doc_ref').val('');
                $('#txtwdfgdoc_date').val('');
                $('#txtwdfg_doc_no').val('');
                $('#txtwdfg_remark').val('');

                $('#txtfg_sys_doc_ref').val('');
                $('#txtfg_doc_no').val('');
                $('#txtdoc_date').val('');
                $('#selectprojecttype').val('');
                $('#selectprojecttype').select2();
                $('#select2-selectprojecttype-results').addClass('txtLabel')
                $('#txtfg_setqty').val('');
                $('#txtfg_goodname').val('');
                $('#txtfg_goodid').val('');
                $('#txtv3_goodname').val('');
                $('#txtv3_goodid').val('');
                $('#txtproj_name').val('');

                $('#txtSheet_id').val('')
                $('#txtSheet_name').val('')

                $('#txtinv').val('');
                $('txtdocid').val('');
                $('txtgoodid').val('');
                $('txtpayqty').val('');
                $('txtpaycost').val('');
                $('txtpayamount').val('');


                Swal.fire({
                    position: 'top-end',
                    icon: 'success',
                    title: '<div class="txtLabel"><strong>[: เคลียร์ข้อมูลเรียบร้อย ]</strong></div>',
                    timer: 1500
                })


            }

            function GetProductRV_NewID() {

                ProgressOn();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductfg_lastid',
                    method: 'post',
                    data: {
                        action: 'GetRV_fg_lastid'

                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#txtfg_sys_doc_ref').val(data[i].newSysCode_doc);
                                $('#dproductfgDisabled').removeClass('productfgDisabled')
                                $('#txtdoc_date').val(currentdate2);
                                ProgressOff();
                            })

                            $('#modal_Products').modal('show');

                        }

                    }
                })
            }

            function Getproject_DatatowdDisplay() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/Getproject_DatatowdDisplay',
                    method: 'post',
                    data: {
                        action: 'Getproject_DatatowdDisplay'

                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //alert(data.length);
                            var tbl_Getproject_Datatowd = $('#tbl_Getproject_Datatowd').DataTable();
                            tbl_Getproject_Datatowd.clear();

                            $.each(data, function (i, item) {
                                tbl_Getproject_Datatowd.row.add([

                                    '<div class="text-center">' + data[i].doc_date + '</div>'
                                    // , '<div class="text-left">' + data[i].sys_doc_ref + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].project_type_detail + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].orderamnt).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="Getproject_DatatowdDisplayByid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 13px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ])

                                tbl_Getproject_Datatowd.draw();
                            });
                        }
                        $('#modal_Getproject_Datatowd').modal('show');
                    }
                })
            }


            function Getproject_DatatowdDisplayByid(mtid) {
                //alert(mtid);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/Getproject_DatatowdDisplayByid',
                    method: 'post',
                    data: {
                        action: 'Getproject_DatatowdDisplayByid'
                        , id: mtid

                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {


                            $.each(data, function (i, item) {
                                $('#txtproduct_detail').val(data[i].goodname + ' ; ' + data[i].orderamnt + 'ชุด');
                                $('#txtproduct_code').val(data[i].goodname);
                                $('#txtproduct_id').val(data[i].id);
                                $('#txtitem_sys_doc_ref').val(data[i].sys_doc_ref);
                                tbl_iteminproductByDocref(data[i].sys_doc_ref);
                            });
                        }
                        $('#modal_Getproject_Datatowd').modal('hide');
                    }
                })
            }

            function tbl_iteminproductByDocref(sys_doc_ref) {
                //alert(sys_doc_ref)
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/tbl_iteminproductByDocref',
                    method: 'post',
                    data: {
                        action: 'tbl_iteminproductByDocref'
                        , sys_doc_ref: sys_doc_ref

                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //alert(data.length);
                            var tbl_iteminproduct = $('#tbl_iteminproduct').DataTable();
                            tbl_iteminproduct.clear();

                            $.each(data, function (i, item) {
                                tbl_iteminproduct.row.add([

                                    '<div class="text-left" style="padding-left:20px">' + data[i].sys_doc_ref + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodcode + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="Getproject_DatatowdDisplayByid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 13px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'



                                ])

                                tbl_iteminproduct.draw();
                            });
                        }
                        $('#modal_Getproject_Datatowd').modal('hide');
                    }
                })
            }

            function fnGetDetailfgDisplay() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetDetailfgDisplay',
                    method: 'post',
                    data: {
                        action: 'GetDetailfgDisplay'

                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //alert(data.length);
                           



                            var tbl_GetProduct_Display = $('#tbl_GetProduct_Display').DataTable();
                            tbl_GetProduct_Display.clear();

                            $.each(data, function (i, item) {
                                tbl_GetProduct_Display.row.add([

                                    '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodcode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetDetailfgByid(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 13px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'



                                ])

                                tbl_GetProduct_Display.draw();
                            });
                        } else {
                            


                            var tbl_GetProduct_Display = $('#tbl_GetProduct_Display').DataTable();
                            tbl_GetProduct_Display.clear();
                        }
                        $('#modal_GetProduct_Display').modal('show');
                    }
                })
            }

            function fnGetDetailfgByid(goodid) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetDetailfgDisplayByid',
                    method: 'post',
                    data: {
                        action: 'GetDetailfgByid'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            $.each(data, function (i, item) {

                                $('#txtfg_goodname').val(data[i].goodname);
                                $('#txtfg_goodid').val(data[i].goodid);




                            });
                        }
                        $('#modal_GetProduct_Display').modal('hide');
                    }
                })
            }

            function fn_v3selectedDisplay() {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fn_v3selectedDisplay',
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
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + numeral(data[i].v3remain).format('0,0.00') + '</div>'
                                    

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_v3selectedDisplaybyid(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID วัตถุดิบ:' + data[i].goodid + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
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
                //alert(goodid)
               // $('#btnsheetSave').prop('disabled',true)

                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fn_v3selectedDisplayByid',
                    method: 'post',
                    data: {
                        action: 'fn_v3selectedDisplaybyid'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {
                                //alert(data[i].matr_goodname + ' ; ' + data[i].goodid)
                                $('#txtv3_goodname').val(data[i].matr_goodname);
                                $('#txtv3_goodid').val(data[i].goodid);
                            });
                            $('#modal_v3selected').modal('hide');
                        }
                    }
                })
            }




            function fgGet_material() {
               
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fgGet_material',
                    method: 'post',
                    data: {action: 'fgGet_material'},
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            $('#tbl_fgGet_Matrial').DataTable().clear();
                            $('#tbl_fgGet_Matrial').DataTable().destroy();


                            var tbl_fgGet_Matrial = $('#tbl_fgGet_Matrial').DataTable({ 'ordering': false });
                            $('[name=tbl_fgGet_Matrial_length]').select2()
                            tbl_fgGet_Matrial.clear();

                            $.each(data, function (i, item) {
                                tbl_fgGet_Matrial.row.add([

                                    '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodcode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:10px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:10px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'

                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fgGet_materialbyid(\'' + data[i].goodid + '\',\'' + this + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID วัตถุดิบ:' + data[i].goodid + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ])
                                tbl_fgGet_Matrial.draw();
                            });
                        }
                        else {
                            $('#tbl_fgGet_Matrial').DataTable().clear();
                            $('#tbl_fgGet_Matrial').DataTable().destroy();


                            var tbl_fgGet_Matrial = $('#tbl_fgGet_Matrial').DataTable({ 'ordering': false });
                            tbl_fgGet_Matrial.clear();
                        }
                        //$('#modal_fgGet_material').modal('show');
                    }
                })
            }


            function modal_fgGet_material(counter) {
                //alert(counter);
                $('#rowsindex').val(counter);
                $('#modal_fgGet_material').modal('show');
            }

            function fgGet_materialbyid(goodid) {
                var rowsInd = $('#rowsindex').val();
                //alert($('#rowsindex').val());
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fgGet_materialByid',
                    method: 'post',
                    data: {
                        action: 'fgGet_materialbyid'
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            $.each(data, function (i, item) {
                                //alert(data[i].goodcode);
                                $('#goodcode' + rowsInd).val(data[i].goodcode);
                                $('#goodname' + rowsInd).val(data[i].goodname);
                                $('#goodid' + rowsInd).val(data[i].goodid);
                                $('#goodStockqty' + rowsInd).val(numeral(data[i].quantity).format('0,0.00'));
                                $('#goodStockqtyx' + rowsInd).val(parseFloat(data[i].quantity));
                                goodStockqtyVar = parseFloat(data[i].quantity);
                            });
                        }
                        $('#modal_fgGet_material').modal('hide');
                    }
                })
            }

            function fgGet_InsertOption(counter) {
                var counterRows = counter
                var goodid = $('#goodid' + counterRows).val();
                var goodqty = $('#goodqty' + counterRows).val();
                //alert('goodid : ' + goodid + '\n' +
                //      'goodqty : ' + goodqty)

            }

            


            function fn_GetCustomerAll() {
                //alert(1);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fn_GetCustomerProjAll_remaOrder',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerAll_order_remaOrder'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            //alert(1);
                            var tbl_Customer = $('#tbl_Customer').DataTable();
                            tbl_Customer.clear();

                            $.each(data, function (i, item) {
                                tbl_Customer.row.add([
                                   
                                    '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetCustomerProjById(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" data-tippy-content="1" title="ID วัตถุดิบ:' + data[i].id + '"  style="font-size: 15px;color:#3c8dbc"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                  

                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customerprojdate + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customername + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customerprojname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].customerorderqty).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].remaOrderQty).format('0,0.00') + '</div>'

                                ]);

                                tbl_Customer.draw();
                            });
                            $('#modal_Customer').modal('show');

                        } else {
                            $('#tbl_Customer').DataTable().clear();
                            $('#tbl_Customer').DataTable().destroy();

                            var tbl_Customer = $('#tbl_Customer').DataTable({ 'ordering': false, });
                            $('[name="tbl_Customer_length"]').select2();
                            tbl_Customer.clear();

                            $('#modal_Customer').modal('show');
                        }
                    }
                })
            }

            function fn_GetCustomerProjById(id) {
                //alert(id);

                $.ajax({
                    url: '../../xTransaction/srv_transaction_project.asmx/fn_GetCustomerProjById',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerProjById'
                        ,id:id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                           


                            $.each(data, function (i, item) {
                                $('#txtcustprojid').val(data[i].id)
                                $('#txtCustomer_id').val(data[i].customerid)
                                $('#txtCustomer_name').val(data[i].customername)
                                $('#txtCust_addr').val(data[i].customeraddress)
                                $('#txtproj_name').val(data[i].customerprojname)
                               

                            });
                            //$('#modal_Customer').modal('show');


                            $('#modal_Customer').modal('hide');
                            $('#txtCustomerProjName').focus();
                        } else {
                            $('#tbl_Customer').DataTable().clear();
                            $('#tbl_Customer').DataTable().destroy();

                            var tbl_Customer = $('#tbl_Customer').DataTable();
                            tbl_Customer.clear();
                        }
                    }
                })
            }
            function fn_GetCustomerByid(CustId) {
                //alert(CustId);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetCustomerDisplayById',
                    method: 'post',
                    data: {
                        action: 'fnGetCustomerDisplayById',
                        CustId: CustId
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            var tbl_Customer = $('#tbl_Customer').DataTable();
                            tbl_Customer.clear();

                            $.each(data, function (i, item) {
                                //alert(data[i].CustId);
                                $('#txtCustomer_name').val(data[i].CustTitle + ' ' + data[i].CustName);
                                $('#txtCustomer_id').val(data[i].CustId);
                                $('#txtCust_addr').val(data[i].CustAddr1 + ' ' + data[i].District + ' ' + data[i].Amphur + ' ' + data[i].Province + ' ' + data[i].PostCode);
                                //alert(1);
                            });
                            $('#modal_Customer').modal('hide');

                        }
                    }
                })
            }

            function fnGetProductDisplay() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductDisplay',
                    method: 'post',
                    data: {
                        action: 'GetProductDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {


                            $('#tbl_mngproject').DataTable().clear();
                            $('#tbl_mngproject').DataTable().destroy();

                            var tbl_mngproject = $('#tbl_mngproject').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false, 'scrollX' : true
                            });
                            $('[name="tbl_mngproject_length"]').select2();

                            tbl_mngproject.clear();
                            $.each(data, function (i, item) {
                                tbl_mngproject.row.add([
                                    '<div class="text-left" style="padding-left:10px">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:10px">' + data[i].CustName + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].matr_goodname + '</div>'
                                    , '<div class="text-right" style="padding-left:20px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-left:20px">' + numeral(data[i].materquantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-left:20px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right" style="padding-left:20px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    //, '<div style="text-align: center;">' +
                                    //'<a href="javascript:void(0)" type="button"   onclick="fnGetProductDisplayById(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID : ' + data[i].id + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>' +
                                    //'</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetProductDisplayAction(\'' + data[i].sys_doc_ref + '\')" class="btn-group" data-toggle="tooltip" data-placement="top" title="ID:' + data[i].id + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ]);

                                tbl_mngproject.draw();
                            });

                        }
                    }
                })

            }

            function fnGetProductDisplayAction(sysdocref) {
                fnRemoveText();
                fnGetProductCustDetail(sysdocref);
                fnGetProductDisplayById(sysdocref);
            }

            function fnGetProductCustDetail(sysdocref) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductCustDetail',
                    method: 'post',
                    data: {
                        action: 'GetProductCustDetail'
                        , sys_doc_ref: sysdocref
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



                            })
                        }
                    }
                })
            }

            function fnGetProductDisplayById(sysdocref) {
                //alert(transac_id);
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductDisplayById',
                    method: 'post',
                    data: {
                        action: 'GetProductDisplayById'
                        , sys_doc_ref: sysdocref
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //fnGetProductCustDetail(sysdocref)

                            var tbl_GetProjectEdit = $('#tbl_GetProjectEdit').DataTable();
                            tbl_GetProjectEdit.clear();

                            $.each(data, function (i, item) {
                                tbl_GetProjectEdit.row.add([
                                    '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].matr_goodname  + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetitemofprojectedit(\'' + data[i].id + '\',\'' + sysdocref + '\',\'' + data[i].matr_code  + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID วัตถุดิบ:' + data[i].goodid + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ]);
                                tbl_GetProjectEdit.draw();
                            });

                        }
                    }
                })

                $('#modal_GetProjectEdit').modal('show');
                //alert(transac_id);

                
            }
            function fnGetitemofprojectedit(transac_id,sysdocref,goodid) {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetitemofprojecteditById',
                    method: 'post',
                    data: {
                        action: 'GetitemofprojecteditById'
                        , id: transac_id
                        , sys_doc_ref: sysdocref
                        , goodid: goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#txt_transac_id').val(data[i].id);
                                $('#txt_sysdocref').val(data[i].sys_doc_ref);
                                $('#txt_goodid').val(data[i].matr_code);
                                $('#txtmatr_goodcode').val(data[i].goodcode);
                                $('#txtmatr_goodname').val(data[i].matr_goodname);
                                $('#txtmatr_qty').val(numeral(data[i].quantity).format('0,0.00'));
                                $('#txtmatr_priceperunit_now').val(numeral(data[i].priceperunit).format('0,0.00'));
                                $('#txtmatr_amnt_now').val(numeral(data[i].amount).format('0,0.00'));

                            });
                        }
                    }
                })
                $('#modal_itemofprojectedit').modal('show');
            }

            function reCalcItem() {
                var qty = parseFloat($('#txtmatr_qty').val());
                var ppunit = parseFloat($('#txtmatr_priceperunit_now').val());
                var amount = parseFloat(($('#txtmatr_amnt_now').val().replace(',','')));

                $('#txtmatr_amnt_now').val(numeral(qty * ppunit).format('0,0.00'));
                //alert(qty*ppunit);
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

            function GetProductWD_NewID() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductWdfg_lastid',
                    method: 'post',
                    data: {
                        action: 'GetWD_fg_lastid'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                //alert(data[i].newSysCode_doc);
                                $('#txtwdfg_sys_doc_ref').val(data[i].newSysCode_doc);
                                $('#dproductfgDisabled').removeClass('productfgDisabled')
                            })


                        }

                    }
                })
            }

            function GetProductWdfg_trasacwsp() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductWdfg_trasacwsp',
                    method: 'post',
                    data: {
                        action: 'GetProductWdfg_trasacwsp'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                           
                           

                            var tbl_GetProductPayoutwsp = $('#tbl_GetProductPayoutwsp').DataTable();
                            tbl_GetProductPayoutwsp.clear();

                            $.each(data, function (i, item) {
                                tbl_GetProductPayoutwsp.row.add([
                                    '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].DocuDate + '</div>'
                                    ,'<div class="text-left txtLabel" style="padding-left:5px">' + data[i].Docuno + '</div>'
                                    ,'<div class="text-left txtLabel" style="padding-left:5px">' + data[i].CustName + '</div>'
                                    ,'<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayQty).format('0,0.00') + '</div>'
                                    ,'<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayCost).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayAmnt).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="GetProductWdfg_trasacwspbyid(\'' + data[i].Docuno + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="ID วัตถุดิบ:' + data[i].goodid + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    //'<div class="text-left" style="padding-left:20px">' + data[i].matr_goodname + '</div>'
                                    //, '<div class="text-right" style="padding-left:20px">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    //, '<div class="text-right" style="padding-left:20px">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    //, '<div class="text-right" style="padding-left:20px">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                   
                                ]);
                                tbl_GetProductPayoutwsp.draw();
                            });
                            $('#modal_ProductPayoutwsp').modal('show');

                        }

                    }
                })
            }

            function GetProductWdfg_trasacwspbyid(docuinv) {
               
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/GetProductWdfg_trasacwspbyid',
                    method: 'post',
                    data: {
                        action: 'GetProductWdfg_trasacwspbyid'
                        ,docuno: docuinv
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#txtwdfg_doc_no').val(data[i].Docuno);
                                $('#txtwdfgdoc_date').val(data[i].DocuDate);
                                $('#txtwdfg_custname').val(data[i].CustName);
                                $('#txtwdfg_custid').val(data[i].custid);
                                $('#txtwdfg_goodname').val(data[i].GoodName1);
                                $('#txtwdfg_goodid').val(data[i].GoodID);
                                $('#txtwdfg_remark').val(data[i].Remark);
                                $('#txtwdfg_qty').val(numeral(data[i].PayQty).format('0,0.00'));
                                $('#txtwdfg_priceperunit').val(numeral(data[i].PayAmnt).format('0,0.00'));
                                $('#txtwdfg_amnt').val(numeral(data[i].PayAmnt).format('0,0.00'));
                            });
                            $('#modal_ProductPayoutwsp').modal('hide');

                        }

                    }
                })
            }

            function fnGet_WdProductDisplay() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetProductWdDisplay',
                    method: 'post',
                    data: {
                        action: 'fnGetProductWdDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //alert(data.length);

                            //$('#tbl_WdProduct').DataTable().clear();
                            //$('#tbl_WdProduct').DataTable().destroy();


                            var tbl_WdProduct = $('#tbl_WdProduct').DataTable();
                            tbl_WdProduct.columns.adjust().fixedColumns().relayout();

                            tbl_WdProduct.clear();
                       
                            //tbl_WdProduct.columns.adjust();

                            
                            $.each(data, function (i, item) {
                                tbl_WdProduct.row.add([
                                    '<div class="text-center">' + data[i].doc_date + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].CustName + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].projectname + '</div>'
                                    , '<div class="text-left" style="padding-left:20px">' + data[i].matr_goodname + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].quantity).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].priceperunit).format('0,0.00') + '</div>'
                                    , '<div class="text-right">' + numeral(data[i].amount).format('0,0.00') + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="Getproject_DatatowdDisplayByid(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 13px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ])
                                tbl_WdProduct.draw();
                                //tbl_WdProduct.columns.adjust();
                                //new $.fn.dataTable.FixedColumns(tbl_WdProduct);
                            });
                        }
                       
                    }
                })
            }

            function fnGetProductSheetAdd() {
                ProgressOn();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fn_GetProductSheetAdd',
                    method: 'post',
                    data: {
                        action: 'GetProductSheetAdd'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            //alert(data.length);

                            //$('#tbl_WdProduct').DataTable().clear();
                            //$('#tbl_WdProduct').DataTable().destroy();


                            var tbl_AddSheet = $('#tbl_AddSheet').DataTable();
                            tbl_AddSheet.columns.adjust().fixedColumns().relayout();

                            tbl_AddSheet.clear();

                            //tbl_WdProduct.columns.adjust();


                            $.each(data, function (i, item) {
                                tbl_AddSheet.row.add([
                                     '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodcode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].goodname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].sheetremain).format('0,0.00') + '</div>'
                                   
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetProductSheetAddById(\'' + data[i].goodid + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].id + '"  style="font-size: 13px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                ])
                                tbl_AddSheet.draw();

                                //tbl_WdProduct.columns.adjust();
                                //new $.fn.dataTable.FixedColumns(tbl_WdProduct);
                            });

                            ProgressOff();
                        }

                    }
                })
            }

            function fnGetProductSheetAddById(goodid) {
                ProgressOn();
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fn_GetProductSheetAddById',
                    method: 'post',
                    data: {
                        action: 'GetProductSheetAddById'
                        ,goodid : goodid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {
                            

                            $.each(data, function (i, item) {
                               
                                $('#txtSheet_name').val(data[i].goodname);
                                $('#txtSheet_id').val(data[i].goodid);
                   
                               
                                //tbl_WdProduct.columns.adjust();
                                //new $.fn.dataTable.FixedColumns(tbl_WdProduct);
                            });
                            $('#modal_AddSheet').modal('hide');
                            ProgressOff();

                        }

                    }
                })
            }

            function fnGetInv() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetInvDisplay',
                    method: 'post',
                    data: {
                        action: 'fnGetInvDisplay'
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {

                            $('#tbl_Inv').DataTable().clear();
                            $('#tbl_Inv').DataTable().destroy();

                            var tbl_Inv = $('#tbl_Inv').DataTable({ 'ordering': false });
                            $('[name=tbl_Inv_length]').select2();


                            $.each(data, function (i, item) {
                                tbl_Inv.row.add([
                                    '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fnGetInvById(\'' + data[i].DocuID + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" title="Edit:' + data[i].DocuID + '"  style="font-size: 15px;color:#0077b6"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].DocuDate + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].Docuno + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayQty).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayCost).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-left:5px">' + numeral(data[i].PayAmnt).format('0,0.00') + '</div>'


                                ])

                                tbl_Inv.draw();
                            })
                            $('#modal_Inv').modal('show');

                        } else {
                            console.log('err');
                        }
                    }
                })
            }
            function fnGetInvById(docuid) {

                $('#txtinv').val('');
                $('#txtdocid').val('');
                $('#txtgoodid').val('');
                $('#txtpayqty').val('');
                $('#txtpaycost').val('');
                $('#txtpayamount').val('');

                $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGetInvDisplayById',
                    method: 'post',
                    data: {
                        action: 'fnGetInvDisplayById'
                        ,id : docuid
                    },
                    dataType: 'json',
                    success: function (data) {

                        if (data != '') {


                            $.each(data, function (i, item) {
                                $('#txtinv').val(data[i].Docuno);
                                $('#txtdocid').val(data[i].DocuID);
                                $('#txtgoodid').val(data[i].GoodID);
                                $('#txtpayqty').val(data[i].PayQty);
                                $('#txtpaycost').val(data[i].PayCost);
                                $('#txtpayamount').val(data[i].PayAmnt);

                            })
                            
                           
                            $('#modal_Inv').modal('hide');

                        } else {
                            console.log('err');
                        }
                    }
                })
            }

        </script>

        <section class="content" style="display: none">
            <div class="row">
                <%--<div class="col-md-12">--%>
                
                <%--<%=  Session["strDropDownNoti"].ToString() %>--%>
                     
                

                <div class="box box-primary" id="boxInput" style="border-radius: 5px">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="user-block">
                                <img src="../../Content/Icons/web512.png" alt="User Image">
                                <span class="username">
                                    <a href="#" class="txtSecondHeader"><strong>จัดการสินค้าสำเร็จรูป</strong></a>
                                </span>
                                <span class="description txtLabel">Monitoring progression of projects</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Custom Tabs -->
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab">
                                        <li class="active" id="tab_Coilx" style="border-top-right-radius: 3px; border-top-left-radius: 3px"><a href="#tab_Coil" class="txtLabel" data-toggle="tab"><strong><i class="fa fa-bandcamp" aria-hidden="true"></i> รับสินค้าสำเร็จรูป</strong></a></li>
                                        <%--<li class="maincolor" id="tab_fgpayoutx" style="border-top-right-radius: 3px; border-top-left-radius: 3px"><a href="#tab_fgpayout" class="txtLabel" data-toggle="tab"><strong><i class="fa fa-bandcamp" aria-hidden="true"></i> เบิก-ขาย สินค้าสำเร็จรูป</strong></a></li>--%>
                                        <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active " id="tab_Coil">
                                            <%--  --%>
                                            <div class="col-md-12 txtLabel " style="margin-bottom: 3px">
                                                <a href="javascript:void(0)" class="pull-right" id="btn_productNewID"><strong><i class="fa fa-plus" style="font-size: 13px"></i> New</strong></a>

                                            </div>
                                            <div class="productfgDisabled" id="dproductfgDisabled">
                                                <div class="row" style="margin-left: 13px; margin-right: 13px">
                                                    <div class="col-md-12  jumbotron txtLabel" style="border-radius: 3px;">
                                                        จัดการ : จัดการรายการสินค้าสำเร็จรูป 
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_mngproject" style="cursor: pointer; border-radius: 3px; width: 100%">
                                                            <thead>
                                                                <tr>
                                                                    <th>วันที่</th>
                                                                    <th>ลูกค้า</th>
                                                                    <th>ชื่อสินค้า</th>
                                                                    <th>จำนวนชุด</th>
                                                                    <th>จำนวนเมตร</th>
                                                                    <th>ราคาต่อหน่วย</th>
                                                                    <th>ราคาต่อหน่วย</th>

                                                                    <th style="width: 20px">#</th>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                        </div>
                                                        
                                                </div>
                                            </div>
                                        </div>
                                           </div>
                                        <%--<div class="tab-pane" id="tab_fgpayout">
                                   
                                            <div class="col-md-12 txtLabel " style="margin-bottom: 3px">
                                                <a href="javascript:void(0)" class="pull-right" id="btn_productPayNewID"><i class="fa fa-plus" style="font-size: 13px"></i> New</a>

                                            </div>
                                            <div class="productfgDisabled" id="dproductPayfgDisabled">
                                                <div class="row" style="margin-left: 13px; margin-right: 13px">
                                                    <div class="col-md-12  jumbotron txtLabel" style="border-radius: 3px;">
                                                        จัดการ : จัดการรายการ เบิก-ขาย สินค้าสำเร็จรูป 
                                                    </div>
                                                    
                                                        <div class="col-md-12 " style="font-weight: 100">
                                                           <div class="row">
                                                               
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">เลขที่อ้างอิง : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtProductfg_code" id="txtwdfg_sys_doc_ref" class="form-control txtLabel  text-right" style="border-radius: 0px 3px 3px 0px" disabled />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">วันที่ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-calendar" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_projsuppliername" id="txtwdfgdoc_date" class="form-control txtLabel  " style="border-radius: 0px 3px 3px 0px" placeholder="yyyy-MM-dd" disabled/>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">เลขเอกสาร : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-file-text" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_projsuppliername" id="txtwdfg_doc_no" class="form-control txtLabel " style="border-radius: 0px 3px 3px 0px"  disabled/>
                                                                                <div id="btn_GetProductPayout" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #00c0ef; cursor: pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                               </div>
                                                              
                                                           
                                                            <div class="row">
                                                                <div class="col-md-8">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">ลูกค้า : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_custname" class="form-control txtLabel " style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            <input type="text" name="" id="txtwdfg_custid" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">ชื่อโครงการ : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_projname" class="form-control txtLabel " style="border-radius: 0px 3px 3px 0px"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-8">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">สินค้า : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-cube" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_goodname" class="form-control txtLabel " style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            <input type="text" name="" id="txtwdfg_goodid" class="form-control txtLabel" style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">หมายเหตุ : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-file-text" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_remark" class="form-control txtLabel " style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">จำนวน : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-cubes" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_qty" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            <div class="input-group-addon txtLabel" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                ชุด
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">ราคาต่อหน่วย : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-btc" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_priceperunit" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            <div class="input-group-addon txtLabel" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                บาท
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label class="txtLabel">เป็นจำนวนเงิน : </label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                <i class="fa fa-btc" aria-hidden="true"></i>
                                                                            </div>
                                                                            <input type="text" name="" id="txtwdfg_amnt" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0px" disabled/>
                                                                            <div class="input-group-addon txtLabel" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                บาท
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>--%>

                                                      

                                                        <%--<div class="col-md-12 " style="font-weight: 100">
                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <div class="col-md-3">

                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">รูปแบบโครงการ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-tasks" aria-hidden="true"></i>
                                                                                </div>
                                                                                <div class="txtLabel">
                                                                                    <select id="selectprojecttype" class="txtLabel " style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                                        <option value="">- รูปแบบโครงการ -</option>
                                                                                        <option value="1">ทึบแสง</option>
                                                                                        <option value="2">โปร่งแสง</option>
                                                                                    </select>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <div class="form-group">
                                                                            <label for="matr_group" class="control-label txtLabel">จำนวนชุด : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-calendar" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtfg_setqty" id="txtfg_setqty" class="form-control txtLabel " />
                                                                                <div class="input-group-addon" style="border-radius: 0px 3px 3px 0px">
                                                                                    <label class="txtLabel">ชุด</label>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label for="exampleInputEmail1" class="txtLabel">รายการสินค้า : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-product-hunt" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_projsuppliername" id="txtfg_goodname" class="form-control txtLabel text-right " />
                                                                                <input type="text" name="txt_projsuppliername" id="txtfg_goodid" class="form-control txtLabel text-right hidden " />
                                                                                <div id="btn_GetDetailfg" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #00c0ef; cursor: pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>--%>

                                                        <%--<div class="col-md-12 " style="font-weight: 100">
                                                           
                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <div class="col-md-6">

                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">รายการ V3 : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtfg_setqty" id="txtv3_goodname" class="form-control txtLabel" />
                                                                                <input type="text" name="txtfg_setqty" id="txtv3_goodid" class="form-control txtLabel hidden" />
                                                                                <div id="btn_v3id" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #00c0ef; cursor: pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                                                                </div>


                                                                                
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <div class="form-group">
                                                                            <label for="matr_group" class="control-label txtLabel">รายการ V7 : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                               
                                                                                <div class="txtLabel">
                                                                                    <select id="v7Select" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                                                        <option value="28102">InClude V7 - รางน้ำ</option>
                                                                                        <option value="">ExClude V7</option>
                                                                                    </select>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <div class="form-group">
                                                                            <label for="exampleInputEmail1" class="txtLabel">หมายเหตุ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txt_projsuppliername" id="txtfg_remark" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0px" />

                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>--%>

                                                        <%--<div class="col-md-12 " style="font-weight: 100">
                                                           
                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <div class="col-md-6">

                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">ลูกค้าโครงการ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtfg_setqty" id="txtCustomer_name" class="form-control txtLabel" />
                                                                                <input type="text" name="txtfg_setqty" id="txtCustomer_id" class="form-control txtLabel hidden" />
                                                                                <div id="btn_GetCustomer" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #00c0ef; cursor: pointer;">
                                                                                    <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                                                                </div>


                                                                             
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">

                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">ชื่อโครงการ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-cube" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtfg_setqty" id="txtproj_name" class="form-control txtLabel" />



                                                                               
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <div class="col-md-12">
                                                                        <div class="form-group">
                                                                            <label for="" class="txtLabel">ที่อยู่ : </label>
                                                                            <div class="input-group">
                                                                                <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                                                    <i class="fa fa-building" aria-hidden="true"></i>
                                                                                </div>
                                                                                <input type="text" name="txtfg_setqty" id="txtCust_addr" class="form-control txtLabel" style="border-radius: 0px 3px 3px 0px" />



                                                                                
                                                                            </div>
                                                                        </div>
                                                                    </div>




                                                                </div>
                                                            </div>

                                                        </div>--%>
                                                        <%--<hr />
                                                        <br />



                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-6">
                                                                     
                                                                        <button type="button" class="btnx btn-md danger pull-left txtLabel" onclick="ClearInput()" >Clear</button>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>


                                                    </div>



                                                </div>
                                            </div>
                                        </div>
                                        <br />--%>
                                    </div>
                                </div>
                            <%-- first start here--%>
                        </div>
                    </div>
                </div>
            </div>
            </div>

            <%--</div>--%>

            <%--row_box_table_coil--%>
            

                <div class="row">
                    <div class="box box-primary" id="box_tbl_WdProduct" style="border-radius: 5px;display:none">
                        <div class="box-header">
                            <div class="box-body txtLabel">
                                <table class="table table-bordered table-striped txtLabel text-center table-hover" id="tbl_WdProduct" style="cursor: pointer; border-radius: 3px; width: 100%">
                                    <thead>
                                        <tr>
                                            <th>วันที่</th>
                                            <th>ชื่อลุกค้า</th>
                                            <th>ชื่อโครงการ</th>
                                            <th>ชื่อสินค้า</th>
                                            <th>จำนวนชุด</th>
                                            <th>ราคาต่อหน่วย</th>
                                            <th>ราคาต่อหน่วย</th>

                                            <th style="width: 20px">#</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


            <div class="modal fade " id="modal_Getproject_Datatowd" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
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
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_Getproject_Datatowd" style="border-radius: 3px; width: 100%">
                                        <thead>
                                            <tr>

                                                <th class="text-right" style="width: 70px; text-align: center">วันที่</th>
                                                <th class="text-center">รูปแบบโครงการ</th>
                                                <th class="text-center" style="width: 13px">รายการวัตถุดิบ</th>
                                                <th class="text-right" style="width: 70px; text-align: center">จำนวนชุด</th>
                                                <th class="text-center">จำนวนแผ่นชีส</th>
                                                <th class="text-center" style="width: 13px">#</th>
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

            <div class="modal fade" id="modal_GetProduct_Display" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog modal-lg" >
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel16"><strong><i class="icofont-brand-bing"></i> รายการสินค้าสำเร็จรูป</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_GetProduct_Display" style="border-radius: 3px; width: 100%">
                                        <thead class="txtLabel">
                                            <tr>

                                                <th class="text-center" style="padding-left:10px">รหัสสินค้า</th>
                                                <th class="text-center" style="padding-left:10px">ชื่อสินค้า</th>
                                                <th class="text-center" style="width: 13px">#</th>
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


            <div class="modal fade " id="modal_v3selected" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;">
                <div class="modal-dialog">
                    <div class="modal-content" style="border-radius: 5px 5px 5px 5px;">
                        <div class="modal-header" style="border-radius: 5px 5px 0px 0px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> Part : V3</strong> </h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_v3selected" style="border-radius: 3px; width: 100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center">รหัสวัตถุดิบ</th>
                                                <th class="text-center">ชื่อวัตถุดิบ</th>
                                                <th class="text-center">คงเหลือ</th>
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

            <div class="modal fade" id="modal_fgGet_material" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog" style="border-bottom-left-radius: 5px;width:60%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="fa fa-flask" aria-hidden="true"></i> เลือกรายการวัตถุดิบ
                                                             </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <input type="text" class="hidden" name="rowsindex" id="rowsindex" value="" />
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_fgGet_Matrial" style="border-radius: 3px; width: 100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center">รหัสสินค้า</th>
                                                <th class="text-center">ชื่อวัตถุดิบ</th>
                                                <th class="text-center">ยอดคงเหลือ</th>
                                                <th class="text-center" style="width: 13px">#</th>

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


            <div class="modal fade " id="modal_Customer" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog modal-lg" style="border-bottom-left-radius: 5px;">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-users-social icofont-1x" ></i> รายการลูกค้าโครงการ</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                 
                                        <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_Customer" style="border-radius: 3px; width: 100%">
                                            <thead class="txtLabel">
                                                <tr>
                                                    <th class="text-center" style="width: 13px">#</th>
                                                    <th class="text-center">วันที่</th>
                                                    <th class="text-center">ชื่อลูกค้า</th>
                                                    <th class="text-center">ชื่อโครงการ</th>
                                                    <th class="text-center">จำนวน Order</th>
                                                    <th class="text-center">Order คงเหลือ</th>
                                                    
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


            <div class="modal fade " id="modal_GetProjectEdit" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog" style="border-radius:0px 0px 5px 5px">
                    <div class="modal-content" style="border-radius:5px">
                        <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-crop"></i> รายการรับสินค้าสำเร็จรูป (ตัดเบิกวัตถุดิบ)</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12">
                                <div class="card">
                                    <div style="padding: 5px 10px 10px 10px">
                                        <h2 id="CustName" class="txtHeader"></h2>
                                        <h4 class="txtLabel16" id="Address" ></h4>
                                        <h4 class="txtLabel16" id="ProjectName"></h4>
                                        <h4 class="txtLabel16" id="ProductName"></h4>
                                        <h4 class="txtLabel16" id="Quantity"></h4>
                                        <h4 class="txtLabel16" id="Priceperunit"></h4>
                                        <h4 class="txtLabel16" id="Amount"></h4>
                                        
                                    </div>
                                   
                                </div>
                            </div>
                            </div>
                           

                            <hr />

                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_GetProjectEdit" style="border-radius: 3px; width: 100%">
                                        <thead class="txtLabel">
                                            <tr>

                                                <th class="text-center">รายการ</th>
                                                <th class="text-center" style="padding-left:10px">จำนวน</th>
                                                <th class="text-center" style="padding-left:10px">ราคาต่อหน่วย</th>
                                                <th class="text-center" style="padding-left:10px">ยอดรวม</th>
                                                <th class="text-center" style="width: 13px;padding-left:10px">#</th>
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

            <div class="modal fade " id="modal_itemofprojectedit" ><%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-md" style="border-radius:5px;width:60%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-radius:5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-edit"></i> แก้ไขรายการวัตถุดิบ</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <h2 class="txtSecondHeader" style="font-weight:600">รายการแก้ไข</h2>
                              <input type="text" class="input-sm hidden" id="txt_transac_id" name="name" value="" />
                                <input type="text" class="input-sm hidden" id="txt_sysdocref" name="name" value="" />
                                <input type="text" class="input-sm hidden" id="txt_goodid" name="name" value="" />
                            <div class="row">
                                <div class="col-md-4 form-group">
                                <label for="" class="txtLabel">รหัสวัตถุดิบ : </label>
                                <div class="input-group">
                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                    </div>
                                    <input type="text" name="txtfg_setqty" id="txtmatr_goodcode" class="form-control txtLabel"  style="border-radius:0px 3px 3px 0px"/>

                                </div>
                            </div>
                            <hr />
                            <div class="col-md-8 form-group">
                                <label for="" class="txtLabel">รายการวัตถุดิบ : </label>
                                <div class="input-group">
                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                    </div>
                                    <input type="text" name="txtfg_setqty" id="txtmatr_goodname" class="form-control txtLabel" style="border-radius:0px 3px 3px 0px"/>
                                </div>
                            </div>
                            </div>
                            <h2 class="txtSecondHeader" style="font-weight:600">ยอดก่อนแก้ไข</h2>
                            <div class="row">
                              
                                <div class="col-md-4 form-group">
                                    <label for="" class="txtLabel">จำนวน : </label>
                                    <div class="input-group">
                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                            <i class="fa fa-cube" aria-hidden="true"></i>
                                        </div>
                                        <input type="text" name="txtfg_setqty" id="txtmatr_qty" class="form-control txtLabel text-right" />
                                        <div class="input-group-addon txtLabel">
                                            ชิ้น
                                        </div>
                                        <div id="btn_reItemCalc" class="input-group-addon" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #00c0ef; cursor: pointer;">
                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure">Go..</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 form-group">
                                    <label for="" class="txtLabel">ราคาต่อหน่วย : </label>
                                    <div class="input-group">
                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                            <i class="fa fa-cube" aria-hidden="true"></i>
                                        </div>
                                        <input type="text" name="txtfg_setqty" id="txtmatr_priceperunit_now" class="form-control txtLabel text-right" disabled />
                                        <div class="input-group-addon txtLabel" style="border-radius: 0px 3px 3px 0px">
                                            บาท
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 form-group">
                                    <label for="" class="txtLabel">ยอดรวม : </label>
                                    <div class="input-group">
                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                            <i class="fa fa-cube" aria-hidden="true"></i>
                                        </div>
                                        <input type="text" name="txtfg_setqty" id="txtmatr_amnt_now" class="form-control txtLabel text-right" disabled />
                                        <div class="input-group-addon txtLabel" style="border-radius: 0px 3px 3px 0px">
                                            บาท
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                            <button type="button" class="btn btn-primary txtLabel" id="btnItemofproject" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button>
                        </div>
                    </div>

                </div>

            </div>

            <div class="modal fade " id="modal_ProductPayoutwsp" ><%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-md" style="border-bottom-left-radius: 5px;width:60%">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการ Sheet </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            
                            <div class="row">
                                <div class="col-md-12 txtLabel" style="width:100%">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_GetProductPayoutwsp" style="border-radius: 3px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>

                                                <th class="text-center">วันที่</th>
                                                <th class="text-center">เลขที่ Inv.</th>
                                                <th class="text-center">ลูกค้า</th>
                                                <th class="text-center">จำนวน</th>
                                                <th class="text-center">ราคา/หน่วย</th>
                                                <th class="text-center">ยอดรวม</th>
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
                            <%--<button type="button" class="btn btn-primary txtLabel" id="btn" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button>--%>
                        </div>
                    </div>

                </div>

            </div>

            <div class="modal fade " id="modal_AddSheet" ><%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-md" style="border-bottom-left-radius: 5px">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการเบิกชีส </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            
                            <div class="row">
                                <div class="col-md-12 txtLabel" style="width:100%">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_AddSheet" style="border-radius: 3px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>

                                                <th class="text-center">รหัสวัตถุดิบ</th>
                                                <th class="text-center">รายการวัตถุดิบ</th>
                                                <th class="text-center">คงเหลือ</th>
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
                            <%--<button type="button" class="btn btn-primary txtLabel" id="btn" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button>--%>
                        </div>
                    </div>

                </div>

            </div>

            <div class="modal fade " id="modal_Inv" ><%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-lg" style="border-bottom-left-radius: 5px">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการขาย DownSlope </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            
                            <div class="row">
                                <div class="col-md-12 txtLabel" style="width:100%">
                                    <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_Inv" style="border-radius: 3px;width:100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center" style="width:20px">#</th>
                                                <th class="text-center">วันที่ Inv.</th>
                                                <th class="text-center">เลขที่ Inv.</th>
                                                <th class="text-center">จำนวน</th>
                                                <th class="text-center">ราคาต่อหน่วย</th>
                                                <th class="text-center">จำนวนรวม</th>
                                                
                                                
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
                            <%--<button type="button" class="btn btn-primary txtLabel" id="btn" style="background-color: #57cc99; border-color: #122b4000; border-radius: 3px"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save changes</button>--%>
                        </div>
                    </div>

                </div>

            </div>

            <div class="modal fade " id="modal_Products">
                <%--style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px"--%>
                <div class="modal-dialog modal-lg" style="border-bottom-left-radius: 5px">
                    <div class="modal-content" style="border-radius: 5px;">
                        <div class="modal-header" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i>รายการขาย DownSlope </strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 " style="font-weight: 100">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="" class="txtLabel">เลขที่อ้างอิง : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtProductfg_code" id="txtfg_sys_doc_ref" class="form-control txtLabel  text-left" style="border-radius: 0px 3px 3px 0px" disabled />


                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="txtLabel">เลขเอกสาร : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-file-text" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_doc_no" id="txtfg_doc_no" class="form-control txtLabel text-left" style="border-radius: 0px 3px 3px 0px" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">วันที่ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-calendar" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtdoc_date" id="txtdoc_date" class="form-control txtLabel" placeholder="yyyy-MM-dd" style="border-radius: 0px 3px 3px 0px" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-3">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">รูปแบบโครงการ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-tasks" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="txtLabel">
                                                        <select id="selectprojecttype" class="txtLabel " style="width: 100%; text-align: justify; height: 34px" name="state">
                                                            <option value="">- รูปแบบโครงการ -</option>
                                                            <option value="1">ทึบแสง</option>
                                                            <option value="2">โปร่งแสง</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">จำนวนชุด : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-calendar" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_setqty" id="txtfg_setqty" class="form-control txtLabel text-right " />
                                                    <div class="input-group-addon" style="border-radius: 0px 3px 3px 0px">
                                                        <label class="txtLabel">ชุด</label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="txtLabel">รายการสินค้า : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-product-hunt" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txt_projsuppliername" id="txtfg_goodname" class="form-control txtLabel text-left " disabled />
                                                    <input type="text" name="txt_projsuppliername" id="txtfg_goodid" class="form-control txtLabel text-right hidden " disabled />
                                                    <div id="btn_GetDetailfg" class="input-group-addon" data-toggle="tooltip" data-title="เลือกสินค้า Downslope" style="border-radius: 0px 3px 3px 0px; background-color: #3C8DBC; cursor: pointer;">
                                                        <label class="txtLabel" style="cursor: pointer; color: azure"><i class="fa fa-cubes" aria-hidden="true"></i></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">

                                        <div class="col-md-6">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">รายการ V3 : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_setqty" id="txtv3_goodname" class="form-control txtLabel" disabled />
                                                    <input type="text" name="txtfg_setqty" id="txtv3_goodid" class="form-control txtLabel hidden" disabled />
                                                    <div id="btn_v3id" class="input-group-addon" data-toggle="tooltip" data-title="เลือก Part V3" style="border-radius: 0px 3px 3px 0px; background-color: #3C8DBC; cursor: pointer;">
                                                        <label class="txtLabel" style="cursor: pointer; color: azure"><i class="fa fa-cube" aria-hidden="true"></i></label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="matr_group" class="control-label txtLabel">รายการ V7 : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>

                                                    <div class="txtLabel">
                                                        <select id="v7Select" class="txtLabel" style="width: 100%; text-align: justify; height: 34px" name="state">
                                                            <option value="28102">InClude V7 - รางน้ำ</option>
                                                            <option value="">ExClude V7</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1" class="txtLabel">หมายเหตุ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txt_projsuppliername" id="txtfg_remark" class="form-control txtLabel text-right" style="border-radius: 0px 3px 3px 0px" />

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">

                                        <div class="col-md-6">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">ลูกค้าโครงการ : </label>
                                                

                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtcustprojid" id="txtcustprojid" class="form-control txtLabel hidden" disabled />
                                                    <input type="text" name="txtfg_setqty" id="txtCustomer_name" class="form-control txtLabel" disabled />
                                                    <input type="text" name="txtfg_setqty" id="txtCustomer_id" class="form-control txtLabel hidden" disabled />
                                                    <div id="btn_GetCustomer" class="input-group-addon" data-toggle="tooltip" data-title="เลือกรายการลูกค้า" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #3C8DBC; cursor: pointer;">
                                                        <label class="txtLabel" style="cursor: pointer; color: azure"><i class="fa fa-users" aria-hidden="true"></i></label>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">ชื่อโครงการ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_setqty" id="txtproj_name" class="form-control txtLabel" disabled />

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label for="" class="txtLabel">ที่อยู่ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-building" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_setqty" id="txtCust_addr" class="form-control txtLabel" style="border-radius: 0px 3px 3px 0px" disabled />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="" class="txtLabel">รับสินค้าตาม Inv. เลขที่ : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtinv" id="txtinv" class="form-control txtLabel" style="border-radius: 0px 3px 3px 0px" disabled />
                                                    <input type="text" name="txtdocid" id="txtdocid" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled />
                                                    <input type="text" name="txtgoodid" id="txtgoodid" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled />
                                                    <input type="text" name="txtpayqty" id="txtpayqty" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled />
                                                    <input type="text" name="txtpaycost" id="txtpaycost" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled />
                                                    <input type="text" name="txtpayamount" id="txtpayamount" class="form-control txtLabel hidden" style="border-radius: 0px 3px 3px 0px" disabled />

                                                    <div id="btn_GetInv" class="input-group-addon" data-toggle="tooltip" data-title="เลือก Inv.ขาย" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #3C8DBC; cursor: pointer;">
                                                        <label class="txtLabel" style="cursor: pointer; color: azure"><i class="fa fa-cloud" aria-hidden="true"></i></label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <h4 class="txtSecondHeader row"><strong><i class="icofont-hand-right"></i>เพิ่มรายการจำนวน Sheet เสีย</strong></h4>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="" class="txtLabel">เลือกรายการชีส : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtSheet_name" id="txtSheet_name" class="form-control txtLabel" disabled />
                                                    <input type="text" name="txtSheet_id" id="txtSheet_id" class="form-control txtLabel hidden" />
                                                    <div id="btn_GetSheet" class="input-group-addon" data-toggle="tooltip" data-title="เลือก Sheet ตัดของเสีย" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px; background-color: #3C8DBC; cursor: pointer;">
                                                        <label class="txtLabel" style="cursor: pointer; color: azure"><i class="fa fa-reorder margin-r-5" aria-hidden="true"></i></label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">จำนวน : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtfg_setqty" id="txtAddSheetqty" class="form-control txtLabel" style="border-radius:0 3px 3px 0" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">ราคาต่อหน่วย : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtAddSheetperunit" id="txtAddSheetperunit" class="form-control txtLabel" disabled />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">

                                            <div class="form-group">
                                                <label for="" class="txtLabel">เป็นยอดรวม : </label>
                                                <div class="input-group">
                                                    <div class="input-group-addon" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">
                                                        <i class="fa fa-cube" aria-hidden="true"></i>
                                                    </div>
                                                    <input type="text" name="txtAddSheetAmnt" id="txtAddSheetAmnt" class="form-control txtLabel" disabled />


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-12">
                                                <h4 class="txtSecondHeader"><strong><i class="icofont-hand-right"></i>เลือกรายการวัตถุดิบ Bolt,Screw,แหวน</strong></h4>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div style="border-radius: 3px; padding-left: 30px; padding-right: 30px;">
                                                <table id="tbl_matrtransac_partoption" class=" table order-list txtLabel table-bordered table-sm table-responsive " style="border-radius: 3px;">
                                                    <thead>
                                                        <tr>
                                                            <td class="text-center" style="font-weight: 700">รหัสวัตถุดิบ</td>
                                                            <td class="text-center" style="font-weight: 700">ชื่อวัตถุดิบ</td>
                                                            <td class="text-center" style="font-weight: 700">ยอดคงเหลือ</td>
                                                            <td class="text-center" style="font-weight: 700">จำนวน</td>
                                                            <td class="text-center" style="font-weight: 700; width: 20px">#</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="4" style="text-align: left;">
                                                                <div class="pull-left">
                                                                    <input type="button" class="btn btn-sm btn-primary" data-toggle="tooltip" data-title="เพิ่มรายการวัสดุ" id="addrow" value="+ NEW" />

                                                                </div>
                                                                <div class="pull-right">
                                                                </div>
                                                            </td>
                                                        </tr>

                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                               <%--<button type="button" class="btnx  success pull-right txtLabel" id="btn_SaveProductPayout" onclick="fnSaveProductPayout()">Save Data</button>--%>
                                <button type="button" class="btn btn-success btn-sm pull-right txtLabel" id="btn_wdoforfg" data-toggle="tooltip" data-title="บันทึกข้อมูล!"><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</button>
                                <%--<button type="button" class="btn btn-warning btn-sm pull-right txtLabel" data-toggle="tooltip" data-title="บันทึกข้อมูล!" onclick="CheckValidateSave()">Save Data</button>--%>
                                   <button type="button" class="btnx  success pull-right txtLabel hidden" id="btn_SaveProductPayout" onclick="fnSaveProductPayout()">Save Data</button>
                        </div>
                    </div>

                </div>

            </div>


        </section>
    </section>
    <script>
        
        function fnGet_Insertitempart_wdforfg() {
            //alert('fnGet_Insertitempart_wdforfg()');
            //alert(usr_name);
            $.ajax({
                url: '../../xTransaction/srv_transaction_product.asmx/fnGet_Insertitempart_wdforfg',
                method: 'post',
                data: {
                    create_by: usr_name
                    , create_date: currentdate2
                    , doc_date: $('#txtdoc_date').val()
                    , sys_doc_ref: $('#txtfg_sys_doc_ref').val()
                    , v7id: $('#v7Select').val()
                    , v3id: $('#txtv3_goodid').val()
                    , orderset: $('#txtfg_setqty').val()
                    , projecttype: $('#selectprojecttype').val()
                    , fg_goodid: $('#txtfg_goodid').val()
                    , txtprojid: $('#txtcustprojid').val()
                    , txtproj_name: $('#txtproj_name').val()
                    , txtfg_remark: $('#txtfg_remark').val()
                    , custid: $('#txtCustomer_id').val()
                    , sheetid: $('#txtSheet_id').val()
                    , sheetqty: $('#txtAddSheetqty').val()
                    , invno: $('#txtinv').val()
                },
                dataType: 'json',
                success: function (data) {

                    if (data != '') {
                        //alert(data);

                        Swal.fire({
                            icon: 'success',
                            title: 'บันทึกข้อมูลเรียบร้อย',
                            html: 'Done...',
                        })

                        fgGet_material();
                        fnGetProductDisplay();

                        ClearInput();
                        var tbl_iteminproduct = $('#tbl_iteminproduct').DataTable();
                        tbl_iteminproduct.clear();
                        tbl_iteminproduct.draw();

                        ProgressOff();

                        $('#modal_Products').modal('hide'); 

                    } else {

                    }
                    // $('#modal_GetProduct_Display').modal('hide');
                }
            })
        }
        function fnGet_InsertProductfg_rv() {

        }

        function CheckValidateSave() {
            
            var txtfg_sys_doc_ref = $('#txtfg_sys_doc_ref');
            var txtMsg = '';

            if ($('#txtfg_sys_doc_ref').val() == '') {
                txtMsg = txtMsg + 'เลขที่อ้างอิง';
            } if ($('#txtfg_doc_no').val()== '') {
                txtMsg = txtMsg + ',เลขที่เอกสาร';
            } if ($('#txtdoc_date').val() == '') {
                txtMsg = txtMsg + ',วันที่เอกสาร';
            } if ($('#selectprojecttype').val() == '') {
                txtMsg = txtMsg + ',รูปแบบโครงการ';
            } if ($('#txtfg_setqty').val() == '') {
                txtMsg = txtMsg + ',จำนวนชุด';
            } if ($('#txtfg_goodname').val() == '') {
                txtMsg = txtMsg + ',รายการสินค้า';
            } 
            
            var txtHtml = '<div class="txtLabel"><strong>กรุณาใส่ข้อมูล : </strong><strong style="color:red">' + txtMsg + '</strong></div>'

            Swal.fire({
                icon: 'error',
                title: '<div class="txtLabel"><strong>[: เกิดข้อผิดพลาด ]</strong></div>',
                html: txtHtml

            })
            
        }


        function Check_fnGet_Insertitempartoption() {

            //ProgressOn();

            var rowCount = $('#tbl_matrtransac_partoption tbody tr').length;
            var i = 0

            if (rowCount == i) {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[: เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ทำรายการเลือกวัตถุดิบ</strong></div>'

                })
            } else {
                while (i < rowCount) {
                    var goodqty = parseFloat($('#goodqty' + i).val());
                    var goodStockqtyt = parseFloat($('#goodStockqtyx' + i).val());
                    if (goodqty > goodStockqtyt) {
                        console.log(2);
                        Swal.fire({
                            icon: 'error',
                            title: '<div class="txtLabel"><strong>[: เกิดข้อผิดพลาด]</strong></div>',
                            html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบจำนวนการเบิกวัตถุดิบ</strong></div>'

                        })

                        //alert('กรุณาตรวจสอบยอดวัตถุดิบ');

                        break;
                    } else {
                        console.log(3);
                        if (i == rowCount - 1) {
                            console.log(4);
                            fnGet_Insertitempartoption();
                            //fnGet_Itemofprojectedit();
                            fnGet_Insertitempart_wdforfg();
                        }


                    }
                    i++;
                }
            }   
        }



        function fnGet_Insertitempartoption() {
            var rowCount = $('#tbl_matrtransac_partoption tbody tr').length;
            var i = 0
            while (i < rowCount) {
                console.log('i : ' + i + '\n' + 'rowCount : ' + rowCount);
                //alert('ref_no : ' + $('#txtfg_sys_doc_ref').val() + '\n' +
                //    'goodid: ' + $('#goodid' + i).val() + '\n' +
                //    'goodqty: ' + $('#goodqty' + i).val() + '\n' +
                //    'i : ' + i)
               $.ajax({
                    url: '../../xTransaction/srv_transaction_product.asmx/fnGet_Insertitempartoption',
                    method: 'post',
                    data: {
                        action: 'fnGet_Insertitempartoption'
                        , create_by: usr_name
                        , create_date: currentdate2
                        , ref_no: $('#txtfg_sys_doc_ref').val()
                        , goodid: $('#goodid' + i).val()
                        , goodqty: $('#goodqty' + i).val()
                    }, 
                    dataType: 'json',
                    success: function (data) {
                        if (data == 'Success') {
                            $.each(data, function (i, item) {

                                console.log('Success');
                                console.log('data[i] : ' + data[i]);

                                $('#tbl_matrtransac_partoption tbody tr').remove();

                            })

                        }
                    }
                })

                i++;
            }
            counter = 0;
        }

        function fnGet_Itemofprojectedit() {
            //alert(1);
            alert(
            'action: GetUpdateitemofproject' + '\n' + 
                'sys_doc_ref: ' + $('#txt_sysdocref').val() + '\n' + 
                'goodid: ' + $('#txt_goodid').val() + '\n' + 
                'id: ' + $('#txt_transac_id').val() + '\n' + 
                'quantity: ' + $('#txtmatr_qty').val() + '\n' + 
               'amount: ' + $('#txtmatr_amnt_now').val()
            )
            $.ajax({
                url: '../../xTransaction/srv_transaction_product.asmx/GetUpdateitemofproject',
                method: 'post',
                data: {
                    action: 'GetUpdateitemofproject'
                    , sys_doc_ref: $('#txt_sysdocref').val()
                    , goodid: $('#txt_goodid').val()
                    , id: $('#txt_transac_id').val()
                    , quantity: $('#txtmatr_qty').val()
                    , amount: $('#txtmatr_amnt_now').val()
                },
                dataType: 'json',
                success: function (data) {
                    if (data == 'Success') {
                        $.each(data, function (i, item) {



                            fnGetProductDisplay();
                            fnGetProductDisplayAction($('#txt_sysdocref').val());

                            $('#modal_itemofprojectedit').modal('hide');
                            $('#tbl_matrtransac_partoption tbody tr').remove();

                            Swal.fire({
                                icon: 'success',
                                title: '<div class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ] </strong></div>'

                            })
                        })
                    }
                }
            })
        }
        function fnSaveProductPayout() {
           
            //alert($('#txtproj_name').val());
            if ($('#txtproj_name').val() == '')
            //if ($('#txtwdfg_projname').val() == '')
            {
                //alert(1);
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบข้อมูลชื่อโครงการ</strong></div>'
                })
            } //else if ($('#txtwdfg_projname').val() != '')
              else  if ($('#txtproj_name').val() != '')
            {
               
                check_fnInsertProductPayOut();
            }
        }

        function check_fnInsertProductPayOut() {
            $.ajax({
                url: '../../xTransaction/srv_transaction_product.asmx/check_fnInsertProductPayOut',
                method: 'post',
                data: {
                    action: 'check_fnInsertProductPayOut'
                    , goodid: $('#txtwdfg_goodid').val()
                    //, qty: $('#txtwdfg_qty').val()
                },
                dataType: 'json',
                success: function (data) {
                    
                    if (data != '') {
                        //alert(1);
                        $.each(data, function (i, item) {
                            var productpayqty = parseFloat($('#txtwdfg_qty').val());
                            var productStock = parseFloat(data[i].PayQty);
                            if (productpayqty > productStock) {
                                Swal.fire({
                                    icon: 'error',
                                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                                    html: '<div class="txtLabel"><strong>กรุณาตรวจสอบ : </strong><strong style="color:red">สินค้า ' + $('#txtwdfg_goodname').val() + ' เหลือไม่พอสำหรับการเบิกจ่ายสินค้า</strong></div>'
                                })
                            } else if (productpayqty <= productStock) {
                                //alert('productpayqty : ' + productpayqty);
                                //alert('productStock : ' + productStock);
                                fnInsertProductPayOut();
                            }
                        })
                    }
                }
            })
        }


        function fnInsertProductPayOut() {
            //alert(1);
            //alert('doc_date: ' + $('#txtwdfgdoc_date').val() + '\n' +
            //    'sys_doc_ref: ' + $('#txtwdfg_sys_doc_ref').val() + '\n' +
            //    'custid : ' + $('#txtwdfg_custid').val() + '\n' +
            //    'projname: ' + $('#txtwdfg_projname').val() + '\n' +
            //    'doc_no: ' + $('#txtwdfg_doc_no').val() + '\n' +
            //    'goodid: ' + $('#txtwdfg_goodid').val() + '\n' +
            //    'qty: ' + $('#txtwdfg_qty').val() + '\n' +
            //    'priceperunit: ' + $('#txtwdfg_priceperunit').val() + '\n' +
            //    'amnt: ' + $('#txtwdfg_amnt').val() + '\n' +
            //    'remark: ' + $('#txtwdfg_amnt').val())
            Swal.fire({
                icon: 'question',
                title: '<div class="txtLabel"><strong>[ ต้องการบันทึกข้อมูลใช่หรือไม่ ? ]</strong></div>',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: '<div class="txtLabel">ใช่</div>',
                denyButtonText: 'ไม่ใช่',
            }).then((result) => {
                
                if (result.isConfirmed) {
                    $.ajax({
                        url: '../../xTransaction/srv_transaction_product.asmx/fnInsertProductPayOut',
                        method: 'post',
                        data: {
                            action: 'fnInsertProductPayOut'
                            , create_by: usr_name
                            , create_date: currentdate2
                            , doc_date: $('#txtwdfgdoc_date').val()
                            , sys_doc_ref: $('#txtwdfg_sys_doc_ref').val()
                            , custid: $('#txtwdfg_custid').val()
                            , projname: $('#txtwdfg_projname').val()
                            , doc_no: $('#txtwdfg_doc_no').val()
                            , goodid: $('#txtwdfg_goodid').val()
                            , qty: $('#txtwdfg_qty').val()
                            , priceperunit: $('#txtwdfg_priceperunit').val()
                            , amnt: $('#txtwdfg_amnt').val()
                            , remark: $('#txtwdfg_remark').val()
                            , invno: $('#txtinv').val()
                        },
                        dataType: 'json',
                        success: function (data) {
                            if (data == 'Success') {
                                $.each(data, function (i, item) {
                                    ClearInput();
                                    Swal.fire({
                                        icon: 'success',
                                        title: '<div class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></div>'
                                    })
                                    

                                })
                            }
                        }
                    })
                } else if (result.isDenied) {
                    Swal.fire('Changes are not saved', '', 'info')
                }
            })



            
        }
    </script>
</asp:Content>