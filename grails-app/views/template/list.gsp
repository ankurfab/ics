
<%@ page import="ics.Template" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="template.list" default="Template List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="template.new" default="New Template" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="template.list" default="Template List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="template.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="template.name" />
                        
                   	    <g:sortableColumn property="code" title="Code" titleKey="template.code" />
                        
                   	    <g:sortableColumn property="body" title="Body" titleKey="template.body" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="template.category" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="template.type" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${templateInstanceList}" status="i" var="templateInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${templateInstance.id}">${fieldValue(bean: templateInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "body")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: templateInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${templateInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
