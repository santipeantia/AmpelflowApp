using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmpelflowWeb.Models
{
    public class tstprojectactiondata
    {
        public int id { get; set; }
        public string create_by { get; set; }
        public string create_date { get; set; }
        public string update_by { get; set; }
        public string update_date { get; set; }
        public bool isdelete { get; set; }
        public bool isactive { get; set; }
        public string projectname { get; set; }
        public double projectset { get; set; }
        public int customer_id { get; set; }
        public string customer_code { get; set; }
        public string customer_name { get; set; }
        public string remark { get; set; }
        public string project_type_detail { get; set; }
        public string projectdate { get; set; }
        public int projecttype { get; set; }
        public double sheetperset { get; set; }
        public string apflastid { get; set; }
        public string goodname { get; set; }

        public string doc_no { get; set; }

        public string doc_Date { get; set; }
        public string sys_doc_ref { get; set; }
        public string matr_code { get; set; }
        public double orderamnt { get; set; }
        public double priceperunit { get; set; }


    }
}