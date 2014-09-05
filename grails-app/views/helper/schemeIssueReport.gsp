
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.show" default="SchemeMember Report" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
                      
        </div>
        <div class="body">
            <h1><g:message code="schemeMember.show" default="SchemeMember Concerns Report" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:each in="${totalIssueSummary}" var="item">
                
                 ${item[0]} ::  ${item[1]} ::<g:link controller="schemeMember" action="show" id="${item[3]}"> ${item[2]} </g:link>
                
                </br></br>
             </g:each>
            
        </div>
    </body>
</html>
