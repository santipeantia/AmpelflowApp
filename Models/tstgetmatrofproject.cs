using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AmpelflowWeb.Models;

namespace AmpelflowWeb.Models
{
    public class tstgetmatrofproject
    {
        public int id { get; set; }
        public bool isdelete { get; set; }
        public bool isactive { get; set; }
        public int pcsperset { get; set; }
        public string project_type_detail { get; set; }
        public string proj_lastid { get; set; }
        public string remark { get; set; }
    }
}