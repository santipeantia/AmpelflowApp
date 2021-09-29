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
    /// Summary description for srv_report_cost
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class srv_report_cost : System.Web.Services.WebService
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
        public void Getproject_display(string action)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spAmpelflow_report_actions", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.projectdate = rdr["projectdate"].ToString();
                cGet.projectname = rdr["projectname"].ToString();
                cGet.projecttype = Convert.ToInt32(rdr["projecttype"]);
                cGet.project_type_detail = rdr["project_type_detial"].ToString();


                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }
        [WebMethod]

        public void Getproject_displaybyid(string action, int id)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spAmpelflow_report_actions", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.projectdate = rdr["projectdate"].ToString();
                cGet.projectname = rdr["projectname"].ToString();
                cGet.projecttype = Convert.ToInt32(rdr["projecttype"]);
                cGet.project_type_detail = rdr["project_type_detial"].ToString();


                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }
        [WebMethod]
        public void vw_reportyproject(string action, int id)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spAmpelflow_report_actions", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.projectdate = rdr["projectdate"].ToString();
                cGet.goodname = rdr["goodname"].ToString();
                cGet.itempart_qty = Convert.ToDouble(rdr["itrmpart_qty"]);
                cGet.itempart_costsheetperunit = Convert.ToDouble(rdr["itempart_costsheetperunit"]);
                cGet.totalamnt = Convert.ToDouble(rdr["totalamnt"]);



                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GettblrptCostProject(string action,string sDate,string eDate)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spReport_Action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", "GettblrptCostProject");
            comm.Parameters.AddWithValue("@sDate", sDate);
            comm.Parameters.AddWithValue("@eDate", eDate);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                cGet.rown = Convert.ToInt32(rdr["rown"]);
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.CustName = rdr["CustName"].ToString();
                cGet.goodname = rdr["Goodname1"].ToString();
                cGet.projectname = rdr["ProjectName"].ToString();
                cGet.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                cGet.doc_date = rdr["doc_date"].ToString();
                cGet.invno = rdr["invno"].ToString();
                cGet.quantity = Convert.ToDecimal(rdr["quantity"]);
                cGet.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGet.amount = Convert.ToDecimal(rdr["amount"]);
                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GettblrptCostProjectByid(string action, string sys_doc_ref)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spReport_Action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                cGet.rown = Convert.ToInt32(rdr["rown"]);
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.CustName = rdr["CustName"].ToString();
                cGet.goodname = rdr["Goodname1"].ToString();
                cGet.projectname = rdr["ProjectName"].ToString();
                cGet.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                cGet.doc_date = rdr["doc_date"].ToString();
                cGet.quantity = Convert.ToDecimal(rdr["quantity"]);
                cGet.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGet.amount = Convert.ToDecimal(rdr["amount"]);
                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void Getrpt_ProjectAll(string action,string sDate,string eDate)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spReport_Action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sDate", sDate);
            comm.Parameters.AddWithValue("@eDate", eDate);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                //cGet.rows = rdr["rows"].ToString();
                //cGet.id = Convert.ToInt32(rdr["id"]);
                //cGet.doc_date = rdr["doc_date"].ToString();
                cGet.CustName = rdr["CustName"].ToString();
                cGet.Projectid = Convert.ToInt32(rdr["project_id"]);
                cGet.projectname = rdr["projectname"].ToString();
                cGet.project_type_detail = rdr["project_type_detial"].ToString();
                cGet.quantity = Convert.ToDecimal(rdr["quantity"]);
                cGet.quantitymeter = Convert.ToDecimal(rdr["quantitymeter"]);
                cGet.costspart = Convert.ToDecimal(rdr["costspart"]);
                cGet.costoption = Convert.ToDecimal(rdr["costoption"]);
                cGet.amount = Convert.ToDecimal(rdr["amount"]);
                cGet.swaste = Convert.ToDecimal(rdr["sWaste"]);
                cGet.costperunit = Convert.ToDecimal(rdr["costperunit"]);
                cGet.costpermeter = Convert.ToDecimal(rdr["costpermeter"]);




                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }

         [WebMethod]
        public void Getrpt_ProjectAllByprojid(string action,int projectid)
        {
            List<cGetReportData> rptGets = new List<cGetReportData>();
            SqlCommand comm = new SqlCommand("spReport_Action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@projectid", projectid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportData cGet = new cGetReportData();
                
                cGet.CustName = rdr["CustName"].ToString();
                //cGet.Projectid = Convert.ToInt32(rdr["project_id"]);
                cGet.projectname = rdr["projectname"].ToString();
                cGet.project_type_detail = rdr["project_type_detial"].ToString();
                cGet.quantity = Convert.ToDecimal(rdr["quantity"]);
                cGet.quantitymeter = Convert.ToDecimal(rdr["quantitymeter"]);
                cGet.costspart = Convert.ToDecimal(rdr["costspart"]);
                cGet.costoption = Convert.ToDecimal(rdr["costoption"]);
                cGet.amount = Convert.ToDecimal(rdr["amount"]);
                cGet.swaste = Convert.ToDecimal(rdr["sWaste"]);
                cGet.costperunit = Convert.ToDecimal(rdr["costperunit"]);
                cGet.costpermeter = Convert.ToDecimal(rdr["costpermeter"]);
                cGet.sys_doc_ref = rdr["sys_doc_ref"].ToString();




                rptGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(rptGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetProductCustDetail(string action, string sys_doc_ref)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay Gets = new cGetProductFGDisplay();
                Gets.CustName = rdr["CustName"].ToString();
                Gets.ProjectName = rdr["ProjectName"].ToString();
                Gets.quantity = Convert.ToDouble(rdr["quantity"]);
                Gets.amount = Convert.ToDouble(rdr["amount"]);
                Gets.Address = rdr["Address"].ToString();
                Gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                Gets.goodname = rdr["goodname1"].ToString();


                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }
    }
}
