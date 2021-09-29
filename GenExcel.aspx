<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenExcel.aspx.cs" Inherits="AmpelflowApp.GenExcel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <%--<script src="Content/plugins/iCheck/icheck.min.js"></script>--%>
    <script src="../../Content/plugins/iCheck/icheck.js"></script>
    <script src="../../Content/plugins/iCheck/icheck.min.js"></script>
    <link href="../../Content/plugins/iCheck/flat/green.css" rel="stylesheet" />
    <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../Content/bower_components/jquery/dist/jquery.js"></script>


    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_flat',
                radioClass: 'iradio_flat'
            });
        });
       

    </script>



    <script runat="server">
        void btnUpload_OnClick(Object sender, EventArgs e)
	    {
		    if(this.fiUpload.HasFile)
		    {
			    this.fiUpload.SaveAs(Server.MapPath("xReporting/FileUpload/"+fiUpload.FileName));
			    this.lblText.Text = fiUpload.FileName + " Uploaded.<br>";
		    }
        }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <button runat="server" onserverclick="excelonprint1job" >job1</button>
            <button runat="server" onserverclick="exceltest" >Test1</button>
            <button runat="server" onserverclick="excelonprintjoball">JobAll</button>
            <button runat="server" onserverclick="excelcostinv">Cost/Inv</button>


            </div>
        <br />
        <div>

            <asp:FileUpload ID="fiUpload" runat="server"></asp:FileUpload>
            <input id="btnUpload" type="button" onserverclick="btnUpload_OnClick" value="Upload" runat="server" />
            <hr />
            <asp:Label ID="lblText" runat="server"></asp:Label>
        </div>
        <div><input class="numeric" type="text" /></div>
        <div>
            <input type="checkbox" />
            <input type="checkbox" checked />
            <input type="radio" name="iCheck" />
            <input type="radio" name="iCheck" checked />
        </div>
    </form>
</body>
</html>
