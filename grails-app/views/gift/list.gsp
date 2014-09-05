
<%@ page import="ics.Gift" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gift.label', default: 'Gift')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'gift.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'gift.name.label', default: 'Name')}" />
                        
                            <!--<th><g:message code="gift.scheme.label" default="Scheme" /></th>-->
                   	    
                            <g:sortableColumn property="worth" title="${message(code: 'gift.worth.label', default: 'Worth')}" />
                        
                            <g:sortableColumn property="cost" title="${message(code: 'gift.cost.label', default: 'Cost')}" />
                        
                            <g:sortableColumn property="qtyInStock" title="${message(code: 'gift.qtyInStock.label', default: 'Qty In Stock')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${giftInstanceList}" status="i" var="giftInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${giftInstance.id}">${fieldValue(bean: giftInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: giftInstance, field: "name")}</td>
                        
                            
                        
                            <td>${fieldValue(bean: giftInstance, field: "worth")}</td>
                        
                            <td>${fieldValue(bean: giftInstance, field: "cost")}</td>
                        
                            <td>${fieldValue(bean: giftInstance, field: "qtyInStock")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${giftInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
