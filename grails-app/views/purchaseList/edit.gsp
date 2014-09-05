
<%@ page import="ics.PurchaseList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="purchaseList.edit" default="Edit PurchaseList" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="purchaseList.list" default="PurchaseList List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="purchaseList.new" default="New PurchaseList" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="purchaseList.edit" default="Edit PurchaseList" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${purchaseListInstance}">
            <div class="errors">
                <g:renderErrors bean="${purchaseListInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${purchaseListInstance?.id}" />
                <g:hiddenField name="version" value="${purchaseListInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchaseListDate"><g:message code="purchaseList.purchaseListDate" default="Purchase List Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchaseListDate', 'errors')}">
                                    <g:datePicker name="purchaseListDate" value="${purchaseListInstance?.purchaseListDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="purchaseList.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: purchaseListInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="preparedBy"><g:message code="purchaseList.preparedBy" default="Prepared By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'preparedBy', 'errors')}">
                                    <g:select name="preparedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.preparedBy?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="preparationComments"><g:message code="purchaseList.preparationComments" default="Preparation Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'preparationComments', 'errors')}">
                                    <g:textField name="preparationComments" value="${fieldValue(bean: purchaseListInstance, field: 'preparationComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="purchaseList.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: purchaseListInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="purchaseList.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${purchaseListInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchaseDateDate"><g:message code="purchaseList.purchaseDateDate" default="Purchase Date Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchaseDateDate', 'errors')}">
                                    <g:datePicker name="purchaseDateDate" value="${purchaseListInstance?.purchaseDateDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchasedBy"><g:message code="purchaseList.purchasedBy" default="Purchased By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchasedBy', 'errors')}">
                                    <g:select name="purchasedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.purchasedBy?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchasedFrom"><g:message code="purchaseList.purchasedFrom" default="Purchased From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchasedFrom', 'errors')}">
                                    <g:select name="purchasedFrom.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.purchasedFrom?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchaseComments"><g:message code="purchaseList.purchaseComments" default="Purchase Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchaseComments', 'errors')}">
                                    <g:textField name="purchaseComments" value="${fieldValue(bean: purchaseListInstance, field: 'purchaseComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estimateDate"><g:message code="purchaseList.estimateDate" default="Estimate Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'estimateDate', 'errors')}">
                                    <g:datePicker name="estimateDate" value="${purchaseListInstance?.estimateDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estimatedAmount"><g:message code="purchaseList.estimatedAmount" default="Estimated Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'estimatedAmount', 'errors')}">
                                    <g:textField name="estimatedAmount" value="${fieldValue(bean: purchaseListInstance, field: 'estimatedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estimateReference"><g:message code="purchaseList.estimateReference" default="Estimate Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'estimateReference', 'errors')}">
                                    <g:textField name="estimateReference" value="${fieldValue(bean: purchaseListInstance, field: 'estimateReference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estimateComments"><g:message code="purchaseList.estimateComments" default="Estimate Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'estimateComments', 'errors')}">
                                    <g:textField name="estimateComments" value="${fieldValue(bean: purchaseListInstance, field: 'estimateComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="estimateStatus"><g:message code="purchaseList.estimateStatus" default="Estimate Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'estimateStatus', 'errors')}">
                                    <g:textField name="estimateStatus" value="${fieldValue(bean: purchaseListInstance, field: 'estimateStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billDate"><g:message code="purchaseList.billDate" default="Bill Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'billDate', 'errors')}">
                                    <g:datePicker name="billDate" value="${purchaseListInstance?.billDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billAmount"><g:message code="purchaseList.billAmount" default="Bill Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'billAmount', 'errors')}">
                                    <g:textField name="billAmount" value="${fieldValue(bean: purchaseListInstance, field: 'billAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billReference"><g:message code="purchaseList.billReference" default="Bill Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'billReference', 'errors')}">
                                    <g:textField name="billReference" value="${fieldValue(bean: purchaseListInstance, field: 'billReference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billComments"><g:message code="purchaseList.billComments" default="Bill Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'billComments', 'errors')}">
                                    <g:textField name="billComments" value="${fieldValue(bean: purchaseListInstance, field: 'billComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billStatus"><g:message code="purchaseList.billStatus" default="Bill Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'billStatus', 'errors')}">
                                    <g:textField name="billStatus" value="${fieldValue(bean: purchaseListInstance, field: 'billStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentDate"><g:message code="purchaseList.paymentDate" default="Payment Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paymentDate', 'errors')}">
                                    <g:datePicker name="paymentDate" value="${purchaseListInstance?.paymentDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paidAmount"><g:message code="purchaseList.paidAmount" default="Paid Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paidAmount', 'errors')}">
                                    <g:textField name="paidAmount" value="${fieldValue(bean: purchaseListInstance, field: 'paidAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentReference"><g:message code="purchaseList.paymentReference" default="Payment Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paymentReference', 'errors')}">
                                    <g:textField name="paymentReference" value="${fieldValue(bean: purchaseListInstance, field: 'paymentReference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentComments"><g:message code="purchaseList.paymentComments" default="Payment Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paymentComments', 'errors')}">
                                    <g:textField name="paymentComments" value="${fieldValue(bean: purchaseListInstance, field: 'paymentComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentMode"><g:message code="purchaseList.paymentMode" default="Payment Mode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paymentMode', 'errors')}">
                                    <g:textField name="paymentMode" value="${fieldValue(bean: purchaseListInstance, field: 'paymentMode')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentStatus"><g:message code="purchaseList.paymentStatus" default="Payment Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'paymentStatus', 'errors')}">
                                    <g:textField name="paymentStatus" value="${fieldValue(bean: purchaseListInstance, field: 'paymentStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredItems"><g:message code="purchaseList.requiredItems" default="Required Items" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'requiredItems', 'errors')}">
                                    <g:select name="requiredItems"
from="${ics.PurchaseItem.list()}"
size="5" multiple="yes" optionKey="id"
value="${purchaseListInstance?.requiredItems}" />


                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="purchasedItems"><g:message code="purchaseList.purchasedItems" default="Purchased Items" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'purchasedItems', 'errors')}">
                                    <g:select name="purchasedItems"
from="${ics.PurchaseItem.list()}"
size="5" multiple="yes" optionKey="id"
value="${purchaseListInstance?.purchasedItems}" />


                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="purchaseList.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: purchaseListInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="purchaseList.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${purchaseListInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="purchaseList.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: purchaseListInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="purchaseList.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: purchaseListInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${purchaseListInstance?.lastUpdated}"  />

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
