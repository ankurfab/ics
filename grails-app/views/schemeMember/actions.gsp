
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="reminders.list" default="Action List" /></title>
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
            <h1><g:message code="reminders.list" default="Executive Action List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
		  <div>
        
    <table>
    <tbody bgcolor="lavender">
    <tr>
      <td>
        <g:link class="list" controller="giftRecord" action="updateGiftRecordCentres"><g:message code="giftRecord.list" default="Update Gift Record Centres" /></g:link>
      </td>
    </tr>
    <tr></tr>
     <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="updateToBeCommunicatedOfMembers"><g:message code="schemeMember.update" default="Update SchemeMembers with No For To Be Communicated" /></g:link>
      </td>
    </tr>
    <tr></tr>
    <tr>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="checkECSMandateFromCommitment"><g:message code="schemeMember.update" default="Check Consumer Number of SchemeMembers With ECS Mandate From Commitment" /></g:link>
      </td>
    </tr>
    </tbody>
    </table>
    
		</div>
        </div>
        


        
    </body>
</html>
