
<%@ page import="ics.OtherContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'otherContact.label', default: 'OtherContact')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'otherContact.id.label', default: 'Id')}" />
                        
                            <th><g:message code="otherContact.individual.label" default="Individual" /></th>
                   	    
                            <g:sortableColumn property="category" title="${message(code: 'otherContact.category.label', default: 'Category')}" />
                        
                            <g:sortableColumn property="contactType" title="${message(code: 'otherContact.contactType.label', default: 'Contact Type')}" />
                        
                            <g:sortableColumn property="contactValue" title="${message(code: 'otherContact.contactValue.label', default: 'Contact Value')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${otherContactInstanceList}" status="i" var="otherContactInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${otherContactInstance.id}">${fieldValue(bean: otherContactInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: otherContactInstance, field: "individual")}</td>
                        
                            <td>${fieldValue(bean: otherContactInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: otherContactInstance, field: "contactType")}</td>
                        
                            <td>${fieldValue(bean: otherContactInstance, field: "contactValue")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${otherContactInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
