using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class tstmaterialdata
    {
        public int id { get; set; }
        public string create_by { get; set; }
        public string create_date { get; set; }
        public string update_by { get; set; }
        public string update_date { get; set; }
        public int matr_flag_group { get; set; }
        public bool matr_status_flag { get; set; }
        public int matr_transac_type { get; set; }
        public string doc_date { get; set; }
        public string doc_ref { get; set; }
        public string matr_code { get; set; }
        public string supplier_code { get; set; }
        public string packingno { get; set; }
        public double costservice { get; set; }
        public double quantity { get; set; }
        public double priceperunit { get; set; }
        public double amount { get; set; }
        public string remark { get; set; }
        public string vendorname { get; set; }
        public string goodname1 { get; set; }
        public string  matr_goodcode { get; set; }
        public string doc_no { get; set; }
        public string lotno { get; set; }
        public double remain { get; set; }
        public string lottime { get; set; }
        public string lotcode { get; set; }
        public double qty_payout { get; set; }
        public string goodid { get; set; }
        public string docu_date { get; set; }
        public int ref_id { get; set; }
        public double partarea { get; set; }
        public double partqty { get; set; }
        public string adjicon { get; set; }
       
        public string sys_doc_ref { get; set; }

        
    }
}