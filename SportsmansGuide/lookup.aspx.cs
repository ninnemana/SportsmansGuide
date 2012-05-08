using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsmansGuide {
    public partial class lookup : System.Web.UI.Page {
        public string vehicleString = "";
        public string mount = "";
        public string year = "";
        public string make = "";
        public string model = "";
        public string style = "";
        public List<ProductConnector> hitchList = new List<ProductConnector>();
        public List<Category> catList = new List<Category>();

        private LINQDataContext db = new LINQDataContext();

        protected void Page_Load(object sender, EventArgs e) {


            var cats = from c in db.Categories
                       where c.ParentID.Equals(null)
                       select c;
            catList = cats.ToList<Category>();

            // Get POSTed data
            mount = Request.Form["mount"];
            year = Request.Form["year"];
            make = Request.Form["make"];
            model = Request.Form["model"];
            style = Request.Form["style"];

            // Compile Vehicle String
            vehicleString = mount + " " + year + " " + make + " " + model + " " + " " + style;

            // Get hitches that fit the given vehicle data
            if (mount == null) {
                Response.Redirect("index.aspx");
            }else if (mount.ToUpper().Trim() == "REAR MOUNT") {
                var hitchResult = (from p in db.Products
                                   join v in db.Vehicles on p.iVehicleID equals v.iVehicleID
                                   join sg in db.SGIDCrosses on p.vchProductCode equals sg.CURTID
                                   where v.vchYear.Equals(year) && v.vchMake.Equals(make) && v.vchModel.Equals(model) && v.vchStyle.Equals(style) && p.iProductClassID != 7
                                   orderby p.vchProductCode, p.vchProductCode descending
                                   select p);
                buildProductConnector(hitchResult);
            } else {
                var hitchResult = (from p in db.Products
                                   join v in db.Vehicles on p.iVehicleID equals v.iVehicleID
                                   join sg in db.SGIDCrosses on p.vchProductCode equals sg.CURTID
                                   where v.vchYear.Equals(year) && v.vchMake.Equals(make) && v.vchModel.Equals(model) && v.vchStyle.Equals(style) && p.iProductClassID.Equals(7)
                                   orderby p.iProductClassID, p.vchProductCode descending
                                   select p);
                buildProductConnector(hitchResult);
            }


        }

        public void buildProductConnector(IQueryable<Product> result) {

            ProductConnector pc = new ProductConnector();

            foreach (Product hitch in result) {
                Connector tempC = new Connector();
                var connectorResult = (from c in db.Connectors
                                       where c.iVehicleID.Equals(hitch.iVehicleID)
                                       select c).FirstOrDefault();
                if (connectorResult != null) {
                    tempC = connectorResult;
                } else {
                    tempC.iConnectorID = 0;
                }
                pc = new ProductConnector(hitch, tempC);
                hitchList.Add(pc);

            }
        }
    }
}