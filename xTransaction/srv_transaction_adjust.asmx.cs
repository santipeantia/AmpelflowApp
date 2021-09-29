using AmpelflowApp.Models;
using AmpelflowWeb.DBConnect;
using AmpelflowWeb.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace AmpelflowApp.xTransaction
{
    /// <summary>
    /// Summary description for srv_transaction_adjust
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class srv_transaction_adjust : System.Web.Services.WebService
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
        public void DisplayAdjustAll(string action)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            //aDisplay

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetAdjust = new cGetAdjustData();

                cGetAdjust.doc_no = rdr["doc_no"].ToString();
                cGetAdjust.doc_date = rdr["doc_date"].ToString();
                cGetAdjust.goodcode = rdr["goodcode"].ToString();
                cGetAdjust.goodname = rdr["goodname"].ToString();
                cGetAdjust.adjust_quantity = Convert.ToDecimal(rdr["quantity"]);
                cGetAdjust.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGetAdjust.amount = Convert.ToDecimal(rdr["amount"]);

                cGets.Add(cGetAdjust);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void tbl_DisplaySheetAdjust(string action)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetAdjust = new cGetAdjustData();

                cGetAdjust.DocDate = rdr["doc_date"].ToString();
                cGetAdjust.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                cGetAdjust.doc_no = rdr["doc_no"].ToString();
                cGetAdjust.goodid = rdr["goodid"].ToString();
                cGetAdjust.goodname = rdr["goodname"].ToString();
                cGetAdjust.squantity = Convert.ToDecimal(rdr["quantity"]);
                cGetAdjust.sRef_qty = Convert.ToDecimal(rdr["sRef_qty"]);
                cGetAdjust.rema_quantity = Convert.ToDecimal(rdr["remaining"]);


                cGets.Add(cGetAdjust);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }
        //DisplaySheetAdjustBySysCode
        [WebMethod]
        public void DisplaySheetAdjustBySysCode(string action, string sysCode)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sysCode", sysCode);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetAdjust = new cGetAdjustData();

                cGetAdjust.DocDate = rdr["doc_date"].ToString();
                cGetAdjust.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                cGetAdjust.doc_no = rdr["doc_no"].ToString();
                cGetAdjust.goodid = rdr["goodid"].ToString();
                cGetAdjust.goodname = rdr["goodname"].ToString();
                cGetAdjust.Rema_quantity = Convert.ToDecimal(rdr["remaining"]);

                cGets.Add(cGetAdjust);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void aInsert(string action, string create_by, string ref_doc, string ref_id, int transac_type, string goodid, decimal quantity)
        {
            try
            {
                List<cGetAdjustData> tstsGets = new List<cGetAdjustData>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@ref_doc", ref_doc);
                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@transac_type", transac_type);
                    comm.Parameters.AddWithValue("@goodid", goodid);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    
                    comm.ExecuteNonQuery();

                    cons.Close();
                }
                List<string> stateStr = new List<string>();
                stateStr.Add("Success");

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }
        }

        [WebMethod]
        public void aDisplay_SheetReCalc(string action,string ref_id)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@ref_id", ref_id);

            //aDisplay

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetAdjust = new cGetAdjustData();

                cGetAdjust.Rema_quantity = Convert.ToInt32(rdr["rmQuantity"]);

                cGets.Add(cGetAdjust);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetItemsAll(string action)
        {
            List<cGetMaterial_item> cGets = new List<cGetMaterial_item>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetMaterial_item cGetItems = new cGetMaterial_item();

                cGetItems.goodid = rdr["goodid"].ToString();
                cGetItems.goodname = rdr["goodname"].ToString();
                cGetItems.goodcode = rdr["goodcode"].ToString();

                cGets.Add(cGetItems);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetItemsAllById(string action,string goodid)
        {
            List<cGetMaterial_item> cGets = new List<cGetMaterial_item>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetMaterial_item cGetItems = new cGetMaterial_item();

                cGetItems.goodid = rdr["goodid"].ToString();
                cGetItems.goodname = rdr["goodname"].ToString();
                cGetItems.goodcode = rdr["goodcode"].ToString();

                cGets.Add(cGetItems);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetTransaction_list(string action, string goodid)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetItems = new cGetAdjustData();
                cGetItems.Transaction_id = Convert.ToInt32(rdr["Transaction_id"]);
                cGetItems.DocDate = rdr["doc_date"].ToString();
                cGetItems.doc_no = rdr["doc_no"].ToString();
                cGetItems.goodname = rdr["ProductName"].ToString();
                cGetItems.rv_quantity = Convert.ToDecimal(rdr["RVQuantity"]);
                cGetItems.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGetItems.wd_quantity = Convert.ToDecimal(rdr["WDQuantity"]);
                cGetItems.rema_quantity = Convert.ToDecimal(rdr["remaQty"]);


                cGets.Add(cGetItems);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetTransaction_listById(string action, int transac_id)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", transac_id);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetItems = new cGetAdjustData();
                cGetItems.Transaction_id = Convert.ToInt32(rdr["Transaction_id"]);
                cGetItems.DocDate = rdr["doc_date"].ToString();
                cGetItems.doc_no = rdr["doc_no"].ToString();
                cGetItems.goodname = rdr["ProductName"].ToString();
                cGetItems.rv_quantity = Convert.ToDecimal(rdr["RVQuantity"]);
                cGetItems.priceperunit = Convert.ToDecimal(rdr["priceperunit"]);
                cGetItems.wd_quantity = Convert.ToDecimal(rdr["WDQuantity"]);
                cGetItems.rema_quantity = Convert.ToDecimal(rdr["remaQty"]);


                cGets.Add(cGetItems);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetAdjustCode(string action)
        {
            List<cGetAdjustData> cGets = new List<cGetAdjustData>();
            SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetAdjustData cGetItems = new cGetAdjustData();
                cGetItems.adjcode = rdr["sys_doc_ref"].ToString();


                cGets.Add(cGetItems);

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Request.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_adjSvaeOut(string action,string create_by
            ,string doc_no,string doc_date,string matr_code,int ref_id
            ,int transac_type,decimal quantity,decimal priceperunit
            ,decimal amount,string remark)
        {
            try
            {
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_adjust_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@matr_transac_type", transac_type);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amount);
                    comm.Parameters.AddWithValue("@remark", remark);
                   

                    comm.ExecuteNonQuery();

                    cons.Close();
                }
                List<string> stateStr = new List<string>();
                stateStr.Add("Success");

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
                //Console.WriteLine(ex.Message);
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }
        }
    }
}
