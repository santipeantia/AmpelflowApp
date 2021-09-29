using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetoptionpartTransac
    {
        public int id { get; set; }
        public int ref_id { get; set; }
        public string sys_doc_ref { get; set; }
        public string doc_no { get; set; }
        public string doc_date { get; set; }
        public string goodname { get; set; }
        public double quantity { get; set; }
        public double priceperunit { get; set; }
        public string itempart_goodid { get; set; }
        public double itempart_qty { get; set; }
        public double balance { get; set; }
        public double quantity_rv { get; set; }
        public double costsheetperunit { get; set; }
        public string rvo_lastid { get; set; }
        public double partarea { get; set; }
        public double itrmpart_qty { get; set; }
        public double sheetpriceperunit { get; set; }
        public double quantity_rm { get; set; }
        public double costservice { get; set; }
        public double sheetCount { get; set; }
        public double araesheared { get; set; }
        public double rmwdsheet { get; set; }
        public double partCount { get; set; }


    }
}