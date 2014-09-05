
<%@ page import="ics.Receipt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'receipt.id.label', default: 'Id')}" />
                        
                            <th><g:message code="receipt.receiptBook.label" default="Receipt Book" /></th>
                   	    
                            <g:sortableColumn property="receiptNumber" title="${message(code: 'receipt.receiptNumber.label', default: 'Receipt Number')}" />
                        
                            <g:sortableColumn property="isBlank" title="${message(code: 'receipt.isBlank.label', default: 'Is Blank')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${receiptInstanceList}" status="i" var="receiptInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${receiptInstance.id}">${fieldValue(bean: receiptInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: receiptInstance, field: "receiptBook")}</td>
                        
                            <td>${fieldValue(bean: receiptInstance, field: "receiptNumber")}</td>
                        
                            <td><g:formatBoolean boolean="${receiptInstance.isBlank}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${receiptInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
