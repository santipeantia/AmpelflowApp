using AmpelflowWeb.DBConnect;
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

namespace AmpelflowApp
{
    /// <summary>
    /// Summary description for ampelflow_master_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ampelflow_master_srv : System.Web.Services.WebService
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
        public void sync_poData()
        {
            try
            {
                using (SqlConnection cons = new SqlConnection(constr))
                {

                    List<string> status = new List<string>();
                    SqlCommand comm = new SqlCommand("spSync_pomonthly", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        status.Add(sdr["status"].ToString());
                    }

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.ContentType = "application/json";
                    Context.Response.Write(js.Serialize(status));

                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());
                
            }
        }

        [WebMethod]
        public void sync_customer_ampelflow()
        {
            try
            {
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    List<string> status = new List<string>();
                    SqlCommand comm = new SqlCommand("spSync_Customer_wsp", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        status.Add(sdr["status"].ToString());
                    }

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.ContentType = "application/json";
                    Context.Response.Write(js.Serialize(status));

                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message.ToString());

            }
        }
    }
}
