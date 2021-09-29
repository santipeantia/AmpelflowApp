using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class cGetProduct_payout
    {
        public int rows { get; set; }
        public string StockDetailID { get; set; }
        public string CostDetailID { get; set; }
        public string DailyID { get; set; }
        public string StockFlag { get; set; }
        public string DocuDate { get; set; }
        public int DocuMonth { get; set; }
        public string DocuID { get; set; }
        public string Docuno { get; set; }
        public string Remark { get; set; }
        public string RemarkEng { get; set; }
        public string GoodID { get; set; }
        public string BrchID { get; set; }
        public string InveID { get; set; }
        public string ListNo { get; set; }
        public string LotNo { get; set; }
        public string SerialNO { get; set; }
        public decimal ReceQty { get; set; }
        public decimal ReceCost { get; set; }
        public decimal ReceAmnt { get; set; }
        public decimal PayQty { get; set; }
        public decimal PayCost { get; set; }
        public decimal PayAmnt { get; set; }
        public decimal RemaQty { get; set; }
        public decimal RemaCost { get; set; }   
        public decimal RemaAmnt { get; set; }
        public string DateOut { get; set; }
        public int  ProductOrpayout_Count { get; set; }
        public string  ProductMsgDetail { get; set; }
        public string GoodName1 { get; set; }
        public string  CustName { get; set; }
        public string  custid { get; set; }
    }
}