
<%@ page import="ics.EmailContact" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'emailContact.label', default: 'EmailContact')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'emailContact.id.label', default: 'Id')}" />
                        
                            <th><g:message code="emailContact.individual.label" default="Individual" /></th>
                   	    
                            <g:sortableColumn property="category" title="${message(code: 'emailContact.category.label', default: 'Category')}" />
                        
                            <g:sortableColumn property="emailAddress" title="${message(code: 'emailContact.emailAddress.label', default: 'Email Address')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${emailContactInstanceList}" status="i" var="emailContactInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${emailContactInstance.id}">${fieldValue(bean: emailContactInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: emailContactInstance, field: "individual")}</td>
                        
                            <td>${fieldValue(bean: emailContactInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: emailContactInstance, field: "emailAddress")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${emailContactInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
