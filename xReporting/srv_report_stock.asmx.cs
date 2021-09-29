using AmpelflowApp.Models;
using AmpelflowWeb.DBConnect;
using AmpelflowWeb.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace AmpelflowApp.xReporting
{
    /// <summary>
    /// Summary description for srv_report_stock
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class srv_report_stock : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();
        string ssql;
        string constr = ConfigurationManager.ConnectionStrings[dbConnect.ServNameDb].ToString();

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public void Display_GetMaterial_Item(string action)
        {
            List<cGetMaterial_item> _Items = new List<cGetMaterial_item>();
            SqlCommand comm = new SqlCommand("spStock_Action_Detail", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetMaterial_item getc = new cGetMaterial_item();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodname = rdr["goodname"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.strCheckbox = rdr["strCheckbox"].ToString();


                _Items.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(_Items));
            conn.CloseConn();
        }

        [WebMethod]
        public void Display_GetMaterial_ItemById(string action, string goodid) //1check
        {
            List<cGetMaterial_item> _Items = new List<cGetMaterial_item>();
            SqlCommand comm = new SqlCommand("spStock_Action_Detail", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", goodid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetMaterial_item getc = new cGetMaterial_item();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodname = rdr["goodname"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();

                _Items.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(_Items));
            conn.CloseConn();
        }

        [WebMethod]
        public void Getitemlist(string action, string allitems) //1check
        {
            List<cGetMaterial_item> _Items = new List<cGetMaterial_item>();
            SqlCommand comm = new SqlCommand("spReport_Action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@allitems", allitems);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetMaterial_item getc = new cGetMaterial_item();
                getc.allteims = rdr["allteims"].ToString();

                _Items.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(_Items));
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetView_rptStockNet(string eDate1, string allitems) //1check
        {
            List<cGetReportData> cGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spReport_StockNet", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@eDate", eDate1);
            comm.Parameters.AddWithValue("@allitems", allitems);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGetReport = new cGetReportData();

                cGetReport.docu_no = rdr["doc_no"].ToString();
                cGetReport.doc_date = rdr["doc_date"].ToString();
                cGetReport.projectname = rdr["ProductName"].ToString();
                cGetReport.vendorname = rdr["vendorname"].ToString();
                cGetReport.RVQuantity = Convert.ToDecimal(rdr["RVQuantity"]);
                cGetReport.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGetReport.WDQuantity = Convert.ToDecimal(rdr["WDQuantity"]);
                cGetReport.remark_transac = rdr["remark_transac_action"].ToString();
                cGetReport.remaQty = Convert.ToDecimal(rdr["remaQty"]);
                cGetReport.CostTotal = Convert.ToDecimal(rdr["CostTotal"]);




                cGets.Add(cGetReport);


            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetView_StockMovement(string sDate1x, string eDate1x ,string items) //1check
        {
            List<cGetReportMovement> cGets = new List<cGetReportMovement>();
            SqlCommand comm = new SqlCommand("spReport_StockMovemrnt", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", "rptStockDisplay");
            comm.Parameters.AddWithValue("@sDate",sDate1x);
            comm.Parameters.AddWithValue("@eDate", eDate1x);
            comm.Parameters.AddWithValue("@items", items);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                
                cGetReportMovement cGetReport = new cGetReportMovement();
                cGetReport.doc_date = rdr["doc_date"].ToString();
                cGetReport.doc_no = rdr["doc_no"].ToString();
                cGetReport.remarkx = rdr["remarkx"].ToString();
                cGetReport.rv_quantity = Convert.ToDecimal(rdr["rv_quantity"]);
                cGetReport.rv_priceperunit = Convert.ToDecimal(rdr["rv_priceperunit"]);
                cGetReport.rv_amount = Convert.ToDecimal(rdr["rv_amount"]);
                cGetReport.wd_quantity = Convert.ToDecimal(rdr["wd_quantity"]);
                cGetReport.wd_priceperunit = Convert.ToDecimal(rdr["wd_priceperunit"]);
                cGetReport.wd_amount = Convert.ToDecimal(rdr["wd_amount"]);
                cGetReport.rema_quantity = Convert.ToDecimal(rdr["rema_quantity"]);
                cGetReport.rema_pricperunit = Convert.ToDecimal(rdr["rema_priceperunit"]);
                cGetReport.rema_amount = Convert.ToDecimal(rdr["rema_amount"]);


                cGets.Add(cGetReport);


            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }


    }
}
