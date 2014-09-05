
<%@ page import="ics.PurchaseList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="purchaseList.list" default="PurchaseList List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="purchaseList.new" default="New PurchaseList" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="purchaseList.list" default="PurchaseList List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="purchaseList.id" />
                        
                   	    <g:sortableColumn property="purchaseListDate" title="Purchase List Date" titleKey="purchaseList.purchaseListDate" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="purchaseList.name" />
                        
                   	    <th><g:message code="purchaseList.preparedBy" default="Prepared By" /></th>
                   	    
                   	    <g:sortableColumn property="preparationComments" title="Preparation Comments" titleKey="purchaseList.preparationComments" />
                        
                   	    <g:sortableColumn property="status" title="Status" titleKey="purchaseList.status" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${purchaseListInstanceList}" status="i" var="purchaseListInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${purchaseListInstance.id}">${fieldValue(bean: purchaseListInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${purchaseListInstance.purchaseListDate}" /></td>
                        
                            <td>${fieldValue(bean: purchaseListInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: purchaseListInstance, field: "preparedBy")}</td>
                        
                            <td>${fieldValue(bean: purchaseListInstance, field: "preparationComments")}</td>
                        
                            <td>${fieldValue(bean: purchaseListInstance, field: "status")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${purchaseListInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
