<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="transaction_project.aspx.cs" Inherits="AmpelflowApp.xTransaction.transaction_project" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header" >
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
            .nav-tabs-custom > .nav-tabs > li.active {
                border-top-color: #3c8dbc;
            }

            .bxbpdercolor {
                border-top-color: #3c8dbc;
            }

            /*.select2-container--default .select2-selection--single {*/
                /*padding-top:3px;
                padding-bottom :3px;*/
                /* height : auto;
                margin-top:0px    ;*/
                /*border-radius: 3px 3px 3px 3px;
            }*/

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

            .disable-div {
                pointer-events: none;
            }

            .card {
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 3px rgba(0,0,0,0.24);
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
                border: 3px solid black;
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
            
            
        </style>

        <script>
         
        </script>


        <script>
           
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
            var counter = 0;
            var goodStockqtyVar;


            $(document).ready(function () {

                $(document).on('show.bs.modal', '.modal', function (event) {
                    var zIndex = 1040 + (10 * $('.modal:visible').length);
                    $(this).css('z-index', zIndex);
                    setTimeout(function () {
                        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                    }, 0);
                });
               
                fn_GetCustomerAll();
                ProgressOn();

                setTimeout(function () {
                    
                    var btn_CustomerProjID = $('#btn_CustomerProjID');
                    btn_CustomerProjID.click(function () {
                        clearinput();

                        $('#btnGetCustomer_Proj').removeClass('disable-div');
                        $('#modal_InputCustomerProject').modal('show');
                        $('#btnGetCustomer_Proj').css({ 'background-color': '#3c8dbc' });
                        $('#btnCalcLength').css({ 'background-color': '#3c8dbc' });

                    })

                    var btnGetCustomer_Proj = $('#btnGetCustomer_Proj');
                    btnGetCustomer_Proj.click(function () {
                        clearinput();
                        $('#txtCustomerProjDate').val(currentdate2);
                        $('#modal_Customer').modal('show');    
                    })

                    var btnSaveCustomerProj = $('#btnSaveCustomerProj');
                    btnSaveCustomerProj.click(function () {
                       
                        fn_SaveCustomerProj_validate();
                    })
                    
                    
                    ProgressOff();

                    var btnCalcLength = $('#btnCalcLength');
                    btnCalcLength.click(function () {
                        fn_CalcLength();
                    })


                    //var txtCustomerQty = $('#txtCustomerQty')
                    var txtCustomerQty = document.getElementById("txtCustomerQty");
                    txtCustomerQty.addEventListener("keyup", function (event) {
                        if (event.keyCode === 13) {
                            event.preventDefault();
                            setTimeout
                            ProgressOn();
                            document.getElementById("btnCalcLength").click();

                            setTimeout(ProgressOff() , 1000)
                         
                        }

                    });

                    


                    fn_GetCustomerProjAll();

                }, 2000);
                
                //modal ซ้อน Modal
                
                $(document).on('show.bs.modal', '.modal', function (event) {
                        var zIndex = 1040 + (10 * $('.modal:visible').length);
                        $(this).css('z-index', zIndex);
                        setTimeout(function () {
                            $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                        }, 0);
                    });
                //$('[data-toggle="tooltip"]').tooltip();
                //var table = $('#tbl_CustomerProject').DataTable({
                //    pageLength: 2,
                //    columnDefs: [
                //        {
                //            targets: 1,
                //            data: null,
                //            className: "center",
                //            defaultContent: '<div align="center"><button type="button" class="btn btn-warning editrow" data-toggle="tooltip" title="Edit User"><span class="fas fa-pen fa-lg" style="color:black"></span></button><span> </span><button type="button" class="btn btn-danger deleterow" data-toggle="tooltip" title="Delete User"><span class="fas fa-trash-alt fa-lg" style="color:black"></span></button></div>',
                //            width: "110px"
                //        }
                //    ],
                //    drawCallback: function (settings) {
                //        console.log('drawCallback');
                //        $('[data-toggle="tooltip"]').tooltip();
                //    }
                //});

                


            });


            function clearinput()
            {
                    $('#txtCustomerId').val('')
                    $('#txtCustomerName').val('')
                    $('#txtCustomerAddress').val('')
                    $('#txtCustomerProjName').val('')
                    $('#txtCustomerQty').val('')
                    $('#txtCustomerLength').val('')
                $('#txtCustomerRemark').val('')
                $('#txtCustomerProjDate').val('')
                $('#txtid').val('')
            }
            function fn_GetCustomerAll() {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_project.asmx/fn_GetCustomerAll',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerAll'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_Customer').DataTable().clear();
                            $('#tbl_Customer').DataTable().destroy();


                            var tbl_Customer = $('#tbl_Customer').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                },'ordering':false
                            });
                            $('#tbl_Customer_length').select2();
                           
                            tbl_Customer.clear();

                            $.each(data, function (i, item) {
                                tbl_Customer.row.add([

                                     '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetCustomerAllById(\'' + data[i].CustId + '\')" class="btn-group" data-toggle="tooltip" data-placement="right" data-title="CustID:' + data[i].CustId + '"  style="font-size: 13px;color:#57cc99"><i class="fa fa-check-circle-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:20px">' + data[i].CustCode + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:20px">' + data[i].CustTitle + ' ' + data[i].CustName + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:20px">' + data[i].Amphur + ' / ' + data[i].Province + '</div>'
                                    
                                ]);
                                tbl_Customer.draw();
                            });
                            //$('#modal_Customer').modal('show');

                        } else {
                            $('#tbl_Customer').DataTable().clear();
                            $('#tbl_Customer').DataTable().destroy();

                            var tbl_Customer = $('#tbl_Customer').DataTable();
                            tbl_Customer.clear();
                        }
                    }
                })

            }
            function fn_GetCustomerAllById(custid) {

                $.ajax({
                    url: '../../xTransaction/srv_transaction_project.asmx/fn_GetCustomerAllById',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerDisplayById'
                        ,custid : custid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $.each(data, function (i, item) {

                                $('#txtCustomerName').val(data[i].CustTitle + ' '  + data[i].CustName)
                                $('#txtCustomerId').val(data[i].CustId)
                                $('#txtCustomerAddress').val(data[i].CustAddr1 + ' ' + data[i].District + ' ' + data[i].Amphur + ' ' + data[i].Province + ' ' + data[i].PostCode)
                               
                            });
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
            function fn_CalcLength() {
                var qty = $('#txtCustomerQty').val();
                var Checkqty = parseInt(qty);
                if (isNaN(Checkqty))
                {
                    Swal.fire({
                        icon: 'error',
                        title: '<div class="txtLabel16" style="color:#f27474"><strong>เกิดข้อผิดพลาด</strong></div>',
                        html: '<div class="txtLabel" style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true" style="color:#D3595B"></i></strong> ตรวจสอบจำนวนสั่งซื้อ</div>',
                        confirmButtonText: '<div class="txtLabel">OK</div>',
                        confirmButtonColor: '#f27474'

                    })

                    $('#txtCustomerLength').val(''); 
                    $('#txtCustomerQty').val('');

                } else {
                    $('#txtCustomerLength').val(parseFloat(Checkqty * 2.5).toFixed(2));   
                    $('#btnSaveCustomerProj').focus();
                }
                
            }

            function fn_GetCustomerProjAll() {
                $.ajax({
                    url: '../../xTransaction/srv_transaction_project.asmx/fn_GetCustomerProjAll',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerProjAll'
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#tbl_CustomerProject').DataTable().clear();
                            $('#tbl_CustomerProject').DataTable().destroy();



                            var tbl_CustomerProject = $('#tbl_CustomerProject').DataTable({
                                drawCallback: function (settings) {
                                    $('[data-toggle="tooltip"]').tooltip();
                                }, 'ordering': false });
                            $('[name=tbl_CustomerProject_length]').select2();

                            tbl_CustomerProject.clear();

                            $.each(data, function (i, item) {
                                tbl_CustomerProject.row.add([

                                    '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_RemoveCustomerProjbyId(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-tippy-content="1" data-title="ลบ:' + data[i].id + '"  style="font-size: 15px;color:#f27474"><i class="fa fa-trash-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="fn_GetCustomerProjById(\'' + data[i].id + '\')" class="btn-group" data-toggle="tooltip" data-title="แก้ไข:' + data[i].id + '"  style="font-size: 14px;color:#74f289"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customerprojdate + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customername + '</div>'
                                    , '<div class="text-left txtLabel" style="padding-left:5px">' + data[i].customerprojname + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].customerorderqty).format('0,0.00') + '</div>'
                                    , '<div class="text-right txtLabel" style="padding-right:5px">' + numeral(data[i].customerorderlegth).format('0,0.00') + '</div>'

                                ]);

                                tbl_CustomerProject.draw();
                            });
                            //$('#modal_Customer').modal('show');

                        } else {
                            $('#tbl_CustomerProject').DataTable().clear();
                            $('#tbl_CustomerProject').DataTable().destroy();

                            var tbl_CustomerProject = $('#tbl_CustomerProject').DataTable();
                            tbl_CustomerProject.clear();
                        }
                    }
                })
            }

            function fn_GetCustomerProjById(id) {
                clearinput();

                $.ajax({
                    url: '../../xTransaction/srv_transaction_project.asmx/fn_GetCustomerProjById',
                    method: 'post',
                    data: {
                        action: 'fn_GetCustomerProjById'
                        ,id : id
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {

                            $('#btnGetCustomer_Proj').addClass('disable-div');
                            $('#btnGetCustomer_Proj').css({ 'background':'#D6D6D6'})
                            $('#btnCalcLength').css({ 'background-color':'#3c87bc'})


                            $.each(data, function (i, item) {
                                $('#txtid').val(data[i].id)
                                $('#txtCustomerId').val(data[i].customerid)
                                $('#txtCustomerName').val(data[i].customername)
                                $('#txtCustomerAddress').val(data[i].customeraddress)
                                $('#txtCustomerProjName').val(data[i].customerprojname)
                                $('#txtCustomerQty').val(numeral(data[i].customerorderqty).format('0,0.00'))
                                $('#txtCustomerLength').val(numeral(data[i].customerorderlegth).format('0,0.00'))
                                $('#txtCustomerRemark').val(data[i].remark)
                                $('#txtCustomerProjDate').val(data[i].customerprojdate)
                                
                            });
                            //$('#modal_Customer').modal('show');
                            
                            
                            $('#modal_InputCustomerProject').modal('show');
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

        </script>

        <section class="content" >
            <div class="row">
          
                

                <div class="box bxbpdercolor" id="boxInput" style="border-radius: 3px">
                    <div class="box-header">
                        <div class="box-body">
                            <div class="user-block">
                                <img src="../../Content/Icons/web512.png" alt="User Image">
                                <span class="username">
                                    <a href="#" class="txtSecondHeader"><strong>รายการลูกค้าโครงการ</strong></a>
                                </span>
                                <span class="description txtLabel">Monitoring progression of projects</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- Custom Tabs -->
                                <div class="col-md-12">
                                    <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs" id="matr_tab">
                                        <li class="active maincolor" id="tab_Coilx" style="border-top-right-radius: 3px; border-top-left-radius: 3px"><a href="#tab_Coil" class="txtLabel" data-toggle="tab"><strong><i class="icofont-people"></i> รายการลูกค้าโครงการ</strong></a></li>
                                        
                                        <a href="javascript:void(0)" class="pull-right" data-toggle="tooltip" data-title="New" id="btn_CustomerProjID"><strong><i class="fa fa-plus" style="font-size: 13px"></i> New</strong></a>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active " id="tab_project">
                                            <%--  --%>
                                            <div class="col-md-12 txtLabel " style="margin-bottom: 3px">
                                                

                                            </div>
                                            
                                        </div>

                                        <%--<h4 class="txtSecondHeader"><strong><i class="icofont-hand-right"></i> รายการลูกค้า - โครงการ</strong></h4>--%>
                                        <br />
                                        <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_CustomerProject" style="border-radius: 3px; width: 100%">
                                        <thead class="txtLabel">
                                            <tr>
                                                <th class="text-center" style="width:15px;padding-left:20px">#</th>
                                                <th class="text-center" style="width:15px;padding-left:20px">#</th>
                                                <th class="text-center">วันที่</th>
                                                <th class="text-center">ชื่อลูกค้า</th>
                                                <th class="text-center">ชื่อโครงการ</th>
                                                <th class="text-center">จำนวนชุด</th>
                                                <th class="text-center">จำนวนความยาว</th>
                                                
                                            </tr>

                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>

                                    </div>



                                </div>
                                </div>
                                
                            </div>
                            <%-- first start here--%>
                            
                        </div>
                       
                    </div>
                </div>
            </div>

            <%--</div>--%>

            <%--row_box_table_coil--%>
            

                <div class="row">
                    <div class="box bxbpdercolor" id="box_tbl_WdProduct" style="border-radius: 8px;display:none">
                        <div class="box-header">
                            <div class="box-body txtLabel">
                                
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
                <div class="modal-dialog" style="border-bottom-left-radius: 5px;">
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
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-users-social icofont-1x" ></i> รายการลูกค้า</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 txtLabel">
                                 
                                        <table class="table table-bordered table-striped table-condensed table-hover txtLabel" id="tbl_Customer" style="border-radius: 3px; width: 100%">
                                            <thead class="txtLabel">
                                                <tr>
                                                    <th class="text-center">#</th>
                                                    <th class="text-center">รหัสลูกค้า</th>
                                                    <th class="text-center">ชื่อลูกค้า</th>
                                                    <th class="text-center">ที่อยู่</th>
                                                    
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


            <div class="modal fade " id="modal_InputCustomerProject" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
                <div class="modal-dialog modal-lg" style="border-radius:0px 0px 5px 5px">
                    <div class="modal-content" style="border-radius:5px">
                        <div class="modal-header" style="border-radius:5px 5px 0px 0px;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-crop"></i> บันทึก : รายการลูกค้าโครงการ</strong></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <div class="row">
                                <div class="col-md-12 ">
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">ชื่อลูกค้า:</label>
                                                    <a href="javascript:void(0)" class="txtLabel pull-right" data-toggle="tooltip" data-title="อัพเดทข้อมูลลูกค้า" id="btnSyncCustomer"><i class="fa fa-refresh" aria-hidden="true"></i><strong> Sync</strong></a>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                            <i class="fa fa-user-o" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtid" id="txtid" class="form-control txtLabel text-right hidden" />
                                                        <input type="text" name="txtCustomerName" id="txtCustomerName" class="form-control txtLabel" disabled/>
                                                        <input type="text" name="txtCustomerId" id="txtCustomerId" class="form-control txtLabel text-right hidden" />
                                                        <div id="btnGetCustomer_Proj" class="input-group-addon elRadius2px" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6" data-toggle="tooltip" data-title="เลือกลูกค้า">
                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure;"><strong><i class="fa fa-cube" aria-hidden="true"></i></strong></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">วันที่ :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius:3px 0px 0px 3px">
                                                            <i class="fa fa-calendar" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerProjDate" id="txtCustomerProjDate" class="form-control txtLabel text-left" style="border-radius:0 3px 3px 0" disabled />
                                                        
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                        </div>
                                            <div class="col-md-12 ">
                                            
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">ที่อยู่ :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-building-o" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerAddress" id="txtCustomerAddress" class="form-control  txtLabel has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" disabled/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 ">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">โครงการ :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerProjName" id="txtCustomerProjName" class="form-control  txtLabel text-left" style="border-radius:0 3px 3px 0 " />
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">จำนวนชุด :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerQty" id="txtCustomerQty" class="form-control txtLabel  has-success text-right" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                        <div id="btnCalcLength" data-toggle="tooltip" data-title="คำนวนความยาว" class="input-group-addon elRadius2px" style="border-radius: 0px 3px 3px 0px; cursor: pointer; background-color: #D6D6D6">
                                                            <label class="txtLabel" style="margin-bottom: auto; font-weight: 500; cursor: pointer; color: azure;"><strong><i class="fa fa-calculator" aria-hidden="true"></i></strong></label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                    <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">ความยาว :</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-ravelry" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerLength" id="txtCustomerLength" class="form-control txtLabel  has-success text-right"  disabled/>
                                                        <div class="input-group-addon elRadius2px txtLabel" style="border-radius: 0px 3px 3px 0px; background-color: #D6D6D6">
                                                            เมตร
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                            </div>
                           <div class="row">
                                <div class="col-md-12 ">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                                    <label for="matr_group" class="control-label txtLabel">หมายเหตุ</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon" style="border-radius: 3px 0px 0px 3px">
                                                            <i class="fa fa-comments-o" aria-hidden="true"></i>
                                                        </div>
                                                        <input type="text" name="txtCustomerRemark" id="txtCustomerRemark" class="form-control txtLabel  has-success" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px" />
                                                        
                                                    </div>
                                                </div>   
                                    </div>
                                         
                                    
                                            
                                </div>
                            </div>

                           
                        </div>

                        <div class="modal-footer">
                            <div class="col-md-12">
                                 <button type="button" class="btn btn-default pull-left txtLabel" data-dismiss="modal" style="border-radius: 3px">Close</button>
                            <button type="button" class="btn btn-success btn-sm txtLabel" id="btnSaveCustomerProj"  style="border-radius: 3px"><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></button>
                           
                            </div>
                           
                        </div>
                    </div>

                </div>

            </div>

            <%--<div class="modal fade " id="modal_GetProjectEdit" style="box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; border-radius: 3px">
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

            </div>--%>

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
                              <input type="text" class=" hidden" id="txt_transac_id" name="name" value="" />
                                <input type="text" class=" hidden" id="txt_sysdocref" name="name" value="" />
                                <input type="text" class=" hidden" id="txt_goodid" name="name" value="" />
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
                            <h4 class="modal-title txtLabel"><strong><i class="icofont-brand-bing"></i> รายการเบิกชีส </strong></h4>
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
                <div class="modal-dialog modal-md" style="border-bottom-left-radius: 5px;width:60%">
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

                   



        </section>
    </section>
    <script>
        
        function fnGet_Insertitempart_wdforfg() {
            //alert('fnGet_Insertitempart_wdforfg()');
            //alert(
            //    'create_by: ' + usr_name + '\n' +
            //    'create_date:  ' + currentdate2 + '\n' +
            //    'doc_date:  ' + $('#txtdoc_date').val() + '\n' +
            //    'sys_doc_ref:  ' + $('#txtfg_sys_doc_ref').val() + '\n' +
            //    'v7id:  ' + $('#v7Select').val() + '\n' +
            //    'v3id:  ' + $('#txtv3_goodid').val() + '\n' +
            //    'orderset:  ' + $('#txtfg_setqty').val() + '\n' +
            //    'projecttype:  ' + $('#selectprojecttype').val() + '\n' +
            //    'fg_goodid:  ' + $('#txtfg_goodid').val() + '\n' +
            //    'txtproj_name:  ' + $('#txtproj_name').val() + '\n' +
            //    'txtfg_remark:  ' + $('#txtfg_remark').val() + '\n' +
            //     'custid:  ' + $('#txtCustomer_id').val()

            //);

            alert('fnGet_Insertitempart_wdforfg()');
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
                    , txtproj_name: $('#txtproj_name').val()
                    , txtfg_remark: $('#txtfg_remark').val()
                    , custid: $('#txtCustomer_id').val()
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
                            title: '<div class="txtLabel"><strong>เกิดข้อผิดพลาด</strong></div>',
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
            if ($('#txtwdfg_projname').val() == '')
            {
                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel"><strong>[ เกิดข้อผิดพลาด ]</strong></div>',
                    html: '<div class="txtLabel"><strong>กรุณา : </strong><strong style="color:red">ตรวจสอบข้อมูลชื่อโครงการ</strong></div>'
                })
            } else if($('#txtwdfg_projname').val() != '')
            {
                //alert(2);
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

        function fn_SaveCustomerProj_validate() {
           
            if ($('#txtCustomerProjName').val() == '' || $('#txtCustomerQtyProj').val() == '' || $('#txtCustomerQty').val() == '') {

                var strerr = ''

                if ($('#txtCustomerProjName').val() == '')
                {
                    strerr += '<div class="txtLabel " style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ตรวจสอบ : ชื่อโครงการ</div>'
                }
                if ($('#txtCustomerQty').val() == '')
                {
                    strerr += '<div class="txtLabel " style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ตรวจสอบ : จำนวนคำสั่งซื้อ</div>'
                }
                if ($('#txtCustomerLength').val() == '')
                {
                    strerr += '<div class="txtLabel " style="color:#f27474"><strong><i class="fa fa-times-circle-o" aria-hidden="true"></i></strong> ตรวจสอบ : จำนวนความยาว</div>'
                }


                Swal.fire({
                    icon: 'error',
                    title: '<div class="txtLabel16" style="color:#f27474"><strong>เกิดข้อผิดพลาด</strong></div>',
                    html: strerr,
                    confirmButtonColor: '#f27474',
                    confirmButtonText: '<div class="txtLabel">OK</div>'
                })
            }
            else if ($('#txtid').val() == '') //Save 
            {
                Swal.fire({
                    title: '<div class="txtLabel16" style="color:#87adbd"><strong>ยืนยันการบันทึกข้อมูล ?</strong></div>',
                    icon: 'question',
                    showDenyButton: true,
                    showCancelButton: true,
                    cancelButtonColor: '#f94144',
                    confirmButtonColor: '#5cb85c',
                    confirmButtonText: '<div class="txtLabel"><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></div>',
                    cancelButtonText: '<div class="txtLabel"><strong>Cancel</strong></div>',
                }).then((result) => {
                    /* Read more about isConfirmed, isDenied below */
                    if (result.isConfirmed) {

                        fn_SaveCustomerProj(); 

                        
                    } 
                })

                

                              
            }
            else if ($('#txtid').val() != '') //Update
            {
                fn_UpdateCustomerProj();
            }

         }

        function fn_SaveCustomerProj()
        {
            
            $.ajax({
                url: '../../xTransaction/srv_transaction_project.asmx/fn_SaveCustomerProj', 
                method: 'post',
                data: {
                    action: 'fn_SaveCustomerProj'
                    , create_by: usr_name
                    , create_date: currentdate2
                    , CustomerID: $('#txtCustomerId').val()
                    , CustomerName: $('#txtCustomerName').val()
                    , CustomerAddress: $('#txtCustomerAddress').val()
                    , CustomerProjName: $('#txtCustomerProjName').val()
                    , CustomerOrderQty: $('#txtCustomerQty').val()
                    , CustomerOrderLength: $('#txtCustomerLength').val()
                    , remark: $('#txtCustomerRemark').val()
                    , customerprojdate: $('#txtCustomerProjDate').val()
                },
                dataType: 'json',
                success: function (data) {
                    if (data == 'Success') {
                        $.each(data, function (i, item) {
                            clearinput();
                            fn_GetCustomerProjAll();
                            $('#modal_InputCustomerProject').modal('hide');
                            //Swal.fire({
                            //    icon: 'success',
                            //    title: '<div class="txtLabel"><strong>[ บันทึกข้อมูลเรียบร้อย ]</strong></div>'
                            //})

                            Swal.fire({
                                icon: 'success',
                                title: '<div class="txtLabel16" style="color:#a5dc86"><strong>บันทึกข้อมูลเรียบร้อย</strong></div>',
                                confirmButtonColor: '#a5dc86',
                                confirmButtonText: '<div class="txtLabel">OK</div>'
                            })


                        })
                    } else {
                        alert(1);
                    }
                }
            })

        }
        function fn_UpdateCustomerProj() {
            console.warn(fn_UpdateCustomerProj());
        }

        function fn_RemoveCustomerProjbyId(id) {
            Swal.fire({
                title: 'ยืนยันการลบข้อมูล',
                icon: 'question',
                showDenyButton: true,
                showCancelButton: true,
                cancelButtonColor: '#f94144',
                confirmButtonColor: '#5cb85c',
                confirmButtonText: '<div class="txtLabel"><strong><i class="fa fa-floppy-o" aria-hidden="true"></i> Save</strong></div>',
                cancelButtonText: '<div class="txtLabel"><strong>Cancel</strong></div>',
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {

                    $.ajax({
                        url: '../../xTransaction/srv_transaction_project.asmx/fn_RemoveCustomerProjbyId',
                        method: 'post',
                        data: {
                            action: 'fn_RemoveCustomerProjbyId'
                            , id : id
                        },
                        dataType: 'json',
                        success: function (data) {
                            if (data == 'Success') {
                                $.each(data, function (i, item) {
                                    fn_GetCustomerProjAll();
                                    $('#modal_InputCustomerProject').modal('hide');
                                    Swal.fire({
                                        icon: 'success',
                                        title: '<div class="txtLabel"><strong>[ ลบข้อมูลเรียบร้อย ]</strong></div>'
                                    })


                                })
                            } else {
                                alert(1);
                            }
                        }
                    })


                }
            })
        }

    </script>
</asp:Content>
