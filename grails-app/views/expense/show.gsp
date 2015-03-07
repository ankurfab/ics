
<%@ page import="ics.Expense" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="expense.show" default="Show Expense" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="expense.list" default="Expense List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new" default="New Expense" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="expense.show" default="Show Expense" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${expenseInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="centre" action="show" id="${expenseInstance?.centre?.id}">${expenseInstance?.centre?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${expenseInstance?.department?.id}">${expenseInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.costCenter" default="Cost Center" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCenter" action="show" id="${expenseInstance?.costCenter?.id}">${expenseInstance?.costCenter?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.raisedBy" default="Raised By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${expenseInstance?.raisedBy?.id}">${expenseInstance?.raisedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.amount" default="Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.expenseDate" default="Expense Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.expenseDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.raisedOn" default="Raised On" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.raisedOn}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.approvedBy" default="Approved By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${expenseInstance?.approvedBy?.id}">${expenseInstance?.approvedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.approvedAmount" default="Approved Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.approvedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.approvalDate" default="Approval Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.approvalDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.approvalComments" default="Approval Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "approvalComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer1" default="Reviewer1" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${expenseInstance?.reviewer1?.id}">${expenseInstance?.reviewer1?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review1Date" default="Review1 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.review1Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review1Comments" default="Review1 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review1Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review1Status" default="Review1 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review1Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer1Amount" default="Reviewer1 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.reviewer1Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer2" default="Reviewer2" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${expenseInstance?.reviewer2?.id}">${expenseInstance?.reviewer2?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review2Date" default="Review2 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.review2Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review2Comments" default="Review2 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review2Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review2Status" default="Review2 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review2Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer2Amount" default="Reviewer2 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.reviewer2Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer3" default="Reviewer3" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${expenseInstance?.reviewer3?.id}">${expenseInstance?.reviewer3?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review3Date" default="Review3 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.review3Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review3Comments" default="Review3 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review3Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.review3Status" default="Review3 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "review3Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.reviewer3Amount" default="Reviewer3 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.reviewer3Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.project" default="Project" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="project" action="show" id="${expenseInstance?.project?.id}">${expenseInstance?.project?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${expenseInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="expense.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "updator")}</td>
                                
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
