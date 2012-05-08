<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lookup.aspx.cs" Inherits="SportsmansGuide.lookup" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" href="css/master.css" />
        <link media="all" rel="Stylesheet" href="css/lookup.css" />
        <link media="all" rel="Stylesheet" href="css/shadowbox.css" />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
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
    

    <div id="vehicleBox"><%: vehicleString %></div>
	<div id="results">
	<%
        int vCounter = 0;
        string[] prodCodes = new string[hitchList.Count];      
        foreach (SportsmansGuide.ProductConnector pc in hitchList) {
            SportsmansGuide.Connector connector = new SportsmansGuide.Connector();
            SportsmansGuide.Product hitch = pc.p;
            connector = pc.c;
            if (!prodCodes.Contains(hitch.vchProductCode)) {

                prodCodes[vCounter] = hitch.vchProductCode;
                string prodCode = hitch.vchProductCode;
                string vClass = "";
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
        %>
        
        <div class='c_product_item'>
            <div style="padding-top: 10px">
                <div style='width: 660px;margin-bottom: 10px'>
                    <div style='font-size: 18px; font-weight: bold; color: rgb(0, 0, 0); float: left;  padding-bottom: 2px;'>
                        <%: hitch.vchShortDesc%>
                    </div>
                    <span style='clear: both; display: block; '>Product #<%: hitch.vchProductCode%> <%: hitch.txtNote6%></span>
                </div>
            </div>
            <div>
                <div style="float:left;width: 180px;"> 
                    <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_300x225_a.jpg" alt="Hitch image" class="mainImg" /> <br />
                    <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_b.jpg" />
                    <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_c.jpg" />
                    <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_d.jpg" />
                    <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_e.jpg" />
                </div> 
                <div style="width: 40%;float:left;padding: 0px 20px">
                    <strong>Install Time: </strong><%: hitch.InstallTime%> minutes<br />
                    <strong><%: vClass%></strong> 
                    <br /><strong>Product: </strong><%: hitch.vchProductCode%> 
                    <br /><strong>Capacity Rating: </strong><%: hitch.vchCapacity%>
                    <br /><b>WC / TW: </b><%: hitch.vchWC%>
                    <br /><br />
                    <img src='img/pdf-icon.png' alt="PDF" />
                    <a target='_blank' style='color:#29627B; font-weight: bold; font-size:11px;' href='/masterlibrary/<%: hitch.vchProductCode %>/installsheet/CM_<%: hitch.vchProductCode %>_INS.pdf'>Instruction Sheet <%: hitch.vchProductCode%></a>
                    <% if (hitch.txtNote1.Trim() != "") { %>
                        <br /><%: hitch.txtNote1%>
                    <% } if (hitch.txtNote2.Trim() != "") { %>
                        <br /><%: hitch.txtNote2%>
                    <% } if(hitch.txtNote3.Trim() != ""){ %>
                        <br /><%: hitch.txtNote3%>
                    <% } if(hitch.txtNote4.Trim() != ""){ %>
                        <br /><%: hitch.txtNote4%>
                    <% }%>
                </div>
                <div style="float:right;margin-right: 20px;width: 25%">
                    <span style="color:#e44f31;font-weight:bold">
                        <%: String.Format("{0:C}", hitch.SGRetail)%>
                    </span>
                    <form action="http://www.sportsmansguide.com/net/LinkShare/LinkShareReturn.aspx?encurl=CURTMFG" method="post">
                        <label>Select Qty</label>
                        <select name='qty_01' style='width: 55px;'>
                            <option value=''>Qty</option>
                            <option value='1' selected='selected'>1</option>
                            <option value='2'>2</option>
                            <option value='3'>3</option>
                            <option value='4'>4</option>
                            <option value='5'>5</option>
                        </select>
                        <input type="hidden" name="vendor_id" value="6061" />
                        <input type="hidden" name="event" value="trends" />
                        <input name='shortDescription_01' value='<%: hitch.vchShortDesc %>' type='hidden' />
                        <input name='productCode_01' value='<%: hitch.vchProductCode %>' type='hidden' />
                        <input name='item_01' value='<%: hitch.SGID %>' type='hidden' />
                        <input name='unitPrice_01' value='<%: hitch.SGRetail %>' type='hidden' />
                        <input name='unitWeight_01' value='65' type='hidden' />
                        <input type="image" src="img/buyNow.png" class="btnBuy" style="float:left" />

                    </form><br />
                    <div style="margin-top: 15px">
                        <a href="Multi.aspx?hitchID=<%: hitch.iProductID %>">
                            <img src="img/moreInfo.png" alt="More Info" />
                        </a>
                    </div>
                </div>
                <div style="clear:both"></div>
                <div class='c_hr'><hr/></div>
            </div>
        </div>
        <%
            if (connector.iConnectorID != 0 && connector.vchConnectorCode.Length > 0) {
                // Display Connector & Hitch %>
                <!--div class='c_product_item'>
                <div style="padding-top: 10px">
                        <input name='event' value='trends' type='hidden' />
                        <input type="hidden" name='vendor_id' value='6061' />
                        <input type="hidden" name='search_id' value='<%: vehicleString %>' />
                        <input name='event' value='trends' type='hidden' />
		    
                        <div style='width: 660px;margin-bottom: 10px'>
                            <div style='font-size: 18px; font-weight: bold; color: rgb(0, 0, 0); float: left;  padding-bottom: 2px;'>
                                <%: hitch.vchShortDesc%> Hitch Kit With Wiring
                            </div>
                            <span style='clear: both; display: block; '>Product #<%: hitch.vchProductCode%> <%: hitch.txtNote6%></span>
                        </div>
                </div>
                <div>
                    <div style="float:left;width: 180px"> 
                        <img src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_300x225_a.jpg" alt="Hitch image" class="mainImg" /> <br />
                        <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_b.jpg" />
                        <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_c.jpg" />
                        <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_d.jpg" />
                        <img class="smImg" onerror="$(this).remove();" src="/masterlibrary/<%: hitch.vchProductCode %>/images/<%: hitch.vchProductCode %>_100x75_e.jpg" />
                    </div> 
                    <div style="width: 30%;float:left;padding: 0px 20px">
                        <strong>Install Time: </strong><%: hitch.InstallTime%> minutes<br />
                        <strong><%: vClass%></strong> 
                        <br /><strong>Product: </strong><%: hitch.vchProductCode%> 
                        <br /><strong>Capacity Rating: </strong><%: hitch.vchCapacity%>
                        <br /><b>WC / TW: </b><%: hitch.vchWC%>
                        <br /><br />
                        <img src='img/pdf-icon.png'>
                        <a target='_blank' style='color:#29627B; font-weight: bold; font-size:11px;' href='/masterlibrary/<%: hitch.vchProductCode %>/installsheet/CM_<%: hitch.vchProductCode %>_INS.pdf'>Instruction Sheet <%: hitch.vchProductCode%></a>
                        <br /><%: hitch.txtNote1%>
                        <br /><%: hitch.txtNote2%>
                    </div>
                    <div style="float:left;width: 20%;">
                        <span style="font-weight: bold; text-decoration:underline; font-size: 10pt;">Wiring Kit</span>
                        <a class="connectorImg" href="masterlibrary/<%: connector.vchConnectorCode %>/images/<%: connector.vchConnectorCode %>_1024x768_a.jpg" target="_blank">
                            <img src="masterlibrary/<%: connector.vchConnectorCode %>/images/<%: connector.vchConnectorCode %>_300x225_a.jpg" style="width:125px" />
                        </a>
                        <span style="display:block"><strong>Connector <%: connector.vchConnectorCode %></strong></span>
                        <span style="display:block">Install Time: <%: connector.vchConnectorInstallTime %> minutes</span>
                        <img alt="PDF" src="img/pdf-icon.png" />
                        <a target="_blank" style='color:#29627B; font-weight: bold; font-size:11px;' href="masterlibrary/<%: connector.vchConnectorCode %>/installsheet/CME_<%: connector.vchConnectorCode %>_INS.pdf">
                            Instruction Sheet <%: connector.vchConnectorCode %>
                        </a>
                    </div>
                    <div style="float:right;margin-right: 20px">
                        <span style="color:red;font-weight:bold">
                            <%: String.Format("{0:C}", hitch.SGRetail)%>
                        </span>
                        <form action="http://www.costco.com/Browse/Product.aspx?Prodid=11537460" method="post">
                        <select name='QtyBox11537460' style='width: 55px;'>
                            <option value=''>Qty</option>
                            <option value='1' selected='selected'>1</option>
                            <option value='2'>2</option>
                            <option value='3'>3</option>
                            <option value='4'>4</option>
                            <option value='5'>5</option>
                        </select>	   
                        <input name='shortDescription_0<%: vCounter %>' value='<%: hitch.vchShortDesc %>' type='hidden' />
                        <input name='productCode_0<%: vCounter %>' value='<%: hitch.vchProductCode %>' type='hidden' />
                        <input name='item_0<%: vCounter %>' value='<%: hitch.SGID %>' type='hidden' />
                        <input name='unitPrice_0<%: vCounter %>' value='<%: hitch.SGRetail %>' type='hidden' />
                        <input name='unitWeight_0<%: vCounter %>' value='65' type='hidden' />
                        <input id="Submit1" maxlength="3" name="AddToCartImg11537460catBC" type="submit" value=" " style="background: url(img/addToCartButton.png);border: none;width: 82px;height: 18px;cursor:pointer" />
                        <input name="onaddtocart" value="AddToCartBase" type="hidden" />
                        </form>
                        <div style='padding-bottom: 5px; padding-top: 10px;'>  
                            <a href="Hitch.aspx?hitchID=<%: hitch.iProductID %>&amp;selectVehicleMount=<%: mount %>&amp;selectVehicleYear=<%: year %>&amp;selectVehicleMake=<%: make %>&amp;selectVehicleModel=<%: model %>&amp;selectVehicleStyle=<%: style %>">
                                <img border=0 src='img/click_here_for_hitch_details.png' alt='' style='text-decoration: none; color:#ffffff;height:97px;width:208px;border: 0px solid white' />
                            </a>
                        </div>
                    </div>
                    <div style="clear:both"></div>
                    <div class='c_hr'><hr/></div>
                    <input name='cartitems' value='<%: vCounter %>' type='hidden' />
                </div>
            </div-->
        <%
            } // End If connector.vchConnectorCode.Length > 0
                
            vCounter++;
            } // End If !prodCodes.Contains(hitch.vchProductCode)
    }
    %>
    </div>
</div>

    
    <script type="text/javascript" src="js/lookup.js"></script>
    <script type="text/javascript" src="js/shadowbox.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            Shadowbox.init();

            $('.connectorImg').click(function () {
                var imgSrc = $(this).attr('href');
                window.open(imgSrc, '', 'location=1,status=1, scrollbars=0, width=1050, height=755');
                return false;
            });

            $('.smImg').click(function () {
                var thisSrc = $(this).attr('src');
                var mainSrc = $(this).parent().find('.mainImg').attr('src');
                thisSrc = thisSrc.replace('100x75', '300x225');
                mainSrc = mainSrc.replace('300x225', '100x75');
                $(this).attr('src', mainSrc);
                $(this).parent().find('.mainImg').attr('src', thisSrc);
            });

            $('.mainImg').click(function () {
                var src = $(this).attr('src');
                src = src.replace('300x225', '1024x768');
                window.open(src, 'thumb1', 'location=1,status=1, scrollbars=0, width=1050, height=755').focus();
            });
        });
    </script>
    </body>
</html>
