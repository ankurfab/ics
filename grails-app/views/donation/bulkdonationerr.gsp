
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${'BulkDonation'}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
			<span class="menuButton"><g:link class="create" action="bulkdonation0">Bulk Donation</g:link></span>
			<span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
			<span class="menuButton"><g:link class="create" controller="receiptBookIssued" action="edit" params="[id: receiptBookIssuedId]">Return ReceiptBook</g:link></span>
		</div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
        </div>
    </body>
</html>
