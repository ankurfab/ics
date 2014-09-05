
<%@ page import="ics.SalaryRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="salaryRecord.edit" default="Edit SalaryRecord" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="salaryRecord.list" default="SalaryRecord List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="salaryRecord.new" default="New SalaryRecord" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="salaryRecord.edit" default="Edit SalaryRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${salaryRecordInstance}">
            <div class="errors">
                <g:renderErrors bean="${salaryRecordInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${salaryRecordInstance?.id}" />
                <g:hiddenField name="version" value="${salaryRecordInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="datePaid"><g:message code="salaryRecord.datePaid" default="Date Paid" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'datePaid', 'errors')}">
                                    <g:datePicker name="datePaid" value="${salaryRecordInstance?.datePaid}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amountPaid"><g:message code="salaryRecord.amountPaid" default="Amount Paid" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'amountPaid', 'errors')}">
                                    <g:textField name="amountPaid" value="${fieldValue(bean: salaryRecordInstance, field: 'amountPaid')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentDetails"><g:message code="salaryRecord.paymentDetails" default="Payment Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'paymentDetails', 'errors')}">
                                    <g:textField name="paymentDetails" value="${fieldValue(bean: salaryRecordInstance, field: 'paymentDetails')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="salaryRecord.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: salaryRecordInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="salaryRecord.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${salaryRecordInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="salaryRecord.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: salaryRecordInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="salaryRecord.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${salaryRecordInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="salaryRecord.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: salaryRecordInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="indDep"><g:message code="salaryRecord.indDep" default="Ind Dep" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salaryRecordInstance, field: 'indDep', 'errors')}">
                                    <g:select name="indDep.id" from="${ics.IndividualDepartment.list()}" optionKey="id" value="${salaryRecordInstance?.indDep?.id}"  />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
