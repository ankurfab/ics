
<%@ page import="ics.BatchItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="batchItem.list" default="BatchItem List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="batchItem.new" default="New BatchItem" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="batchItem.list" default="BatchItem List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="batchItem.id" />
                        
                   	    <g:sortableColumn property="postingDate" title="Posting Date" titleKey="batchItem.postingDate" />
                        
                   	    <g:sortableColumn property="effectiveDate" title="Effective Date" titleKey="batchItem.effectiveDate" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="batchItem.description" />
                        
                   	    <g:sortableColumn property="ref" title="Ref" titleKey="batchItem.ref" />
                        
                   	    <g:sortableColumn property="debit" title="Debit" titleKey="batchItem.debit" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${batchItemInstanceList}" status="i" var="batchItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${batchItemInstance.id}">${fieldValue(bean: batchItemInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${batchItemInstance.postingDate}" /></td>
                        
                            <td><g:formatDate date="${batchItemInstance.effectiveDate}" /></td>
                        
                            <td>${fieldValue(bean: batchItemInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: batchItemInstance, field: "ref")}</td>
                        
                            <td><g:formatBoolean boolean="${batchItemInstance.debit}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${batchItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
