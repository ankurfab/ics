
<%@ page import="ics.CostCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategory.list" default="CostCategory List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCategory.new" default="New CostCategory" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCategory.list" default="CostCategory List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="costCategory.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="costCategory.name" />
                        
                   	    <g:sortableColumn property="alias" title="Alias" titleKey="costCategory.alias" />
                        
                   	    <g:sortableColumn property="owner" title="Owner" titleKey="costCategory.owner" />
                                                
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="costCategory.lastUpdated" />

                   	    <g:sortableColumn property="updator" title="Updator" titleKey="costCategoryPaymentMode.updator" />
                                                
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${costCategoryInstanceList}" status="i" var="costCategoryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${costCategoryInstance.id}">${fieldValue(bean: costCategoryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: costCategoryInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: costCategoryInstance, field: "alias")}</td>
                        
                            <td>${fieldValue(bean: costCategoryInstance, field: "owner")}</td>
                                                
                            <td><g:formatDate format="dd-MM-yyyy" date="${costCategoryInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: costCategoryInstance, field: "updator")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${costCategoryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
