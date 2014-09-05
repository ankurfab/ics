
<%@ page import="ics.CostCategoryPaymentMode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategoryPaymentMode.list" default="CostCategoryPaymentMode List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCategoryPaymentMode.new" default="New CostCategoryPaymentMode" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCategoryPaymentMode.list" default="CostCategoryPaymentMode List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="costCategoryPaymentMode.id" />
                        
                   	    <th><g:message code="costCategoryPaymentMode.costCategory" default="Cost Category" /></th>
                   	    
                   	    <th><g:message code="costCategoryPaymentMode.paymentMode" default="Payment Mode" /></th>
                   	    
                   	    <g:sortableColumn property="bankCode" title="Bank Code" titleKey="costCategoryPaymentMode.bankCode" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Date Updated" titleKey="costCategoryPaymentMode.lastUpdated" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="costCategoryPaymentMode.updator" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${costCategoryPaymentModeInstanceList}" status="i" var="costCategoryPaymentModeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${costCategoryPaymentModeInstance.id}">${fieldValue(bean: costCategoryPaymentModeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: costCategoryPaymentModeInstance, field: "costCategory")}</td>
                        
                            <td>${fieldValue(bean: costCategoryPaymentModeInstance, field: "paymentMode")}</td>
                        
                            <td>${fieldValue(bean: costCategoryPaymentModeInstance, field: "bankCode")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${costCategoryPaymentModeInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: costCategoryPaymentModeInstance, field: "updator")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${costCategoryPaymentModeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
