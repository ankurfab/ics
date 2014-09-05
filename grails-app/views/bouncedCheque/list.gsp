
<%@ page import="ics.BouncedCheque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'bouncedCheque.label', default: 'Dishonoured Cheque')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'bouncedCheque.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="donation" title="${message(code: 'bouncedCheque.donation.label', default: 'Donation')}" />
                        
                            <g:sortableColumn property="chequeNo" title="${message(code: 'bouncedCheque.chequeNo.label', default: 'Cheque No')}" />
                        
                            <g:sortableColumn property="chequeDate" title="${message(code: 'bouncedCheque.chequeDate.label', default: 'Cheque Date')}" />
                        
                            <g:sortableColumn property="bankName" title="${message(code: 'bouncedCheque.bankName.label', default: 'Bank Name')}" />
                        
                            <g:sortableColumn property="branchName" title="${message(code: 'bouncedCheque.branchName.label', default: 'Branch Name')}" />
                        
                            <g:sortableColumn property="issuedBy" title="${message(code: 'bouncedCheque.issuedBy.label', default: 'Issued By')}" />
                        
                            <g:sortableColumn property="status" title="${message(code: 'bouncedCheque.status.label', default: 'Status')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${bouncedChequeInstanceList}" status="i" var="bouncedChequeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${bouncedChequeInstance.id}">${fieldValue(bean: bouncedChequeInstance, field: "id")}</g:link></td>
                        
                            <td><g:link controller="donation" action="show" id="${bouncedChequeInstance.donation?.id}">${fieldValue(bean: bouncedChequeInstance, field: "donation")}</g:link></td>
                        
                            <td>${fieldValue(bean: bouncedChequeInstance, field: "chequeNo")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${bouncedChequeInstance.chequeDate}" /></td>
                        
                            <td>${fieldValue(bean: bouncedChequeInstance, field: "bankName")}</td>
                        
                            <td>${fieldValue(bean: bouncedChequeInstance, field: "branchName")}</td>
                        
                            <td>${fieldValue(bean: bouncedChequeInstance, field: "issuedBy")}</td>
                        
                            <td>${fieldValue(bean: bouncedChequeInstance, field: "status")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${bouncedChequeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
