
<%@ page import="ics.AccessLog" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="plain">
        <title>Jq Plot Demo</title>

    <r:require module="jqmobile" />


    <style type="text/css" media="screen">
        .jqplot-axis {
            font-size: 0.85em;
        }
        .jqplot-title {
            font-size: 1.1em;
        }

        #container
        {

            border: 1px solid black;" 
            }

            #currentdiv
            {
            width:300px;
            height:80%;
            }

            #midnight
            {
            width:300px;
            height:80%;
            }
            #onemonth
            {
            width:300px;
            height:250px;
            }
            #oneyear
            {
            width:300px;
            height:250px;
            }
            div[data-role ="page"] 
            {            width: 95%;
            height: 100%;
            }
            .collaps.p
            {
            width:10%;
            }
        </style>
    </head>
    <body>
        <div data-role="page" id="pageone">	
            <div class="panel left" data-role="panel" data-position="left "data-theme="p" data-display="overlay"  data-shadow="true" id="panel-01">
                <ul data-role="listview" id="dashboard">
                    <li class="current"><a href="#" title="Home">current logged in users</a> </li>
                    <li class="mid"><a href="#" title="Profile">login users since midnight</a></li>
                    <li class="onemonth"><a href="#" title="Setting">Last 1 month logins count</a></li>
                    <li class="oneyear"><a href="#" title="Logout">Last 12 month logins count</a></li>
                </ul>
            </div>

            <div class="header" data-role="header">
                <p>This is a Header: Count: ${count}</p>
            </div>


            <div data-role="main" class="ui-content">
                <span class="title">Access Log DashBoard</span>
                <span class="open left" data-icon="bars">
                <a href="#panel-01#" data-role="button" data-icon="bars" data-iconpos="notext" data-theme="b" data-iconshadow="false" data-inline="true">&#9776;</a>
                </span>
                <div id="container">
                    <span>current logged in users (in last 2 hours)</span>
                    <div id="currentdiv">

                        <g:each in="${accessLogInstanceList}" status="i" var="accessLogInstance">

                            <fieldset data-role="collapsible" data-theme="a" data-content-theme="d" class="collaps">
                                <legend>${fieldValue(bean: accessLogInstance, field: "loginid")}</legend>
                                <p> Loginid:${fieldValue(bean: accessLogInstance, field: "loginid")}</p>
                                <p> Ipaddr:${fieldValue(bean: accessLogInstance, field: "ipaddr")}</p>
                                <p>Login Time:<g:formatDate date="${accessLogInstance.loginTime}" /></p>
                                <p> Logout Time:<g:link action="show" id="${accessLogInstance.id}">${fieldValue(bean: accessLogInstance, field: "logoutTime")}</g:link>
                                </p>
                            </fieldset>
                        </g:each>
                    </div>

                    <span>Login User Since Midnight</span>
                    <div id="midnight">
                        <g:each in="${accessLogInstanceList}" status="i" var="accessLogInstance">

                            <fieldset data-role="collapsible" data-theme="a" data-content-theme="d" class="collaps">
                                <legend>${fieldValue(bean: accessLogInstance, field: "loginid")}</legend>
                                <p> Loginid:${fieldValue(bean: accessLogInstance, field: "loginid")}</p>
                                <p> Ipaddr:${fieldValue(bean: accessLogInstance, field: "ipaddr")}</p>
                                <p>Login Time:<g:formatDate date="${accessLogInstance.loginTime}" /></p>
                                <p> Logout Time:<g:link action="show" id="${accessLogInstance.id}">${fieldValue(bean: accessLogInstance, field: "logoutTime")}</g:link>
                                </p>
                            </fieldset>
                        </g:each>
                    </div>
                    <span>Last 1 Month Count of logins</span>
                    <div id="onemonth"></div>

                    <span>Last 12 Month Count of logins</span>
                    <div id="oneyear"></div>
                </div>

            </div>

            <h1>Page Footer</h1>
        </div>
    </div>

</body>
</html>
