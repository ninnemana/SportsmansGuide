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
        <link href="css/demo_table.css" rel="stylesheet" type="text/css" />
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
                        <a href="category.aspx?catID=<%: catLink.catID %>">
                            <img src="img/tabs/<%: catLink.catTitle.ToLower().Trim().Replace(" ","") %>_tab.png" style="margin-right: 1px;width: 94px" />
                        </a>
                    <% } %>
                </div>
            </div>
        
            <div id="catContent">
            
                <!-- Left Nav -->
                <div id="subNav">
                    <h3></h3>
                    <% foreach (KeyValuePair<int, SportsmansGuide.Category> sub in subCatTitles) {
                           int underscorePosition = sub.Value.catTitle.IndexOf("_");
                           if (underscorePosition != -1) {
                               string[] title = sub.Value.catTitle.Split('_');   
                                // Print Link 
                               if (catID == sub.Key) { %>
                                    <a href="category.aspx?catID=<%: sub.Key %>" id="<%: sub.Key %>" class="subCatLink active"><%: title[0]%></a>
                                <% } else { %>
                                    <a href="category.aspx?catID=<%: sub.Key %>" id="<%: sub.Key %>" class="subCatLink"><%: title[0]%></a>
                                <% }
                            } else if(SportsmansGuide.Part_Getters.CheckSubsAndParts(sub.Key)) {
                                if (catID == sub.Key) { %>
                                    <a href="category.aspx?catID=<%: sub.Key %>" class="subCatLabel active" id="<%: sub.Key %>"><%: sub.Value.catTitle %></a>
                                <% } else { %>
                                    <a href="category.aspx?catID=<%: sub.Key %>" class="subCatLabel" id="<%: sub.Key %>"><%: sub.Value.catTitle %></a>
                            <%  }   
                            }
                        } 
                     %>
                </div>
                <div id="itemContent">
                    <div class="itemList catDesc" id="sub_0">
                        <h3><%: cat.catTitle.Replace("_sub","")%></h3>
                        <div class="catContent">
                            <p><%: cat.longDesc %></p>
                        </div>
                    </div>
                    <div style="clear:both"></div>

                    <% if(items.Count > 0){ %>
                            <div class="itemList">
                            <% if (!oversized_categories.Contains(catID)) {
                                   foreach (SportsmansGuide.Part item in items) {
                                       SportsmansGuide.SGID_Cross sg = SportsmansGuide.Part_Getters.GetSG(item.partID);       
                                %>
                                    <div class="item">
                                        <h4><%: item.shortDesc%> #<%: item.partID%></h4>
                                        <div class="titleImage">
                                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: item.partID %>/images/<%: item.partID %>_300x225_a.jpg" width="75" />
                                        </div>
                                        <div class="itemParams">
                                            <ul>
                                                <% foreach (SportsmansGuide.PartAttribute attr in SportsmansGuide.Part_Getters.GetAttributes(item.partID)) { %>
                                                    <li><strong><%: attr.field%>: </strong><%: attr.value%></li>
                                                <% } %>
                                            </ul>
                                        </div>
                                        <div class="purchase">
                                            <span class="price"><%: String.Format("{0:C}", sg.Retail)%></span>
                                            <form action="http://www.sportsmansguide.com/net/LinkShare/LinkShareReturn.aspx?encurl=CURTMFG" method="post">
                                                <input type="hidden" name="vendor_id" value="6061" />
                                                <input type="hidden" name="event" value="trends" />
                                                <input type="hidden" name="productCode_01" value="<%: item.partID %>" />
                                                <input type="hidden" name="shortDescription_01" value="<%: item.shortDesc %>" />
                                                <input type="hidden" name="item_01" value="<%: sg.SGID %>" />
                                                <input type="hidden" name="unitPrice_01" value="<%: sg.Retail %>" />
                                                <label>Select Qty</label>
                                                <input type="text" name="qty_01" class="qtyBox" placeholder="0" /><br />
                                                <input type="image" src="img/buyNow.png" />
                                            </form>
                                        </div>
                                        <div style="clear:both"></div>
                                    </div>
                                <% }
                               } else { %>
                                    <div style="padding-left:5%">
                                       <p>Below you will find a condensed version of the part listing. There are <%: item_count %> parts in this category. If you would like to find a receiver hitch that is better fit for your specific vehicle, please use the vehicle look-up at the top of the page.</p>
                                       <table>
                                        <thead>
                                            <tr>
                                                <th>Part #</th>
                                                <th>Part</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% foreach (SportsmansGuide.Part item in items) { %>
                                                <tr>
                                                    <td><%: item.partID %></td>
                                                    <td><%: item.shortDesc %></td>
                                                    <td><a href="MultiOpen.aspx?hitchID=<%: item.partID %>" title="View Part #<%: item.partID %>">View Details</a></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                       </table>
                                    </div>
                               <% } %>
                            </div>
                    <% } %>
                </div>
                <div style="clear:both"></div>
            </div>
        </div>
        <script type="text/javascript" src="js/category.js"></script>
        <script type="text/javascript" src="js/lookup.js"></script>
        <script type="text/javascript" src="js/shadowbox.js"></script>
        <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                Shadowbox.init();
                $('table').dataTable();
            });
        </script>
    </body>
</html>