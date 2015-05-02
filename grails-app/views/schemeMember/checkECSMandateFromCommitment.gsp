
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="reminders.list" default="Check List" /></title>
	<r:require module="grid" />
    <r:require module="export"/>    
        <export:resource />
        <style>
        td{vertical-align:top;}
        </style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            
            <span class="menuButton"><g:link class="list" controller="schemeMember" action="list"><g:message code="schememMembers.list" default="Scheme Members List" /></g:link></span>                
        </div>
        <div class="body">
            <h1><g:message code="reminders.list" default="Copies ECS Mandate from Committment to Scheme Member" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
		  <div>
        
    <table>
    <tbody bgcolor="lavender">
    <tr>
     <td>
     Schemes getting processed  ${schemes}
     </td>
    </tr>
    <tr>
    <td>${size} Scheme Members got updated and Made Active</td>
    </tr>
    <tr>
    <td>
    ${notfound} Committment does not have any scheme member in system ,please correct, they are listed below
    </td>
    </tr>
    <tr>
    <td>
    <table>
    <g:each in="${noLinkedIndividuals}" status="i" var="record">
    <tr>
     <td>Scheme : ${record[0]}</td>
     <td><g:link controller="individual" action="show" params="['id':record[1].id]" target="_blank">${record[1]}</g:link></td>
    </tr>
    </g:each>
    </table>
    </td>
    </tr>
    </tbody>
    </table>
    
		</div>
        </div>
        


        
    </body>
</html>
