
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="voucher.list" default="Voucher List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="voucher.new" default="New Voucher" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="voucher.list" default="Voucher List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="voucher.id" />
                        
                   	    <g:sortableColumn property="voucherDate" title="Voucher Date" titleKey="voucher.voucherDate" />
                        
                   	    <th><g:message code="voucher.departmentCode" default="Department Code" /></th>
                   	    
                   	    <g:sortableColumn property="voucherNo" title="Voucher No" titleKey="voucher.voucherNo" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="voucher.description" />

                   	    <g:sortableColumn property="amount" title="Withdrawal" titleKey="voucher.amount" />
                        
                   	    <g:sortableColumn property="amountSettled" title="Deposit" titleKey="voucher.amountSettled" />
                        
                   	    <g:sortableColumn property="updator" title="Updator" titleKey="voucher.updator" />

                   	    <g:sortableColumn property="lastUpdated" title="LastUpdated Date" titleKey="voucher.lastUpdated" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${voucherInstanceList}" status="i" var="voucherInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${voucherInstance.id}">${fieldValue(bean: voucherInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${voucherInstance.voucherDate}" /></td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "departmentCode")}</td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "voucherNo")}</td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "amount")}</td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "amountSettled")}</td>
                        
                            <td>${fieldValue(bean: voucherInstance, field: "updator")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy HH:mm:ss" date="${voucherInstance.lastUpdated}" /></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${voucherInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
