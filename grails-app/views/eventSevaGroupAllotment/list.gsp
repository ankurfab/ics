
<%@ page import="ics.EventSevaGroupAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaGroupAllotment.list" default="EventSevaGroupAllotment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaGroupAllotment.new" default="New EventSevaGroupAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaGroupAllotment.list" default="EventSevaGroupAllotment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="eventSevaGroupAllotment.id" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="eventSevaGroupAllotment.dateCreated" />
                        
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="eventSevaGroupAllotment.creator" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="eventSevaGroupAllotment.lastUpdated" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="eventSevaGroupAllotment.updator" />
                        
                   	    <th><g:message code="eventSevaGroupAllotment.eventSeva" default="Event Seva" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${eventSevaGroupAllotmentInstanceList}" status="i" var="eventSevaGroupAllotmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${eventSevaGroupAllotmentInstance.id}">${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${eventSevaGroupAllotmentInstance.dateCreated}" /></td>
                        
                            <td>${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "creator")}</td>
                        
                            <td><g:formatDate date="${eventSevaGroupAllotmentInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "updator")}</td>
                        
                            <td>${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "eventSeva")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventSevaGroupAllotmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
