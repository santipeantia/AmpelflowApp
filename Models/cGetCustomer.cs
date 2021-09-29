using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetCustomer
    {
        public int CustId { get; set; }
        public string CustCode { get; set; }
        public string CustTitle { get; set; }
        public string CustName { get; set; }
        public string CustAddr1 { get; set; }
        public string District { get; set; }
        public string Amphur { get; set; }
        public string Province { get; set; }
        public string PostCode { get; set; }
        //        CustCode
        //CustTitle
        //CustName
        //CustAddr1
        //District
        //Amphur
        //Province
        //PostCode
    }
}