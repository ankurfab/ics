
<%@ page import="ics.Batch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batch.list" default="Batch List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="batch.new" default="New Batch" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batch.list" default="Batch List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="batch.id" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="batch.category" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="batch.type" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="batch.name" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="batch.description" />
                        
                   	    <g:sortableColumn property="ref" title="Ref" titleKey="batch.ref" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${batchInstanceList}" status="i" var="batchInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${batchInstance.id}">${fieldValue(bean: batchInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: batchInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: batchInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: batchInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: batchInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: batchInstance, field: "ref")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${batchInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
