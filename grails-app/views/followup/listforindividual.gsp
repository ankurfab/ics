
<%@ page import="ics.Followup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'followup.label', default: 'Followup')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="search">Search</g:link></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'followup.id.label', default: 'Id')}" />
                        
                  	    
                            <g:sortableColumn property="startDate" title="${message(code: 'followup.startDate.label', default: 'Start Date')}" />
                        
                            <g:sortableColumn property="endDate" title="${message(code: 'followup.endDate.label', default: 'End Date')}" />
                        
                            <g:sortableColumn property="category" title="${message(code: 'followup.category.label', default: 'Category')}" />
                            <th><g:message code="followup.indBy.comments" default="Comments" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${followupInstanceList}" status="i" var="followupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${followupInstance.id}">${fieldValue(bean: followupInstance, field: "id")}</g:link></td>
                        
                        
                            <td><g:formatDate date="${followupInstance.startDate}" /></td>
                        
                            <td><g:formatDate date="${followupInstance.endDate}" /></td>
                        
                            <td>${fieldValue(bean: followupInstance, field: "category")}</td>

                            <td>${fieldValue(bean: followupInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${followupInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
