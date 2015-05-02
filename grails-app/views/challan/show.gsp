
<%@ page import="ics.Challan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="challan.show" default="Show Challan" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="challan.list" default="Challan List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="challan.new" default="New Challan" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="challan.show" default="Show Challan" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${challanInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.refNo" default="Ref No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "refNo")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.issuedTo" default="Issued To" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${challanInstance?.issuedTo?.id}">${challanInstance?.issuedTo?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.issuedBy" default="Issued By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${challanInstance?.issuedBy?.id}">${challanInstance?.issuedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.settleBy" default="Settle By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${challanInstance?.settleBy?.id}">${challanInstance?.settleBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.issueDate" default="Issue Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${challanInstance?.issueDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.settleDate" default="Settle Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${challanInstance?.settleDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.advanceAmount" default="Advance Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${challanInstance?.advanceAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.totalAmount" default="Total Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${challanInstance?.totalAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.settleAmount" default="Settle Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${challanInstance?.settleAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${challanInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${challanInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: challanInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.lineItems" default="Line Items" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${challanInstance?.lineItems}" var="challanLineItemInstance">
                                        <li><g:link controller="challanLineItem" action="show" id="${challanLineItemInstance.id}">${challanLineItemInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="challan.paymentReferences" default="Payment References" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${challanInstance?.paymentReferences}" var="paymentReferenceInstance">
                                        <li><g:link controller="paymentReference" action="show" id="${paymentReferenceInstance.id}">${paymentReferenceInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
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
