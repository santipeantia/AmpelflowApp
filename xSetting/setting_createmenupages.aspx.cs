using AmpelflowWeb.DBConnect;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AmpelflowApp.xSetting
{
    public partial class setting_createmenupages : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();


        public string strTblDetail = "";



        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (Session["emp_id"] != null)
                {

                    //todo something......

                    //GetDataMenuAll();

                }
                else
                {
                    Response.Redirect("../signin.aspx");
                }
            }
            catch (Exception ex)
            {

            }
        }

       
    }
}