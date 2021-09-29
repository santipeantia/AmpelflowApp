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
    /// Summary description for srv_transaction_product
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class srv_transaction_product : System.Web.Services.WebService
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
        public void GetProductfg_lastid(string action)
        {
            List<cGetProductFGDisplay> tstsGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetProductFGDisplay gets = new cGetProductFGDisplay();
                gets.newSysCode_doc = rdr["sys_doc_ref"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }

        [WebMethod]
        public void Getproject_DatatowdDisplay(string action)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                getc.project_type_detail = rdr["project_type_detial"].ToString();
                getc.goodname = rdr["goodname"].ToString();
                getc.orderamnt = Convert.ToDouble(rdr["orderamnt"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                //mt.id,mt.doc_date,mt.sys_doc_ref,mo.project_type_detial,mi.goodname,mt.orderamnt,mt.quantity

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void Getproject_DatatowdDisplayByid(string action, int id)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.doc_date = rdr["doc_date"].ToString();
                getc.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                getc.project_type_detail = rdr["project_type_detial"].ToString();
                getc.goodname = rdr["goodname"].ToString();
                getc.orderamnt = Convert.ToDouble(rdr["orderamnt"]);
                getc.quantity = Convert.ToDouble(rdr["quantity"]);
                //mt.id,mt.doc_date,mt.sys_doc_ref,mo.project_type_detial,mi.goodname,mt.orderamnt,mt.quantity

                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void tbl_iteminproductByDocref(string action, string sys_doc_ref)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.id = Convert.ToInt32(rdr["id"]);
                getc.sys_doc_ref = rdr["matr_transaction_code"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.goodname = rdr["goodname"].ToString();
                getc.quantity = Convert.ToDouble(rdr["itrmpart_qty"]);


                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnGetDetailfgDisplay(string action)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.goodname = rdr["goodname"].ToString();




                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnGetDetailfgDisplayByid(string action, string goodid)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.goodname = rdr["goodname"].ToString();




                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnGet_Insertitempart_wdforfg(//string doc_no,string create_by,string create_date,string doc_date,int id
                                                    string create_by, string create_date,
                                                    string doc_date, string sys_doc_ref, string v7id, string v3id,
                                                    decimal orderset, int projecttype, string fg_goodid,int txtprojid, string txtproj_name, 
                                                    string txtfg_remark, string custid , string sheetid ,decimal sheetqty ,string invno
                                                )
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spInsertitempart_wd_check", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 120;
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@v7id", v7id);
                    comm.Parameters.AddWithValue("@v3id", v3id);
                    comm.Parameters.AddWithValue("@orderset", orderset);
                    comm.Parameters.AddWithValue("@projecttype", projecttype);
                    comm.Parameters.AddWithValue("@fg_goodid", fg_goodid);
                    comm.Parameters.AddWithValue("@txtprojid", txtprojid);
                    comm.Parameters.AddWithValue("@txtproj_name", txtproj_name);
                    comm.Parameters.AddWithValue("@txtfg_remark", txtfg_remark);
                    comm.Parameters.AddWithValue("@custid", custid);
                    comm.Parameters.AddWithValue("@sheetid", sheetid);
                    comm.Parameters.AddWithValue("@sheetqty", sheetqty);
                    comm.Parameters.AddWithValue("@invno", invno);

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
        public void fgGet_material(string action)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.goodname = rdr["goodname1"].ToString();
                getc.quantity = Convert.ToDouble(rdr["totalQty"]);


                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fgGet_materialByid(string action, string goodid)
        {
            List<cGetProductFGDisplay> tstGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());

            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProductFGDisplay getc = new cGetProductFGDisplay();
                getc.goodid = rdr["goodid"].ToString();
                getc.goodcode = rdr["goodcode"].ToString();
                getc.goodname = rdr["goodname1"].ToString();
                getc.quantity = Convert.ToDouble(rdr["totalQty"]);


                tstGets.Add(getc);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnGet_Insertitempartoption(string action, string create_by, string create_date
                                               , string ref_no, string goodid, decimal goodqty)

        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("fnGet_Insertitempartoption", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 30;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@ref_no", ref_no);
                    comm.Parameters.AddWithValue("@goodid", goodid);
                    comm.Parameters.AddWithValue("@goodqty", goodqty);



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
        //[WebMethod]
        //public void fnGetCustomerDisplay(string action, string provincename)
        //{
        //    List<cGetCustomer> cGetCustomers = new List<cGetCustomer>();
        //    SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
        //    comm.CommandType = CommandType.StoredProcedure;
        //    comm.Parameters.AddWithValue("@action", action);
        //    comm.Parameters.AddWithValue("@provincename", provincename);


        //    SqlDataReader rdr = comm.ExecuteReader();
        //    while (rdr.Read())
        //    {
        //        cGetCustomer cGetc = new cGetCustomer();
        //        cGetc.CustId = Convert.ToInt32(rdr["CustId"]);
        //        cGetc.CustCode = rdr["CustCode"].ToString();
        //        cGetc.CustTitle = rdr["CustTitle"].ToString();
        //        cGetc.CustName = rdr["CustName"].ToString();
        //        cGetc.CustAddr1 = rdr["CustAddr1"].ToString();
        //        cGetc.District = rdr["District"].ToString();
        //        cGetc.Amphur = rdr["Amphur"].ToString();
        //        cGetc.Province = rdr["Province"].ToString();
        //        cGetc.PostCode = rdr["PostCode"].ToString();



        //        cGetCustomers.Add(cGetc);
        //    }
        //    JavaScriptSerializer js = new JavaScriptSerializer();
        //    Context.Response.ContentType = "application/json";
        //    Context.Response.Write(js.Serialize(cGetCustomers));
        //    conn.CloseConn();
        //}
        [WebMethod]
        public void fnGetCustomerAll(string action)
        {
            List<cGetCustomer> cGetCustomers = new List<cGetCustomer>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
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
        public void fnGetCustomerDisplayById(string action, string CustId)
        {
            List<cGetCustomer> cGetCustomers = new List<cGetCustomer>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@CustId", CustId);


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
        public void fnGetCustomerProvice(string action)
        {
            List<cGetCustomerprovince> cGetCustomerprovinces = new List<cGetCustomerprovince>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetCustomerprovince cGetp = new cGetCustomerprovince();
                cGetp.id = Convert.ToInt32(rdr["id"]);
                cGetp.province_eng = rdr["province_eng"].ToString();
                cGetp.province_th = rdr["province_th"].ToString();


                cGetCustomerprovinces.Add(cGetp);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGetCustomerprovinces));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_v3selectedDisplay(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.goodid = rdr["goodid"].ToString();
                Gets.matr_code = rdr["goodcode"].ToString();
                Gets.matr_goodname = rdr["goodname"].ToString();
                Gets.v3remain = Convert.ToDecimal(rdr["v3remain"]);

                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_v3selectedDisplayByid(string action, string goodid)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.goodid = rdr["goodid"].ToString();
                Gets.matr_code = rdr["goodcode"].ToString();
                Gets.matr_goodname = rdr["goodname"].ToString();

                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }


        [WebMethod]
        public void GetProductDisplay(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.id = Convert.ToInt32(rdr["id"]);
                Gets.doc_date = rdr["doc_date"].ToString();
                Gets.CustName = rdr["CustName"].ToString();
                Gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                Gets.projectname = rdr["projectname"].ToString();
                Gets.matr_goodname = rdr["GoodName1"].ToString();
                Gets.quantity = Convert.ToDouble(rdr["quantity"]);
                Gets.materquantity = Convert.ToDecimal(rdr["mater-quantity"]);
                Gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                Gets.amount = Convert.ToDouble(rdr["amount"]);


                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
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


        [WebMethod]
        public void GetProductDisplayById(string action, string sys_doc_ref)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.id = Convert.ToInt32(rdr["id"]);
                Gets.matr_code = rdr["matr_code"].ToString();
                Gets.matr_goodname = rdr["GoodName1"].ToString();
                Gets.quantity = Convert.ToDouble(rdr["quantity"]);
                Gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                Gets.amount = Convert.ToDouble(rdr["amount"]);


                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetitemofprojecteditById(string action, int id, string sys_doc_ref, string goodid)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
            comm.Parameters.AddWithValue("@goodid", goodid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.id = Convert.ToInt32(rdr["id"]);
                Gets.matr_code = rdr["matr_code"].ToString();
                Gets.goodcode = rdr["goodcode"].ToString();
                Gets.matr_goodname = rdr["GoodName1"].ToString();
                Gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                Gets.quantity = Convert.ToDouble(rdr["quantity"]);
                Gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                Gets.amount = Convert.ToDouble(rdr["amount"]);


                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetUpdateitemofproject(string action, string sys_doc_ref, string goodid, int id, decimal quantity, decimal amount)
        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 30;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@goodid", goodid);
                    comm.Parameters.AddWithValue("@id", id);
                    comm.Parameters.AddWithValue("@quantity", quantity);
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

        //GetProductWdfg_lastid
        [WebMethod]
        public void GetProductWdfg_lastid(string action)
        {
            List<cGetProductFGDisplay> tstsGets = new List<cGetProductFGDisplay>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetProductFGDisplay gets = new cGetProductFGDisplay();
                gets.newSysCode_doc = rdr["sys_doc_ref"].ToString();


                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void GetProductWdfg_trasacwsp(string action)
        {
            List<cGetProduct_payout> tstsGets = new List<cGetProduct_payout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetProduct_payout gets = new cGetProduct_payout();
                gets.GoodID = rdr["goodID"].ToString();
                gets.GoodName1 = rdr["GoodName1"].ToString();
                gets.CustName = rdr["CustName"].ToString();
                gets.DocuDate = rdr["DocuDatex"].ToString();
                gets.Docuno = rdr["DocuNo"].ToString();
                gets.Remark = rdr["remark"].ToString();
                gets.PayQty = Convert.ToDecimal(rdr["PayQty"]);
                gets.PayCost = Convert.ToDecimal(rdr["PayCost"]);
                gets.PayAmnt = Convert.ToDecimal(rdr["PayAmnt"]);
                gets.custid = rdr["CustID"].ToString();



                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();

        }
        [WebMethod]
        public void GetProductWdfg_trasacwspbyid(string action, string docuno)
        {
            List<cGetProduct_payout> tstsGets = new List<cGetProduct_payout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@docuno", docuno);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetProduct_payout gets = new cGetProduct_payout();
                gets.GoodID = rdr["goodID"].ToString();
                gets.GoodName1 = rdr["GoodName1"].ToString();
                gets.CustName = rdr["CustName"].ToString();
                gets.DocuDate = rdr["DocuDatex"].ToString();
                gets.Docuno = rdr["DocuNo"].ToString();
                gets.Remark = rdr["remark"].ToString();
                gets.PayQty = Convert.ToDecimal(rdr["PayQty"]);
                gets.PayCost = Convert.ToDecimal(rdr["PayCost"]);
                gets.PayAmnt = Convert.ToDecimal(rdr["PayAmnt"]);
                gets.custid = rdr["CustID"].ToString();

                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnInsertProductPayOut(string action, string create_by, string create_date, string doc_date
                                               , string sys_doc_ref, string custid, string projname, string doc_no
                                               , string goodid, decimal qty
                                               , decimal priceperunit, decimal amnt
                                               , string remark,string invno
            )

        {
            try
            {
                List<tstmaterialdata> tstmatr = new List<tstmaterialdata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 30;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@custId", custid);
                    comm.Parameters.AddWithValue("@projectname", projname);
                    comm.Parameters.AddWithValue("@docuno", doc_no);
                    comm.Parameters.AddWithValue("@goodid", goodid);
                    comm.Parameters.AddWithValue("@quantity", qty);
                    comm.Parameters.AddWithValue("@priceperunit", priceperunit);
                    comm.Parameters.AddWithValue("@amount", amnt);
                    comm.Parameters.AddWithValue("@remark", remark);
                    comm.Parameters.AddWithValue("@invno", invno);


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
        public void check_fnInsertProductPayOut(string action, string goodid)
        {
            List<cGetProduct_payout> tstsGets = new List<cGetProduct_payout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);


            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {

                cGetProduct_payout gets = new cGetProduct_payout();
                gets.GoodID = rdr["goodID"].ToString();
                gets.PayQty = Convert.ToDecimal(rdr["quantityx"]);
                tstsGets.Add(gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstsGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetProductSheetAdd(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.goodid = rdr["goodid"].ToString();
                Gets.goodcode = rdr["goodcode"].ToString();
                Gets.goodname = rdr["goodname"].ToString();
                Gets.sheetremain = Convert.ToDecimal(rdr["sheetremain"]);



                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetProductSheetAddById(string action,string goodid)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@goodid", goodid);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.goodid = rdr["goodid"].ToString();
                Gets.goodcode = rdr["goodcode"].ToString();
                Gets.goodname = rdr["goodname"].ToString();
                Gets.sheetremain = Convert.ToDecimal(rdr["sheetremain"]);



                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }


        [WebMethod]
        public void fnGetProductWdDisplay(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout Gets = new tstmatrtransacout();
                Gets.id = Convert.ToInt32(rdr["id"]);
                Gets.doc_date = rdr["doc_date"].ToString();
                Gets.CustName = rdr["CustName"].ToString();
                Gets.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                Gets.projectname = rdr["projectname"].ToString();
                Gets.matr_goodname = rdr["GoodName1"].ToString();
                Gets.quantity = Convert.ToDouble(rdr["quantity"]);
                Gets.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                Gets.amount = Convert.ToDouble(rdr["amount"]);


                tstGets.Add(Gets);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }
        [WebMethod]
        public void fnGetInvDisplay(string action)
        {
            List<cGetProduct_payout> Gets = new List<cGetProduct_payout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProduct_payout cGetProduct = new cGetProduct_payout();
                cGetProduct.DocuID = rdr["DocuID"].ToString();
                cGetProduct.DocuDate = rdr["DocuDate"].ToString();
                cGetProduct.Docuno = rdr["Docuno"].ToString();
                cGetProduct.GoodID = rdr["Goodid"].ToString();
                cGetProduct.PayQty = Convert.ToDecimal(rdr["PayQty"]);
                cGetProduct.PayCost = Convert.ToDecimal(rdr["PayCost"]);
                cGetProduct.PayAmnt = Convert.ToDecimal(rdr["PayAmnt"]);


                Gets.Add(cGetProduct);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(Gets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fnGetInvDisplayById(string action,string id)
        {
            List<cGetProduct_payout> cGets = new List<cGetProduct_payout>();
            SqlCommand comm = new SqlCommand("spGetproductfg_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetProduct_payout cGetProduct = new cGetProduct_payout();
                cGetProduct.DocuID = rdr["DocuID"].ToString();
                cGetProduct.DocuDate = rdr["DocuDate"].ToString();
                cGetProduct.Docuno = rdr["Docuno"].ToString();
                cGetProduct.GoodID = rdr["Goodid"].ToString();
                cGetProduct.PayQty = Convert.ToDecimal(rdr["PayQty"]);
                cGetProduct.PayCost = Convert.ToDecimal(rdr["PayCost"]);
                cGetProduct.PayAmnt = Convert.ToDecimal(rdr["PayAmnt"]);


                cGets.Add(cGetProduct);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_GetCustomerProjAll_remaOrder(string action)
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
                cGet.remaOrderQty = Convert.ToDecimal(rdr["rema_orderqty"]);



                cGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }



    }
}
