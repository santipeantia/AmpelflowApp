<%@ Page Title="" Language="C#" MasterPageFile="~/Ampelflow.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="AmpelflowApp.Main" %>

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

        <h1 class="txtHeader">รายการ : รายงานสินค้าคงคลัง</h1>
        <style>
            .nav-tabs-custom > .nav-tabs > li.active {
                border-top-color: #00b4d8;
            }

            .bxbpdercolor {
                border-top-color: #00b4d8;
            }

            

            .textBoxinit {
                border-radius: 0px 3px 3px 0px;
                width: 100%
            }

            .textBoxaddons {
                border-radius: 3px 0px 0px 3px;
            }

            .txtLabelx {
                font-family: 'Athiti', sans-serif;
                font-size: 15px;
                font-weight: normal;
            }

            .has-error .select2-selection {
                border-color: rgb(185, 74, 72) !important;
            }


            /*----------------------------------------------------*/
            .spinner {
                height: 60px;
                width: 60px;
                margin: auto;
                display: flex;
                position: absolute;
                -webkit-animation: rotation .6s infinite linear;
                -moz-animation: rotation .6s infinite linear;
                -o-animation: rotation .6s infinite linear;
                animation: rotation .6s infinite linear;
                border-left: 6px solid rgba(0, 174, 239, .15);
                border-right: 6px solid rgba(0, 174, 239, .15);
                border-bottom: 6px solid rgba(0, 174, 239, .15);
                border-top: 6px solid rgba(0, 174, 239, .8);
                border-radius: 100%;
            }

            @-webkit-keyframes rotation {
                from {
                    -webkit-transform: rotate(0deg);
                }

                to {
                    -webkit-transform: rotate(359deg);
                }
            }

            @-moz-keyframes rotation {
                from {
                    -moz-transform: rotate(0deg);
                }

                to {
                    -moz-transform: rotate(359deg);
                }
            }

            @-o-keyframes rotation {
                from {
                    -o-transform: rotate(0deg);
                }

                to {
                    -o-transform: rotate(359deg);
                }
            }

            @keyframes rotation {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(359deg);
                }
            }

            #overlayx {
                position: absolute;
                display: none;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0,0,0,0.5);
                z-index: 2;
                cursor: pointer;
            }


            /*----------------------------------------------------*/



        </style>
        <script>
            $(document).ready(function () {

                setTimeout(function () {
                    ProgressOff();

                }, 1000)
                
                //$('body').removeClass('overlay');
                //alert(1);

            });
        </script>
        

        <script>
            //Setting Spinner Overlay spinner

           

            function on() {
                document.getElementById("overlayx").style.display = "flex";
            }

            function off() {
                document.getElementById("overlayx").style.display = "none";
            }
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


            
          
        </script>


    </section>
    <section class="content" id="sectionContent" onload="ProgressOn()" style="display: none">
       
    </section>
</asp:Content>
