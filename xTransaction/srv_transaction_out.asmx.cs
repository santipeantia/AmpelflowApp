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
    /// Summary description for srv_transaction_out
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class srv_transaction_out : System.Web.Services.WebService
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
        public void tstgetmatrofprject(string action, int id)
        {
            List<tstgetmatrofproject> tstGets = new List<tstgetmatrofproject>();
            SqlCommand comm = new SqlCommand("spmatr_ofproject_action", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstgetmatrofproject getp = new tstgetmatrofproject();
                getp.id = Convert.ToInt32(rdr["id"]);
                getp.isdelete = Convert.ToBoolean(rdr["isdelete"]);
                getp.isactive = Convert.ToBoolean(rdr["isactive"]);
                getp.pcsperset = Convert.ToInt32(rdr["pcsperset"]);
                getp.project_type_detail = rdr["project_type_detial"].ToString();
                getp.remark = rdr["remark"].ToString();


                tstGets.Add(getp);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }



        [WebMethod]
        public void display_tblsheetforpaymd(string action, int matr_flag_group)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                //tstget = new tstgetmatrofproject();
                tstmaterialdata getmatr = new tstmaterialdata();
                getmatr.id = Convert.ToInt32(rdr["id"]);
                getmatr.lotno = rdr["lotno"].ToString();
                getmatr.lotcode = rdr["lotcode"].ToString();
                getmatr.goodname1 = rdr["goodname"].ToString();
                getmatr.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getmatr.quantity = Convert.ToDouble(rdr["quantity"]);
                getmatr.qty_payout = Convert.ToDouble(rdr["qty_payout"]);
                getmatr.remain = Convert.ToDouble(rdr["remain"]);



                tstGets.Add(getmatr);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void tstInsertprojectdata(string action, string create_by, string create_date, string isdelete, string isactive
                                    , string projectdate, string projectname, int projecttype, double projectset, string remark)
        {
            try
            {
                List<tstprojectactiondata> tstsGets = new List<tstprojectactiondata>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@isdelete", isdelete);
                    comm.Parameters.AddWithValue("@isactive", isactive);
                    comm.Parameters.AddWithValue("@projectdate", projectdate);
                    comm.Parameters.AddWithValue("@projectname", projectname);
                    comm.Parameters.AddWithValue("@projecttype", projecttype);
                    comm.Parameters.AddWithValue("@projectset", projectset);
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
        public void displayprojectmd(string action)
        {
            List<tstprojectactiondata> tstGets = new List<tstprojectactiondata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstprojectactiondata proj = new tstprojectactiondata();
                proj.id = Convert.ToInt32(rdr["id"]);
                proj.projectname = rdr["projectname"].ToString();
                proj.projectset = Convert.ToDouble(rdr["projectset"]);
                proj.projectdate = rdr["projectdate"].ToString();
                proj.project_type_detail = rdr["project_type_detial"].ToString();


                tstGets.Add(proj);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void displayprojectcbb(string action)
        {
            List<tstprojectactiondata> tstGets = new List<tstprojectactiondata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstprojectactiondata proj = new tstprojectactiondata();
                proj.id = Convert.ToInt32(rdr["id"]);
                proj.projectname = rdr["projectname"].ToString();

                tstGets.Add(proj);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void display_tbl_matr_forpay(string action, string isdelete, string isactive, string matr_transac_type)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@isdelete", isdelete);
            comm.Parameters.AddWithValue("@isactive", isactive);
            comm.Parameters.AddWithValue("@matr_transac_type", matr_transac_type);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                // mt.id,mt.doc_date,ap.projectname,mo.project_type_detial,mi.goodname,mt.priceperunit,mt.quantity,mt.amount

                tstmatrtransacout mout = new tstmatrtransacout();
                //mout.id = Convert.ToInt32(rdr["id"]);
                mout.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                
                mout.sstatus = Convert.ToInt32(rdr["matr_status_flag"]);
                mout.doc_date = rdr["doc_date"].ToString();
                mout.projecttype_name = rdr["project_type_detial"].ToString();
                mout.matr_goodname = rdr["goodname"].ToString();
                mout.priceperunitx = rdr["priceperunit"].ToString();
                mout.remaquantity = Convert.ToDouble(rdr["remaining"]);
                mout.quantity = Convert.ToDouble(rdr["quantity"]);
                mout.rvquanity = Convert.ToDouble(rdr["rv-quantity"]);
                mout.amount = Convert.ToDouble(rdr["amount"]);
                mout.remark = rdr["remark"].ToString();

                tstGets.Add(mout);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void Display_Sheet_forpayById(string action, string sys_doc_ref)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
           

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                // mt.id,mt.doc_date,ap.projectname,mo.project_type_detial,mi.goodname,mt.priceperunit,mt.quantity,mt.amount

                tstmatrtransacout mout = new tstmatrtransacout();
                mout.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                mout.doc_date = rdr["doc_date"].ToString();
                mout.matr_code = rdr["matr_code"].ToString();
                mout.matr_goodname = rdr["goodname1"].ToString();
                mout.projecttype_id = Convert.ToInt32(rdr["matr_projtype"]);
                mout.supplier_code = rdr["supplier_code"].ToString();
                mout.v3code = rdr["v3code"].ToString();
                mout.v3name = rdr["v3name"].ToString();
                mout.v7code = rdr["v7code"].ToString();
                mout.doc_no = rdr["doc_no"].ToString();
                mout.orderamnt = Convert.ToDouble(rdr["orderamnt"]);
                mout.quantity = Convert.ToDouble(rdr["quantity"]);
                mout.amount = Convert.ToDouble(rdr["amount"]);
                mout.remark = rdr["remark"].ToString();




                tstGets.Add(mout);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void Display_tblSheet_forpayById(string action,string sysDoct)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@sys_doc_ref", sysDoct);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                // mt.id,mt.doc_date,ap.projectname,mo.project_type_detial,mi.goodname,mt.priceperunit,mt.quantity,mt.amount

                tstmatrtransacout mout = new tstmatrtransacout();
                //mout.id = Convert.ToInt32(rdr["id"]);
                mout.sys_doc_ref = rdr["sys_doc_ref"].ToString();
                mout.doc_no = rdr["doc_no"].ToString();
                mout.sstatus = Convert.ToInt32(rdr["matr_status_flag"]);
                mout.doc_date = rdr["doc_date"].ToString();
                mout.projecttype_name = rdr["project_type_detial"].ToString();
                mout.matr_goodname = rdr["goodname"].ToString();
                mout.priceperunitx = rdr["priceperunit"].ToString();
                mout.rvquanity = Convert.ToDouble(rdr["sRef_qty"]);
                mout.orderamnt = Convert.ToDouble(rdr["orderamnt"]);
                mout.remaquantity = Convert.ToDouble(rdr["remaining"]);
                mout.quantity = Convert.ToDouble(rdr["quantity"]);
                mout.amount = Convert.ToDouble(rdr["amount"]);
                mout.remark = rdr["remark"].ToString();

                tstGets.Add(mout);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }
        [WebMethod]
        public void insertsheet_matr_forout(string action, string create_by, string create_date, string isdelete, string isactive
                                            , string sys_doc_ref, string docu_no
                                            , int matr_flag_group, string matr_status_flag, int matr_transactype
                                            , string doc_date, string matr_code, string supplier_code, double quantity
                                            , int projecttype, double orderset, double sheetofproject, string v3id, string v7InClude
                                            , string remark
                                            )
        {
            try
            {
                List<tstmatrtransacout> tstsGets = new List<tstmatrtransacout>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@create_by", create_by);
                    comm.Parameters.AddWithValue("@create_date", create_date);
                    comm.Parameters.AddWithValue("@isdelete", isdelete);
                    comm.Parameters.AddWithValue("@isactive", isactive);


                    comm.Parameters.AddWithValue("@sys_doc_ref", sys_doc_ref);
                    comm.Parameters.AddWithValue("@docu_no", docu_no);
                    comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
                    comm.Parameters.AddWithValue("@matr_status_flag", matr_status_flag);
                    comm.Parameters.AddWithValue("@matr_transac_type", matr_transactype);
                    //comm.Parameters.AddWithValue("@project_id", project_id);

                    comm.Parameters.AddWithValue("@doc_date", doc_date);
                    comm.Parameters.AddWithValue("@matr_code", matr_code);
                    comm.Parameters.AddWithValue("@supplier_code", supplier_code);
                    comm.Parameters.AddWithValue("@quantity", quantity);

                    comm.Parameters.AddWithValue("@projecttype", projecttype);
                    comm.Parameters.AddWithValue("@orderamnt", orderset);
                    comm.Parameters.AddWithValue("@sheetofproject", sheetofproject);
                    comm.Parameters.AddWithValue("@v3id", v3id);
                    comm.Parameters.AddWithValue("@v7InClude", v7InClude);
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
        public void display_tblsheetforpaymdbyid(string action, string matr_flag_group)
        {
            List<tstmaterialdata> tstGets = new List<tstmaterialdata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@matr_flag_group", matr_flag_group);
            //comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                //tstget = new tstgetmatrofproject();
                tstmaterialdata getmatr = new tstmaterialdata();
                getmatr.id = Convert.ToInt32(rdr["id"]);
                getmatr.lotno = rdr["lotno"].ToString();
                getmatr.lotcode = rdr["lotcode"].ToString();
                getmatr.goodname1 = rdr["goodname"].ToString();
                getmatr.priceperunit = Convert.ToDouble(rdr["priceperunit"]);
                getmatr.quantity = Convert.ToDouble(rdr["quantity"]);
                getmatr.qty_payout = Convert.ToDouble(rdr["qty_payout"]);
                getmatr.remain = Convert.ToDouble(rdr["remain"]);



                tstGets.Add(getmatr);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void modal_ampelflow_proj(string action)
        {
            List<tstprojectactiondata> tstGets = new List<tstprojectactiondata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstprojectactiondata proj = new tstprojectactiondata();
                proj.id = Convert.ToInt32(rdr["id"]);
                proj.projectname = rdr["projectname"].ToString();
                proj.projectset = Convert.ToDouble(rdr["projectset"]);
                proj.projectdate = rdr["projectdate"].ToString();
                proj.project_type_detail = rdr["project_type_detial"].ToString();
                proj.sheetperset = Convert.ToDouble(rdr["sheetperset"]);

                tstGets.Add(proj);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void display_projecttypeamntbyid(string action, int id)
        {
            List<tstprojecttypedata> tstGets = new List<tstprojecttypedata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstprojecttypedata proj = new tstprojecttypedata();
                proj.id = Convert.ToInt32(rdr["id"]);
                proj.project_type_detail = rdr["project_type_detial"].ToString();
                proj.pcsperset = Convert.ToDouble(rdr["pcsperset"]);

                tstGets.Add(proj);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void modal_ampelflow_projbyid(string action, int id)
        {
            List<tstprojectactiondata> tstGets = new List<tstprojectactiondata>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);
            comm.Parameters.AddWithValue("@id", id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstprojectactiondata proj = new tstprojectactiondata();
                proj.id = Convert.ToInt32(rdr["id"]);
                proj.projectname = rdr["projectname"].ToString();
                proj.projectset = Convert.ToDouble(rdr["projectset"]);
                proj.projectdate = rdr["projectdate"].ToString();
                proj.project_type_detail = rdr["project_type_detial"].ToString();
                proj.sheetperset = Convert.ToDouble(rdr["sheetperset"]);

                tstGets.Add(proj);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void Getwithdraw_lastid(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout tstgetidout = new tstmatrtransacout();
                tstgetidout.lastid = rdr["sys_doc_ref"].ToString();

                tstGets.Add(tstgetidout);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSheet_Ramain_forcheck(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                tstmatrtransacout tstgetidout = new tstmatrtransacout();
                tstgetidout.sRemain = Convert.ToDouble(rdr["sRemain"]);

                tstGets.Add(tstgetidout);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(tstGets));
            conn.CloseConn();
        }

        [WebMethod]
        public void fn_v3selectedDisplay(string action)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@action", action);

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
        public void fn_v3selectedDisplaybyid(string action, string goodid)
        {
            List<tstmatrtransacout> tstGets = new List<tstmatrtransacout>();
            SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
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
        public void update_matr_forout(string action,string SysDoct,string Remark,string update_by,string update_date)
        {
            try
            {
                List<tstmatrtransacout> tstsGets = new List<tstmatrtransacout>();
                using (SqlConnection cons = new SqlConnection(constr))
                {
                    cons.Open();
                    SqlCommand comm = new SqlCommand("spmatr_transaction_pay", conn.OpenConn());
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@action", action);
                    comm.Parameters.AddWithValue("@sys_doc_ref", SysDoct);
                    comm.Parameters.AddWithValue("@remark", Remark);
                    comm.Parameters.AddWithValue("@create_by", update_by);
                    comm.Parameters.AddWithValue("@create_date", update_date);
                    
                    
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



                cGets.Add(cGet);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(cGets));
            conn.CloseConn();
        }

    }
}

