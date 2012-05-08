<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SportsmansGuide.index" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link media="all" rel="stylesheet" href="css/master.css" />
        <link media="all" rel="stylesheet" href="css/shadowbox.css" />
    </head>
    <body>
        <div id="main">
            <div id="header">
                <a id="logo" href="/">
                    <img src="img/curtLogo_onBlack.png" alt="CURT Manufacturing" />
                </a>

                <div id="hitchInfo_link">
                    <a href="/HitchInfo/index.html" target="_blank" title="Towing 101" rel="shadowbox">
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
            
            <!-- Categories -->
            <div id="content">
                <% foreach(SportsmansGuide.Category cat in catList){ %>
                <a class="article" href="category.aspx?catID=<%: cat.catID %>">
                    <img class="corner" src="img/<%: cat.catTitle.ToLower().Replace(" ","") %>Corner.png" />
                    <div class="lifestyleImg">
                        <img src="img/<%: cat.catTitle.ToLower().Trim().Replace(" ","_") %>.png" alt="<%: cat.catTitle.Trim() %>" />
                    </div>
                    <span><%: cat.catTitle %></span>
                    <p style="width: 225px;top: -35px;position:relative;margin-left:10px;font-size:8pt;color: white">
                        <%: cat.shortDesc %>
                    </p>
                </a>
                <% } %>

            </div>
            
            
            
        </div>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
        <script type="text/javascript" src="js/lookup.js"></script>
        <script type="text/javascript" src="js/shadowbox.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                Shadowbox.init();
            });
        </script>
    </body>
</html>
