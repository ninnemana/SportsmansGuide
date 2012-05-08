using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsmansGuide {
    public partial class category : System.Web.UI.Page {

        public int catID = 0;
        public LINQDataContext db = new LINQDataContext();
        public Category cat = new Category();
        public Dictionary<int, Category> subCatTitles = new Dictionary<int, Category>();
        public Dictionary<int, List<CPart>> subItems = new Dictionary<int, List<CPart>>();
        public Dictionary<int, Category> subParentIDs = new Dictionary<int, Category>();
        public List<Category> catList = new List<Category>();
        public string title = "";

        protected void Page_Load(object sender, EventArgs e) {

            var cats = from c in db.Categories
                       where c.ParentID.Equals(null)
                       select c;
            catList = cats.ToList<Category>();


            // Get the catID
            catID = Convert.ToInt32(Request.QueryString["catID"]);

            var catResult = from c in db.Categories
                            where c.CatID.Equals(catID)
                            select c;
            cat = catResult.FirstOrDefault();

            // Get the Sub categories for this category
            var subResult = from sc in db.Categories
                            where sc.ParentID.Equals(catID)
                            select sc;

            // Step through the sub category result
            foreach (var sub in subResult) {

                // Add the category to the list of category titles
                subCatTitles.Add(Convert.ToInt32(sub.CatID), sub);

                int id = Convert.ToInt32(sub.CatID);
                while (id != -1) {
                    var subCatsResult = from catResults in db.Categories
                                        where catResults.ParentID.Equals(id)
                                        select catResults;
                    if (subCatsResult.Count() != 0) {

                        foreach (Category newCat in subCatsResult) {
                            id = Convert.ToInt32(newCat.CatID);
                            title = newCat.CatTitle;
                            getParts(id, newCat);
                        }
                    } else {
                        id = -1;
                    }
                }
            }


        }


        public void getParts(int catID, Category cat) {
            var items = from cp in db.CParts
                        join catp in db.CatParts on cp.vchProductCode equals catp.vchProductCode
                        join sg in db.SGIDCrosses on cp.vchProductCode equals sg.CURTID
                        where catp.CatID.Equals(catID)
                        select cp;
            
            if (items.Count() > 0) {
                cat.CatTitle = cat.CatTitle + "_sub";
                List<CPart> itemList = items.ToList<CPart>();
                subCatTitles.Add(Convert.ToInt32(catID), cat);
                subItems.Add(Convert.ToInt32(catID), itemList);
            }


        }
    }
}