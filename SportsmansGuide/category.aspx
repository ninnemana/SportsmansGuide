<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="SportsmansGuide.category" %>
<%@ Assembly Name="System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" %>
<%@ Assembly Name="System.Data.Linq, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" %>
<%@ Import Namespace="System.Linq" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" href="css/master.css" />
        <link media="all" rel="Stylesheet" href="css/category.css" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
        <link media="all" rel="Stylesheet" href="css/shadowbox.css" />
    </head>
    <body>
        <div id="main">
            <div id="header">
                <a id="logo" href="/">
                    <img src="img/curtLogo_onBlack.png" alt="CURT Manufacturing" />
                </a>
                <div id="hitchInfo_link">
                    <a href="/Hitchinfo/index.html" target="_blank" title="Towing 101" rel="shadowbox">
                        <img src="img/Towing-101.png" style="width: 205px;" />
                    </a>
                </div>
                <div style="clear:both"></div>
                <div id="lookup">
                    <h2>Quick Hitch &amp; Wiring Lookup</h2>
                    <form action="lookup.aspx" method="post">
                        <select name="mount" id="mount">
                            <option value="0">- Select Mount -</option>
                            <option>Front Mount</option>
                            <option>Rear Mount</option>
                        </select>
                        <select name="year" id="year" disabled="disabled">
                            <option value="0">- Select Year -</option>
                        </select><img src="img/ajax-spinner.gif" class="spinner" id="loaderYear" />
                        <select name="make" id="make" disabled="disabled">
                            <option value="0">- Select Make -</option>
                        </select><img src="img/ajax-spinner.gif" class="spinner" id="loaderMake" />
                        <select name="model" id="model" disabled="disabled">
                            <option value="0">- Select Model -</option>
                        </select><img src="img/ajax-spinner.gif" class="spinner" id="loaderModel" />
                        <select name="style" id="style" disabled="disabled">
                            <option value="0">- Select Style -</option>
                        </select><img src="img/ajax-spinner.gif" class="spinner" id="loaderStyle" />
                        <input type="image" disabled="disabled" alt="Search" name="btnSearch" id="btnSearch" src="img/btnSearch.jpg" />
                    </form>
                </div>
                <img src="img/home_BringIt_scaled.jpg" style="float:left;width:530px;margin-left: 10px;margin-bottom: 10px;margin-top: 5px" />
                <div style="clear:both"></div>
                <div style="margin:auto;width: 100%;text-align:center">
                    <% foreach (SportsmansGuide.Category catLink in catList) { %>
                        <a href="category.aspx?catID=<%: catLink.CatID %>">
                            <img src="img/tabs/<%: catLink.CatTitle.ToLower().Trim().Replace(" ","") %>_tab.png" style="margin-right: 1px;width: 94px" />
                        </a>
                    <% } %>
                </div>
            </div>
        
            <div id="catContent">
            
                <!-- Left Nav -->
                <div id="subNav">
                    <h3><%: cat.CatTitle %></h3>
                    <% foreach (KeyValuePair<int, SportsmansGuide.Category> sub in subCatTitles) {
                           int underscorePosition = sub.Value.CatTitle.IndexOf("_");
                           if (underscorePosition != -1) {
                               string[] title = sub.Value.CatTitle.Split('_');   
                            // Print Link %>
                            <a href="#sub_<%: sub.Key %>" id="<%: sub.Key %>" class="subCatLink"><%: title[0]%></a>
                        <% } else {  
                             subParentIDs.Add(sub.Key,sub.Value);    
                        %>
                            <span class="subCatLabel" id="<%: sub.Key %>"><%: sub.Value.CatTitle %></span>
                        <% }
                    } %>
                </div>
                <div id="itemContent">
                    <div class="itemList catDesc" id="sub_0">
                        <h3><%: cat.CatTitle %></h3>
                        <div class="catContent">
                            <p><%: cat.longDesc %></p>
                            <% foreach(KeyValuePair<int, SportsmansGuide.Category> sub in subParentIDs){ %>
                                <div class="subCatLabel catBox" id="<%: sub.Key %>">
                                    <% if (sub.Value.CatImage != null) { %>
                                        <div class="catImageBox">
                                            <img src="<%: sub.Value.CatImage.Trim() %>" />
                                        </div>
                                    <% } %>
                                    <span><%: sub.Value.CatTitle %></span>
                                </div>
                            <% } %>

                        </div>
                    </div>
                    <% foreach(KeyValuePair<int,SportsmansGuide.Category> parent in subParentIDs){ 
                        
                           // Get the sub categories of this parent
                           SportsmansGuide.LINQDataContext db = new SportsmansGuide.LINQDataContext();
                           var subs = from sub in db.Categories
                                      where sub.ParentID.Equals(parent.Key)
                                      select sub;

                    %>
                        <div class="itemList" id="sub_<%: parent.Key %>">
                            <h3><%: parent.Value.CatTitle %></h3>
                            <div class="catContent">
                                <h5><%: parent.Value.shortDesc %></h5>
                                <p><%: parent.Value.longDesc %></p>
                                <% foreach (var sub in subs) {
                                       var itemCount = (from cp in db.CParts
                                                        join catp in db.CatParts on cp.vchProductCode equals catp.vchProductCode
                                                        join sg in db.SGIDCrosses on cp.vchProductCode equals sg.CURTID
                                                        where catp.CatID.Equals(sub.CatID)
                                                        select cp).Count();
                                       if (itemCount > 0) { %>
                                        <div class="subCatLink catBox" id="<%: sub.CatID %>">
                                            <% if (sub.CatImage != null) { %>
                                        <div class="catImageBox">
                                            <img src="<%: sub.CatImage.Trim() %>" />
                                        </div>
                                    <% } %>
                                            <span><%: sub.CatTitle %></span>
                                        </div>
                                <%     }
                                   } %>
                            </div>
                        </div>
                    <% } %>

                    <% foreach (KeyValuePair<int,List<SportsmansGuide.CPart>> subItem in subItems) {
                        List<SportsmansGuide.CPart> items = subItem.Value;
                        if(items.Count > 0){ %>
                            <div class="itemList" id="sub_<%: subItem.Key %>">
                                <h3 class="itemHeader"></h3>
                            <% foreach (SportsmansGuide.CPart item in items) {
                                   string[] parameters = null;
                                   if (item.vchParams != null) {
                                       parameters = item.vchParams.Split(';');
                                   }
                            %>
                                <div class="item">
                                    <h4><%: item.vchSDesc %></h4>
                                    <div class="titleImage">
                                        <img src="/masterlibrary/<%: item.vchProductCode %>/images/<%: item.vchProductCode %>_300x225_a.jpg" width="75" />
                                    </div>
                                    <div class="itemParams">
                                        <ul>
                                            <% if (parameters != null) {
                                                   foreach (string parameter in parameters) {
                                                       if (parameter.Trim() != "" && parameter.Trim() != "\"") { %>
                                                        <li><%: parameter%></li>
                                            <%         }
                                                   }
                                               }
                                            %>
                                        </ul>
                                    </div>
                                    <div class="purchase">
                                        <span class="price"><%: String.Format("{0:C}",item.SGRetail) %></span>
                                        <form action="http://www.sportsmansguide.com/net/LinkShare/LinkShareReturn.aspx?encurl=CURTMFG" method="post">
                                            <input type="hidden" name="vendor_id" value="6061" />
                                            <input type="hidden" name="event" value="trends" />
                                            <input type="hidden" name="productCode_01" value="<%: item.vchProductCode %>" />
                                            <input type="hidden" name="shortDescription_01" value="<%: item.vchSDesc %>" />
                                            <input type="hidden" name="item_01" value="<%: item.SGID %>" />
                                            <input type="hidden" name="unitPrice_01" value="<%: item.SGRetail %>" />
                                            <label>Select Qty</label>
                                            <input type="text" name="qty_01" class="qtyBox" placeholder="0" /><br />
                                            <input type="image" src="img/buyNow.png" />
                                        </form>
                                    </div>
                                    <div style="clear:both"></div>
                                </div>
                            <% } %>
                            </div>
                    <%  }
                    } %>
                </div>
                <div style="clear:both"></div>
            </div>
        </div>
        <script type="text/javascript" src="js/category.js"></script>
        <script type="text/javascript" src="js/lookup.js"></script>
        <script type="text/javascript" src="js/shadowbox.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                Shadowbox.init();
            });
        </script>
    </body>
</html>