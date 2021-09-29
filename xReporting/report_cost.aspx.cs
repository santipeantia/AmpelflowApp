using AmpelflowWeb.DBConnect;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Excel.Functions.DateTime;
using OfficeOpenXml.Style;


//using AmpelflowApp.xReporting.Reports;

namespace AmpelflowApp.xReporting
{
    public partial class report_cost : System.Web.UI.Page
    {
        
        DataTable dt = new DataTable();
        dbConnection Conn = new dbConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        ReportDocument rpt = new ReportDocument();
        string strDate = DateTime.Now.ToString("yyyy-MM-dd");
        //string connString = @"Data Source=Localhost;Initial Catalog=Db_AmpelFlow;User ID=sa;Password=123456789sa";
        string connString = ConfigurationManager.ConnectionStrings[dbConnect.ServNameDb].ToString();
        string ssql = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //if (Session["usr_id"].ToString() != null)
                if (!string.IsNullOrEmpty(Session["usr_id"] as string))
                {
                    string strUsr_id = Session["usr_id"].ToString();
                    string strEmp_id = Session["emp_id"].ToString();
                    string strUsr_name = Session["usr_name"].ToString();
                    string strUsr_password = Session["usr_password"].ToString();

                    string strOpt = Request.QueryString["opt"];

                    //GetSystemMenu(strUsr_name, strUsr_password);
                    //GetSystemActiveMenu(strOpt);
                }
                else
                {
                    Response.Redirect("../Signin.aspx");
                }


            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                Response.Redirect("../signin.aspx");
            }
        }

        protected void OnPrint(object sender, EventArgs e)
        {
            string reportby = Session["usr_name"].ToString();
            string PrintType = txtPrintType.Value.ToString();
            string SysdocCode = txtSysdocCode.Value.ToString();
            string ProjTyperpt = "rpt_CostProjectByid";

            if (PrintType == "Pdf")
            {
                try
                {
                    DataTable dtx = new DataTable();
                    DataTable dtx2 = new DataTable();
                    DataTable dtx3 = new DataTable();
                    using (SqlConnection Conn = new SqlConnection(connString))
                    {
                      
                        ssql = "spReport_Action";
                        Comm = new SqlCommand(ssql, Conn);
                        Comm.CommandType = CommandType.StoredProcedure;
                        Comm.Parameters.AddWithValue("@action", "rpt_CostProjectByid");
                        Comm.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                        da = new SqlDataAdapter(Comm);
                        
                        da.Fill(dtx);
                        Conn.Close();
                    }

                    using (SqlConnection Conn = new SqlConnection(connString))
                    {
                        ssql = "spReport_Action";
                        SqlCommand Comm2 = new SqlCommand(ssql, Conn);
                        Comm2.CommandType = CommandType.StoredProcedure;
                        Comm2.Parameters.AddWithValue("@action", "rpt_ProjectDetail");
                        Comm2.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                        Conn.Open();
                        SqlDataAdapter da2 = new SqlDataAdapter(Comm2);
                        da2.Fill(dtx2);
                        Conn.Close();
                    }

                    /////////////////////////////////////////////////////////////

                    using (SqlConnection Conn = new SqlConnection(connString))
                    {
                        SqlCommand cmd = new SqlCommand("spGetproductfg_action", Conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@action", "GetProductCustDetail");
                        cmd.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                        cmd.CommandTimeout = 120;
                        Conn.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(dtx3);
                        Conn.Close();
                    }

                        /////////////////////////////////////////////////////////////

                    rpt.Load(Server.MapPath("Reports/report_cost_perproject.rpt"));


                    ds_report_costallproject _Report_Costallproject = new ds_report_costallproject();
                    _Report_Costallproject.Merge(dtx);

                    ds_report_costperproject_detail _Report_Costperproject_Detail = new ds_report_costperproject_detail();
                    _Report_Costperproject_Detail.Merge(dtx2);

                    ds_report_costperproject_summary _Report_Costperproject_Summary = new ds_report_costperproject_summary();
                    _Report_Costperproject_Summary.Merge(dtx3);

                    rpt.SetDataSource(dtx);

                    rpt.Subreports["subRpt_ReportProjectDetail"].Database.Tables[0].SetDataSource(dtx2);
                    rpt.Subreports["ReportTotalSumary"].Database.Tables[0].SetDataSource(dtx3);

                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "CostProject_" + strDate);


                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }

            }
            else if (PrintType == "Excel")
            {
                string Goodnamex = "", Projectnamex = "", Custnamex = "";
                decimal Quantityx = 0;
                decimal TotalAmnt = 0;
                decimal FooterCostperSet = 0, FooterCostpermater = 0, FooterSetAmnt = 0, FooterMaterAmnt = 0;


                //string SysdocCode = "RV-FG-00002";

                DataTable dtx = new DataTable();
                DataTable dtx3 = new DataTable();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    //---------------------------------------------------------
                    SqlCommand sCom = new SqlCommand("spReport_Action", conn);

                    sCom.CommandType = CommandType.StoredProcedure;
                    sCom.Parameters.AddWithValue("@action", "rpt_ProjectDetail");
                    sCom.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                    sCom.Parameters.AddWithValue("@TypeReport", "excel");
                    sCom.CommandTimeout = 120;

                    da = new SqlDataAdapter(sCom);
                    dt = new DataTable();
                    da.Fill(dt);
                    Console.WriteLine(dt.Rows.Count);

                    foreach (DataRow rows in dt.Rows)
                    {
                        Custnamex = rows["CustNameX"].ToString();
                        Projectnamex = rows["projectnamex"].ToString();
                        Goodnamex = rows["GoodName1x"].ToString();
                        Quantityx = Convert.ToDecimal(rows["quantityx"]);

                    }

                }


                using (SqlConnection Conn = new SqlConnection(connString))
                {

                    ssql = "spReport_Action";
                    Comm = new SqlCommand(ssql, Conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.Parameters.AddWithValue("@action", "rpt_CostProjectByid");
                    Comm.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                    Comm.Parameters.AddWithValue("@TypeReport", "excel");

                    da = new SqlDataAdapter(Comm);
                    dtx = new DataTable();
                    da.Fill(dtx);
                    Conn.Close();

                    foreach (DataRow rows in dtx.Rows)
                    {
                        TotalAmnt = TotalAmnt + Convert.ToDecimal(rows["amount"]);
                    }


                }

                using (SqlConnection Conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand("spGetproductfg_action", Conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@action", "GetProductCustDetail");
                    cmd.Parameters.AddWithValue("@sys_doc_ref", SysdocCode);
                    cmd.Parameters.AddWithValue("@TypeReport", "excel");
                    cmd.CommandTimeout = 120;
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dtx3);
                    Conn.Close();



                    foreach (DataRow rows in dtx3.Rows)
                    {
                        FooterSetAmnt = Convert.ToDecimal(rows["quantity"]);
                        FooterMaterAmnt = Convert.ToDecimal(rows["quantity_mater"]);
                        FooterCostperSet = Convert.ToDecimal(rows["priceperunit"]);
                        FooterCostpermater = Convert.ToDecimal(rows["amount"]);



                    }

                }


                ExcelPackage exc = new ExcelPackage();
                var workSheet = exc.Workbook.Worksheets.Add("รายการต้นทุนโครงการ_" + Projectnamex);
                //////////////////////////////////////////////////////////
                List<string> textHeader = new List<string> { "บริษัท แอมเพิลไลท์ เวิลด์", "ต้นทุนสินค้า Ampelflow : " + Goodnamex, "โครงการ : " + Projectnamex + " จำนวน " + Quantityx.ToString("0.00") + " ชุด", "ลูกค้า : " + Custnamex };
                List<float> fontsize = new List<float> { 22, 17, 17, 17 };
                List<string> textHeaderTable = new List<string> { "ลำดับ", "วันที่", "รายการวัตถุดิบ", "จำนวน", "ราคาต่อหน่วย", "จำนวนรวม" };
                List<double> columnWidth = new List<double> { 7, 12, 49, 11, 14, 11 };
                List<string> textFooterSummary = new List<string> { };


                List<int> textAlignLeft = new List<int> { 3 };
                List<int> textAlignRight = new List<int> { 4, 5, 6 };
                List<int> textAlignCenter = new List<int> { 1, 2 };
                var totalCols = dtx.Columns.Count;
                var totalrows = dtx.Rows.Count;


                workSheet.PrinterSettings.PaperSize = ePaperSize.A4;
                workSheet.PrinterSettings.FitToPage = true;
                workSheet.PrinterSettings.Orientation = eOrientation.Portrait;
                workSheet.PrinterSettings.TopMargin = (decimal)1.5 / 2.54M;
                workSheet.PrinterSettings.BottomMargin = (decimal).8 / 2.54M;
                workSheet.PrinterSettings.LeftMargin = (decimal).8 / 2.54M;
                workSheet.PrinterSettings.RightMargin = (decimal).8 / 2.54M;

                //init Header Report Roop Row
                for (int i = 1; i <= textHeader.Count; i++)
                {
                    if (i == 1)
                    {
                        workSheet.Row(i).Height = 23;
                        workSheet.Row(i).Style.Font.Bold = true;
                    }
                    else if (i > 1)
                    {
                        workSheet.Row(i).Height = 20;
                        workSheet.Row(i).Style.Font.Bold = false;
                    }

                    workSheet.Cells[i, 1, i, textHeaderTable.Count].Merge = true;
                    workSheet.Cells[i, 1, i, textHeaderTable.Count].Value = textHeader[i - 1];
                    workSheet.Cells[i, 1, i, textHeaderTable.Count].Style.Font.Name = "TH Sarabun New";
                    workSheet.Cells[i, 1, i, textHeaderTable.Count].Style.Font.Size = (float)fontsize[i - 1];
                    workSheet.Cells[i, 1, i, textHeaderTable.Count].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;



                }

                //init Header Report Roop Column
                for (int j = 1; j <= textHeaderTable.Count; j++)
                {

                    double charWidth = initColumnWidth(textHeaderTable[j - 1]);
                    if (charWidth > columnWidth[j - 1])
                    {

                        columnWidth.RemoveAt(j - 1);
                        columnWidth.Insert(j - 1, charWidth);
                        workSheet.Column(j).Width = charWidth;

                    }
                    else if (charWidth < columnWidth[j - 1])
                    {
                        workSheet.Column(j).Width = columnWidth[j - 1];

                    }



                    workSheet.Cells[5, j, 5, j].Value = textHeaderTable[j - 1];
                    workSheet.Cells[5, j, 5, j].Style.Font.Bold = true;
                    workSheet.Cells[5, j, 5, j].Style.Font.Name = "TH Sarabun New";
                    workSheet.Cells[5, j, 5, j].Style.Font.Size = 16;
                    workSheet.Cells[5, j, 5, j].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                    workSheet.Cells[5, j, 5, j].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;

                    workSheet.Cells[5, j, 5, j].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    workSheet.Cells[5, j, 5, j].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    workSheet.Cells[5, j, 5, j].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                    workSheet.Cells[5, j, 5, j].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;


                }

                // Binding Data
                for (int rows = 1; rows <= totalrows; rows++)
                {
                    for (int cols = 1; cols <= totalCols; cols++)
                    {

                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Font.Size = 16;

                        if (textAlignCenter.Contains(cols))
                        {
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Value = dtx.Rows[rows - 1][cols - 1].ToString();
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                        }
                        else if (textAlignLeft.Contains(cols))
                        {
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Value = dtx.Rows[rows - 1][cols - 1].ToString();
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        }
                        else if (textAlignRight.Contains(cols))
                        {
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Value = Convert.ToDecimal(dtx.Rows[rows - 1][cols - 1]);
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                            workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Numberformat.Format = "#,##0.00";
                        }

                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rows + 5, cols, rows + 5, cols].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;


                    }

                }


                // Summary Data lst Rows
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Merge = true;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Value = "รวม";
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Font.Name = "TH Sarabun New";
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Font.Size = 16;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 1, totalrows + 6, 5].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;



                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Merge = true;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Value = TotalAmnt;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Numberformat.Format = "#,##0.00";
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Font.Name = "TH Sarabun New";
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Font.Size = 16;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;


                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                workSheet.Cells[totalrows + 6, 6, totalrows + 6, 6].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;



                // init FooterSummary
                for (int rowsum = 1; rowsum <= 3; rowsum++)
                {
                    if (rowsum == 1)
                    {
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Value = "สรุป";
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Style.Font.Bold = true;
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Style.Font.UnderLine = true;
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Style.Font.Size = 18;
                        workSheet.Cells[totalrows + 6 + rowsum, 1, totalrows + 6 + rowsum, 1].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                        workSheet.Row(totalrows + rowsum + 6).Height = 18;

                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Value = "ต้นทุน Ampelflow : จำนวน " + FooterSetAmnt.ToString("0.00") + " ชุด ; เป็นจำนวน " + FooterMaterAmnt.ToString("0.00") + " เมตร";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Bold = false;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Size = 16;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                    }
                    else if (rowsum == 2)
                    {
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Value = "ต้นทุน ต่อ ชุด : เป็นจำนวนเงิน " + FooterCostperSet.ToString("0,00.00") + " บาท ";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Bold = false;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Size = 16;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                        workSheet.Row(totalrows + rowsum + 6).Height = 18;
                    }
                    else if (rowsum == 3)
                    {
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Value = "ต้นทุน ต่อ ต่อเมตร : เป็นจำนวนเงิน " + FooterCostpermater.ToString("0,00.00") + " บาท ";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Bold = false;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.Font.Size = 16;
                        workSheet.Cells[totalrows + 6 + rowsum, 2, totalrows + 6 + rowsum, 2].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                        workSheet.Row(totalrows + rowsum + 6).Height = 18;
                    }
                }





                byte[] bin = exc.GetAsByteArray();

                //clear the buffer stream
                Response.ClearHeaders();
                Response.Clear();
                Response.Buffer = true;

                //set the correct contenttype
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //set the correct length of the data being send
                Response.AddHeader("content-length", bin.Length.ToString());

                //set the filename for the excel package
                Response.AddHeader("content-disposition", "attachment; filename=\"ต้นทุนโครงการ_" + DateTime.Now.ToString("yyyy-mm-dd") + ".xlsx\"");

                //send the byte array to the browser
                Response.OutputStream.Write(bin, 0, bin.Length);

                //cleanup
                Response.Flush();
                HttpContext.Current.ApplicationInstance.CompleteRequest();

                Response.End();
            }
        }

        protected void rptAllOnPrint(object sender, EventArgs e)
        {

            string RptAllType = txtRptCostAllType.Value.ToString();
            string Reportby = Session["usr_name"].ToString();
            string Reportdate = DateTime.Now.ToString();

            if (RptAllType == "Pdf")
            {
                try
                {
                    SqlConnection conn = new SqlConnection(connString);
                    conn.Open();
                    ssql = "spReport_Action";
                    Comm = new SqlCommand(ssql, conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.Parameters.AddWithValue("@action", "rpt_ProjectAll");
                    da = new SqlDataAdapter(Comm);
                    DataTable dtx = new DataTable();
                    da.Fill(dtx);
                    conn.Close();

                    Console.WriteLine(dtx.Rows.Count);

                    rpt.Load(Server.MapPath("Reports/report_cost_allproject.rpt"));

                    ds_report_costallproject ds_Report_Costallproject = new ds_report_costallproject();
                    ds_Report_Costallproject.Merge(dtx);
                

                    rpt.SetDataSource(dtx);
                    //rpt.Subreports["subRpt_ReportProjectDetail"].Database.Tables[0].SetDataSource(dtx2); กรณี มี Subreport


                    rpt.SetParameterValue("@ReportBy", Reportby);
                    rpt.SetParameterValue("@ReportDate", Reportdate);


                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "รายงานรวมโปรเจค_" + strDate);
                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }
            }
            else if (RptAllType == "Excel")
            {
                using (SqlConnection sCon = new SqlConnection(connString))
                {



                    SqlCommand sCom = new SqlCommand("spReport_Action", sCon);

                    sCom.CommandType = CommandType.StoredProcedure;
                    sCom.Parameters.AddWithValue("@action", "rpt_ProjectAll");
                    sCom.Parameters.AddWithValue("@TypeReport", RptAllType);
                    sCom.CommandTimeout = 120;

                    da = new SqlDataAdapter(sCom);
                    dt = new DataTable();
                    da.Fill(dt);
                    Console.WriteLine(dt.Rows.Count);

                    ExcelPackage exc = new ExcelPackage();
                    var workSheet = exc.Workbook.Worksheets.Add("ยอดรวมต้นทุนรายโครงการ");
                    var totalCols = dt.Columns.Count;
                    var totalrows = dt.Rows.Count;
                    List<string> textHeader = new List<string> { "บริษัท แอมเพิลไลท์ เวิลด์", "ต้นทุนสินค้าราย JOB(ตามโครงการ)" };
                    List<float> fontsize = new List<float> { 22, 18 };
                    List<string> textHeaderTable = new List<string> { "ลำดับ", "วันที่", "ชื่อลูกค้า", "ชื่อโครงการ", "รูปแบบ", "จำนวนชุด", "ความยาว", "CostPart", "Nut,Bolts", "Sheet เสีย", "รวม", "ราคา/ชุด", "ราคา/เมตร" };
                    List<double> columnWidth = new List<double> { 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13 };
                    List<int> textAlignLeft = new List<int> { 3, 4, 5 };
                    List<int> textAlignRight = new List<int> { 6, 7, 8, 9, 10, 11, 12, 13 };
                    List<int> textAlignCenter = new List<int> { 1, 2 };


                    //Set Up Printer Setting
                    workSheet.PrinterSettings.PaperSize = ePaperSize.A4;
                    workSheet.PrinterSettings.FitToPage = true;
                    workSheet.PrinterSettings.Orientation = eOrientation.Landscape;
                    workSheet.PrinterSettings.TopMargin = (decimal)1.5 / 2.54M;
                    workSheet.PrinterSettings.BottomMargin = (decimal).8 / 2.54M;
                    workSheet.PrinterSettings.LeftMargin = (decimal).8 / 2.54M;
                    workSheet.PrinterSettings.RightMargin = (decimal).8 / 2.54M;


                    //Initial Header Report :: Loop Row
                    for (int i = 1; i <= 2; i++)
                    {
                        workSheet.Cells[i, 1, i, totalCols].Merge = true;
                        workSheet.Cells[i, 1, i, totalCols].Value = textHeader[i - 1];
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Size = (float)fontsize[i - 1];
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Bold = true;
                        workSheet.Cells[i, 1, i, totalCols].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;


                        if (i == 2)
                        {
                            workSheet.Cells[i, 1, i, totalCols].Style.Font.Bold = false;
                            workSheet.Row(i).Height = 18;
                        }
                        else if (i == 1) // 
                        {
                            workSheet.Row(i).Height = 23;
                        }



                    }
                    //Initial Header Table
                    for (int j = 1; j <= textHeaderTable.Count; j++)
                    {

                        double charWidth = initColumnWidth(textHeaderTable[j - 1]);
                        if (charWidth > columnWidth[j - 1])
                        {

                            columnWidth.RemoveAt(j - 1);
                            columnWidth.Insert(j - 1, charWidth);
                            workSheet.Column(j).Width = charWidth;

                        }
                        else if (charWidth < columnWidth[j - 1])
                        {
                            workSheet.Column(j).Width = columnWidth[j - 1];

                        }

                        workSheet.Cells[3, j, 3, totalCols].Value = textHeaderTable[j - 1];
                        workSheet.Cells[3, j, 3, totalCols].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[3, j, 3, totalCols].Style.Font.Size = 16;
                        workSheet.Cells[3, j, 3, totalCols].Style.Font.Bold = true;
                        workSheet.Cells[3, j, 3, totalCols].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                        workSheet.Cells[3, j, 3, totalCols].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                        workSheet.Row(4).Height = 18.00;




                        workSheet.Cells[3, j, 3, totalCols].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j ,  4, totalCols].Style.Border.Top.Color.SetColor(Color.Gray);
                        workSheet.Cells[3, j, 3, totalCols].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j,  4, totalCols].Style.Border.Bottom.Color.SetColor(Color.Gray);
                        workSheet.Cells[3, j, 3, totalCols].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j,  4, totalCols].Style.Border.Left.Color.SetColor(Color.Gray);
                        workSheet.Cells[3, j, 3, totalCols].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        //workSheet.Cells[4, j,  4, totalCols].Style.Border.Right.Color.SetColor(Color.Gray);
                    }

                    //Initial Data

                    for (int rows = 0; rows < totalrows; rows++)
                    {
                        for (int cols = 0; cols < totalCols; cols++)
                        {
                            double charWidth = initColumnWidth(dt.Rows[rows][cols].ToString());
                            if (charWidth > columnWidth[cols])
                            {

                                columnWidth.RemoveAt(cols);
                                columnWidth.Insert(cols, charWidth);
                                workSheet.Column(cols + 1).Width = charWidth;

                            }
                            else if (charWidth < columnWidth[cols])
                            {
                                workSheet.Column(cols + 1).Width = columnWidth[cols];

                            }


                            if (textAlignRight.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Value = Convert.ToDecimal(dt.Rows[rows][cols]);
                            }
                            else
                            {
                                workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Value = dt.Rows[rows][cols].ToString();
                            }


                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Font.Name = "TH Sarabun New";
                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Font.Size = 14;
                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;


                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;







                            if (textAlignLeft.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;


                            }
                            else if (textAlignCenter.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;

                            }
                            else if (textAlignRight.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 4, cols + 1, rows + 4, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                                workSheet.Cells[rows + 4, cols + 1].Style.Numberformat.Format = "#,##0.00";
                                //workSheet.Cells[rows + 5, cols + 1].Style.Numberformat.Format = "#,##0.00";
                            }

                        }

                    }





                    //convert the excel package to a byte array
                    byte[] bin = exc.GetAsByteArray();

                    //clear the buffer stream
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.Buffer = true;

                    //set the correct contenttype
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                    //set the correct length of the data being send
                    Response.AddHeader("content-length", bin.Length.ToString());

                    //set the filename for the excel package
                    Response.AddHeader("content-disposition", "attachment; filename=\"ต้นทุนโครงการ_" + DateTime.Now.ToString("yyyy-mm-dd") + ".xlsx\""); ;

                    //send the byte array to the browser
                    Response.OutputStream.Write(bin, 0, bin.Length);

                    //cleanup
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();

                    Response.End();

                }
            }

        }

       
        protected void rptCost_job1OnPrint(object sender, EventArgs e)
        {
            //Console.WriteLine("xx");

            string RptAllType = txtRptAllType_job1.Value.ToString();
            string Reportby = Session["usr_name"].ToString();
            string Reportdate = DateTime.Now.ToString();
            string ProjectId = txtProjId.Value.ToString();
            string ProjectNname = txtProjname.Value.ToString();

            Console.WriteLine(RptAllType);

            if (RptAllType == "Pdf")
            {
                //try
                //{
                    SqlConnection conn = new SqlConnection(connString);
                    conn.Open();
                    ssql = "spReport_Action";
                    Comm = new SqlCommand(ssql, conn);
                    Comm.CommandType = CommandType.StoredProcedure;
                    Comm.Parameters.AddWithValue("@action", "rpt_ProjectAllByprojid");
                    Comm.Parameters.AddWithValue("@projectid", ProjectId);

                    da = new SqlDataAdapter(Comm);
                    DataTable dtx = new DataTable();
                    da.Fill(dtx);
                    conn.Close();

                    Console.WriteLine(dtx.Rows.Count);

                    rpt.Load(Server.MapPath("Reports/report_cost_allproject-job1.rpt"));

                    
                    ds_report_costallproject ds_Report_Costallproject = new ds_report_costallproject();
                    ds_Report_Costallproject.Merge(dtx);


                    rpt.SetDataSource(dtx);
                   
                    rpt.SetParameterValue("@ReportBy", Reportby);
                    rpt.SetParameterValue("@ReportDate", Reportdate);
                    rpt.SetParameterValue("@projectname", ProjectNname);


                    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "รายงานรวมโปรเจค_" + strDate);
                
              
            }
            else if (RptAllType == "Excel")
            {
               //string ProjectName = "BangPlee";

                using (SqlConnection sCon = new SqlConnection(connString))
                {



                    SqlCommand sCom = new SqlCommand("spReport_Action", sCon);

                    sCom.CommandType = CommandType.StoredProcedure;
                    sCom.Parameters.AddWithValue("@action", "rpt_ProjectAllByprojid");
                    sCom.Parameters.AddWithValue("@projectid", ProjectId);
                    sCom.CommandTimeout = 120;

                    da = new SqlDataAdapter(sCom);
                    dt = new DataTable();
                    da.Fill(dt);
                    Console.WriteLine(dt.Rows.Count);

                    ExcelPackage exc = new ExcelPackage();
                    var workSheet = exc.Workbook.Worksheets.Add("ยอดรวมต้นทุนรายโครงการ");
                    var totalCols = dt.Columns.Count;
                    var totalrows = dt.Rows.Count;
                    List<string> textHeader = new List<string> { "บริษัท แอมเพิลไลท์ เวิลด์", "ต้นทุนสินค้าราย JOB(ตามโครงการ)", "ชื่อโครงการ : " + ProjectNname };
                    List<float> fontsize = new List<float> { 22, 18, 18 };
                    List<string> textHeaderTable = new List<string> { "ลำดับ", "วันที่", "ชื่อลูกค้า", "ชื่อโครงการ", "รูปแบบ", "จำนวนชุด", "ความยาว", "CostPart", "Nut,Bolts", "Sheet เสีย", "รวม", "ราคา/ชุด", "ราคา/เมตร" };
                    List<double> columnWidth = new List<double> { 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13 };
                    List<int> textAlignLeft = new List<int> { 3, 4, 5 };
                    List<int> textAlignRight = new List<int> { 6, 7, 8, 9, 10, 11, 12, 13 };
                    List<int> textAlignCenter = new List<int> { 1, 2 };


                    //Set Up Printer Setting
                    


                    workSheet.PrinterSettings.PaperSize = ePaperSize.A4;
                    workSheet.PrinterSettings.FitToPage = true;
                    workSheet.PrinterSettings.Orientation = eOrientation.Landscape;
                    workSheet.PrinterSettings.TopMargin = (decimal)1.5 / 2.54M;
                    workSheet.PrinterSettings.BottomMargin = (decimal).8 / 2.54M;
                    workSheet.PrinterSettings.LeftMargin = (decimal).8 / 2.54M;
                    workSheet.PrinterSettings.RightMargin = (decimal).8 / 2.54M;



                    //Initial Header Report :: Loop Row
                    for (int i = 1; i <= 3; i++)
                    {
                        workSheet.Cells[i, 1, i, totalCols].Merge = true;
                        workSheet.Cells[i, 1, i, totalCols].Value = textHeader[i - 1];
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Size = (float)fontsize[i - 1];
                        workSheet.Cells[i, 1, i, totalCols].Style.Font.Bold = true;
                        workSheet.Cells[i, 1, i, totalCols].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;


                        if (i == 2 || i == 3)
                        {
                            workSheet.Cells[i, 1, i, totalCols].Style.Font.Bold = false;
                            workSheet.Row(i).Height = 18;
                        }
                        else if (i == 1) // 
                        {
                            workSheet.Row(i).Height = 23;
                        }



                    }
                    //Initial Header Table
                    for (int j = 1; j <= textHeaderTable.Count; j++)
                    {

                        double charWidth = initColumnWidth(textHeaderTable[j - 1]);
                        if (charWidth > columnWidth[j - 1])
                        {

                            columnWidth.RemoveAt(j - 1);
                            columnWidth.Insert(j - 1, charWidth);
                            workSheet.Column(j).Width = charWidth;

                        }
                        else if (charWidth < columnWidth[j - 1])
                        {
                            workSheet.Column(j).Width = columnWidth[j - 1];

                        }

                        workSheet.Cells[4, j, 4, totalCols].Value = textHeaderTable[j - 1];
                        workSheet.Cells[4, j, 4, totalCols].Style.Font.Name = "TH Sarabun New";
                        workSheet.Cells[4, j, 4, totalCols].Style.Font.Size = 16;
                        workSheet.Cells[4, j, 4, totalCols].Style.Font.Bold = true;
                        workSheet.Cells[4, j, 4, totalCols].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                        workSheet.Cells[4, j, 4, totalCols].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                        workSheet.Row(4).Height = 18.00;




                        workSheet.Cells[4, j, 4, totalCols].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j ,  4, totalCols].Style.Border.Top.Color.SetColor(Color.Gray);
                        workSheet.Cells[4, j, 4, totalCols].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j,  4, totalCols].Style.Border.Bottom.Color.SetColor(Color.Gray);
                        workSheet.Cells[4, j, 4, totalCols].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        // workSheet.Cells[4, j,  4, totalCols].Style.Border.Left.Color.SetColor(Color.Gray);
                        workSheet.Cells[4, j, 4, totalCols].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        //workSheet.Cells[4, j,  4, totalCols].Style.Border.Right.Color.SetColor(Color.Gray);
                    }

                    //Initial Data

                    for (int rows = 0; rows < totalrows; rows++)
                    {
                        for (int cols = 0; cols < totalCols; cols++)
                        {
                            double charWidth = initColumnWidth(dt.Rows[rows][cols].ToString());
                            if (charWidth > columnWidth[cols])
                            {

                                columnWidth.RemoveAt(cols);
                                columnWidth.Insert(cols, charWidth);
                                workSheet.Column(cols + 1).Width = charWidth;

                            }
                            else if (charWidth < columnWidth[cols])
                            {
                                workSheet.Column(cols + 1).Width = columnWidth[cols];

                            }


                            if (textAlignRight.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Value = Convert.ToDecimal(dt.Rows[rows][cols]);
                            }
                            else
                            {
                                workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Value = dt.Rows[rows][cols].ToString();
                            }

                            // workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Value = dt.Rows[rows][cols].ToString();
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Font.Name = "TH Sarabun New";
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Font.Size = 14;
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;
                            //workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;

                            //workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Top.Color.SetColor(Color.Gray);
                            //workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Bottom.Color.SetColor(Color.Gray);
                            //workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Right.Color.SetColor(Color.Gray);
                            //workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Left.Color.SetColor(Color.Gray);


                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                            workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;







                            if (textAlignLeft.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;


                            }
                            else if (textAlignCenter.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;

                            }
                            else if (textAlignRight.Contains(cols + 1))
                            {
                                workSheet.Cells[rows + 5, cols + 1, rows + 5, cols + 1].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                                workSheet.Cells[rows + 5, cols + 1].Style.Numberformat.Format = "#,##0.00";
                                //workSheet.Cells[rows + 5, cols + 1].Style.Numberformat.Format = "#,##0.00";
                            }

                        }

                    }





                    //convert the excel package to a byte array
                    byte[] bin = exc.GetAsByteArray();

                    //clear the buffer stream
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.Buffer = true;

                    //set the correct contenttype
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                    //set the correct length of the data being send
                    Response.AddHeader("content-length", bin.Length.ToString());

                    //set the filename for the excel package
                    Response.AddHeader("content-disposition", "attachment; filename=\"ยอดรวมต้นทุนรายโครงการ_" + ProjectNname + ".xlsx\"");

                    //send the byte array to the browser
                    Response.OutputStream.Write(bin, 0, bin.Length);

                    //cleanup
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();

                    Response.End();

                }




            }
        }


        private double initColumnWidth(string data)
        {
            double countWidth = data.Length;
            return countWidth;
        }


    }
}
