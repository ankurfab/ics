
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.list" default="Create Zero donation records" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="create" action="uploadpaymentdata"><g:message code="donationRecord.upload" default="DonationRecord Upload" /></g:link></span>

                 <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
            </sec:ifAnyGranted>
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.zeropayment" default="Create Zero donation records For(Active, Irregular, Resumed)" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                        <th><g:message code="member.id" default="Id" /></th>
                   	    
                        
                   	    <th><g:message code="member.name" default="Legal Name" /></th>


                   	    <th><g:message code="member.center" default="Center" /></th>
                   	    
                        
                        <th><g:message code="member.status" default="Status" /></th>
                   	    
                        
                   	    <th><g:message code="member.comments" default="Comments" /></th>
                   	    
                   	     <th><g:message code="member.recentcommu" default="Recent Communication" /></th>

                         <th><g:message code="member.concerntoaddress" default="Address any Concern" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${members}" status="i" var="member">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link target="_blank" controller="schemeMember" action="show" id="${member.id}">${fieldValue(bean: member, field: "id")}</g:link></td>

                            <td><g:link target="_blank"  controller="schemeMember" action="show" id="${member.id}">${member?.member?.encodeAsHTML()}</g:link></td>
                        
                            <td>${member?.centre?.encodeAsHTML()}</td>
                        
                            <td>${member?.status}</td>
                        
                            <td>${member?.comments}</td>
                        
                            <td>${member?.recentCommunication}</td>
                        
                            <td>${member?.addressTheConcern}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:form method="post" >
            <div class="buttons">                   
                    <span class="button"><g:actionSubmit class="create" action="savezeropaymentrecords" value="${message(code: 'savezeropaymentrecords', 'default': 'Create Zero Donation Record Entry')}" onclick="return confirm('${message(code: 'upload.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
           
        </div>
    </body>
</html>
