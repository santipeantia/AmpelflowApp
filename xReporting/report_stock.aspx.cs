using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using AmpelflowWeb.DBConnect;
using OfficeOpenXml;

namespace AmpelflowApp.xReporting
{
    public partial class report_stocknet : System.Web.UI.Page
    {
        
        string ConStr = ConfigurationManager.ConnectionStrings[dbConnect.ServNameDb].ToString();

        ReportDocument rpt = new ReportDocument();

        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void OnPrintPDF(object sender,EventArgs e)
        {
            string rptType = serv_btnReportTypeSelected.Value.ToString();
            string strDate = serv_eDate1.Value.ToString();
            string strDateNow = DateTime.Now.ToString("yyyy-MM-dd");
            string allitems = serv_txtitemlist.Value.ToString() ;
            Console.Write(allitems);


            if (rptType == "1")
            {
                

                        SqlConnection Conn = new SqlConnection(ConStr);
                        SqlCommand scd = new SqlCommand("spReport_StockNet", Conn);
                        scd.CommandType = System.Data.CommandType.StoredProcedure;
                        scd.Parameters.AddWithValue("@eDate", strDate);
                        scd.Parameters.AddWithValue("@allitems", allitems);
                        Conn.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(scd);
                        DataTable Dt = new DataTable();
                        sda.Fill(Dt);
                        Conn.Close();

                        Console.WriteLine(Dt.Rows.Count);
                        ReportDocument rpt = new ReportDocument();
                        rpt.Load(Server.MapPath("Reports/report_stock_net.rpt"));
                        rpt.SetDatabaseLogon("sa", "AmpelitE88", "192.168.1.13", "Db_AmpelFlow");


                        ds_report_stocknet _Report_Stocknet = new ds_report_stocknet();
                        _Report_Stocknet.Merge(Dt);

               
                        Response.Buffer = false;
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.ContentType = "application/pdf";
                        rpt.SetDataSource(Dt);

                        rpt.SetParameterValue("eDate", strDate);
                        rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "รายงานสินค้าคงคลัง_" + strDateNow);                        
                  
              
                   
                
            }
            else if(rptType == "2"){

            }

        }

        protected void OnPrintExcel(object sender,EventArgs e)
        {
            var strDate = DateTime.Now.ToString();

            using (var package = new ExcelPackage())
            {
                var workbook = package.Workbook;
                ExcelPackage excel = new ExcelPackage();
                var worksheet = excel.Workbook.Worksheets.Add("สินค้าคงเหลือ");

                //*** Sheet 1
               
                worksheet.Cells["A1"].Value = "ThaiCreate.Com";
                worksheet.Cells["B2"].Value = "2017";

                byte[] bin = excel.GetAsByteArray();

                //clear the buffer stream
                Response.ClearHeaders();
                Response.Clear();
                Response.Buffer = true;

                //set the correct contenttype
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //set the correct length of the data being send
                Response.AddHeader("content-length", bin.Length.ToString());

                //set the filename for the excel package
                Response.AddHeader("content-disposition", "attachment; filename=\"รายงานสินค้าคงเหลือ_" + strDate + ".xlsx\"");

                //send the byte array to the browser
                Response.OutputStream.Write(bin, 0, bin.Length);

                //cleanup
                Response.Flush();
                HttpContext.Current.ApplicationInstance.CompleteRequest();

                Response.End();
            }
        }

        protected void OnPrint_StockMovement(object sender,EventArgs e)
        {
            string TypeReport = serv_TypeReport.Value.ToString() ;
            string sDate = serv_sDate1x.Value.ToString();
            string eDate = serv_eDate1x.Value.ToString() ;
            string items = serv_txtitemlist.Value.ToString();
            //string items = "18065;18103;18182;18797;28095;28097;28098;28099;28100;28101;28102;28103;28106;28107;28108;28111;28112;28113;28116;28117;39243;39244;39245;39246;39285;39286;39247;39248;39249;39250;39251;39252;39255;39256;39284;39290;39293";

            if (TypeReport == "pdf")
            {
                using (SqlConnection sConn = new SqlConnection(ConStr))
                {
                    SqlCommand cmd = new SqlCommand("spReport_StockMovemrnt", sConn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@action", "rptStockDisplay");
                    cmd.Parameters.AddWithValue("@sDate", sDate);
                    cmd.Parameters.AddWithValue("@eDate", eDate);
                    cmd.Parameters.AddWithValue("@items", items);
                    cmd.CommandTimeout = 120;

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dtx = new DataTable();

                    sda.Fill(dtx);

                    Console.WriteLine(dtx.Rows.Count);
                    ReportDocument rpt = new ReportDocument();
                    rpt.Load(Server.MapPath("Reports/report_stock_movement.rpt"));
                    rpt.SetDatabaseLogon("sa", "AmpelitE88", "192.168.1.13", "Db_AmpelFlow");

                    ds_report_stockmovment _Report_Stockmovment = new ds_report_stockmovment();
                    _Report_Stockmovment.Merge(dtx);
                    ds_report_stocknet _Report_Stocknet = new ds_report_stocknet();




                    Response.Buffer = false;
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/pdf";
                    rpt.SetDataSource(dtx);
                    rpt.SetParameterValue("sDate", sDate);
                    rpt.SetParameterValue("eDate", eDate);


                    

                    //rpt.SetParameterValue("eDate", strDate);
                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "รายงานสินค้าคงคลัง_" + DateTime.Now.ToString("yyyy-mm-dd"));

                }

            }else if(TypeReport == "excel"){

            }
        }
    }
}