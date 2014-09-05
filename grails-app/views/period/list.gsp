
<%@ page import="ics.Period" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="period.list" default="Period List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="period.new" default="New Period" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="period.list" default="Period List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="period.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="period.name" />
                        
                   	    <g:sortableColumn property="category" title="Category" titleKey="period.category" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="period.type" />
                        
                   	    <g:sortableColumn property="fromDate" title="From Date" titleKey="period.fromDate" />
                        
                   	    <g:sortableColumn property="toDate" title="To Date" titleKey="period.toDate" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${periodInstanceList}" status="i" var="periodInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${periodInstance.id}">${fieldValue(bean: periodInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: periodInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: periodInstance, field: "category")}</td>
                        
                            <td>${fieldValue(bean: periodInstance, field: "type")}</td>
                        
                            <td><g:formatDate date="${periodInstance.fromDate}" /></td>
                        
                            <td><g:formatDate date="${periodInstance.toDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${periodInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
