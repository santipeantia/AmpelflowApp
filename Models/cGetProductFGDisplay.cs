using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetProductFGDisplay
    {


        public int id { get; set; }
        public string create_by { get; set; }
        public string create_date { get; set; }
        public string update_by { get; set; }
        public string update_date { get; set; }
        public int matr_flag_group { get; set; }
        public bool matr_status_flag { get; set; }
        public int matr_transac_type { get; set; }
        public int ref_id { get; set; }
        public int project_id { get; set; }
        public string doc_ref { get; set; }
        public string sys_doc_ref { get; set; }
        public string doc_no { get; set; }
        public string doc_date { get; set; }
        public string matr_code { get; set; }
        public double orderamnt { get; set; }
        public double quantity { get; set; }
        public double priceperunit { get; set; }
        public double amount { get; set; }
        public string newSysCode_doc { get; set; }
        public string project_type_detail { get; set; }
        public string goodname { get; set; }
        public string goodcode { get; set; }
        public string goodid { get; set; }
        public string CustName { get; set; }
        public string ProjectName { get; set; }
        public string Address { get; set; }
    }
}