
<%@ page import="ics.EventParticipant" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventParticipant.label', default: 'EventParticipant')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'eventParticipant.id.label', default: 'Id')}" />
                        
                            <th><g:message code="eventParticipant.event.label" default="Event" /></th>
                   	    
                            <th><g:message code="eventParticipant.individual.label" default="Individual" /></th>
                   	    
                            <g:sortableColumn property="attended" title="${message(code: 'eventParticipant.attended.label', default: 'Attended')}" />
                        
                            <g:sortableColumn property="invited" title="${message(code: 'eventParticipant.invited.label', default: 'Invited')}" />
                        
                            <g:sortableColumn property="confirmed" title="${message(code: 'eventParticipant.confirmed.label', default: 'Confirmed')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${eventParticipantInstanceList}" status="i" var="eventParticipantInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${eventParticipantInstance.id}">${fieldValue(bean: eventParticipantInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: eventParticipantInstance, field: "event")}</td>
                        
                            <td>${fieldValue(bean: eventParticipantInstance, field: "individual")}</td>
                        
                            <td><g:formatBoolean boolean="${eventParticipantInstance.attended}" /></td>
                        
                            <td><g:formatBoolean boolean="${eventParticipantInstance.invited}" /></td>
                        
                            <td><g:formatBoolean boolean="${eventParticipantInstance.confirmed}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventParticipantInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
