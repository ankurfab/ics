
<%@ page import="ics.Expense" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="expense.create" default="Create Expense" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="expense.list" default="Expense List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="expense.create" default="Create Expense" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${expenseInstance}">
            <div class="errors">
                <g:renderErrors bean="${expenseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="expense.centre" default="Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'centre', 'errors')}">
                                    <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${expenseInstance?.centre?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="expense.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${expenseInstance?.department?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenter"><g:message code="expense.costCenter" default="Cost Center" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'costCenter', 'errors')}">
                                    <g:select name="costCenter.id" from="${ics.CostCenter.findAllByStatusIsNull()}" optionKey="id" value="${expenseInstance?.costCenter?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="raisedBy"><g:message code="expense.raisedBy" default="Raised By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'raisedBy', 'errors')}">
                                    <g:select name="raisedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.raisedBy?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="expense.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: expenseInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="expense.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: expenseInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="expense.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: expenseInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="expense.amount" default="Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="expenseDate"><g:message code="expense.expenseDate" default="Expense Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'expenseDate', 'errors')}">
                                    <g:datePicker name="expenseDate" value="${expenseInstance?.expenseDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="raisedOn"><g:message code="expense.raisedOn" default="Raised On" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'raisedOn', 'errors')}">
                                    <g:datePicker name="raisedOn" value="${expenseInstance?.raisedOn}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="expense.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: expenseInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvedBy"><g:message code="expense.approvedBy" default="Approved By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'approvedBy', 'errors')}">
                                    <g:select name="approvedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.approvedBy?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvedAmount"><g:message code="expense.approvedAmount" default="Approved Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'approvedAmount', 'errors')}">
                                    <g:textField name="approvedAmount" value="${fieldValue(bean: expenseInstance, field: 'approvedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvalDate"><g:message code="expense.approvalDate" default="Approval Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'approvalDate', 'errors')}">
                                    <g:datePicker name="approvalDate" value="${expenseInstance?.approvalDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvalComments"><g:message code="expense.approvalComments" default="Approval Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'approvalComments', 'errors')}">
                                    <g:textField name="approvalComments" value="${fieldValue(bean: expenseInstance, field: 'approvalComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer1"><g:message code="expense.reviewer1" default="Reviewer1" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer1', 'errors')}">
                                    <g:select name="reviewer1.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer1?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Date"><g:message code="expense.review1Date" default="Review1 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review1Date', 'errors')}">
                                    <g:datePicker name="review1Date" value="${expenseInstance?.review1Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Comments"><g:message code="expense.review1Comments" default="Review1 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review1Comments', 'errors')}">
                                    <g:textArea name="review1Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review1Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Status"><g:message code="expense.review1Status" default="Review1 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review1Status', 'errors')}">
                                    <g:textField name="review1Status" value="${fieldValue(bean: expenseInstance, field: 'review1Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer1Amount"><g:message code="expense.reviewer1Amount" default="Reviewer1 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer1Amount', 'errors')}">
                                    <g:textField name="reviewer1Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer1Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer2"><g:message code="expense.reviewer2" default="Reviewer2" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer2', 'errors')}">
                                    <g:select name="reviewer2.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer2?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Date"><g:message code="expense.review2Date" default="Review2 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review2Date', 'errors')}">
                                    <g:datePicker name="review2Date" value="${expenseInstance?.review2Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Comments"><g:message code="expense.review2Comments" default="Review2 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review2Comments', 'errors')}">
                                    <g:textArea name="review2Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review2Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Status"><g:message code="expense.review2Status" default="Review2 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review2Status', 'errors')}">
                                    <g:textField name="review2Status" value="${fieldValue(bean: expenseInstance, field: 'review2Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer2Amount"><g:message code="expense.reviewer2Amount" default="Reviewer2 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer2Amount', 'errors')}">
                                    <g:textField name="reviewer2Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer2Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer3"><g:message code="expense.reviewer3" default="Reviewer3" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer3', 'errors')}">
                                    <g:select name="reviewer3.id" from="${ics.Individual.list()}" optionKey="id" value="${expenseInstance?.reviewer3?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Date"><g:message code="expense.review3Date" default="Review3 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review3Date', 'errors')}">
                                    <g:datePicker name="review3Date" value="${expenseInstance?.review3Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Comments"><g:message code="expense.review3Comments" default="Review3 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review3Comments', 'errors')}">
                                    <g:textArea name="review3Comments" rows="5" cols="40" value="${fieldValue(bean: expenseInstance, field: 'review3Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Status"><g:message code="expense.review3Status" default="Review3 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'review3Status', 'errors')}">
                                    <g:textField name="review3Status" value="${fieldValue(bean: expenseInstance, field: 'review3Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer3Amount"><g:message code="expense.reviewer3Amount" default="Reviewer3 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'reviewer3Amount', 'errors')}">
                                    <g:textField name="reviewer3Amount" value="${fieldValue(bean: expenseInstance, field: 'reviewer3Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="project"><g:message code="expense.project" default="Project" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'project', 'errors')}">
                                    <g:select name="project.id" from="${ics.Project.list()}" optionKey="id" value="${expenseInstance?.project?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="expense.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${expenseInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="expense.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: expenseInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="expense.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${expenseInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="expense.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: expenseInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
