
<%@ page import="ics.Expense" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="expense.list" default="Expense List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new" default="New Expense" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="expense.list" default="Expense List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="expense.id" />
                        
                   	    <th><g:message code="expense.centre" default="Centre" /></th>
                   	    
                   	    <th><g:message code="expense.department" default="Department" /></th>
                   	    
                   	    <th><g:message code="expense.costCenter" default="Cost Center" /></th>
                   	    
                   	    <th><g:message code="expense.raisedBy" default="Raised By" /></th>
                   	    
                   	    <g:sortableColumn property="type" title="Type" titleKey="expense.type" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${expenseInstanceList}" status="i" var="expenseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${expenseInstance.id}">${fieldValue(bean: expenseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: expenseInstance, field: "centre")}</td>
                        
                            <td>${fieldValue(bean: expenseInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: expenseInstance, field: "costCenter")}</td>
                        
                            <td>${fieldValue(bean: expenseInstance, field: "raisedBy")}</td>
                        
                            <td>${fieldValue(bean: expenseInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${expenseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
