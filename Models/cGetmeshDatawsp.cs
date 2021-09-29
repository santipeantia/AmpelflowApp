using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetmeshDatawsp
    {
        public string DocuDate { get; set; }
        public string GoodID { get; set; }
        public double GoodQty2 { get; set; }
        public double GoodPrice2 { get; set; }
        public double GoodRemaQty2 { get; set; }
        public double GoodStockQty { get; set; }
        public double GoodAmnt { get; set; }
        public string GoodName { get; set; }
        public string RefeNo { get; set; }
        public double TotaExcludeAmnt { get; set; }
        public double RemaGoodStockQty { get; set; }
        public string POInvID { get; set; }
        public string InvNO { get; set; }
        public double SumExcludeAmnt { get; set; }
        public double SumGoodAmnt { get; set; }
        public double TotaBaseAmnt { get; set; }
        public double VATAmnt { get; set; }
        public double NETAmnt { get; set; }
        public string Vendoeid { get; set; }
        public string VendorName { get; set; }
        public int rowscount { get; set; }
        

    }
}