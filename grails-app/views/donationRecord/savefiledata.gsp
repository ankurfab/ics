
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.upload.show" default="Upload DonationRecord" /></title>

    </head>
    <body>
     <r:require module="jqui" />
            <script>
            $(document).ready(function() {

          
            });
            </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
            </sec:ifAnyGranted>
         
            
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.show" default="DonationRecord Upload Message" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            
            To view data click on <g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link>
        </div>
    </body>
</html>
