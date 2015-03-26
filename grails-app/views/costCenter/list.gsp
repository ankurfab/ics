
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenter.list" default="CostCenter List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" controller="costCategory" action="list"><g:message code="costCategory.list" default="CostCategory List" /></g:link></span>
            <span class="menuButton"><g:link class="list" controller="costCategoryPaymentMode" action="list"><g:message code="costCategory.list" default="CostCategoryPaymentMode List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenter.list" default="CostCenter List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="costCenter.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="costCenter.name" />
                        
                   	    <g:sortableColumn property="alias" title="Alias" titleKey="costCenter.alias" />
                        
                   	    <g:sortableColumn property="costCategory" title="CostCategory" titleKey="costCenter.costCategory" />
                        
                   	    <g:sortableColumn property="isProfitCenter" title="IsProfitCenter" titleKey="costCenter.isProfitCenter" />

                   	    <g:sortableColumn property="isServiceCenter" title="IsServiceCenter" titleKey="costCenter.isServiceCenter" />

                   	    <g:sortableColumn property="budget" title="Budget" titleKey="costCenter.budget" />

                   	    <g:sortableColumn property="capitalBudget" title="CapitalBudget" titleKey="costCenter.capitalBudget" />

                   	    <g:sortableColumn property="owner" title="Owner" titleKey="costCenter.owner" />
                        
                   	    <g:sortableColumn property="owner1" title="Owner1" titleKey="costCenter.owner1" />
                        
                   	    <g:sortableColumn property="owner2" title="Owner2" titleKey="costCenter.owner2" />
                        
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="costCenter.lastUpdated" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="costCategoryPaymentMode.updator" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${costCenterInstanceList}" status="i" var="costCenterInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${costCenterInstance.id}">${fieldValue(bean: costCenterInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: costCenterInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: costCenterInstance, field: "alias")}</td>
                        
                            <td>${fieldValue(bean: costCenterInstance, field: "costCategory")}</td>
                        
                            <td>${costCenterInstance.isProfitCenter?'Yes':'No'}</td>
                                                
                            <td>${costCenterInstance.isServiceCenter?'Yes':'No'}</td>
                                                
                            <td>${fieldValue(bean: costCenterInstance, field: "budget")}</td>
                                                
                            <td>${fieldValue(bean: costCenterInstance, field: "capitalBudget")}</td>
                                                
                            <td>${fieldValue(bean: costCenterInstance, field: "owner")}</td>
                                                
                            <td>${fieldValue(bean: costCenterInstance, field: "owner1")}</td>
                                                
                            <td>${fieldValue(bean: costCenterInstance, field: "owner2")}</td>
                                                
                            <td><g:formatDate format="dd-MM-yyyy" date="${costCenterInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: costCenterInstance, field: "updator")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${costCenterInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
