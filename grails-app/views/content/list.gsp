
<%@ page import="ics.Content" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="content.list" default="Content List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="content.new" default="New Content" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="content.list" default="Content List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="content.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="content.name" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="content.description" />
                        
                   	    <g:sortableColumn property="htmlContent" title="Html Content" titleKey="content.htmlContent" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="content.category" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="content.type" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${contentInstanceList}" status="i" var="contentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${contentInstance.id}">${fieldValue(bean: contentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: contentInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: contentInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: contentInstance, field: "htmlContent")}</td>
                        
                            <td>${fieldValue(bean: contentInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: contentInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${contentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
