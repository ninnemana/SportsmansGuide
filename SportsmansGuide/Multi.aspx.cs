using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsmansGuide {
    public partial class Multi : System.Web.UI.Page {

        private LINQDataContext db = new LINQDataContext();
        public List<Category> catList = new List<Category>();
        public Product hitch = new Product();
        public Connector con = new Connector();
        public SGIDCross conCross = new SGIDCross();
        public List<CPart> accessories = new List<CPart>();
        public string vClass = "";
        public string weightCarrying = "n/a";
        public string tongueWeight = "n/a";
        public string weightDistribution = "n/a";
        public string wdTongue = "n/a";

        protected void Page_Load(object sender, EventArgs e) {

            var cats = from c in db.Categories
                       where c.ParentID.Equals(null)
                       select c;
            catList = cats.ToList<Category>();

            // Get the hitchID from the url
            int hitchID = Convert.ToInt32(Request.QueryString["hitchID"]);

            if (hitchID > 0) { // make sure we have a valid hitchID

                var hitchResult = from h in db.Products
                                  where h.iProductID.Equals(hitchID)
                                  select h;

                if (hitchResult.Count() == 0) { // Make sure we found a hitch
                    Response.Redirect("index.aspx");
                } else {
                    // Reassign our hitch to the Product object
                    hitch = hitchResult.FirstOrDefault();
                    switch (hitch.iProductClassID) {
                        case 1:
                            vClass = "Class 1 Hitch";
                            break;
                        case 2:
                            vClass = "Class 2 Hitch";
                            break;
                        case 3:
                            vClass = "Class 3 Hitch";
                            break;
                        case 4:
                            vClass = "Class 1 Hitch";
                            break;
                        case 7:
                            vClass = "Front Mount Hitch";
                            break;
                        case 8:
                            vClass = "Heavy Duty Hitch";
                            break;
                        case 9:
                            vClass = "Class 5 Hitch";
                            break;
                        case 10:
                            vClass = "Class 5 HD Hitch";
                            break;
                        case 11:
                            vClass = "Class 5 ID Hitch";
                            break;
                        default:
                            vClass = "";
                            break;
                    }

                    if (hitch.vchWC.Trim().ToUpper() != "N/A") {
                        string[] wc = hitch.vchWC.Split('/');
                        weightCarrying = wc[0];
                        tongueWeight = wc[1];
                    }
                    if (hitch.vchWD.Trim().ToUpper() != "N/A") {
                        string[] wd = hitch.vchWD.Split('/');
                        weightDistribution = wd[0];
                        wdTongue = wd[1];
                    }

                    // Get the accesories of this hitch
                    string[] upcList = hitch.vchUPCList.Split(',').ToArray();
                    var accResult = from cparts in db.CParts
                                    where upcList.Contains(cparts.vchPartUPC.ToString())
                                    select cparts;
                    accessories = accResult.ToList<CPart>();

                    // Get the T-Connector
                    var conResult = (from connector in db.Connectors
                                    where connector.iVehicleID.Equals(hitch.iVehicleID)
                                    select connector);

                    if (conResult.Count() > 0) {
                        con = conResult.FirstOrDefault();
                        var sgResult = from cross in db.SGIDCrosses
                                       where cross.CURTID.Equals(con.vchConnectorCode)
                                       select cross;
                        if (sgResult.Count() > 0) {
                            conCross = sgResult.FirstOrDefault();
                        }
                    }


                }
            } else { // We had an error, redirect to homepage
                Response.Redirect("index.aspx");
            }
        }
    }
}