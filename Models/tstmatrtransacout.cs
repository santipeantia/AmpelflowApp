using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class tstmatrtransacout
    {
        internal int status;

        public int id { get; set; }
        public string create_by { get; set; }
        public string create_date { get; set; }
        public string update_by { get; set; }
        public string update_date { get; set; }
        public string isdelete { get; set; }
        public string isactive { get; set; }
        public string doc_date { get; set; }
        public string goodid { get; set; }
        public string matr_code { get; set; }
        public string matr_goodname { get; set; }
        public int project_id { get; set; }
        public string project_name { get; set; }
        public int projecttype_id { get; set; }
        public string projecttype_name { get; set; }
        public double quantity { get; set; }
        public double priceperunit { get; set; }
        public double amount { get; set; }
        public int matr_flag_group { get; set; }
        public string matr_status_flag { get; set; }
        public int matr_transactype { get; set; }
        public int ref_id { get; set; }
        public string supplier_code { get; set; }
        public double sheetperset { get; set; }
        public string lastid { get; set; }
        public string sys_doc_ref { get; set; }
        public string doc_no { get; set; }
        public double sRemain { get; set; }
        public string priceperunitx { get; set; }
        public double rvquanity { get; set; }
        public double remaquantity { get; set; }
        public int sstatus { get; set; }
        public string CustName { get; set; }
        public string projectname { get; set; }
        public string goodcode { get; set; }
        public string remark  { get; set; }
        public decimal materquantity { get; set; }
        public string v3code { get; set; }
        public string v3name { get; set; }
        public string v7code { get; set; }
        public double orderamnt { get; set; }
        public decimal v3remain { get; set; }
        public string goodname { get; set; }
        public decimal sheetremain { get; set; }
    }
}