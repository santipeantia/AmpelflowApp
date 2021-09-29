<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="setting_usermanagement.aspx.cs" Inherits="AmpelflowApp.xSetting.setting_usermanagement_aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>

        <style>
             [name="tbluser_length"] {border-radius: 3px;}
             [type="search"] {border-radius: 3px;}
             [name*="_length"] {border-radius: 3px;}
    
             .input-Radius {border-radius:3px}
             .input-Radius-left {border-radius: 3px 0px 0px 3px;}
             .input-Radius-right {border-radius: 3px 0px 0px 3px;}
             .select2-container--default .select2-selection--single {
                height: auto;
                margin-top: 0px;
                border-radius: 3px;
            }
        </style>


        <script>
            $(document).ready(function () {

                setTimeout(function () {
                    getEmployeeList();
                    getUserGroupType();


                    getUserWithoutList();

                    //$("#tblemployee").on('click', '.btnSelect', function () {
                    //    var currentRow = $(this).closest("tr");

                    //    var emp_id = currentRow.find("td:eq(0)").html(); // get current row 1st table cell td value
                    //    var firstname = currentRow.find("td:eq(1)").html(); // get current row 2nd table cell td value
                    //    var lastname = currentRow.find("td:eq(2)").html(); // get current row 3rd table cell  td value
                    //    var data = emp_id + "\n" + firstname + "\n" + lastname;


                    //    $('#emp_id').val(emp_id);
                    //    $('#firstname').val(firstname);
                    //    $('#lastname').val(lastname);
                    //    $('#modal-employee').modal("hide");
                    //});

                    var btnsearch = $('#btnsearch');
                    btnsearch.click(function () {

                        $('#modal-employee').modal({ backdrop: false });
                        $('#modal-employee').modal('show');
                    });

                    var btnSavechanges = $('#btnSavechanges');
                    btnSavechanges.click(function () {
                        savedatachanges();
                    });

                    var btnEditchanges = $('#btnEditchanges');
                    btnEditchanges.click(function () {
                        Swal.fire({
                            title: 'Are you sure?',
                            text: "Are you sure you want to update changes?!",
                            icon: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, update changes.!'
                        }).then((result) => {
                            if (result.value) {
                                updatedatachanges();
                            }
                        });
                    });

                    //case select multi cheked when button click
                    var btncheck = $('#btncheck');
                    btncheck.click(function () {

                        // declare variable table for assign attribute


                        var table = $('#tblemployee').DataTable();
                        var arr = [];
                        var checkedvalues = table.$('input:checked').each(function () {
                            arr.push("'" + $(this).attr('id') + "'")
                        });
                        // convert array to string
                        arr = arr.toString();

                        alert(arr);

                        var empid = arr.split(",");
                        empid.forEach(getEmpid);

                        function getEmpid(item, index) {
                            console.log(index + ':' + item)
                        }
                        $('#example-result').text(empid);
                        //table.$('input:checked').removeAttr('checked');                   
                        getUserWithoutList();

                        // $('#modal-employee').modal('hide');

                        
                    }); 
                    $('body').removeClass('overlay');
                }, 500);
                //todo something here                
                           
            });

            function getUserGroupType() {
                var selgroup = $('#selgroup');
                var selgroup_edit = $('#selgroup_edit');

                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetUserGroupType',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {
                        selgroup.empty();
                        selgroup_edit.empty();
                        $(data).each(function (index, item) {
                            // binding data into select option in case create new
                            selgroup.append($('<option/>', { value: item.usr_type_id, text: item.type_desc }));

                            // binding data into select option incase update changes
                            selgroup_edit.append($('<option/>', { value: item.usr_type_id, text: item.type_desc }));

                        });
                    }
                });
            };

            function getEmployeeList() {
                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetEmployeeList',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {

                        $('#tbluser').DataTable().clear();
                        $('#tbluser').DataTable().destroy();


                        var table;
                        table = $('#tbluser').DataTable({'ordering':false});
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([
                                    '<div style="padding-left:5px">' + data[i].emp_id + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].prefix + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].firstname + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].lastname + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].username + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].name_desc + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].urlview + '</div>'
                                    , data[i].urltrash
                                ]);
                            });
                        }
                        else {
                            //todo empty....
                        }
                        table.draw();
                        
                        bindtableuser(); 

                    }
                });
            }

            function getUserWithoutList() {

                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetUserWithoutList',
                    method: 'post',
                    dataType: 'json',                   
                    success: function (data) {
                        //$('#tblemployee').DataTable().clear();
                        //$('#tblemployee').DataTable().destroy();



                        var table;
                        table = $('#tblemployee').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([
                                    '<div style="padding-left:5px">' + data[i].emp_id + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].firstname + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].lastname + '</div>'
                                    , '<div style="padding-left:5px">' + data[i].orglevel + '</div>'
                                    , '<div style="text-align: center;">' +
                                    '<a href="javascript:void(0)" type="button"   onclick="GetUserWithoutListById(\'' + data[i].emp_id + '\')" class="btn-group" data-toggle="tooltip" data-placement="right"  style="font-size:14px;color:#18A558"><i class="fa fa-user-plus" aria-hidden="true"></i></a>' +
                                    '</div>'
                                    , data[i].chk
                                    
                                ]);
                            });
                        }
                        else {
                        }
                        //finally draw into a table
                        table.draw();
                    }
                });
            };

            function bindtableuser() {
                var table = document.getElementById("tbluser"), rIndex;
                for (var i = 1; i < table.rows.length; i++) {
                    for (var j = 0; j < table.rows[i].cells.length; j++) {

                        table.rows[i].cells[j].onclick = function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            console.log(rIndex + "  :  " + cIndex);

                            if (this.cellIndex == 6) {
                                                               
                                //todo showing member of mene
                                // get key value from table 
                                var currentRow = $(this).closest("tr");

                                // this key value is empid
                                var empid = currentRow.find("td:eq(0)").html();

                                // get data from webservice                            
                                $.ajax({
                                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetEmployeeById',
                                    method: 'post',
                                    data: {
                                        empid: empid
                                    },
                                    datatype: 'json',
                                    success: function (data) {
                                        var obj = jQuery.parseJSON(JSON.stringify(data));
                                        if (obj != '') {
                                            $.each(obj, function (key, inval) {
                                                // assign obj data into input object..
                                                $('#emp_id_edit').val(inval["emp_id"]);
                                                $('#firstname_edit').val(inval["firstname"]);
                                                $('#lastname_edit').val(inval["lastname"]);
                                                $('#username_edit').val(inval["username"]);
                                                $('#password_edit').val(inval["password"]);

                                                // set select option as selected..;
                                                $('#selgroup_edit').val(inval["usr_type_id"]).change();
                                                //$('#selgroup_edit').change();   
                                                
                                                $('#selstatus_edit').val(inval["isactive"]).change();
                                                //$('#selstatus_edit').change();  
                                            });
                                        }
                                    }
                                })
                                                                                         
                                $('#myModalEdit').modal({ backdrop: false });
                                $('#myModalEdit').modal('show');

                                //alert('Open Modal Edit Member..');
                            }

                            else if (this.cellIndex == 7) {

                                var currentRow = $(this).closest("tr");

                                // this key value is empid
                                var empid = currentRow.find("td:eq(0)").html();

                                //todo showing detalis of delete
                                Swal.fire({
                                    title: 'Are you sure?',
                                    text: "Are you sure you want to update changes?!",
                                    icon: 'question',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Yes, update changes.!'
                                }).then((result) => {
                                    if (result.value) {
                                        deletedchanges(empid);
                                    }
                                });

                                //alert('Open Modal Delete..');
                            }

                        }
                    }
                }
            };

            function GetUserWithoutListById(empid) {
           
                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetUserWithoutListById',
                    method: 'post',
                    data: {
                        empid: empid
                    },
                    datatype: 'json',
                    success: function (data) {
                        //var obj = jQuery.parseJSON(JSON.stringify(data));
                        if (data != '') {
                            $.each(data, function (i, item) {
                                $('#emp_id').val(data[i].emp_id)
                                $('#firstname').val(data[i].firstname)
                                $('#lastname').val(data[i].lastname)

                                
                            })
                            $('#modal-employee').modal('hide');
                        }
                        
                    }
                })
            }

        </script>

        <h1 class="txtHeader">User Management Pages 
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary" style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img  src="../Content/Icons/user512.png" alt="User Image">
                                    <span class="username">
                                        <a href="#" class="txtSecondHeader">User Management</a>
                                        <span class="pull-right">
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
                                    <span class="description">Monitoring progression of projects</span>
                                </div>
                            </div>
                        </div>

                        <hr />

                        <%-- <%--step 2 design user interface ui below--%>
                        <div class="box-body txtLabel">

                            <div class="col-md-12">
                                <div class="nav-tabs-custom tab-info">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tabusers" class="txtLabel" data-toggle="tab"><strong><i class="icofont-users" style="font-size:18px"></i> User Lists</strong></a></li>
                                       
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabusers">
                                            <table id="tbluser" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                                <thead class="txtLabel ">
                                                    <tr>
                                                        <th class="text-center">EmpID</th>
                                                        <th class="text-center">Pefix</th>
                                                        <th class="text-center">Firstname</th>
                                                        <th class="text-center">Lastname</th>
                                                        <th class="text-center">Username</th>
                                                        <th class="text-center">GroupType</th>
                                                        <th style="width: 20px; text-align: center;">#</th>
                                                        <th style="width: 20px; text-align: center;">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="txtLabel">
                                                </tbody>
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

        <div class="modal modal-default fade" id="myModalNew">
            <div class="modal-dialog" >
                <div class="modal-content" style="border-radius:5px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-ui-user" style="font-size:18px"></i> New Member App</strong></h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">
                       
                            <div class="form-group">
                                <label class="txtLabel"><strong>Employee ID</strong></label>
                                <div class="input-group input-group-sm">
                                    <input type="text" id="emp_id" name="emp_id" class="form-control txtLabel" disabled required>
                                    <span class="input-group-btn txtLabel">
                                        <button type="button" id="btnsearch" class="btn btn-info btn-flat txtLabel">Go..!</button>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">First Name</label>
                                <input type="text" id="firstname" name="firstname" class="form-control input-sm input-Radius txtLabel" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Last Name</label>
                                <input type="text" id="lastname" name="lastname" class="form-control input-sm input-Radius txtLabel" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Username</label>
                                <input type="text" id="username" name="username" class="form-control input-sm input-Radius txtLabel" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Password</label>
                                <input type="password" id="password" name="pasword" class="form-control input-sm input-Radius txtLabel" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">User Group</label>
                                <div class="txtLabel">
                                    <select id="selgroup" name="selgroup" class="form-control input-sm input-Radius txtLabel" style="width: 100%">
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Status</label>
                                <div class="txtLabel">
                                    <select id="selstatus" name="selstatus" class="form-control input-sm txtLabel" style="width: 100%">
                                        <option value="1">Status is active</option>
                                        <option value="0">Status is cancel</option>

                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSavechanges" name="btnSavechanges" class="btn btn-primary"><strong><i class="icofont-save"></i> Save</strong></button>
                        <button type="button" class="btn btn-danger hidden" id="btnsavenew" runat="server">Save New</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>


         <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Edit Entry</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <div class="form-group">
                                <label class="txtLabel">Employee ID</label>
                                <div class="input-group input-group-sm">
                                    <input type="text" id="emp_id_edit" name="emp_id_edit" class="form-control" readonly >
                                    <span class="input-group-btn">
                                        <button type="button" id="btnsearch_edit" class="btn btn-info btn-flat">Go..!</button>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">First Name</label>
                                <input type="text" id="firstname_edit" name="firstname_edit" class="form-control input-sm" readonly>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Last Name</label>
                                <input type="text" id="lastname_edit" name="lastname_edit" class="form-control input-sm" readonly>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Username</label>
                                <input type="text" id="username_edit" name="username_edit" class="form-control input-sm" >
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Password</label>
                                <input type="text" id="password_edit" name="password_edit" class="form-control input-sm" >
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">User Group</label>
                                <div class="txtLabel">
                                    <select id="selgroup_edit" name="selgroup_edit" class="form-control input-sm" style="width: 100%">
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Status</label>
                                <div class="txtLabel">
                                    <select id="selstatus_edit" name="selstatus_edit" class="form-control input-sm " style="width: 100%">
                                        <option value="1">Status is active</option>
                                        <option value="0">Status is cancel</option>

                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnEditchanges" name="btnEditchanges" class="btn btn-info">Edit Changes</button>
                        <button type="button" class="btn btn-danger hidden" id="Button1" runat="server">Save New</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>
        
        <div class="modal modal-default fade" id="modal-employee">
            <div class="modal-dialog">
                <div class="modal-content" style="border-radius:5px;width:120%;left:-10%;" >
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel"><strong><i class="icofont-users-social" style="font-size:18px"></i> Employee</strong></h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <table id="tblemployee" class="table table-striped table-bordered table-hover table-condensed txtLabel" style="width: 100%">
                                <thead class="txtLabel">
                                    <tr>
                                        <th class="text-center">EmpId</th>
                                        <th class="text-center">Firstname</th>
                                        <th class="text-center">Lastname</th>
                                        <th class="text-center">OrgLevel</th>
                                        <th class="text-center">#</th>
                                        <th class="text-center">#</th>
                                    </tr>
                                </thead>
                                <tbody class="txtLabel">
                                </tbody>
                            </table>

                           <p><button type="button" id="btncheck" name="btncheck">Get multi selected</button></p>
                            <p id="example-result"></p>
                        </div>
                    </div>


                </div>
            </div>
        </div>
      
        <script>
            function openModal() {
                $("#myModalNew").modal({ backdrop: false });
                $('[id=myModalNew]').modal('show');

                //$('#modal-employee').modal({ backdrop: false });
                //$('#modal-employee').modal('show');
            }

            function validatesave() {

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Are you sure you want to save changes?!",
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, save changes.!'
                }).then((result) => {
                    if (result.value) {
                        savedatachanges();
                    }
                });

                //return;
            }


            function savedatachanges() {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;


                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetSavechangesUser',
                    method: 'post',
                    data: {
                        usr_id: '0',
                        emp_id: $('#emp_id').val(),
                        usr_name: $('#username').val(),
                        usr_password: $('#password').val(),
                        usr_type_id: $('#selgroup').val(),
                        isactive: $('#selstatus').val(),
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalNew').modal('hide');

                        $('#emp_id').val('');
                        $('#firstname').val('');
                        $('#lastname').val('');
                        $('#username').val('');
                        $('#password').val('');

                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                        getEmployeeList();
                    }
                });
            }

            function updatedatachanges() {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetSavechangesUser',
                    method: 'post',
                    data: {
                        usr_id: '1',
                        emp_id: $('#emp_id_edit').val(),
                        usr_name: $('#username_edit').val(),
                        usr_password: $('#password_edit').val(),
                        usr_type_id: $('#selgroup_edit').val(),
                        isactive: $('#selstatus_edit').val(),
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalEdit').modal('hide');

                        $('#emp_id_edit').val('');
                        $('#firstname_edit').val('');
                        $('#lastname_edit').val('');
                        $('#username_edit').val('');
                        $('#password_edit').val('');

                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                        getEmployeeList();
                    }
                });
            }

            function deletedchanges(empid) {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;
              
                $.ajax({
                    url: '../../xsetting/srv_setting_usermanagement.asmx/GetSavechangesUser',
                    method: 'post',
                    data: {
                        usr_id: '2',
                        emp_id: empid,
                        usr_name: null,
                        usr_password: null,
                        usr_type_id: null,
                        isactive: '0',
                        created_by: null,
                        create_date: null,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        
                        Swal.fire(
                            'Deleted.!',
                            'Your file has been delete changes.',
                            'success'
                        )
                        getEmployeeList();
                    }
                });
            }

        </script>

    </section>

</asp:Content>
