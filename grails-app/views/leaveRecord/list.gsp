
<%@ page import="ics.LeaveRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="leaveRecord.list" default="LeaveRecord List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="leaveRecord.new" default="New LeaveRecord" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="leaveRecord.list" default="LeaveRecord List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="leaveRecord.id" />
                        
                   	    <g:sortableColumn property="dateFrom" title="Date From" titleKey="leaveRecord.dateFrom" />
                        
                   	    <g:sortableColumn property="dateTill" title="Date Till" titleKey="leaveRecord.dateTill" />
                        
                   	    <g:sortableColumn property="status" title="Status" titleKey="leaveRecord.status" />
                        
                   	    <g:sortableColumn property="comments" title="Comments" titleKey="leaveRecord.comments" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="leaveRecord.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${leaveRecordInstanceList}" status="i" var="leaveRecordInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${leaveRecordInstance.id}">${fieldValue(bean: leaveRecordInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${leaveRecordInstance.dateFrom}" /></td>
                        
                            <td><g:formatDate date="${leaveRecordInstance.dateTill}" /></td>
                        
                            <td>${fieldValue(bean: leaveRecordInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: leaveRecordInstance, field: "comments")}</td>
                        
                            <td><g:formatDate date="${leaveRecordInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${leaveRecordInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
