
<%@ page import="ics.SalaryRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="salaryRecord.list" default="SalaryRecord List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="salaryRecord.new" default="New SalaryRecord" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="salaryRecord.list" default="SalaryRecord List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="salaryRecord.id" />
                        
                   	    <g:sortableColumn property="datePaid" title="Date Paid" titleKey="salaryRecord.datePaid" />
                        
                   	    <g:sortableColumn property="amountPaid" title="Amount Paid" titleKey="salaryRecord.amountPaid" />
                        
                   	    <g:sortableColumn property="paymentDetails" title="Payment Details" titleKey="salaryRecord.paymentDetails" />
                        
                   	    <g:sortableColumn property="comments" title="Comments" titleKey="salaryRecord.comments" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="salaryRecord.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${salaryRecordInstanceList}" status="i" var="salaryRecordInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${salaryRecordInstance.id}">${fieldValue(bean: salaryRecordInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${salaryRecordInstance.datePaid}" /></td>
                        
                            <td>${fieldValue(bean: salaryRecordInstance, field: "amountPaid")}</td>
                        
                            <td>${fieldValue(bean: salaryRecordInstance, field: "paymentDetails")}</td>
                        
                            <td>${fieldValue(bean: salaryRecordInstance, field: "comments")}</td>
                        
                            <td><g:formatDate date="${salaryRecordInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${salaryRecordInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
