<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="testx.aspx.cs" Inherits="AmpelflowApp.xSetting.testx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
          <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../Content/bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../Content/plugins/numeral.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
        <script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>

        <script>
            
            $(document).ready(function () {

                $(":input").inputmask();

                $("#number").inputmask({ "mask": "9", "repeat": 10 });  // ~ mask "9999999999"
                $('#curr').inputmask('999,999.99', { numericInput: true }, );
                $('#curr1').inputmask('decimal', { rightAlign: false });  //disables the right alignment of the decimal input


                $(".decimal").inputmask('decimal', {
                    rightAlign: true
                });
                $(".currency").inputmask('currency', {
                    rightAlign: true
                });
                $(".custom1").inputmask({
                    mask: "9,999[.9999]",
                    rightAlign : true,
                    greedy: false,
                    definitions: {
                        '*': {
                            validator: "[0-9]"
                        }
                    },
                    
                });
                $(".custom2").inputmask({
                    'alias': 'decimal',
                    rightAlign: true,
                    'groupSeparator': '.',
                    'autoGroup': true
                });
                $(".custom3").inputmask({
                    'alias': 'decimal',
                    'mask': "99[.99]",
                    rightAlign: true
                });

                $(".mask").inputmask('Regex', { regex: "^[0-9]{1,6}(\\.\\d{1,2})?$" });
            });
           
        </script>
    </section>

    <section class="content col-md-12">
        <div class="row">
            <div class="col-md-12">
             <input type="text" id="number"/>
            <input type="text" id="curr"/ style="color:green">
            <input type="text" id="curr1"/>
        </div>
            </div>
        <div class="row">
            <div class="col-md-12">
                <input data-inputmask="'mask': '99-9999999'" />
                <input data-inputmask="'alias': 'date'" />
                <input  data-inputmask="'mask': '9,999,999.9999', 'repeat': 10,'greedy' : false"/>
                <input data-inputmask="'mask': '99-9999999','greedy' : false" />
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <input type="text" class="decimal" />
                <input type="text" class="currency" />
                <input type="text" class="custom1" />
                <input type="text" class="custom2" />
                <input type="text" class="custom3" value="0" />
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <input class="mask" type="text" />
            </div>
        </div>
        <br />
       
        
        <div><button>Click</button></div>
        
        
    </section>
</asp:Content>
