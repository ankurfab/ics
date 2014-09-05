
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Dashboard For ${clor} </title>
	<r:require module="jqui" />
	<r:require module="newjqplot" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>Dandavats HG ${clor}</h1>
            <h2>More Devotees! Happy Devotees!!</h2>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="clorSummary"/>
	    </div>
	    <div id="divDonations" style="margin-top:20px; width:600px; height:200px;float:left;">
	    	<g:render template="donationSummary"/>
	    </div>
	    <div id="divBD" style="margin-top:20px; width:600px; height:200px;float:left;">
	    	<g:render template="bdSummary"/>
	    </div>
	    <div id="divMeetings" style="margin-top:20px; width:400px; height:200px;float:left;">
	    	<g:render template="meetingSummary"/>
	    </div>
	    <div id="divEvents" style="margin-top:20px; width:400px; height:200px;float:left;">
	    	<g:render template="eventSummary"/>
	    </div>
        </div>

	<script>

$(document).ready(function(){

});

	</script>



    </body>
</html>
