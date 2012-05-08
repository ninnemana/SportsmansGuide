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
                        <a href="category.aspx?catID=<%: catLink.catID %>">
                            <img src="img/tabs/<%: catLink.catTitle.ToLower().Trim().Replace(" ","") %>_tab.png" style="margin-right: 1px;width: 94px" />
                        </a>
                    <% } %>
                </div>
            </div>
            
            <div id="content">
                <form method="post" action="http://www.sportsmansguide.com/net/LinkShare/LinkShareReturn.aspx?encurl=CURTMFG">
                <input type="hidden" name="vendor_id" value="6061" />
                <input type="hidden" name="event" value="trends" />
                <div id="descBox">
                    <%: hitch.shortDesc %>
                </div>
                <div id="hitch">

                    <!-- Hitch Images -->
                    <div id="imageArea">
                        <div id="mainImage">
                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/images/<%: hitch.partID %>_300x225_a.jpg" />
                        </div>
                        <div id="miniImages">
                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/images/<%: hitch.partID %>_100x75_b.jpg" onerror="$(this).remove()" />
                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/images/<%: hitch.partID %>_100x75_c.jpg" onerror="$(this).remove()" />
                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/images/<%: hitch.partID %>_100x75_d.jpg" onerror="$(this).remove()" />
                            <img src="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/images/<%: hitch.partID %>_100x75_e.jpg" onerror="$(this).remove()" />
                        </div>

                        <div id="shortDesc">
                            <% foreach(SportsmansGuide.Content content in SportsmansGuide.Part_Getters.GetContent(hitch.partID,"Description")){ %>
                                <p><%: content.text %></p>
                            <% } %>
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
                            <span id="price"><%: String.Format("{0:C}",part_cross.Retail) %></span>
                            <input name='shortDescription_01' value='<%: hitch.shortDesc %>' type='hidden' />
                            <input name='productCode_01' value='<%: hitch.partID %>' type='hidden' />
                            <input name='item_01' value='<%: part_cross.SGID.Trim() %>' type='hidden' />
                            <input name='unitPrice_01' value='<%: part_cross.Retail %>' type='hidden' />
                            <input name='unitWeight_01' value='65' type='hidden' />
                            <input type="image" src="img/buyNow.png" style="vertical-align: bottom" />
                        </div>

                        <div id="hitchDetails">
                            <span id="productCode">Product #<%: hitch.partID %> Details</span><br />
                            <ul id="details">
                                <li><strong>Class</strong> <%: vClass %></li>
                                <li><strong>Install Time</strong> <%: vehicle_info.installTime %> minutes</li>
                                <li><strong>Drilling</strong> <%: vehicle_info.drilling %></li>
                                <li style="margin-bottom: 15px"><strong>Main Body</strong> <%: vehicle_info.exposed %></li>
                                <li style="margin-bottom: 15px">
                                    <strong>Notes:</strong>
                                        <ul>
                                            <li>
                                                <img src="img/pdf-icon.png" alt="Instruction Sheet" />
                                                <a href="http://graphics.curthitch.biz/masterlibrary/<%: hitch.partID %>/installsheet/CM_<%: hitch.partID %>_INS.pdf" target="_blank">
                                                    Instruction Sheet <%: hitch.partID %>
                                                </a>
                                            </li>
                                            <% foreach (SportsmansGuide.Content content in SportsmansGuide.Part_Getters.GetContent(hitch.partID, "Note")) { %>
                                                <li><%: content.text %></li>
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
                                    if (con.partID != null && con.partID > 0) { %>
                                    <div class="accessory">
                                        <div class="accImageArea">
                                            <div class="imgContainer">
                                                <img src="http://graphics.curthitch.biz/masterlibrary/<%: con.partID %>/images/<%: con.partID %>_300x225_a.jpg" alt="Connector Image" />
                                            </div>
                                        </div>
                                        <div class="partSpecs">
                                            <span class="partNo"><strong>Connector <%: con.partID %></strong> - Install time: <%: connector_info.installTime %> minutes</span>
                                            <div class="partPrice">
                                                <span class="price"><strong><%: String.Format("{0:C}",conCross.Retail) %></strong></span>
                                                <span>Include</span>
                                                <input type="text" name="qty_0<%: itemCount %>" class="qty" value="0" />
                                                <span> In My Package</span><br />
                                                <a title="Instruction Sheet" href="http://graphics.curthitch.biz/masterlibrary/<%: con.partID %>/installsheet/CME_<%: con.partID %>_INS.pdf" target="_blank">
                                                    <img src="img/pdf-icon.png" alt="PDF" />
                                                    Instruction Sheet <%: con.partID %>
                                                </a>

                                                <input name='shortDescription_0<%: itemCount %>' value='<%: con.shortDesc %>' type='hidden' />
                                                <input name='productCode_0<%: itemCount %>' value='<%: con.partID %>' type='hidden' />
                                                <input name='item_0<%: itemCount %>' value='<%: conCross.SGID %>' type='hidden' />
                                                <input name='unitPrice_0<%: itemCount %>' value='<%: conCross.Retail %>' type='hidden' />
                                                <input name='unitWeight_0<%: itemCount %>' value='65' type='hidden' />
                                            </div>
                                        </div>
                                    </div>
                                    
                                <% itemCount++;
                                    }

                                    foreach (SportsmansGuide.Part acc in accessories) {
                                        SportsmansGuide.SGID_Cross acc_cross = SportsmansGuide.Part_Getters.GetSG(acc.partID);
                                %>
                                    <div class="accessory">
                                        <div class="accImageArea">
                                            <div class="imgContainer">
                                                <img src="http://graphics.curthitch.biz/masterlibrary/<%: acc.partID %>/images/<%: acc.partID %>_300x225_a.jpg" />
                                            </div>
                                        </div>
                                        <div class="partSpecs">
                                            <span class="partNo"><strong>Part #</strong>: <%: acc.partID %></span>
                                            <span class="partDesc"><strong>Description</strong>:<%: acc.shortDesc %></span>
                                            <div class="partPrice">
                                                <span class="price"><strong><%: String.Format("{0:C}", acc_cross.Retail) %></strong></span>
                                                <span>Include</span>
                                                <input type="text" name="qty_0<%: itemCount %>" class="qty" value="0" />
                                                <span> In My Package</span>

                                                <input name='shortDescription_0<%: itemCount %>' value='<%: acc.shortDesc.Trim() %>' type='hidden' />
                                                <input name='productCode_0<%: itemCount %>' value='<%: acc.partID %>' type='hidden' />
                                                <input name='item_0<%: itemCount %>' value='<%: acc_cross.SGID %>' type='hidden' />
                                                <input name='unitPrice_0<%: itemCount %>' value='<%: acc_cross.Retail %>' type='hidden' />
                                                <input name='unitWeight_0<%: itemCount %>' value='65' type='hidden' />
                                            </div>
                                            <ul>
                                                <% foreach (SportsmansGuide.Content content in SportsmansGuide.Part_Getters.GetContent(acc.partID, "Note")) { %>
                                                    <li><%: content.text %></li>
                                                <% } %>
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
