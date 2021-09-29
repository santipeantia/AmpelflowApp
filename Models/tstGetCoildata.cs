using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class tstGetCoildata
    {
        

        public int id { get; set; }
        public int matr_flag_group { get; set; }
        public string cdocu_date { get; set; }
        public string cref { get; set; }
        public string csupplier_code { get; set; }
        public string vendorname { get; set; }
        public string cmatr_code { get; set; }
        public string cgood_name { get; set; }
        public double cqty { get; set; }
        public double camnt { get; set; }
        public double cpunit { get; set; }
        public bool cmatr_status_flag { get; set; }
        public string remark { get; set; }
        public string rvc_lastid { get; set; }

    }
}