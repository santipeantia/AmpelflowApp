using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetCustomerProject
    {
        public int id { get; set; }
        public string create_by  { get; set; }
        public string create_date { get; set; }
        public string update_by { get; set; }
        public string update_date { get; set; }
        public string customerid { get; set; }
        public string customername { get; set; }
        public string customeraddress { get; set; }
        public string customerprojname { get; set; }
        public decimal customerorderqty { get; set; }
        public decimal customerorderlegth { get; set; }
        public string customerinv { get; set; }
        public string remark { get; set; }
        public string customerprojdate { get; set; }
        public decimal remaOrderQty { get; set; }
       

        //  id
        //create_by
        //create_date
        //update_by
        //update_date
        //isdelete
        //isactive
        //CustomerID
        //CustomerName
        //CustomerAddress
        //CustomerProjName
        //CustomerOrderQty
        //CustomerOrderLength
        //CustomerInv
        //remark
    }
}