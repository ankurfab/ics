
<%@ page import="ics.EventCriteria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventCriteria.label', default: 'EventCriteria')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="slips">Slips</g:link></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'eventCriteria.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'eventCriteria.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'eventCriteria.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="conditon1" title="${message(code: 'eventCriteria.conditon1.label', default: 'Conditon1')}" />
                        
                            <g:sortableColumn property="conditon2" title="${message(code: 'eventCriteria.conditon2.label', default: 'Conditon2')}" />
                        
                            <g:sortableColumn property="conditon3" title="${message(code: 'eventCriteria.conditon3.label', default: 'Conditon3')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${eventCriteriaInstanceList}" status="i" var="eventCriteriaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${eventCriteriaInstance.id}">${fieldValue(bean: eventCriteriaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: eventCriteriaInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: eventCriteriaInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: eventCriteriaInstance, field: "conditon1")}</td>
                        
                            <td>${fieldValue(bean: eventCriteriaInstance, field: "conditon2")}</td>
                        
                            <td>${fieldValue(bean: eventCriteriaInstance, field: "conditon3")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${eventCriteriaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
