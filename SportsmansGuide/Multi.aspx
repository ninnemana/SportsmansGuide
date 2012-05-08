<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Multi.aspx.cs" Inherits="SportsmansGuide.Multi" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" href="css/master.css" />
        <link media="all" rel="stylesheet" href="css/hitch.css" />
        <link media="all" rel="Stylesheet" href="css/shadowbox.css" />
    </head>
    <body>
        <div id="main">
            <div id="header">
                <a id="logo" href="/">
                    <img src="img/curtLogo_onBlack.png" alt="CURT Manufacturing" style="background: none" />
                </a>
                <div id="hitchInfo_link">
                    <a href="/Hitchinfo/index.html" target="_blank" title="Towing 101" rel="Shadowbox">
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
                <img src="img/home_BringIt_scaled.jpg" style="float:left;width:520px;margin-left: 10px;margin-bottom: 10px;margin-top: 5px" />
                <div style="clear:both"></div>
                <div style="margin:auto;width: 100%;text-align:center">
                    <% foreach (SportsmansGuide.Category catLink in catList) { %>
                        <a href="category.aspx?catID=<%: catLink.CatID %>">
                            <img src="img/tabs/<%: catLink.CatTitle.ToLower().Trim().Replace(" ","") %>_tab.png" style="margin-right: 1px;width: 94px" />
                        </a>
                    <% } %>
                </div>
            </div>
            
            <div id="content">
                <form method="post" action="http://www.sportsmansguide.com/net/LinkShare/LinkShareReturn.aspx?encurl=CURTMFG">
                <input type="hidden" name="vendor_id" value="6061" />
                <input type="hidden" name="event" value="trends" />
                <div id="descBox">
                    <%: hitch.vchShortDesc + " " + hitch.txtNote6 %>
                </div>
                <div id="hitch">

                    <!-- Hitch Images -->
                    <div id="imageArea">
                        <div id="mainImage">
                            <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_300x225_a.jpg" />
                        </div>
                        <div id="miniImages">
                            <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_b.jpg" onerror="$(this).remove()" />
                            <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_c.jpg" onerror="$(this).remove()" />
                            <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_d.jpg" onerror="$(this).remove()" />
                            <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_e.jpg" onerror="$(this).remove()" />
                        </div>

                        <div id="shortDesc">
                            <p><% Response.Write(hitch.vchLongDesc.Replace('"',' ')); %></p>
                        </div>
                        <div style="clear:both"></div>
                    </div>

                    <!-- Hitch Specs -->
                    <div id="specs">
                    
                        <!-- Pricing -->
                        <div id="pricing">
                            <label>Select Qty</label>
                            <select name="qty_01">
                                <option value="0">Qty</option>
                                <option selected="selected">1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select><br />
                            <span id="price"><%: String.Format("{0:C}",hitch.SGRetail) %></span>
                            <input name='shortDescription_01' value='<%: hitch.vchShortDesc %>' type='hidden' />
                            <input name='productCode_01' value='<%: hitch.vchProductCode %>' type='hidden' />
                            <input name='item_01' value='<%: hitch.SGID %>' type='hidden' />
                            <input name='unitPrice_01' value='<%: hitch.SGRetail %>' type='hidden' />
                            <input name='unitWeight_01' value='65' type='hidden' />
                            <input type="image" src="img/buyNow.png" style="vertical-align: bottom" />
                        </div>

                        <div id="hitchDetails">
                            <span id="productCode">Product #<%: hitch.vchProductCode %> Details</span><br />
                            <ul id="details">
                                <li><strong>Class</strong> <%: vClass %></li>
                                <li><strong>Install Time</strong> <%: hitch.InstallTime %> minutes</li>
                                <li><strong>Drilling</strong> <%: hitch.vchDrilling %></li>
                                <li style="margin-bottom: 15px"><strong>Main Body</strong> <%: hitch.vchExposed %></li>
                                <li style="margin-bottom: 15px">
                                    <strong>Notes:</strong>
                                        <ul>
                                            <li>
                                                <img src="img/pdf-icon.png" alt="Instruction Sheet" />
                                                <a href="/masterlibrary/<%: hitch.vchProductCode %>/installsheet/CM_<%: hitch.vchProductCode %>_INS.pdf" target="_blank">
                                                    Instruction Sheet <%: hitch.vchProductCode %>
                                                </a>
                                            </li>
                                            <% if (hitch.txtNote1.Trim() != "") { %>
                                                <li><%: hitch.txtNote1 %></li>
                                            <% } %>
                                            <% if (hitch.txtNote2.Trim() != "") { %>
                                                <li><%: hitch.txtNote2 %></li>
                                            <% } %>
                                            <% if (hitch.txtNote3.Trim() != "") { %>
                                                <li><%: hitch.txtNote3 %></li>
                                            <% } %>
                                            <% if (hitch.txtNote4.Trim() != "") { %>
                                                <li><%: hitch.txtNote4 %></li>
                                            <% } %>
                                        </ul>
                                </li>
                                <li>
                                    <strong>Gross Load Capacity</strong>
                                    <ul id="loadCapacity">
                                        <li>
                                            <span class="label">Weight Carrying</span>
                                            <span class="value"><%: weightCarrying %></span>
                                        </li>
                                        <li>
                                            <span class="label">Tongue Weight</span>
                                            <span class="value"><%: tongueWeight %></span>
                                        </li>
                                        <li>
                                            <span class="label">Weight Distribution (WD)</span>
                                            <span class="value"><%: weightDistribution %></span>
                                        </li>
                                        <li>
                                            <span class="label">WD Tongue Weight</span>
                                            <span class="value"><%: wdTongue %></span>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>

                    </div>

                    <div style="clear:both"></div>

                    <!-- Tabbed Content -->
                    <div id="tabs" style="margin-top: 25px;">
                        <ul class="tabs">
                            <li><a href="#accessories">Accessories</a></li>
                            <!--li><a href="#electrical">Electrical</a></li-->
                        </ul>
                        <div class="tab_container">
                            <div id="accessories" class="tab_content">

                                <% 
                                    int itemCount = 2;
                                    if (con.vchConnectorCode != null && con.vchConnectorCode.Length > 0) { %>
                                    <div class="accessory">
                                        <div class="accImageArea">
                                            <div class="imgContainer">
                                                <img src="/masterlibrary/<%: con.vchConnectorCode %>/images/<%: con.vchConnectorCode %>_300x225_a.jpg" alt="Connector Image" />
                                            </div>
                                        </div>
                                        <div class="partSpecs">
                                            <span class="partNo"><strong>Connector <%: con.vchConnectorCode %></strong> - Install time: <%: con.vchConnectorInstallTime %> minutes</span>
                                            <div class="partPrice">
                                                <span class="price"><strong><%: String.Format("{0:C}",conCross.SGRetail) %></strong></span>
                                                <span>Include</span>
                                                <input type="text" name="qty_0<%: itemCount %>" class="qty" value="0" />
                                                <span> In My Package</span><br />
                                                <a title="Instruction Sheet" href="/masterlibrary/<%: con.vchConnectorCode %>/installsheet/CME_<%: con.vchConnectorCode %>_INS.pdf" target="_blank">
                                                    <img src="img/pdf-icon.png" alt="PDF" />
                                                    Instruction Sheet <%: con.vchConnectorCode %>
                                                </a>

                                                <input name='shortDescription_0<%: itemCount %>' value='<%: con.txtConnectorNotes %>' type='hidden' />
                                                <input name='productCode_0<%: itemCount %>' value='<%: con.vchConnectorCode.Trim() %>' type='hidden' />
                                                <input name='item_0<%: itemCount %>' value='<%: conCross.SGID %>' type='hidden' />
                                                <input name='unitPrice_0<%: itemCount %>' value='<%: conCross.SGRetail %>' type='hidden' />
                                                <input name='unitWeight_0<%: itemCount %>' value='65' type='hidden' />
                                            </div>
                                        </div>
                                    </div>
                                    
                                <% itemCount++;
                                    }

                                    foreach (SportsmansGuide.CPart acc in accessories) { 
                                        string[] vchParams = new string[' '];
                                        if (acc.vchParams != null && acc.vchParams.Length > 0) {
                                            vchParams = acc.vchParams.Split(';');
                                        }
                                %>
                                    <div class="accessory">
                                        <div class="accImageArea">
                                            <div class="imgContainer">
                                                <img src="/masterlibrary/<%: acc.vchProductCode %>/images/<%: acc.vchProductCode %>_300x225_a.jpg" />
                                            </div>
                                        </div>
                                        <div class="partSpecs">
                                            <span class="partNo"><strong>Part #</strong>: <%: acc.vchProductCode %></span>
                                            <span class="partDesc"><strong>Description</strong>:<%: acc.vchSDesc %></span>
                                            <div class="partPrice">
                                                <span class="price"><strong><%: String.Format("{0:C}", acc.SGRetail) %></strong></span>
                                                <span>Include</span>
                                                <input type="text" name="qty_0<%: itemCount %>" class="qty" value="0" />
                                                <span> In My Package</span>

                                                <input name='shortDescription_0<%: itemCount %>' value='<%: acc.vchSDesc.Trim() %>' type='hidden' />
                                                <input name='productCode_0<%: itemCount %>' value='<%: acc.vchProductCode.Trim() %>' type='hidden' />
                                                <input name='item_0<%: itemCount %>' value='<%: acc.SGID.Trim() %>' type='hidden' />
                                                <input name='unitPrice_0<%: itemCount %>' value='<%: acc.SGRetail %>' type='hidden' />
                                                <input name='unitWeight_0<%: itemCount %>' value='65' type='hidden' />
                                            </div>
                                            <ul>
                                                <% foreach (string p in vchParams) {
                                                       if (p != null && p.Trim() != "" && p.Trim() != "\"") { %>
                                                        <li><%: p%></li>
                                                <%     }
                                                   } %>
                                            </ul>
                                        </div>
                                        <div style="clear:both"></div>
                                    </div>
                                <% 
                                    itemCount++;
                                    } 
                                    
                                %>
                            </div>
                            <div id="electrical" class="tab_content"></div>
                        </div>
                    </div>
                
                <div style="clear:both"></div>
                </div> <!-- End #hitch -->
                
                </form>
            </div> <!-- End #content -->
        </div>

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
        <script type="text/javascript" src="js/lookup.js"></script>
        <script type="text/javascript" src="js/shadowbox.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                Shadowbox.init();

                $('.tab_content').hide();
                $('ul.tabs li:first').addClass('active');
                $('.tab_content:first').show();

                $('ul.tabs li').click(function () {
                    $('ul.tabs li').removeClass('active');
                    $(this).addClass('active');
                    $('.tab_content').hide();

                    var activeTab = $(this).find('a').attr('href');
                    $(activeTab).fadeIn();
                    return false;
                });

                $('#miniImages img').click(function () {
                    var thisSrc = $(this).attr('src').replace('100x75', '300x225');
                    var bigSrc = $('#mainImage img').attr('src').replace('300x225', '100x75');
                    $(this).attr('src', bigSrc);
                    $('#mainImage img').attr('src', thisSrc);
                });

                $('#mainImage img').click(function () {
                    var thisSrc = $(this).attr('src').replace('300x225', '1024x768');
                    window.open(thisSrc, '', 'status=1,location=1,resizable=1,scrollbars=1');
                });

                $('.imgContainer').click(function () {
                    var thisSrc = $(this).find('img').attr('src').replace('300x225', '1024x768');
                    window.open(thisSrc, '', 'status=1,location=1,resizable=1,scollbars=1');
                });

                $('.qty').focus(function () {
                    $(this).select();
                });
            });
        </script>
    </body>
</html>
