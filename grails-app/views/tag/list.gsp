
<%@ page import="ics.Tag" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tag.list" default="Tag List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="tag.new" default="New Tag" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="tag.list" default="Tag List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="tag.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="tag.name" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="tag.category" />
                        
                   	    <th><g:message code="tag.department" default="Department" /></th>
                   	    
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="tag.creator" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="tag.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tagInstanceList}" status="i" var="tagInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tagInstance.id}">${fieldValue(bean: tagInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: tagInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: tagInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: tagInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: tagInstance, field: "creator")}</td>
                        
                            <td><g:formatDate date="${tagInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tagInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
