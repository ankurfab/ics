
<%@ page import="ics.Challan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="challan.list" default="Challan List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="challan.new" default="New Challan" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="challan.list" default="Challan List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="challan.id" />
                        
                   	    <g:sortableColumn property="refNo" title="Ref No" titleKey="challan.refNo" />
                        
                   	    <th><g:message code="challan.issuedTo" default="Issued To" /></th>
                   	    
                   	    <th><g:message code="challan.issuedBy" default="Issued By" /></th>
                   	    
                   	    <th><g:message code="challan.settleBy" default="Settle By" /></th>
                   	    
                   	    <g:sortableColumn property="issueDate" title="Issue Date" titleKey="challan.issueDate" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${challanInstanceList}" status="i" var="challanInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${challanInstance.id}">${fieldValue(bean: challanInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: challanInstance, field: "refNo")}</td>
                        
                            <td>${fieldValue(bean: challanInstance, field: "issuedTo")}</td>
                        
                            <td>${fieldValue(bean: challanInstance, field: "issuedBy")}</td>
                        
                            <td>${fieldValue(bean: challanInstance, field: "settleBy")}</td>
                        
                            <td><g:formatDate date="${challanInstance.issueDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${challanInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
