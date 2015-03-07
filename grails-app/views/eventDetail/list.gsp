
<%@ page import="ics.EventDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventDetail.list" default="EventDetail List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventDetail.new" default="New EventDetail" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventDetail.list" default="EventDetail List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="eventDetail.id" />
                        
                   	    <g:sortableColumn property="event" title="Event" titleKey="eventDetail.event" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="eventDetail.category" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="eventDetail.type" />
                        
                   	    <g:sortableColumn property="details" title="Details" titleKey="eventDetail.details" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="eventDetail.updator" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="eventDetail.lastUpdated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${eventDetailInstanceList}" status="i" var="eventDetailInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${eventDetailInstance.id}">${fieldValue(bean: eventDetailInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: eventDetailInstance, field: "event")}</td>
                        
                            <td>${fieldValue(bean: eventDetailInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: eventDetailInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: eventDetailInstance, field: "details")}</td>
                        
                            <td>${fieldValue(bean: eventDetailInstance, field: "updator")}</td>
                        
                            <td><g:formatDate date="${eventDetailInstance.lastUpdated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventDetailInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
