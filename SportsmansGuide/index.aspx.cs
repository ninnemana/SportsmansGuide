using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsmansGuide {
    public partial class index : System.Web.UI.Page {
        public List<Category> catList = new List<Category>();
        protected void Page_Load(object sender, EventArgs e) {
            LINQDataContext db = new LINQDataContext();
            var cats = from c in db.Categories
                        where c.ParentID.Equals(null)
                        select c;
            catList = cats.ToList<Category>();

        }
    }
}