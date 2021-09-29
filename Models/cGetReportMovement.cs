using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowApp.Models
{
    public class cGetReportMovement
    {
        public string doc_date { get; set; }
        public string doc_no { get; set; }
        public string remarkx { get; set; }
        public decimal rv_quantity { get; set; }
        public decimal rv_priceperunit { get; set; }
        public decimal rv_amount { get; set; }
        public decimal wd_quantity { get; set; }
        public decimal wd_priceperunit { get; set; }
        public decimal wd_amount { get; set; }
        public decimal rema_quantity { get; set; }
        public decimal rema_pricperunit { get; set; }
        public decimal rema_amount { get; set; }


    }
}