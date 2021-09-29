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
    /// Summary description for srv_transaction_in
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class srv_transaction_in : System.Web.Services.WebService
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
        public void ctstInsertdata(string action, string create_by, string create_date, bool isdelete, bool isactive, int matr_flag_group
            , bool matr_status_flag, int matr_transac_type, string sys_doc_ref, string doc_date, string doc_ref, string matr_code, string supplier_code
            , double quantity, double priceperunit, double amount, string remark)
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@isdelete", isdelete);
                    comm.Parameters.AddWithValue("@isactive", isactive);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_ref", doc_ref);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
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
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }

        }

        [WebMethod]
        public void ctstUpdatedata(string action, int id, string update_by, string update_date, int matr_flag_group
            , bool matr_status_flag, int matr_transac_type, string doc_date, string doc_ref, string matr_code, string supplier_code
            , double quantity, double priceperunit, double amount, string remark)
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@id", id);
                    comm.Parameters.AddWithValue("@update_by", update_by);
                    comm.Parameters.AddWithValue("@update_date", update_date);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_ref", doc_ref);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
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
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }

        }



        [WebMethod]
        public void ctstDisplaydata(string action, int matr_flag_group)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata getc = new tstmaterialdata();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.doc_ref = rdr["doc_ref"].ToString();
                getc.vendorname = rdr["vendorname"].ToString();
                getc.goodname1 = rdr["Goodname1"].ToString();
                getc.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                getc.amount = Convert.ToDouble(rdr["amount"]);
                getc.matr_status_flag = Convert.ToBoolean(rdr["matr_status_flag"]);
                getc.remark = rdr["remark"].ToString();

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void ctstDisplaydatamd(string action, int matr_flag_group, bool matr_status_flag)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
            comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata getc = new tstmaterialdata();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.doc_ref = rdr["doc_ref"].ToString();
                getc.vendorname = rdr["vendorname"].ToString();
                getc.goodname1 = rdr["Goodname1"].ToString();
                getc.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                getc.amount = Convert.ToDouble(rdr["amount"]);
                getc.matr_status_flag = Convert.ToBoolean(rdr["matr_status_flag"]);
                getc.remark = rdr["remark"].ToString();

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void ctstDisplaybyid(string action, int matr_flag_group, int id)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata getc = new tstmaterialdata();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.doc_ref = rdr["doc_ref"].ToString();
                getc.supplier_code = rdr["supplier_code"].ToString();
                getc.matr_code = rdr["matr_code"].ToString();
                getc.vendorname = rdr["vendorname"].ToString();
                getc.goodname1 = rdr["Goodname1"].ToString();
                getc.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                getc.amount = Convert.ToDouble(rdr["amount"]);
                getc.matr_status_flag = Convert.ToBoolean(rdr["matr_status_flag"]);
                getc.remark = rdr["remark"].ToString();

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void ctstDisplaybyidmd(string action, int matr_flag_group, int id)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata getc = new tstmaterialdata();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.doc_ref = rdr["doc_ref"].ToString();
                getc.vendorname = rdr["vendorname"].ToString();
                getc.goodname1 = rdr["Goodname1"].ToString();
                getc.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                getc.amount = Convert.ToDouble(rdr["amount"]);
                getc.matr_status_flag = Convert.ToBoolean(rdr["matr_status_flag"]);
                getc.remark = rdr["remark"].ToString();

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void ctstRemovedata(string action, string update_by, string update_date, int matr_flag_group, int id)
        {
            try
            {
                List<tstGetCoildata> tstGets = new List<tstGetCoildata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transaction_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@update_by", update_by);
                    comm.Parameters.AddWithValue("@update_date", update_date);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@id", id);


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
        public void ststInsertdata(string action, string create_by, string create_date, bool isdelete
                                    , bool isactive, string lotno, string lottime, int matr_flag_group, bool matr_status_flag, int matr_transac_type, string sys_doc_ref
                                    , int ref_id
                                    , string doc_date, string doc_ref, string doc_no, string matr_code
                                    , string supplier_code, string packingno
                                    , double costservice
                                    , double quantity, double priceperunit, decimal amount
        )
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@isdelete", isdelete);
                    comm.Parameters.AddWithValue("@isactive", isactive);
                    comm.Parameters.AddWithValue("@lotno", lotno);
                    comm.Parameters.AddWithValue("@lottime", lottime);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_ref", doc_ref);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
                    comm.Parameters.AddWithValue("@packingno", packingno);
                    comm.Parameters.AddWithValue("@costservice", costservice);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amount);


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
        public void ststUpdatedata(string action, int id, string update_by, string update_date
                                    , int matr_flag_group, bool matr_status_flag, int matr_transac_type
                                    , int ref_id, string doc_date, string doc_ref, string doc_no, string matr_code
                                    , string supplier_code, string packingno, double costservice
                                    , double quantity, double priceperunit, decimal amount
        )
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@id", id);
                    comm.Parameters.AddWithValue("@update_by", update_by);
                    comm.Parameters.AddWithValue("@update_date", update_date);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);
                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_ref", doc_ref);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
                    comm.Parameters.AddWithValue("@packingno", packingno);
                    comm.Parameters.AddWithValue("@costservice", costservice);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amount);


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
        public void ststDisplaydata(string action, int matr_flag_group)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_no = rdr["doc_no"].ToString();
                gets.doc_ref = rdr["doc_ref"].ToString();
                gets.doc_date = rdr["doc_date"].ToString();
                gets.packingno = rdr["packingno"].ToString();
                gets.goodname1 = rdr["GoodName1"].ToString();
                gets.vendorname = rdr["vendorname"].ToString();
                gets.costservice = Convert.ToDouble(rdr["costservice"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.quantity = Convert.ToDouble(rdr["quantity"]);




                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void ststDisplaybyid(string action, string matr_flag_group, int id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_no = rdr["doc_no"].ToString();
                gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                gets.ref_id = Convert.ToInt32(rdr["ref_id"]);
                gets.doc_ref = rdr["doc_ref"].ToString();
                gets.doc_date = rdr["doc_date"].ToString();
                gets.packingno = rdr["packingno"].ToString();
                gets.matr_code = rdr["matr_code"].ToString();
                gets.supplier_code = rdr["supplier_code"].ToString();
                gets.goodname1 = rdr["GoodName1"].ToString();
                gets.vendorname = rdr["vendorname"].ToString();
                gets.costservice = Convert.ToDouble(rdr["costservice"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);
                gets.lotno = rdr["lotno"].ToString();
                gets.lottime = rdr["lottime"].ToString();

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }


        [WebMethod]
        public void osref_display(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.matr_code = rdr["matr_code"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.supplier_code = rdr["supplier_code"].ToString();
                gets.vendorname = rdr["VendorNamex"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);

                gets.doc_date = rdr["doc_datex"].ToString();




                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void osref_displaybyid(string action, int id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.matr_code = rdr["matr_code"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.supplier_code = rdr["supplier_code"].ToString();
                gets.vendorname = rdr["VendorNamex"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);

                gets.doc_date = rdr["doc_datex"].ToString();




                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void matr_itemdisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.matr_code = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void matr_itemdisplaybyid(string action, string id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", id);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.goodid = rdr["goodid"].ToString();
                gets.matr_code = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.partarea = Convert.ToDouble(rdr["partarea"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void oDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_no = rdr["doc_no"].ToString();
                gets.docu_date = rdr["docu_date"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                //gets.vendorname = rdr["VendorName"].ToString();
                gets.costservice = Convert.ToDouble(rdr["costservice"]);
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);
                gets.remark = rdr["remark"].ToString();






                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void oDisplaybyid(string action, int id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.docu_date = rdr["docu_datex"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.vendorname = rdr["VendorName"].ToString();
                gets.costservice = Convert.ToDouble(rdr["costservice"]);
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);
                gets.remark = rdr["remark"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void oInsert(string action, string create_by, string create_date
                            , int matr_flag_group, bool matr_status_flag, int matr_transac_type
                            , int ref_id, string sys_doc_ref, string doc_date, string doc_no, string matr_code
                            , string supplier_code, double sRef_qty, double costservice, double quantity, double priceperunit
                            , double amount, string remark, string sys_doc_sref,int transac_item_id)
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);

                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);

                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
                    comm.Parameters.AddWithValue("@sref_qty", sRef_qty);
                    comm.Parameters.AddWithValue("@costservice", costservice);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amount);
                    comm.Parameters.AddWithValue("@remark", remark);
                    comm.Parameters.AddWithValue("@sys_doc_sref", sys_doc_sref);

                    comm.Parameters.AddWithValue("@transac_item_id", transac_item_id);


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
        public void woInsert(string action, string create_by, string create_date
                            , int matr_flag_group, bool matr_status_flag, int matr_transac_type
                            , int ref_id, string sys_doc_ref, string doc_date, string doc_no, string matr_code
                            , string supplier_code, double sRef_qty, double costservice, double quantity
                            , double priceperunit, double amount, string remark, string sys_doc_sref
                            , string wmatr_goodid,decimal wirelength_amnt, decimal wirequantity,int transac_item_id)
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);

                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);

                    comm.Parameters.AddWithValue("@ref_id", ref_id);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
                    comm.Parameters.AddWithValue("@sref_qty", sRef_qty);
                    comm.Parameters.AddWithValue("@costservice", costservice);
                    comm.Parameters.AddWithValue("@quantity", quantity);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amount);
                    comm.Parameters.AddWithValue("@remark", remark);
                    comm.Parameters.AddWithValue("@sys_doc_sref", sys_doc_sref);

                    comm.Parameters.AddWithValue("@wmatr_goodid", wmatr_goodid);
                    comm.Parameters.AddWithValue("@wirequantity", wirequantity);
                    comm.Parameters.AddWithValue("@wirelength_amnt", wirelength_amnt);

                    comm.Parameters.AddWithValue("@transac_item_id", transac_item_id); 


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
        public void modal_matr_sheettransac_oDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.docu_date = rdr["doc_date"].ToString();
                gets.doc_ref = rdr["doc_ref"].ToString();
                gets.matr_code = rdr["matr_code"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.packingno = rdr["packingno"].ToString();
                gets.supplier_code = rdr["supplier_code"].ToString();
                gets.quantity = Convert.ToDouble(rdr["amount"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);








                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void modal_matr_sheettransac_oDisplaybyid(string action, int id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);
            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_ref = rdr["doc_ref"].ToString();
                gets.matr_code = rdr["matr_code"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.supplier_code = rdr["supplier_code"].ToString();
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void omatr_itemdisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.matr_code = rdr["goodid"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void omatr_itemdisplaybyid(string action, string goodid)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.matr_code = rdr["goodid"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.partarea = Convert.ToDouble(rdr["partareax"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }


        [WebMethod]
        public void omatr_itempartdisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);



            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                //gets.id = Convert.ToInt32(rdr["id"]);
                //gets.matr_code = rdr["goodid"].ToString();
                //gets.matr_goodcode = rdr["goodcode"].ToString();
                //gets.goodname1 = rdr["goodname"].ToString();
                gets.doc_date = rdr["doc_date"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.priceperunit = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void omatr_itempartdisplaybycode(string action, string refcode)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", refcode);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();

                gets.doc_date = rdr["doc_date"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.priceperunit = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void omatr_itempartrefsheet(string action)
        {
            List<cGetoptionpartTransac> tstsGets = new List<cGetoptionpartTransac>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetoptionpartTransac gets = new cGetoptionpartTransac();

                gets.id = Convert.ToInt32(rdr["id"]);
                gets.ref_id = Convert.ToInt32(rdr["ref_id"]);
                gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.doc_date = rdr["doc_date"].ToString();
                gets.goodname = rdr["goodname"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.quantity_rv = Convert.ToDouble(rdr["rvQuantity"]);
                gets.quantity_rm = Convert.ToDouble(rdr["rmQuantity"]);



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void omatr_itemdisplaybysysdoc(string action, string syscodet, int transac_id)
        {
            List<cGetoptionpartTransac> tstsGets = new List<cGetoptionpartTransac>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@syscodet", syscodet);
            comm.Parameters.AddWithValue("@transac_id", transac_id);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetoptionpartTransac gets = new cGetoptionpartTransac();

                //gets.id = Convert.ToInt32(rdr["id"]);
                gets.itempart_goodid = rdr["itempart_goodid"].ToString();
                gets.goodname = rdr["goodname"].ToString();
                gets.itempart_qty = Convert.ToDouble(rdr["itrmpart_qty"]);
                gets.quantity_rv = Convert.ToDouble(rdr["quantity_rv"]);
                gets.balance = Convert.ToDouble(rdr["balance"]);

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void omatr_itemdisplaybysyscodeandid(string action, int transac_id, string syscodet, string goodid)
        {
            List<cGetoptionpartTransac> tstsGets = new List<cGetoptionpartTransac>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@transac_id", transac_id);
            comm.Parameters.AddWithValue("@syscodet", syscodet);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetoptionpartTransac gets = new cGetoptionpartTransac();

                // gets.id = Convert.ToInt32(rdr["id"]);
                // gets.ref_id = Convert.ToInt32(rdr["ref_id"]);
                gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                gets.itempart_goodid = rdr["itempart_goodid"].ToString();
                gets.itrmpart_qty = Convert.ToDouble(rdr["itrmpart_qty"]);
                gets.goodname = rdr["goodname"].ToString();
                gets.costsheetperunit = Convert.ToDouble(rdr["costsheetperunit"]);
                gets.partarea = Convert.ToDouble(rdr["partarea"]);
                gets.quantity_rm = Convert.ToDouble(rdr["rmquantity"]);
                gets.sheetpriceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.costservice = Convert.ToDouble(rdr["costservice"]);
                gets.sheetCount = Convert.ToDouble(rdr["sheetCount"]);
                gets.araesheared = Convert.ToDouble(rdr["araesheared"]);
                gets.rmwdsheet = Convert.ToDouble(rdr["rmwdsheet"]);
                gets.partCount = Convert.ToDouble(rdr["partCount"]);
                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void GetRv_optionpart_lastid(string action)
        {
            List<cGetoptionpartTransac> tstsGets = new List<cGetoptionpartTransac>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetoptionpartTransac gets = new cGetoptionpartTransac();
                gets.rvo_lastid = rdr["sys_doc_ref"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void GetRv_coils_lastid(string action)
        {
            List<tstGetCoildata> tstsGets = new List<tstGetCoildata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstGetCoildata gets = new tstGetCoildata();
                gets.rvc_lastid = rdr["sys_doc_ref"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void GetRv_sheets_lastid(string action)
        {
            List<tstgetSheetdata> tstsGets = new List<tstgetSheetdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstgetSheetdata gets = new tstgetSheetdata();
                gets.rvs_lastid = rdr["sys_doc_ref"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void fn_selectoption_state(string action, string invno)
        {
            List<cGetmeshDatawsp> tstsGets = new List<cGetmeshDatawsp>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@doc_no", invno);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetmeshDatawsp gets = new cGetmeshDatawsp();

                gets.rowscount = Convert.ToInt32(rdr["rowscount"]);


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void omatr_meshwspitemdisplay(string action, string goodid)
        {
            List<cGetmeshDatawsp> tstsGets = new List<cGetmeshDatawsp>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetmeshDatawsp gets = new cGetmeshDatawsp();

                gets.POInvID = rdr["POInvID"].ToString();
                gets.DocuDate = rdr["DocuDate"].ToString();
                gets.GoodID = rdr["GoodID"].ToString();
                gets.GoodQty2 = Convert.ToDouble(rdr["GoodQty2"]);
                gets.GoodPrice2 = Convert.ToDouble(rdr["GoodPrice2"]);
                gets.GoodAmnt = Convert.ToDouble(rdr["GoodAmnt"]);
                gets.GoodName = rdr["GoodName"].ToString();
                gets.RefeNo = rdr["RefeNo"].ToString();
                gets.InvNO = rdr["InvNo"].ToString();
                gets.Vendoeid = rdr["VendorID"].ToString();
                gets.VendorName = rdr["VendorName"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void omatr_meshwspitemdisplaybyid(string action, string poinvid, string goodid)
        {
            List<cGetmeshDatawsp> tstsGets = new List<cGetmeshDatawsp>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@poinvid", poinvid);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetmeshDatawsp gets = new cGetmeshDatawsp();

                gets.POInvID = rdr["POInvID"].ToString();
                gets.DocuDate = rdr["DocuDate"].ToString();
                gets.GoodID = rdr["GoodID"].ToString();
                gets.GoodQty2 = Convert.ToDouble(rdr["GoodQty2"]);
                gets.GoodPrice2 = Convert.ToDouble(rdr["GoodPrice2"]);
                gets.GoodAmnt = Convert.ToDouble(rdr["GoodAmnt"]);
                gets.GoodName = rdr["GoodName"].ToString();
                gets.RefeNo = rdr["RefeNo"].ToString();
                gets.InvNO = rdr["InvNo"].ToString();
                gets.Vendoeid = rdr["VendorID"].ToString();
                gets.VendorName = rdr["VendorName"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void GetRv_mesh_lastid(string action)
        {
            List<cGetMestLastid> tstsGets = new List<cGetMestLastid>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetMestLastid gets = new cGetMestLastid();
                gets.mesh_lastid = rdr["sys_doc_ref"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void mInsert(string action, string create_by, string create_date
                            , int matr_flag_group, bool matr_status_flag, int matr_transac_type
                            , string doc_date, string doc_no, string matr_code, string sys_doc_ref
                            , string supplier_code, double quantity, double priceperunit, double amount, string remark)
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);

                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);


                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);

                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
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
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }

        }

        [WebMethod]
        public void fn_GetMeshDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();

                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_date = rdr["doc_date"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void fn_GetMeshDisplaybyid(string action, int id)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();

                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_date = rdr["doc_date"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void fn_GetODataCalc(string action, string goodid)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();

                gets.goodid = rdr["matr_goodid"].ToString();
                gets.goodname1 = rdr["matr_goodname"].ToString();
                gets.partarea = Convert.ToDouble(rdr["partarea"]);
                gets.partqty = Convert.ToDouble(rdr["partqty"]);


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void GetScrewsDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.goodid = rdr["GoodID"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname1"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void GetScrewsDisplaybyid(string action, string goodid)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.goodid = rdr["GoodID"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname1"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void scInsert(string action, string create_by, string create_date
                            , int matr_flag_group, bool matr_status_flag, int matr_transac_type
                            , string doc_date, string doc_no, string matr_code, string sys_doc_ref
                            , double quantity, double priceperunit, double amount, string remark)
        {
            try
            {
                List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);

                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);


                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@doc_no", doc_no);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);

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
                List<string> stateStr = new List<string>();
                stateStr.Add("UnSuccess");
                stateStr.Add(ex.Message.ToString());

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.ContentType = "application/json";
                Context.Response.Write(js.Serialize(stateStr));
            }

        }

        [WebMethod]
        public void fn_GetScrewsDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.id = Convert.ToInt32(rdr["id"]);
                gets.doc_date = rdr["doc_date"].ToString();
                gets.doc_no = rdr["doc_no"].ToString();
                gets.goodname1 = rdr["goodname1"].ToString();
                gets.quantity = Convert.ToDouble(rdr["quantity"]);
                gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                gets.amount = Convert.ToDouble(rdr["amount"]);


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void fn_rvPart_rowCount(string sysDoct)
        {
            List<cGet_rvPart_rowCount> _cGet = new List<cGet_rvPart_rowCount>();
            SqlCommand comm = new SqlCommand("spGet_rvPart_rowCount", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@syscodet", sysDoct);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGet_rvPart_rowCount rwCount = new cGet_rvPart_rowCount();
                rwCount.Part_RowCount = Convert.ToInt32(rdr["countRow"]);

                _cGet.Add(rwCount);
               
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(_cGet));
            conn.CloseConn();

        }

        [WebMethod]
        public void wDisplay(string action)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.goodid = rdr["goodid"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void wDisplayByid(string action,string goodid)
        {
            List<tstmaterialdata> tstsGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                tstmaterialdata gets = new tstmaterialdata();
                gets.goodid = rdr["goodid"].ToString();
                gets.matr_goodcode = rdr["goodcode"].ToString();
                gets.goodname1 = rdr["goodname"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void fn_wireCalc(string action ,string goodid,decimal wtotalQty)     
        {

            List<string> wGet = new List<string>();
            SqlCommand sCom = new SqlCommand("spmatr_transactions_action", conn.OpenConn());
            sCom.CommandType = CommandType.StoredProcedure;
            sCom.Parameters.AddWithValue("@action", action);
            sCom.Parameters.AddWithValue("@goodid", goodid);
            sCom.Parameters.AddWithValue("@wirequantity", wtotalQty);

            SqlDataReader rDr = sCom.ExecuteReader();
            while (rDr.Read())
            {
                wGet.Add(rDr["result"].ToString());
                
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(wGet));
            conn.CloseConn();

        }
    }
}
