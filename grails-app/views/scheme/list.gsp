
<%@ page import="ics.Scheme" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'scheme.label', default: 'Scheme')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'scheme.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'scheme.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="minAmount" title="${message(code: 'scheme.minAmount.label', default: 'Min Amount')}" />
                        
                            <g:sortableColumn property="benefits" title="${message(code: 'scheme.benefits.label', default: 'Benefits')}" />
                        
                            <g:sortableColumn property="effectiveFrom" title="${message(code: 'scheme.effectiveFrom.label', default: 'Effective From')}" />
                            
                            <g:sortableColumn property="effectiveTill" title="${message(code: 'scheme.effectiveTill.label', default: 'Effective Till')}" />
                        
                            <g:sortableColumn property="costCenter" title="${message(code: 'scheme.costCenter.label', default: 'Cost Center')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${schemeInstanceList}" status="i" var="schemeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${schemeInstance.id}">${fieldValue(bean: schemeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: schemeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: schemeInstance, field: "minAmount")}</td>
                        
                            <td>${fieldValue(bean: schemeInstance, field: "benefits")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${schemeInstance.effectiveFrom}" /></td>
                            
                            <td><g:formatDate format="dd-MM-yyyy" date="${schemeInstance.effectiveTill}" /></td>
                        
                            <td>${fieldValue(bean: schemeInstance, field: "cc")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${schemeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
