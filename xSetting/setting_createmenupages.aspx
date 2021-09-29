<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="setting_createmenupages.aspx.cs" Inherits="AmpelflowApp.xSetting.setting_createmenupages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        
        <script>
            var mnu_ids = '';
            var emp_id = '<%= Session["emp_id"] %>';
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
            var currentdate2 = yyyy + '-' + mm + '-' + dd;
            
            
            

            $(document).ready(function () {

                setTimeout(function () {
                    GetDataPageMenuAllReload();
                    $('#Main-Content').fadeIn(1000);
                    $('body').removeClass('overlay');
                }, 500);
                
               
            })
       
            function GetDataPageMenuAllReload() {
                //alert(' GetDataPageMenuAllReload()');
                $.ajax({
                    url: '../../xSetting/srv_setting_createmenupages.asmx/GetDataMenuAll',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data != '') {
                            var tblMenusAll = $('#tblMenusAll').DataTable();
                            tblMenusAll.clear();

                            $.each(data, function (i, item) {
                                tblMenusAll.row.add([

                                    '<div>' + data[i].mnu_type_name + '</div>'
                                    , '<div>' + data[i].mnu_page + '</div>'
                                    , '<div>' + data[i].mnu_title + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="GetMemberDataPageMenuAll(\'' + data[i].mnu_id + '\')" class="btn-group"   style="font-size: 15px;color:#43AA8B"><i class="fa fa-users" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="GetMemberDataPageMenuAllById(\'' + data[i].mnu_id + '\')" class="btn-group"   style="font-size: 15px;color:#5390d9"><i class="fa fa-pencil" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="DeleteMemberDataPageMenuAll(\'' + data[i].mnu_id + '\')" class="btn-group"   style="font-size: 15px;color:#e76f51"><i class="fa fa-trash-o" aria-hidden="true"></i></a>' +
                                    '</div>'

                                ]);
                            });
                            tblMenusAll.draw();
                        }
                    }
                })
            }

            function GetMemberDataPageMenuAll(mnuid) {  
                $.ajax({
                    url: '../../xsetting/srv_setting_createmenupages.asmx/GetDataMenuAllById',
                    method: 'post',
                    dataType: 'json',
                    data: {
                        mnuid: mnuid
                    },
                    success: function (data) {

                        $.each(data, function (i, item) {

                            var stext = $('#mnu_type_id');
                            stext.text(data[i].mnu_type_id);
                            $('#mnu_type_name').text(data[i].mnu_type_name);

                            $('#mnu_type_id_edit').val(data[i].mnu_type_id);
                            $('#mnu_type_name_edit').val(data[i].mnu_type_name);
                            $('#mnu_id_edit').val(data[i].mnu_id);
                            $('#mnu_page_edit').val(data[i].mnu_page);
                            $('#mnu_title_edit').val(data[i].mnu_title);
                        })

                        getUserLists(mnuid);
                        getMemberLists(mnuid);
                    }
                });

                $("#modal-memberedit").modal({ backdrop: false });
                $("#modal-memberedit").modal("show");
               
            }

            function SaveMemberDataPageMenuAll() {
                
                if (mnu_ids == '') {
                    InsertDataMenuPageAll();
                } else if (mnu_ids != '') {
                    UpdateDataMenuPageAll();
                } else {

                }
            }

            function GetMemberDataPageMenuAllById(mnu_id) {  //for Edited
                $.ajax({
                    url: '../../xsetting/srv_setting_createmenupages.asmx/GetDataMenuAllById',
                    method: 'post',
                    dataType: 'json',
                    data: {
                        mnuid: mnu_id
                    },
                    success: function (data) {
                        if (data != '') {
                            Swal.fire({
                                title: 'ต้องการเลือกแก้ไขรายการนี้ใช่หรือไม่ ?',
                                //text: "You won't be able to revert this!",
                                icon: 'question',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Yes, Selected it!'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    $.each(data, function (i, item) {
                                        mnu_ids = data[i].mnu_id
                                        $('#mnuSysType').val(data[i].mnu_type_id);
                                        $('#mnuSysType').change();
                                        $('#pagename').val(data[i].mnu_page);
                                        $('#pagetitle').val(data[i].mnu_title);
                                        $('#seqno').val(data[i].mnu_seqno);
                                        
                                    })
                                }
                            })  
                        }
                        
                    }
                })
            }

            function DeleteMemberDataPageMenuAll(mnu_id) {
               
                Swal.fire({
                    title: 'คุณต้องการลบรายการนี้ใช่หรือไม่ ?',
                    //text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        
                        $.ajax({
                            url: '../../xsetting/srv_setting_createmenupages.asmx/GetDeleteMenuLists',
                            method: 'post',
                            dataType: 'json',
                            data: {
                                mnuid: mnu_id
                            },
                            success: function (data) {
                                if (data == 'Success') {
                                    Swal.fire({
                                        title: 'Saved!',
                                        icon: 'success',
                                        text: 'Your file has been saved.',
                                        type: 'success'
                                    });

                                    ClearInput();
                                    //window.location.reload(true);

                                    GetDataPageMenuAllReload();
                                }
                                
                                
                                
                            }
                            
                        })
                       
                    }
                })


            }

            function ClearInput() {
               

                mnu_ids = '';
                $('#mnuSysType').val('1');
                $('#mnuSysType').change();
                $('#pagename').val('');
                $('#pagetitle').val('');
                $('#seqno').val('');
            }

            function InsertDataMenuPageAll() {
                //alert('InsertDataMenuPageAll()');
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, save it!'
                }).then((result) => {
                    if (result.value) {
                        //todo web service working here and then after success alert     
                        //alert(empid.text());
                        $.ajax({
                            url: '../../xsetting/srv_setting_createmenupages.asmx/GetInsertMenuPage',
                            method: 'POST',
                            data: {
                                mnu_type_id: $('#mnuSysType').val(),
                                mnu_page: $('#pagename').val(),
                                mnu_title: $('#pagetitle').val(),
                                mnu_seqno: $('#seqno').val(),
                                isactive: '1',
                                created_by: emp_id,
                                create_date: currentdate,
                                update_by: emp_id,
                                update_date: currentdate
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire({
                                    title: 'Saved!',
                                    icon: 'success',
                                    text: '<div class="txtSecondHeader">บันทึกข้อมูลเรียบร้อย ...</div>',
                                    type: 'success'
                                });
                                GetDataPageMenuAllReload(); 
                                ClearInput();
                            }
                        });

                    }
                })
            }

            function UpdateDataMenuPageAll() {
                //alert(mnu_ids);
                Swal.fire({
                    title: 'Are you sure?',
                    text: "คุณต้องการแก้ไขรายการนี้?!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, save it!'
                }).then((result) => {
                    if (result.value) {
                        //todo web service working here and then after success alert     
                        //alert(empid.text());
                        $.ajax({
                            url: '../../xsetting/srv_setting_createmenupages.asmx/GetUpdateMenuPage',
                            method: 'POST',
                            data: {
                                mnu_id : mnu_ids,
                                mnu_type_id: $('#mnuSysType').val(),
                                mnu_page: $('#pagename').val(),
                                mnu_title: $('#pagetitle').val(),
                                mnu_seqno: $('#seqno').val(),
                                isactive: '1',
                                //created_by: emp_id,
                                //create_date: currentdate,
                                update_by: emp_id,
                                update_date: currentdate
                            },
                            dataType: 'json',
                            complete: function (data) {
                                Swal.fire({
                                    title: 'Saved!',
                                    icon: 'success',
                                    text: 'Your file has been saved.',
                                    type: 'success'
                                });
                                GetDataPageMenuAllReload();
                                ClearInput();
                            }
                        });

                    }
                })
            }

            function getUserLists(mnuid) {
                $.ajax({
                    url: '../../xsetting/srv_setting_createmenupages.asmx/GetDataUserLists',
                    method: 'post',
                    data: {
                        mnuid: mnuid
                    },
                    dataType: 'json',
                    success: function (data) {
                        //variable table for keep data
                        var table;
                        table = $('#tbluser').DataTable();
                        //remove rows on table
                        table.clear();
                        //check data has rows then
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].empid, data[i].firstname, data[i].lastname, data[i].urllink]);
                            });
                        }
                        else {
                            //$('#tbluser').html('<h3>No users are available</h3>');
                        }
                        //finally draw into a table
                        table.draw();

                        $(function () {
                            //change cursor handle
                            $('#tbluser td').hover(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                if (rIndex != 0 & cIndex == 3) {
                                    $(this).css('cursor', 'pointer');
                                }
                            });

                             var table = document.getElementById("tbluser"), rIndex;
                            for (var i = 1; i < table.rows.length; i++) {
                                for (var j = 0; j < table.rows[i].cells.length; j++) {
                                    table.rows[i].cells[j].onclick = function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        console.log(rIndex + "  :  " + cIndex);

                                        var empid = $("#tbluser").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                        var usrcreate = '<%= Session["emp_id"] %>';

                                        if (this.cellIndex == 3) {
                                            //confirm delete member
                                            Swal.fire({
                                                title: 'Are you sure?',
                                                text: "You won't be able to revert this!",
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: '#3085d6',
                                                cancelButtonColor: '#d33',
                                                confirmButtonText: 'Yes, save it!'
                                            }).then((result) => {
                                                if (result.value) {
                                                    //todo web service working here and then after success alert     
                                                    //alert(empid.text());
                                                    
                                                    $.ajax({
                                                        url: '../../xsetting/srv_setting_createmenupages.asmx/GetSaveMemberLists',
                                                        method: 'POST',
                                                        data: {
                                                            empid: empid.text(),
                                                            mnuid: mnuid,                                                            
                                                            isactive: 'true',
                                                            isdelete: 'false', 
                                                            usrcreate: usrcreate
                                                        },
                                                        dataType: 'json',                                                        
                                                        complete: function (data) {
                                                            Swal.fire(
                                                                'Saved!',
                                                                'Your file has been saved.',
                                                                'success'
                                                            )
                                                            getMemberLists(mnuid);

                                                            getUserLists(mnuid);
                                                            //GetDataPageMenuAllReload()
                                                        }                                                        
                                                    });                                                   
                                                }
                                            })
                                        }
                                    }
                                }
                            }

                        });
                    }
                });
            };

            function getMemberLists(mnuid) {
                $.ajax({
                    url: '../../xsetting/srv_setting_createmenupages.asmx/GetDataMemberLists',
                    data: {
                        mnuid: mnuid
                    },
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        //variable table for keep data
                        var table;
                        table = $('#tblmember').DataTable();
                        //remove rows on table
                        table.clear();
                        //check data has rows then
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].empid, data[i].firstname, data[i].lastname, data[i].urllink]);
                            });
                        }
                        else {
                            //$('#tblmember').html('<h3>No users are available</h3>');
                        }
                        //finally draw into a table
                        table.draw();

                        $(function () {
                            //change cursor handle
                            $('#tblmember td').hover(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                if (rIndex != 0 & cIndex == 3) {
                                    $(this).css('cursor', 'pointer');
                                }
                            });

                            var table = document.getElementById("tblmember"), rIndex;
                            for (var i = 1; i < table.rows.length; i++) {
                                for (var j = 0; j < table.rows[i].cells.length; j++) {
                                    table.rows[i].cells[j].onclick = function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        console.log(rIndex + "  :  " + cIndex);

                                        var empid = $("#tblmember").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                        if (this.cellIndex == 3) {
                                            //confirm delete member
                                            Swal.fire({
                                                title: 'Are you sure?',
                                                text: "You won't be able to revert this!",
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: '#3085d6',
                                                cancelButtonColor: '#d33',
                                                confirmButtonText: 'Yes, delete it!'
                                            }).then((result) => {
                                                if (result.value) {
                                                    //todo web service working here and then after success alert     
                                                    //alert(empid.text());
                                                    
                                                    $.ajax({
                                                        url: '../../xsetting/srv_setting_createmenupages.asmx/GetDeleteMemberLists',
                                                        method: 'POST',
                                                        data: {
                                                            mnuid: mnuid,
                                                            empid: empid.text()
                                                        },
                                                        dataType: 'json',                                                        
                                                        complete: function (data) {
                                                            Swal.fire(
                                                                'Deleted!',
                                                                'Your file has been deleted.',
                                                                'success'
                                                            )
                                                            getMemberLists(mnuid);

                                                            getUserLists(mnuid);
                                                        }                                                        
                                                    });                                                   
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                        });
                    }
                });

                ////#endregion single
            };

            function closeMemberList() {

                $("#modal-memberedit").modal({ backdrop: false });
                $("#modal-memberedit").modal("hide");


                var stext = $('#mnu_type_id');
                stext.text('');
                $('#mnu_type_name').text('');

                $('#mnu_type_id_edit').val('');
                $('#mnu_type_name_edit').val('');
                $('#mnu_id_edit').val('');
                $('#mnu_page_edit').val('');
                $('#mnu_title_edit').val('');
            }

        </script>



        <h1 class="txtHeader">Create Menu Pages
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content" id="Main-Content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary"   style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img  src="../../Content/Icons/web512.png" alt="User Image">
                                    <span class="username">
                                        <a href="#" class="txtSecondHeader">Menu Setting</a>
                                        <span class="pull-right">
                                            <button type="button" id="btnReload" name="btnReload" class="btn btn-default btn-sm checkbox-toggle" onclick="GetDataPageMenuAllReload()" data-toggle="tooltip" title="Reload">
                                                <i class="fa fa-refresh"></i>
                                            </button>
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description txtLabel">Monitoring progression of projects</span>
                                </div>
                            </div>
                        </div>


                        <%-- first start here--%>
                        <div class="box-body">

                            <div class="col-md-4">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active txtLabel"><a href="#activity" data-toggle="tab"><strong><i class="icofont-navigation-menu" style="font-size:14px"></i> Menu Setting</strong></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="activity">
                                            <!-- Post -->
                                            <div class="post">
                                                <div class="form-group">
                                                    <label class="txtLabel">MenuType</label>
                                                    <div class="txtLabel">
                                                        <select id="mnuSysType" name="mnuSysType" class="form-control input-sm">
                                                            <option value="1">Enterprise Master</option>
                                                            <option value="2">Transaction Entry</option>
                                                            <option value="3">Reporting</option>
                                                            <option value="4">Help & Support</option>
                                                            <option value="5">Setting</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="txtLabel">Page name</label>
                                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="pagename" name="pagename" placeholder="yourpages.aspx">
                                                </div>
                                                <div class="form-group">
                                                    <label class="txtLabel">Menu Title</label>
                                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="pagetitle" name="pagetitle" placeholder="show display menu">
                                                </div>
                                                <div class="form-group">
                                                    <label class="txtLabel">Seq No.</label>
                                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="seqno" name="seqno" placeholder="sequent number for alight menu">
                                                </div>

                                                <div class="row">
                                                     <div class="col-md-3">
                                                        <button type="button" id="btnClearInput" name="btnClearInput" onclick="ClearInput()" class="btn btn-danger btn-sm btn-block txtLabel">Clear</button>
                                                    </div>
                                                    
                                                    <div class="col-md-5">
                                                        
                                                    </div>
                                                   <div class="col-md-4">
                                                        <button type="button" id="button1" name="buton1" onclick="SaveMemberDataPageMenuAll()" class="btn btn-primary btn-sm btn-block txtLabel" style="background-color:#57cc99;border-color:#122b4000;padding:5px"><strong><i class="icofont-save"></i> Save</strong></button>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                             <div class="col-md-8 txtLabel">
                                <table id="tblMenusAll" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%;border-radius:3px">
                                    <thead class="txtLabel">
                                        <tr>
                                            <%--<th class="hidden" >TypeID</th>--%>
                                            <th class="text-center">TypeName</th>
                                            <th class="text-center">Filename</th>
                                            <th class="text-center">Title</th>
                                            <th class="text-center" style="text-align:center;width:20px">#</th>
                                            <th class="text-center" style="text-align:center;width:20px">#</th>
                                            <th class="text-center" style="text-align:center;width:20px">#</th>
                                        </tr>
                                    </thead>
                                    <tbody class="txtLabel">
                                        <%= strTblDetail %>
                                    </tbody>

                                </table>
                            </div>

                           
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade txtLabel" id="modal-memberedit">
            <div class="modal-dialog"  style="width: 1000px;">
                <div class="modal-content elRadius5px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><i class="icofont-users-alt-5"></i> Members :  <span class="txtLabel"> <label id="mnu_type_id"></label> <label id="mnu_type_name"></label> </span> </h4> 
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="">
                                <div class="form-group col-md-4 hidden">
                                    <label class="txtLabel">Type ID.</label>
                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="mnu_type_id_edit" name="mnu_type_id_edit" placeholder="">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Menu Type.</label>
                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="mnu_type_name_edit" name="mnu_type_name_edit" disabled placeholder="">
                                </div>

                                <div class="form-group col-md-4 hidden">
                                    <label class="txtLabel">Menu ID.</label>
                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="mnu_id_edit" name="mnu_id_edit" placeholder="">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Page Name.</label>
                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="mnu_page_edit" name="mnu_page_edit" disabled placeholder="">
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Title Name.</label>
                                    <input class="form-control input-sm txtLabel input-Radius" type="text" id="mnu_title_edit" name="mnu_title_edit" disabled placeholder="">
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-6">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tabusers" data-toggle="tab">User Lists</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabusers">
                                            <!-- Post -->
                                            <div class="post">
                                                <table id="tbluser" class="table table-striped table-bordered table-hover table-condensed elRadius5px" style="width: 100%">
                                                    <thead>
                                                        <tr class="txtLabel">
                                                            <th class="text-center">EmpCode</th>
                                                            <th class="text-center">FirstName</th>
                                                            <th class="text-center">LastName</th>
                                                            <th class="text-center" style="width: 20px; text-align: center;">#</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="txtLabel">
                                                        <%--<tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="member"><i class="fa fa-user-plus text-green"></i></a></td>
                                                        </tr>                                                        
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="member"><i class="fa fa-user-plus text-green"></i></a></td>
                                                        </tr>--%>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-md-6">
                                <div class="nav-tabs-custom tab-danger">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tabmember" data-toggle="tab">Member of menu</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabmember">
                                            <!-- Post -->
                                            <div class="post">
                                                <table id="tblmember" class="table table-striped table-bordered table-hover table-condensed txtLabel elRadius5px" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-center">EmpCode</th>
                                                            <th class="text-center">FirstName</th>
                                                            <th class="text-center">LastName</th>
                                                            <th style="width: 20px; text-align: center;">#</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="txtLabel">
                                                        <%--<tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>--%>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                        
                        <p>&nbsp;</p>

                    </div>
                    <div class="modal-footer">
                        <%--<button type="button" class="btn btn-default btn-sm pull-left" data-dismiss="modal">Close</button>--%>
                        <button type="button" class="btn btn-danger btn-sm" onclick="closeMemberList()">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </section>
</asp:Content>
