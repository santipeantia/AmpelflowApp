
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
    /// Summary description for srv_transaction_project
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class srv_transaction_project : System.Web.Services.WebService
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
        public void fn_GetCustomerAll(string action)
        {
            List<cGetCustomer> cGetCustomers = new List<cGetCustomer>();
            SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetCustomer cGetc = new cGetCustomer();
                cGetc.CustId = Convert.ToInt32(rdr["CustId"]);
                cGetc.CustCode = rdr["CustCode"].ToString();
                cGetc.CustTitle = rdr["CustTitle"].ToString();
                cGetc.CustName = rdr["CustName"].ToString();
                cGetc.CustAddr1 = rdr["CustAddr1"].ToString();
                cGetc.District = rdr["District"].ToString();
                cGetc.Amphur = rdr["Amphur"].ToString();
                cGetc.Province = rdr["Province"].ToString();
                cGetc.PostCode = rdr["PostCode"].ToString();



                cGetCustomers.Add(cGetc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGetCustomers));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetCustomerAllById(string action,string custid)
        {
            List<cGetCustomer> cGetCustomers = new List<cGetCustomer>();
            SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@CustId", custid);
            


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetCustomer cGetc = new cGetCustomer();
                cGetc.CustId = Convert.ToInt32(rdr["CustId"]);
                cGetc.CustCode = rdr["CustCode"].ToString();
                cGetc.CustTitle = rdr["CustTitle"].ToString();
                cGetc.CustName = rdr["CustName"].ToString();
                cGetc.CustAddr1 = rdr["CustAddr1"].ToString();
                cGetc.District = rdr["District"].ToString();
                cGetc.Amphur = rdr["Amphur"].ToString();
                cGetc.Province = rdr["Province"].ToString();
                cGetc.PostCode = rdr["PostCode"].ToString();



                cGetCustomers.Add(cGetc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGetCustomers));
            conn.CloseConn();
        }

        [WebMethod] 
        public void fn_SaveCustomerProj(string action
                                        , string create_by
                                        , string create_date
                                        , int CustomerID
                                        , string CustomerName
                                        , string CustomerAddress
                                        , string CustomerProjName
                                        , decimal CustomerOrderQty
                                        , decimal CustomerOrderLength
                                        , string remark
                                        , string customerprojdate
            )
        
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 30;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@CustID", CustomerID);
                    comm.Parameters.AddWithValue("@CustName", CustomerName);
                    comm.Parameters.AddWithValue("@CustAddr", CustomerAddress);
                    comm.Parameters.AddWithValue("@CustProjName", CustomerProjName);
                    comm.Parameters.AddWithValue("@CustOrderQty", CustomerOrderQty);
                    comm.Parameters.AddWithValue("@CustOrderLength", CustomerOrderLength);
                    comm.Parameters.AddWithValue("@remark", remark);
                    comm.Parameters.AddWithValue("@CustProjDate", customerprojdate);


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
        public void fn_GetCustomerProjAll(string action)
        {
            List<cGetCustomerProject> cGets = new List<cGetCustomerProject>();
            SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetCustomerProject cGet = new cGetCustomerProject();
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.customerid = rdr["CustomerID"].ToString();
                cGet.customername = rdr["CustomerName"].ToString();
                cGet.customeraddress = rdr["CustomerAddress"].ToString();
                cGet.customerprojname = rdr["CustomerProjName"].ToString();
                cGet.customerorderqty = Convert.ToDecimal(rdr["CustomerOrderQty"]);
                cGet.customerorderlegth = Convert.ToDecimal(rdr["CustomerOrderLength"]);
                cGet.customerinv = rdr["CustomerInv"].ToString();
                cGet.remark = rdr["remark"].ToString();
                cGet.customerprojdate = rdr["CustomerProjDate"].ToString();



                cGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetCustomerProjById(string action,int id)
        {
            List<cGetCustomerProject> cGets = new List<cGetCustomerProject>();
            SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetCustomerProject cGet = new cGetCustomerProject();
                cGet.id = Convert.ToInt32(rdr["id"]);
                cGet.customerid = rdr["CustomerID"].ToString();
                cGet.customername = rdr["CustomerName"].ToString();
                cGet.customeraddress = rdr["CustomerAddress"].ToString();
                cGet.customerprojname = rdr["CustomerProjName"].ToString();
                cGet.customerorderqty = Convert.ToDecimal(rdr["CustomerorderQty"]);
                cGet.customerorderlegth = Convert.ToDecimal(rdr["CustomerOrderLength"]);
                cGet.customerinv = rdr["CustomerInv"].ToString();
                cGet.remark = rdr["remark"].ToString();
                cGet.customerprojdate = rdr["CustomerProjDate"].ToString();



                cGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_RemoveCustomerProjbyId(string action, string id)
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spGet_customer_project", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 30;
                    comm.Parameters.AddWithValue("@action", action);
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
    }
}
