
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="reminders.list" default="Check List" /></title>
	<r:require module="grid" />
    <r:require module="jqui" />
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
            <h1><g:message code="reminders.list" default="Finding Individuals which have given Donation for below Schemes but not having Scheme Membership" /></h1>
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
    <td>${size} Individuals are found. find about them and make their respective membership.</td>
    </tr>
    <tr>
   
    </tr>
    <tr>
    <td>
    <table>
    <tr class="prop">
            <td valign="top" class="name">
           From Date
            </td>

            <td valign="top" class="value">
            <g:form  action="findDonationRecordsHavingNoSchemeMember" >
                     <g:textField name="fromDate" value="${fromDate}"/>  
                      <span class="button"><input type="submit" class="edit"value="${message(code: 'schemeMemberDonationReport', 'default': 'Get Records')}"  /></span>  
            </g:form>
            </td>
    </tr>
    <tr>
    <td>Name of Member</td><td>Donation given to the scheme Since above date:</td>
    </tr>
    <g:each in="${individuals}" status="i" var="record">
    <tr>     
     <td><g:link controller="individual" action="show" params="['id':record[0].id]" target="_blank">${record[0]}</g:link></td>
     <td>${record[1]}</td>
    </tr>
    </g:each>
    </table>
    </td>
    </tr>
    </tbody>
    </table>
    
		</div>
        </div>
        
 <script type="text/javascript" language="javascript">

         $(document).ready(function(){

               $("#fromDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                });
        </script>

        
    </body>
</html>
