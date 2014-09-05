
<%@ page import="ics.PurchaseList" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="purchaseList.show" default="Show PurchaseList" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="purchaseList.list" default="PurchaseList List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="purchaseList.new" default="New PurchaseList" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="purchaseList.show" default="Show PurchaseList" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${purchaseListInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchaseListDate" default="Purchase List Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.purchaseListDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.preparedBy" default="Prepared By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${purchaseListInstance?.preparedBy?.id}">${purchaseListInstance?.preparedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.preparationComments" default="Preparation Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "preparationComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${purchaseListInstance?.department?.id}">${purchaseListInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchaseDateDate" default="Purchase Date Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.purchaseDateDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchasedBy" default="Purchased By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${purchaseListInstance?.purchasedBy?.id}">${purchaseListInstance?.purchasedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchasedFrom" default="Purchased From" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${purchaseListInstance?.purchasedFrom?.id}">${purchaseListInstance?.purchasedFrom?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchaseComments" default="Purchase Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "purchaseComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.estimateDate" default="Estimate Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.estimateDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.estimatedAmount" default="Estimated Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${purchaseListInstance?.estimatedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.estimateReference" default="Estimate Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "estimateReference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.estimateComments" default="Estimate Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "estimateComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.estimateStatus" default="Estimate Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "estimateStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.billDate" default="Bill Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.billDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.billAmount" default="Bill Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${purchaseListInstance?.billAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.billReference" default="Bill Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "billReference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.billComments" default="Bill Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "billComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.billStatus" default="Bill Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "billStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paymentDate" default="Payment Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.paymentDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paidAmount" default="Paid Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${purchaseListInstance?.paidAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paymentReference" default="Payment Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "paymentReference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paymentComments" default="Payment Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "paymentComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paymentMode" default="Payment Mode" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "paymentMode")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.paymentStatus" default="Payment Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "paymentStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.requiredItems" default="Required Items" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${purchaseListInstance?.requiredItems}" var="purchaseItemInstance">
                                        <li><g:link controller="purchaseItem" action="show" id="${purchaseItemInstance.id}">${purchaseItemInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.purchasedItems" default="Purchased Items" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${purchaseListInstance?.purchasedItems}" var="purchaseItemInstance">
                                        <li><g:link controller="purchaseItem" action="show" id="${purchaseItemInstance.id}">${purchaseItemInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: purchaseListInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="purchaseList.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${purchaseListInstance?.lastUpdated}" /></td>
                                
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
