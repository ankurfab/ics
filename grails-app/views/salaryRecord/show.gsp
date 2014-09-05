
<%@ page import="ics.SalaryRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="salaryRecord.show" default="Show SalaryRecord" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="salaryRecord.list" default="SalaryRecord List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="salaryRecord.new" default="New SalaryRecord" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="salaryRecord.show" default="Show SalaryRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${salaryRecordInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.datePaid" default="Date Paid" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${salaryRecordInstance?.datePaid}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.amountPaid" default="Amount Paid" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "amountPaid")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.paymentDetails" default="Payment Details" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "paymentDetails")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${salaryRecordInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${salaryRecordInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: salaryRecordInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="salaryRecord.indDep" default="Ind Dep" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individualDepartment" action="show" id="${salaryRecordInstance?.indDep?.id}">${salaryRecordInstance?.indDep?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
