
<%@ page import="ics.MbProfile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="mbProfile.list" default="MbProfile List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="mbProfile.new" default="New MbProfile" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="mbProfile.list" default="MbProfile List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="mbProfile.id" />
                        
                   	    <th><g:message code="mbProfile.candidate" default="Candidate" /></th>
                   	    
                   	    <th><g:message code="mbProfile.referredBy" default="Referred By" /></th>
                   	    
                   	    <th><g:message code="mbProfile.assignedTo" default="Assigned To" /></th>
                   	    
                   	    <g:sortableColumn property="profileStatus" title="Profile Status" titleKey="mbProfile.profileStatus" />
                        
                   	    <g:sortableColumn property="matchMakingStatus" title="Match Making Status" titleKey="mbProfile.matchMakingStatus" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${mbProfileInstanceList}" status="i" var="mbProfileInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${mbProfileInstance.id}">${fieldValue(bean: mbProfileInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: mbProfileInstance, field: "candidate")}</td>
                        
                            <td>${fieldValue(bean: mbProfileInstance, field: "referredBy")}</td>
                        
                            <td>${fieldValue(bean: mbProfileInstance, field: "assignedTo")}</td>
                        
                            <td>${fieldValue(bean: mbProfileInstance, field: "profileStatus")}</td>
                        
                            <td>${fieldValue(bean: mbProfileInstance, field: "matchMakingStatus")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${mbProfileInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
