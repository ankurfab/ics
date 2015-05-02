
<%@ page import="ics.Attribute" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attribute.list" default="Attribute List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="attribute.new" default="New Attribute" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attribute.list" default="Attribute List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="attribute.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="attribute.name" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="attribute.type" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="attribute.category" />
                        
                   	    <th><g:message code="attribute.department" default="Department" /></th>
                   	    
                   	    <th><g:message code="attribute.centre" default="Centre" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${attributeInstanceList}" status="i" var="attributeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${attributeInstance.id}">${fieldValue(bean: attributeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: attributeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: attributeInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: attributeInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: attributeInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: attributeInstance, field: "centre")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${attributeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
