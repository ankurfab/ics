
<%@ page import="ics.EventSevaAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaAllotment.list" default="EventSevaAllotment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaAllotment.new" default="New EventSevaAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaAllotment.list" default="EventSevaAllotment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="eventSevaAllotment.id" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="eventSevaAllotment.dateCreated" />
                        
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="eventSevaAllotment.creator" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="eventSevaAllotment.lastUpdated" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="eventSevaAllotment.updator" />
                        
                   	    <th><g:message code="eventSevaAllotment.eventSeva" default="Event Seva" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${eventSevaAllotmentInstanceList}" status="i" var="eventSevaAllotmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${eventSevaAllotmentInstance.id}">${fieldValue(bean: eventSevaAllotmentInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${eventSevaAllotmentInstance.dateCreated}" /></td>
                        
                            <td>${fieldValue(bean: eventSevaAllotmentInstance, field: "creator")}</td>
                        
                            <td><g:formatDate date="${eventSevaAllotmentInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: eventSevaAllotmentInstance, field: "updator")}</td>
                        
                            <td>${fieldValue(bean: eventSevaAllotmentInstance, field: "eventSeva")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventSevaAllotmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
