
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="item.list" default="Item List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="item.new" default="New Item" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="item.list" default="Item List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="item.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="item.name" />
                        
                   	    <g:sortableColumn property="otherNames" title="Other Names" titleKey="item.otherNames" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="item.category" />
                        
                            <g:sortableColumn property="densityFactor" title="DensityFactor" titleKey="item.densityFactor" />
                        
                   	    <g:sortableColumn property="variety" title="Variety" titleKey="item.variety" />
                        
                   	    <g:sortableColumn property="brand" title="Brand" titleKey="item.brand" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${itemInstanceList}" status="i" var="itemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${itemInstance.id}">${fieldValue(bean: itemInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: itemInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: itemInstance, field: "otherNames")}</td>
                        
                            <td>${fieldValue(bean: itemInstance, field: "category")}</td>
                            
                            <td>${fieldValue(bean: itemInstance, field: "densityFactor")}</td>
                        
                            <td>${fieldValue(bean: itemInstance, field: "variety")}</td>
                        
                            <td>${fieldValue(bean: itemInstance, field: "brand")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${itemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
