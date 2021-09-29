using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class tstgetSheetdata
    {
        public int id { get; set; }
        public int sref_cid { get; set; }
        public string sref_c { get; set; }
        public string spackingno { get; set; }
        public string sdocudate { get; set; }
        public string ssupplier_code { get; set; }
        public string smatr_code { get; set; }
        public string goodname { get; set; }
        public double sqty { get; set; }
        public double scamnt { get; set; }
        public double samntservice { get; set; }
        public double sperunit { get; set; }
        public string sremark { get; set; }
        public bool sflag_status { get; set; }
        public string rvs_lastid { get; set; }

    }
}